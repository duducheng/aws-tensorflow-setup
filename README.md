# Setting up TensorFlow 0.12rc with Python 3.5 on AWS GPU-instance

## Description

`setup-aws-tensorflow.bash` installs the following things on the ec2 `p2.xlarge` instance running Ubuntu 14.04:

- Required linux packages
- CUDA 8.0
- cuDNN v5.1
- Anaconda with Python 3.5
- TensorFlow 0.12rc
- Keras

Also configures the Jupyter Notebook for interactive use

Forked from:
<https://github.com/jwittenbach/aws-tensorflow-setup>


## Preliminaries -- broad strokes steps

- Install the Amazon Web Services CLI or use the AWS Dashboard online
- Setup your AWS credentials
- Create a security group with the following ports open to TCP/IP traffic: 22 (SSH), 80 (HTTP), 9999 (Jupyter Notebook)
- Launch a `p2.xlarge` instance running Ubuntu server
- Log in to your instance via SSH

## Setting up TensorFlow + Keras with GPU support
- Update `apt-get` and packages
```bash
sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get install -y build-essential git python-pip
sudo pip install awscli
aws configure
# aws s3 sync s3:// `your s3 path` $HOME/s3
```
- Clone this repo
```bash
git clone https://github.com/duducheng/aws-tensorflow-setup
```
- Run the installation script
```bash
./aws-tensorflow-setup/setup-aws-tensorflow.bash
```
**Note**: When installing Anaconda3, it may cause some problems. If it doesn't work well, run the scipts from "# install anaconda" again.
- Launch a Jupyter Notebook server
```bash
jupyter Notebook
```
and access it by pointing your browser to `[publicIP]:9999`

## Shutting down

You have two options for shutting down the instance:
1. If you `stop` the instance, then you can later `start` the instance back up again, and you will not need to go through the setup again. However, the disk image will be stored on AWS S3, which does cost a small fee.
2. If you `terminate` the instance, then you will need to `launch` a branch new instance the next time, which will entail redoing the setup process.
