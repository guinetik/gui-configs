#!/usr/bin/env bash
##
echo -e "$(tput setaf 6)\u2699 Installing nodejs$(tput sgr 0)"
sudo apt update
sudo apt upgrade
##
curl -fsSL https://deb.nodesource.com/setup_17.x | sudo -E bash -
sudo apt-get install gcc g++ make
sudo apt-get install -y nodejs
##
VERSION=$(node --version)
##
echo -e "$(tput setaf 6)\u26a1 Node $VERSION Installed!$(tput sgr 0)"