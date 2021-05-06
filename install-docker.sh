#!/bin/bash
set -ex

apt-get update -q
apt-get install -qy apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

add-apt-repository \
 "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
 $(lsb_release -cs) \
 stable"

apt-get update -q
apt-get install -qy docker-ce

usermod -aG docker ubuntu

