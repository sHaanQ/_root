#!/bin/bash

# Prepare system
echo "DeepSpeech Native Builder"
echo "*************************"
echo "Run from nlp/coder dir"
echo "*************************"

echo "--------------------------------------------------------------------"
echo "Pull DeepSpeech ?"
echo "--------------------------------------------------------------------"
select yn in "Yes" "No"; do
	case $yn in
		Yes ) git clone https://github.com/mozilla/DeepSpeech.git
			  break;;
		No  ) break;;
	esac
done

echo "--------------------------------------------------------------------"
echo "Pull DeepSpeech Tensorflow ?"
echo "--------------------------------------------------------------------"
select yn in "Yes" "No"; do
	case $yn in
		Yes ) git clone https://github.com/mozilla/tensorflow.git
			  break;;
		No  ) break;;
	esac
done

echo "--------------------------------------------------------------------"
echo "Install dependancies ?"
echo "--------------------------------------------------------------------"
select yn in "Yes" "No"; do
	case $yn in
		Yes )	sudo apt-get install pkg-config zip g++ openjdk-8-jdk zlib1g-dev unzip python realpath libsox-dev coreutils \
								python-numpy python-dev python-pip python-wheel \
								python3-numpy python3-dev python3-pip python3-wheel
				pip install six numpy wheel
				pip3 install six numpy wheel
				 
				# Install Bazel
				echo "Pull Bazel 0.11.1"
				wget --no-check-certificate https://github.com/bazelbuild/bazel/releases/download/0.11.1/bazel_0.11.1-linux-x86_64.deb
				sudo dpkg -i bazel_0.11.1-linux-x86_64.deb
				export PATH="$PATH:$HOME/bin"
			  	break;;
		No  ) break;;
	esac
done

 
 # Proxy settings
echo "--------------------------------------------------------------------"
echo "Behind a Proxy ?"
echo "Check Username, password and proxy URL"
echo "--------------------------------------------------------------------"
select yn in "Yes" "No"; do
	case $yn in
		Yes ) unset http_proxy 
		      unset https_proxy 
		      export HTTPS_PROXY=https://username:pass@proxy-server:port
		      export HTTPS_PROXY=https://username:pass@proxy-server:port
			  break;;
		No  ) break;;
	esac
done



#echo "--------------------------------------------------------------------"
#echo "Building with AVX AVX2 FMA SSE4.1 SSE4.2"
#echo "Check using : cat /proc/cpuinfo"
#echo "--------------------------------------------------------------------"
#select yn in "Yes" "No"; do
#	# If AVX2, FMA support present on CPU
#	case $yn in#		Yes ) bazel build --jobs 4 -c opt --copt=-mavx --copt=-mavx2 --copt=-mfma \
#				--copt=-msse4.1 --copt=-msse4.2 //tensorflow/tools/pip_package:build_pip_package
#			  break;
#		# If No AVX2 support, fallback to deafult config options#		No )  bazel build --jobs 4 --config=opt //tensorflow/tools/pip_package:build_pip_package
#			  break;
#
#
#echo "Build TensorFlow pip package and install it"
#bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
#pip install --user /tmp/tensorflow_pkg/tensorflow-1.10.0-py2-none-any.whl
#echo "--------------------------------------------------------------------"
#echo "Test the build's working"
#echo "Change directory (cd) to any directory on your system other"
#echo "than the tensorflow subdirectory from which you invoked the configure command"
#echo "Try a sample tensorflow program"
#echo "--------------------------------------------------------------------"
#cd ../tensorflow## Call tensorflow.py


echo "--------------------------------------------------------------------"
echo "Get back to building DeepSpeech"
echo "Before building the DeepSpeech client libraries, you will need to prepare your"
echo "environment to configure and build TensorFlow."
echo "--------------------------------------------------------------------"
cd ./tensorflow

# Using CPU optimizations:
# -mtune=generic -march=x86-64 -msse -msse2 -msse3 -msse4.1 -msse4.2 -mavx.
# Adding --config=cuda flag to build using CUDA.

# passing LD_LIBRARY_PATH is required cause Bazel doesn't pickup it from environment


# Build LM Prefix Decoder, CPU only - no need for CUDA flag
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu/:/home/bhargav/Coder/nlp/tensorflow/bazel-bin/native_client
bazel build --jobs 4 -c opt --copt=-O3 --copt="-D_GLIBCXX_USE_CXX11_ABI=0" --copt=-mtune=generic --copt=-march=x86-64 --copt=-msse --copt=-msse2 --copt=-msse3 --copt=-msse4.1 --copt=-msse4.2 --copt=-mavx //native_client:libctc_decoder_with_kenlm.so  --verbose_failures --action_env=LD_LIBRARY_PATH=${LD_LIBRARY_PATH}
#bazel build -c opt --copt=-mavx --copt=-mavx2 --copt=-mfma --copt=-msse4.1 --copt=-msse4.2 --copt=-O3 --copt="-D_GLIBCXX_USE_CXX11_ABI=0" //native_client:libctc_decoder_with_kenlm.so

# Build DeepSpeech
bazel build --jobs 4 --config=monolithic  -c opt --copt=-O3 --copt="-D_GLIBCXX_USE_CXX11_ABI=0" --copt=-mtune=generic --copt=-march=x86-64 --copt=-msse --copt=-msse2 --copt=-msse3 --copt=-msse4.1 --copt=-msse4.2 --copt=-mavx --copt=-fvisibility=hidden //native_client:libdeepspeech.so //native_client:deepspeech_utils //native_client:generate_trie --verbose_failures --action_env=LD_LIBRARY_PATH=${LD_LIBRARY_PATH}
#bazel build --config=monolithic -c opt --copt=-mavx --copt=-mavx2 --copt=-mfma --copt=-msse4.1 --copt=-msse4.2 --copt=-O3 --copt="-D_GLIBCXX_USE_CXX11_ABI=0" --copt=-fvisibility=hidden //native_client:libdeepspeech.so //native_client:generate_trie

# Build Tensorflow
ln -s ../DeepSpeech/native_client/ ./

# Build TF pip package
bazel build --jobs 4 --config=opt --copt="-D_GLIBCXX_USE_CXX11_ABI=0" --copt=-mtune=generic --copt=-march=x86-64 --copt=-msse --copt=-msse2 --copt=-msse3 --copt=-msse4.1 --copt=-msse4.2 --copt=-mavx //tensorflow/tools/pip_package:build_pip_package --verbose_failures --action_env=LD_LIBRARY_PATH=${LD_LIBRARY_PATH}
./configure
bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
pip install /tmp/tensorflow_pkg/*.whl

# All generated libs @ location 
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/bhargav/Coder/nlp/tensorflow/bazel-bin/native_client

cd ../DeepSpeech/native_client
echo "--------------------------------------------------------------------"
echo "Build DeepSpeech"
echo "--------------------------------------------------------------------"
make deepspeech

