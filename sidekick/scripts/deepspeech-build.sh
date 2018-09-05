#!/bin/bash


if [ -z "$1" ]; then
	echo "Specify the number of jobs to Run for building"
	echo "Usage: $0 <no-of-jobs>"
	echo "Ex: $0 300"
	exit 1
fi

if [ -z "$NLP" ]; then
	# Enter here if NLP is Blank
	echo "Let's set your workspace..."
	echo "Mention a directory path to setup everything or I'll panic"
	echo "I'm not very smart..."
	read -p "Enter workspace path: " NLP_PATH
	#eval NLP_PATH=$NLP_PATH		# Do Not Use This !!
	NLP_PATH="${NLP_PATH/#\~/$HOME}"
	echo "Workspace @ $NLP_PATH"
	echo ""
	echo "export NLP=$NLP_PATH" >> ~/.zshrc
	echo "export NLP=$NLP_PATH" >> ~/.bashrc
	NLP=$NLP_PATH
else
	echo "Environment variable NLP is set to"
	echo $NLP
fi

if [ ! -d "$NLP" ]; then
   # Control will enter here if DIRECTORY doesn't exist @ NLP_PATH.
   mkdir $NLP
fi

# Prepare system
echo "********************************************************************"
echo "DeepSpeech Native Builder"
echo "Running from $NLP directory"
echo "********************************************************************"

# Switch to nlp directory
cd $NLP

echo "--------------------------------------------------------------------"
echo "Pull DeepSpeech ?"
echo "--------------------------------------------------------------------"
DIRECTORY=$NLP/DeepSpeech
if [ ! -d "$DIRECTORY" ]; then
	# Control will enter here if DeepSpeech repository is not found
	echo "Cloning DeepSpeech"
	git clone https://github.com/mozilla/DeepSpeech.git
	cd $DIRECTORY
	git checkout tags/v0.2.0-alpha.8
	cd $NLP
else
	echo "DeepSpeech Repo found"
	cd $DIRECTORY
	git checkout tags/v0.2.0-alpha.8
	cd $NLP
fi

echo "--------------------------------------------------------------------"
echo "Pull Mozilla Tensorflow ?"
echo "--------------------------------------------------------------------"
DIRECTORY=$NLP/tensorflow
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
		echo "--------------------------------------------------------------------"
	  	echo "Fetching Packages"
		echo "--------------------------------------------------------------------"
		sudo apt-get update
		sudo apt-get -y install pkg-config zip g++ openjdk-8-jdk zlib1g-dev unzip python libsox-dev coreutils
		sudo apt-get -y install python-numpy python-dev python-pip python-wheel
		sudo apt-get -y install python3-numpy python3-dev python3-pip python3-wheel
		pip install six numpy wheel
		pip3 install six numpy wheel
	fi

	echo "--------------------------------------------------------------------"
	echo "ALL Packages installed"
	echo "--------------------------------------------------------------------"

	# Install Bazel
	echo "Pull Bazel 0.11.1"
	if [ ! -f ./bazel_0.11.1-linux-x86_64.deb ]; then
		# Control will enter here if file doesn't exist.
		wget --no-check-certificate https://github.com/bazelbuild/bazel/releases/download/0.11.1/bazel_0.11.1-linux-x86_64.deb
	fi
	sudo dpkg -i bazel_0.11.1-linux-x86_64.deb
	export PATH="$PATH:$HOME/bin"

	echo "--------------------------------------------------------------------"
	echo "Bazel installed"
	echo "--------------------------------------------------------------------"

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
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$NLP/tensorflow/bazel-bin/native_client
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$NLP/tensorflow/bazel-bin/native_client" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$NLP/tensorflow/bazel-bin/native_client" >> ~/.zshrc

echo "--------------------------------------------------------------------"
echo "Get back to building DeepSpeech"
echo "Before building the DeepSpeech client libraries, you will need to prepare your"
echo "environment to configure and build TensorFlow."
echo "--------------------------------------------------------------------"
cd $NLP/tensorflow
echo "Working @ $PWD"

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
ln -s $NLP/DeepSpeech/native_client/ ./

# Build TF pip package
echo "--------------------------------------------------------------------"
echo "Building TensorFlow"
echo "--------------------------------------------------------------------"
if [ ! -f $NLP/tensorflow/.tf_configure.bazelrc ]; then
	# Control will enter here if file doesn't exist.
	echo "Running Configure Script for Tensorflow"
	./configure
fi
bazel build --jobs $1 --config=opt --copt="-D_GLIBCXX_USE_CXX11_ABI=0" --copt=-mtune=generic --copt=-march=x86-64 --copt=-msse \
	 --copt=-msse2 --copt=-msse3 --copt=-msse4.1 --copt=-msse4.2 --copt=-mavx --copt=-mavx2 --copt=-mfma \
	 //tensorflow/tools/pip_package:build_pip_package --verbose_failures --action_env=LD_LIBRARY_PATH=${LD_LIBRARY_PATH}
bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
pip install /tmp/tensorflow_pkg/*.whl

cd $NLP/DeepSpeech/native_client
echo "--------------------------------------------------------------------"
echo "Make DeepSpeech"
echo "--------------------------------------------------------------------"
make clean
make deepspeech

if [ ! -f $NLP/DeepSpeech/native_client/deepspeech ]; then
   	# Control will enter here if file doesn't exist.
	echo "--------------*************----------------------"
   	echo "DeepSpeech build FAILED"
	echo "--------------*************----------------------"
else
	echo "--------------*****************------------------"
   	echo "DeepSpeech build SUCCESSFUL"
	echo "--------------*****************------------------"
	echo "Build Completed, switch to $NLP/DeepSpeech/native_client/ directory and Run"
	echo "./deepspeech --model <path-to>/output_graph.pb --alphabet <path-to>/models/alphabet.txt"
	echo "--lm <path-to>/models/lm.binary  --trie <path-to>/models/trie --audio .<path-to>/audio/8455-210777-0068.wav -t"
fi

