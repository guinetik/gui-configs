#!/usr/bin/env bash
#set -ex
# getting this script's DIR
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# getting current user's DIR
#HOME_DIR=$(bash -c -s "cd ~$(printf %q $USER) && pwd")
HOME_DIR=~
echo $SCRIPT_DIR
echo $HOME_DIR
###
LIB_NAME="bash-oo-framework"
LIB_LINK='https://github.com/niieani/bash-oo-framework/archive/refs/tags/2.1.tar.gz'
LIB_FOLDER="/usr/lib/$LIB_NAME-2.1"
###
###
downloadBashLib() {
    echo "$(tput setaf 6)>>$(tput setaf 6)Downloading bash-oo-framework...$(tput sgr 0)"
    sudo curl -L -k $LIB_LINK | sudo tar -xz -C /usr/lib
}
downloadExa() {
    EXA_VERSION=$(curl -s "https://api.github.com/repos/ogham/exa/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
    sudo curl -Lo exa.zip "https://github.com/ogham/exa/releases/latest/download/exa-linux-x86_64-v${EXA_VERSION}.zip"
    sudo unzip -q exa.zip bin/exa -d /usr/local
    exa --version
    rm -rf exa.zip
}
###
[ ! -d $LIB_FOLDER ] && downloadBashLib
###
source "$LIB_FOLDER/lib/oo-bootstrap.sh"
import util/log util/exception util/tryCatch util/namedParameters util/class
####
####
namespace guinetik
Log::AddOutput guinetik INFO
####
try {
    ###
    echo ""
    Log "$(UI.Color.Cyan)$(UI.Powerline.Lightning) Update apt-get?$(UI.Color.Default)"
    read -n1 -p "$(UI.Color.Cyan)Choose: [$(UI.Color.Yellow)y$(UI.Color.Default),$(UI.Color.Yellow)n$(UI.Color.Default)]$(UI.Color.Default)" doit
    echo ""
    case $doit in
        y|Y) {
                sudo apt update
                sudo apt upgrade
            }
    esac
    ###
    Log "$(UI.Color.Cyan)$(UI.Powerline.Lightning) Installing essential packages$(UI.Color.Default)"
    sudo apt install zsh
    sudo apt install jq
    sudo apt install -y unzip
    sudo apt install highlight
    ##
    Log "$(UI.Color.Cyan)$(UI.Powerline.Cog) Install $(UI.Color.Blue)Docker?$(UI.Color.Default)"
    read -n1 -p "$(UI.Color.Cyan)Choose: [$(UI.Color.Yellow)y$(UI.Color.Default),$(UI.Color.Yellow)n$(UI.Color.Default)]$(UI.Color.Default)" doit
    echo ""
    case $doit in
        y|Y) bash ../util/install-docker-compose.sh
    esac
    echo ""
    ####
    Log "$(UI.Color.Cyan)$(UI.Powerline.Cog) Install $(UI.Color.Green)NodeJS?$(UI.Color.Default)"
    read -n1 -p "$(UI.Color.Cyan)Choose: [$(UI.Color.Yellow)y$(UI.Color.Default),$(UI.Color.Yellow)n$(UI.Color.Default)]$(UI.Color.Default)" doit
    echo ""
    case $doit in
        y|Y) bash ../util/install-node-debian.sh
    esac
    ###
    echo ""
    Log "$(UI.Color.Cyan)$(UI.Powerline.Cog) Install $(UI.Color.LightRed)Rust?$(UI.Color.Default)"
    read -n1 -p "$(UI.Color.Cyan)Choose: [$(UI.Color.Yellow)y$(UI.Color.Default),$(UI.Color.Yellow)n$(UI.Color.Default)]$(UI.Color.Default)" doit
    echo ""
    case $doit in
        y|Y) sh -c ../util/install-rust-wsl.sh
    esac
    echo ""
    Log "$(UI.Color.Cyan)$(UI.Powerline.Cog) Install $(UI.Color.Red)Java?$(UI.Color.Default)"
    read -n1 -p "$(UI.Color.Cyan)Choose: [$(UI.Color.Yellow)y$(UI.Color.Default),$(UI.Color.Yellow)n$(UI.Color.Default)]$(UI.Color.Default)" doit
    echo ""
    case $doit in
        y|Y) sh -c ../util/install-openjdk.sh
    esac
    echo ""
    ###
    echo ""
    Log "$(UI.Color.Cyan)$(UI.Powerline.Cog) Install $(UI.Color.White)Wakatime?$(UI.Color.Default)"
    read -n1 -p "$(UI.Color.Cyan)Choose: [$(UI.Color.Yellow)y$(UI.Color.Default),$(UI.Color.Yellow)n$(UI.Color.Default)]$(UI.Color.Default)" doit
    echo ""
    case $doit in
        y|Y) sh -c ../util/install-wakatime.sh
    esac
    echo ""
    ###
    Log "$(UI.Color.Cyan)$(UI.Powerline.Lightning) Installing exa for $(UI.Color.Underline)beautiful list commands!$(UI.Color.Default)"
    read -n1 -p "$(UI.Color.Cyan)Choose: [$(UI.Color.Yellow)y$(UI.Color.Default),$(UI.Color.Yellow)n$(UI.Color.Default)]$(UI.Color.Default)" doit
    echo ""
    case $doit in
        y|Y) downloadExa
    esac
    
    ##
    Log "$(UI.Color.Cyan)$(UI.Powerline.Lightning) Installing antigen $(UI.Color.Underline)for zsh Plugins$(UI.Color.Default)"
    curl -L git.io/antigen > $HOME_DIR/antigen.zsh
    ##
    try {
        Log "$(UI.Color.Cyan)$(UI.Powerline.Lightning) Installing oh-my-zsh$(UI.Color.Default)"
        rm -rf $HOME_DIR/.oh-my-zsh
        Log "$(UI.Color.Yellow)$(UI.Powerline.Lightning) After OZSH installs it will launch the first time.$(UI.Color.Default)"
        Log "$(UI.Color.Yellow)$(UI.Powerline.Lightning) leave out of that with exit to come back to the setup$(UI.Color.Default)"
        Log "$(UI.Color.Yellow)$(UI.Powerline.Lightning) Press y to continue...$(UI.Color.Default)"
        read -n1 -p "$(UI.Color.Cyan)Choose: [$(UI.Color.Yellow)y$(UI.Color.Default),$(UI.Color.Yellow)n$(UI.Color.Default)]$(UI.Color.Default)" doit
        echo ""
        case $doit in
            y|Y) sh -c "$(curl -SL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        esac
        } catch {
        Log "$(UI.Color.Red)$(UI.Powerline.Fail) Error installing oh-my-zsh$(UI.Color.Default)"
        exit 1
    }
    ##
    Log "$(UI.Color.Cyan)$(UI.Powerline.Cog) Copying dotfiles$(UI.Color.Default)"
    ##
    cp $SCRIPT_DIR/../p10k/.p10k.zsh $HOME_DIR/.p10k.zsh
    cp $SCRIPT_DIR/.bashrc $HOME_DIR/.bashrc
    cp $SCRIPT_DIR/.zshrc $HOME_DIR/.zshrc
    Log "$(UI.Color.Cyan)$(UI.Powerline.Lightning) Launching zsh$(UI.Color.Default)"
    exec zsh
    # something more...
    } catch {
    Log "$(UI.Color.Red)$(UI.Powerline.Fail) Something went wrong :($(UI.Color.Default)"
    rm -rf $HOME_DIR/.oh-my-zsh
    sudo rm -rf $LIB_FOLDER
    Exception::PrintException "${__EXCEPTION__[@]}"
}