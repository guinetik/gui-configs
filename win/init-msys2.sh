#!/usr/bin/env bash
#
# Inspirado por: https://gist.github.com/otonii/e6bae9fabe0f19daa969f10e9047970d
# Atualizando bibliotecas MSYS2
echo "$(tput setaf 6)>>$(tput setaf 0 setab 6)Installing linux apps $(tput sgr 0)"
pacman -S man vim nano
pacman -S openssh rsync make
pacman -S zip unzip
pacman -S mingw64/mingw-w64-x86_64-jq
pacman -S diffutils
echo "$(tput setaf 6)>>$(tput sgr 0)"
echo "$(tput setaf 6)>>$(tput setaf 0 setab 6)Installing zsh $(tput sgr 0)"
pacman -S zsh
CONFIG_DIR=$(pwd)
echo "$(tput setaf 6)>>$(tput setaf 0 setab 6)Installing oh-my-zsh...$(tput sgr 0)"
#
# Instalando o Oh My Zsh
echo "$(tput setaf 6)>>$(tput setaf 0 setab 6)After the instalation, leave zsh with ´exit´ to come back to the setup$(tput sgr 0)"
echo "$(tput setaf 3)>>$(tput setaf 0 setab 3)Press any key to continue$(tput sgr 0)"
read goahead
cd ~
rm -rf ~/.antigen
rm -rf ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#
# Instalando o Antigen
echo "$(tput setaf 6)>>$(tput sgr 0)"
echo "$(tput setaf 6)>>$(tput setaf 0 setab 6)Installing Antigen...$(tput sgr 0)"
curl -L git.io/antigen > ~/antigen.zsh
#
rm -rf ~/.bashrc
rm -rf ~/.zshrc
#
echo "$(tput setaf 6)>>$(tput sgr 0)"
echo "$(tput setaf 6)>>$(tput setaf 0 setab 6)Booting zsh...$(tput sgr 0)"
echo "$(tput setaf 6)>>$(tput setaf 0 setab 6)The screen will load the first time setup for ZSH.$(tput sgr 0)"
echo "$(tput setaf 6)>>$(tput setaf 0 setab 6)Select (0) to leave setup and go to ZSH.$(tput sgr 0)"
echo "$(tput setaf 6)>>$(tput setaf 0 setab 6)Then leave zsh with ´exit´ to come back to the setup$(tput sgr 0)"
echo "$(tput setaf 3)>>$(tput setaf 0 setab 3)Press any key to continue$(tput sgr 0)"
read goahead
zsh
echo "$(tput setaf 6)>>$(tput sgr 0)"
echo "$(tput setaf 6)>>$(tput setaf 0 setab 6)Booting zsh...$(tput sgr 0)"
echo "$(tput setaf 3)>>$(tput setaf 0 setab 3)Press any key to continue$(tput sgr 0)"
cd $CONFIG_DIR
pwd
cp ./.bashrc ~/.bashrc --force
cp ./.zshrc ~/.zshrc --force
cp ../p10k/.p10k.zsh ~/.p10k.zsh --force
read goahead
zsh
#
#
#
echo "$(tput setaf 6)>>$(tput sgr 0)"
echo "$(tput setaf 6)>>$(tput setaf 0 setab 6)Copying dotfiles...$(tput sgr 0)"
cp ./.bashrc ~/.bashrc --force
cp ./.zshrc ~/.zshrc --force
cp ../p10k/.p10k.zsh ~/.p10k.zsh --force
~/.bashrc