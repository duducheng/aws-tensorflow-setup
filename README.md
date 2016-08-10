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

Also configures the Jupyter Notebook for interactive use

Forked from:
<https://github.com/Avsecz/aws-tensorflow-setup>

Based on the blog post: <http://max-likelihood.com/2016/06/18/aws-tensorflow-setup/>.

## Preliminaries -- broad strokes steps

- Install the Amazon Web Services CLI or use the AWS Dashboard online
- Setup your AWS credentials
- Create a security group with the following ports open to TCP/IP traffic: 22 (SSH), 80 (HTTP), 9999 (Jupyter Notebook)
- Launch a `g2.2xlarge` instance running Ubuntu server (`ami-fce3c696`)
- Log in to your instance via SSH

For more details, see the beginning of this blog post: <http://max-likelihood.com/2016/06/18/aws-tensorflow-setup/>. Though make sure to open the additional ports if you wish to use the Jupyter Notebook.

## Setting up TensorFlow + Keras with GPU support

- Update `apt-get` and packages
```bash
sudo apt-get update && sudo apt-get -y upgrade
```
- Install `git`
```bash
sudo apt-get install -y git
```
- Clone this repo
```bash
git clone https://github.com/jwittenbach/aws-tensorflow-setup
```
- Run the installation script
```bash
./aws-tensorflow-setup/setup-aws-tensorflow.bash
```
- Source your bash profile to set environment variables
```bash
source ~/.bash_profile
```
- (Optional) Launch a Jupyter Notebook server
```bash
jupyter Notebook
```
and access it by pointing your browser to `[publicIP]:9999`

## Shutting down

You have two options for shutting down the instance:
1. If you `stop` the instance, then you can later `start` the instance back up again, and you will not need to go through the setup again. However, the disk image will be stored on AWS S3, which does cost a small fee.
2. If you `terminate` the instance, then you will need to `launch` a branch new instance the next time, which will entail redoing the setup process.
