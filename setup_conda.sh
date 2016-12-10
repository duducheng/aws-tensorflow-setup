#!/bin/bash

mkdir -p $HOME/install

# install anaconda
# if there is some problem, run all the script below again.
wget http://repo.continuum.io/archive/Anaconda3-4.0.0-Linux-x86_64.sh
bash Anaconda3-4.0.0-Linux-x86_64.sh -b -p $HOME/install/anaconda3
rm Anaconda3-4.0.0-Linux-x86_64.sh
echo 'export PATH="$HOME/install/anaconda3/bin:$PATH"' >> $HOME/.bash_profile

# export env vars
source $HOME/.bash_profile

# install tensorflow
pip install --ignore-installed --upgrade pip setuptools
pip install --upgrade https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-0.12.0rc1-cp35-cp35m-linux_x86_64.whl

# configure Jupyter Notebook
jupyter notebook --generate-config
echo "
c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False
c.NotebookApp.port = 9999
" >> .jupyter/jupyter_notebook_config.py

# install some other libraries: theano, pymc3, Lasagne, keras
pip install git+https://github.com/theano/theano
echo "
[global]
floatX = float32
device = gpu0

[lib]
cnmem = 1
" >> $HOME/.theanorc
pip install git+https://github.com/pymc-devs/pymc3
pip install git+https://github.com/Lasagne/Lasagne

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
