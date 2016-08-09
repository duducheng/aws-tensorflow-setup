# Setting up TensorFlow 0.9 with Python 3.5 on AWS GPU-instance

## Description

`setup-aws-tensorflow.bash` installs the following things on the ec2 `g2.2xlarge` instance running Ubuntu 14.04:

- Required linux packages
- CUDA 7.5
- cuDNN v4
- Anaconda with Python 3.5
- TensorFlow 0.9
- Keras
- GPU usage tool `gpustat`

Also configures the Jupyter Notebook interactive use

Based on the blog post: <http://max-likelihood.com/2016/06/18/aws-tensorflow-setup/>.

## Usage

1. Log in to your instance and update `apt-get`
```bash
sudo apt-get update && sudo apt-get -y upgrade
```
2. Use `apt-get` to install `git`
```bash
sudo apt-get install -y git
```
3. Clone this repo
```bash
git clone https://github.com/jwittenbach/aws-tensorflow-setup
```
4. Run the installation script
```bash
./aws-tensorflow-setup/setup-aws-tensorflow.bash
```
