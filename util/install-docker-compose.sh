#!/usr/bin/env bash
DOCKER_COMPOSE_VERSION=1.29.0
#
echo -e "$(tput setaf 6)\u2699 Installing docker$(tput sgr 0)"
sudo apt update
sudo apt upgrade
sudo apt install apt-transport-https ca-certificates curl software-properties-common
sudo apt install build-essential
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce
sudo service docker start
echo -e "$(tput setaf 6)\u2699 Booting hello-world image...$(tput sgr 0)\n"
sleep 10s
sudo docker run hello-world
#
echo -e "$(tput setaf 6)\u2699 Installing docker-compose$(tput sgr 0)\n"
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
#
COMPOSE_VERSION=$(docker-compose --version)
DOCKER_VERSION=$(docker --version)

echo -e "$(tput setaf 6)\u26a1 $DOCKER_VERSION + $COMPOSE_VERSION installed!$(tput sgr 0)"