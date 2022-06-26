#!/usr/bin/env bash
# Instrunctions collated from: https://wakatime.com/terminal
# getting this script's DIR
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# getting current user's DIR
HOME_DIR=$(bash -c "cd ~$(printf %q $USER) && pwd")
###########################################################################
# DELETING WAKATIME STUFF FROM THE PAST
sudo rm -rf $HOME_DIR/.wakatime*
sudo rm -rf $HOME_DIR/wakatime
sudo rm -rf $HOME_DIR/wakatime.cfg
###########################################################################
echo -e "$(tput setaf 6)\u2699 Installing Wakatime for vim...$(tput sgr 0)"
sudo python3 -c "$(curl -SL https://raw.githubusercontent.com/wakatime/vim-wakatime/master/scripts/install_cli.py)" $HOME_DIR/wakatime
# Need to do some moving shenaningans here
sudo mv $HOME_DIR/wakatime/.wakatime $HOME_DIR/.wakatime
# Symlinking...
sudo ln -sfn $HOME_DIR/.wakatime/wakatime-cli-linux-amd64 $HOME_DIR/.wakatime/wakatime-cli
###########################################################################
echo -e "$(tput setaf 6)\u2699 Installing Wakatime for bash...$(tput sgr 0)"
sudo git clone https://github.com/gjsheep/bash-wakatime.git $HOME_DIR/wakatime/bash
# Moving files
sudo mv $HOME_DIR/wakatime/bash/*.sh $HOME_DIR/.wakatime
sudo rm -rf $HOME_DIR/wakatime
###########################################################################
echo -e "$(tput setaf 6)\u2699 Provide API KEY: $(tput sgr 0)"
# Reading API Key from input
read WAKA_API_KEY
# Copying template file
sudo cp $SCRIPT_DIR/wakatime.cfg $SCRIPT_DIR/wakatime_t.cfg
# Using sed to replace the key template with user's input
sudo sed -i "s/WAKA_API_KEY/$WAKA_API_KEY/" $SCRIPT_DIR/wakatime_t.cfg
# Moving Wakatime Config File
mv $SCRIPT_DIR/wakatime_t.cfg ~/wakatime.cfg
##
echo -e "$(tput setaf 6)\u26a1 Wakatime installed!$(tput sgr 0)"