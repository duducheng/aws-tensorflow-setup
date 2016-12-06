#!/bin/bash

# stop on error
set -e
############################################
# install into /mnt/bin
sudo mkdir -p $HOME/install
sudo chown ubuntu:ubuntu $HOME/install

# install the required packages
sudo apt-get -y install linux-headers-$(uname -r) linux-image-extra-`uname -r`

# install cuda
wget https://developer.nvidia.com/compute/cuda/8.0/prod/local_installers/cuda-repo-ubuntu1604-8-0-local_8.0.44-1_amd64-deb
sudo dpkg -i cuda-repo-ubuntu1604-8-0-local_8.0.44-1_amd64-deb
rm cuda-repo-ubuntu1604-8-0-local_8.0.44-1_amd64-deb
sudo apt-get update
sudo apt-get install -y cuda

# get cudnn
sudo dpkg -i $HOME/s3/libcudnn5_5.1.5-1+cuda8.0_amd64.deb
sudo dpkg -i $HOME/s3/libcudnn5-dev_5.1.5-1+cuda8.0_amd64.deb

# set the appropriate library path
echo 'export CUDA_HOME=/usr/local/cuda
export CUDA_ROOT=/usr/local/cuda
export PATH=$PATH:$CUDA_ROOT/bin:$HOME/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_ROOT/lib64
' >> ~/.bash_profile

# install anaconda
wget http://repo.continuum.io/archive/Anaconda3-4.0.0-Linux-x86_64.sh
bash Anaconda3-4.0.0-Linux-x86_64.sh -b -p $HOME/install/anaconda3
rm Anaconda3-4.0.0-Linux-x86_64.sh
echo 'export PATH="$HOME/install/anaconda3/bin:$PATH"' >> ~/.bash_profile

# export env vars
source $HOME/.bash_profile

# install tensorflow
export TF_BINARY_URL="https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-0.12.0rc0-cp35-cp35m-linux_x86_64.whl"
pip install --upgrade $TF_BINARY_URL

# install and configure Keras
pip install git+https://github.com/fchollet/keras
echo "import keras" | python
echo '
{
    "backend": "tensorflow",
    "epsilon": 1e-07,
    "floatx": "float32",
    "image_dim_ordering": "tf"
}
' > ~/.keras/keras.json

# configure Jupyter Notebook
jupyter notebook --generate-config
echo "
c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False
c.NotebookApp.port = 9999
" >> .jupyter/jupyter_notebook_config.py

# install monitoring programs
sudo wget https://git.io/gpustat -O /usr/local/bin/gpustat
sudo chmod +x /usr/local/bin/gpustat
sudo nvidia-smi daemon
sudo apt-get -y install htop

############################################
# run the test
# byobu				# start byobu + press Ctrl + F2
# htop				# run in window 1, press Shift + F2
# watch --color -n1.0 gpustat -cp	# run in window 2, press Shift + <left>
# wget https://raw.githubusercontent.com/tensorflow/tensorflow/master/tensorflow/models/image/mnist/convolutional.py
# python convolutional.py		# run in window 3
