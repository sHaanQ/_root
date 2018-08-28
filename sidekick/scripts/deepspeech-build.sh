#!/bin/bash


if [ -z "$1" ]; then
	echo "Specify the number of cores to use for building"
	echo "Usage: $0 <no-of-cores>"
	echo "Ex: $0 4"
	exit 1
fi

# Prepare system
echo "****************************"
echo "DeepSpeech Native Builder"
echo "Running from ~/nlp directory"
echo "****************************"

DIRECTORY=~/nlp
if [ ! -d "$DIRECTORY" ]; then
   # Control will enter here if $DIRECTORY doesn't exist.
   mkdir ~/nlp
fi

# Switch to nlp directory
cd ~/nlp

echo "--------------------------------------------------------------------"
echo "Pull DeepSpeech ?"
echo "--------------------------------------------------------------------"
DIRECTORY=~/nlp/DeepSpeech
if [ ! -d "$DIRECTORY" ]; then
	# Control will enter here if DeepSpeech repository is not found
	echo "Cloning DeepSpeech"
	git clone https://github.com/mozilla/DeepSpeech.git
	cd ~/nlp/DeepSpeech
	git checkout tags/v0.2.0-alpha.8
	cd ~/nlp	
else
	echo "DeepSpeech Repo found"
	cd ~/nlp/DeepSpeech
	git checkout tags/v0.2.0-alpha.8
	cd ~/nlp
fi

echo "--------------------------------------------------------------------"
echo "Pull Mozilla Tensorflow ?"
echo "--------------------------------------------------------------------"
DIRECTORY=~/nlp/tensorflow
if [ ! -d "$DIRECTORY" ]; then
	echo "Cloning mozilla/TensorFlow"
	git clone https://github.com/mozilla/tensorflow.git
else
	echo "TensorFlow Repo found"
fi


if [ $(dpkg-query -W -f='${Status}' bazel 2>/dev/null | grep -c "ok installed") -eq 0 ];
then	
	if [ $(dpkg-query -W -f='${Status}' openjdk-8-jdk 2>/dev/null | grep -c "ok installed") -eq 0 ];
	then
	  	# Fetch Packages
		sudo apt-get update
		sudo apt-get -y install pkg-config zip g++ openjdk-8-jdk zlib1g-dev unzip python libsox-dev coreutils
		sudo apt-get -y install python-numpy python-dev python-pip python-wheel
		sudo apt-get -y install python3-numpy python3-dev python3-pip python3-wheel
		pip install six numpy wheel
		pip3 install six numpy wheel

		# Install Bazel
		echo "Pull Bazel 0.11.1"
		wget --no-check-certificate https://github.com/bazelbuild/bazel/releases/download/0.11.1/bazel_0.11.1-linux-x86_64.deb
		sudo dpkg -i bazel_0.11.1-linux-x86_64.deb
		export PATH="$PATH:$HOME/bin"

		echo "--------------------------------------------------------------------"
	 	echo "ALL Packages installed"
		echo "--------------------------------------------------------------------"
	fi	 
else
	# Packages are present
	echo "--------------------------------------------------------------------"
 	echo "All packages are present"
	echo "--------------------------------------------------------------------"
fi

# # Proxy settings
#echo "--------------------------------------------------------------------"
#echo "Behind a Proxy ?"
#echo "Check Username, password and proxy URL"
#echo "--------------------------------------------------------------------"
#select yn in "Yes" "No"; do
#	case $yn in
#		Yes ) unset http_proxy 
#		      unset https_proxy 
#		      export HTTPS_PROXY=https://username:pass@proxy-server:port
#		      export HTTPS_PROXY=https://username:pass@proxy-server:port
#			  break;;
#		No  ) break;;
#	esac
#done

# All generated libs @ location 
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/nlp/tensorflow/bazel-bin/native_client

echo "--------------------------------------------------------------------"
echo "Get back to building DeepSpeech"
echo "Before building the DeepSpeech client libraries, you will need to prepare your"
echo "environment to configure and build TensorFlow."
echo "--------------------------------------------------------------------"
cd ~/nlp/tensorflow

# Using CPU optimizations:
# -mtune=generic -march=x86-64 -msse -msse2 -msse3 -msse4.1 -msse4.2 -mavx.

# passing LD_LIBRARY_PATH is required cause Bazel doesn't pickup it from environment


# Build LM Prefix Decoder, CPU only - no need for CUDA flag
echo "--------------------------------------------------------------------"
echo "Building CTC Decoder & lm"
echo "--------------------------------------------------------------------"
bazel build --jobs $1 -c opt --copt=-O3 --copt="-D_GLIBCXX_USE_CXX11_ABI=0" --copt=-mtune=generic --copt=-march=x86-64 \
	--copt=-msse --copt=-msse2 --copt=-msse3 --copt=-msse4.1 --copt=-msse4.2 --copt=-mavx --copt=-mavx2 --copt=-mfma \
	//native_client:libctc_decoder_with_kenlm.so  --verbose_failures --action_env=LD_LIBRARY_PATH=${LD_LIBRARY_PATH}

# Build DeepSpeech
echo "--------------------------------------------------------------------"
echo "Building deepspeech, deepspeech utils and trie"
echo "--------------------------------------------------------------------"
bazel build --jobs $1 --config=monolithic  -c opt --copt=-O3 --copt="-D_GLIBCXX_USE_CXX11_ABI=0" --copt=-mtune=generic \
	--copt=-march=x86-64 --copt=-msse --copt=-msse2 --copt=-msse3 --copt=-msse4.1 --copt=-msse4.2 --copt=-mavx \
	--copt=-mavx2 --copt=-mfma --copt=-fvisibility=hidden //native_client:libdeepspeech.so //native_client:deepspeech_utils \
	//native_client:generate_trie --verbose_failures --action_env=LD_LIBRARY_PATH=${LD_LIBRARY_PATH}

# Build Tensorflow
ln -s ~/nlp/DeepSpeech/native_client/ ./

# Build TF pip package
echo "--------------------------------------------------------------------"
echo "Building TensorFlow"
echo "--------------------------------------------------------------------"
./configure
bazel build --jobs $1 --config=opt --copt="-D_GLIBCXX_USE_CXX11_ABI=0" --copt=-mtune=generic --copt=-march=x86-64 --copt=-msse \
	 --copt=-msse2 --copt=-msse3 --copt=-msse4.1 --copt=-msse4.2 --copt=-mavx --copt=-mavx2 --copt=-mfma \
	 //tensorflow/tools/pip_package:build_pip_package --verbose_failures --action_env=LD_LIBRARY_PATH=${LD_LIBRARY_PATH}
bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
pip install /tmp/tensorflow_pkg/*.whl

cd ../DeepSpeech/native_client
echo "--------------------------------------------------------------------"
echo "Make DeepSpeech"
echo "--------------------------------------------------------------------"
make clean
make deepspeech

if [ ! -f ~/nlp/DeepSpeech/native_client/deepspeech ]; then
   	# Control will enter here if file doesn't exist.
	echo "--------------*************----------------------"
   	echo "DeepSpeech build FAILED"
	echo "--------------*************----------------------"
else
	echo "--------------*****************------------------"
   	echo "DeepSpeech build SUCCESSFUL"
	echo "--------------*****************------------------"
	echo "Build Completed, switch to ~/nlp/DeepSpeech/native_client/ directory and Run"
	echo "./deepspeech --model ../../models/output_graph.pb --alphabet ../../models/alphabet.txt"
	echo "--lm ../../models/lm.binary  --trie ../../models/trie --audio ../../audio/8455-210777-0068.wav -t"
fi

