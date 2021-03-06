#!/bin/bash -e
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates
sudo apt-key adv \
           --keyserver hkp://ha.pool.sks-keyservers.net:80 \
           --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

# Install tools
sudo apt-get update
sudo apt-get install -y socat unzip

# Install docker
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get install -y docker-engine
sudo service docker start

# Install docker: prepare for OpenShift
sudo sed -i 's/ExecStart=\(.*\)/ExecStart=\1 --insecure-registry 172.30.0.0\/16/' /lib/systemd/system/docker.service
sudo sed -i 's/SocketMode=\(.*\)/SocketMode=0666/' /lib/systemd/system/docker.socket
sudo systemctl daemon-reload
sudo systemctl restart docker

# Install oc CLI
cd ~
wget https://github.com/openshift/origin/releases/download/v1.4.1/openshift-origin-client-tools-v1.4.1-3f9807a-linux-64bit.tar.gz
tar xvzf openshift-origin-client-tools-v1.4.1-3f9807a-linux-64bit.tar.gz
cd openshift*
sudo mv oc /usr/bin
sudo chown root:root /usr/bin/oc
