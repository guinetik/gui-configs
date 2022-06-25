#before running, set permissions chmod +x init5.sh
printf "updating pkgs...\n"
apt-get update
apt-get upgrade
#
printf "install zsh...\n"
apt install zsh
apt install jq
apt install -y unzip
apt instal highlight ## normaly i'd go for "bat" here but it 404 last time i tried
EXA_VERSION=$(curl -s "https://api.github.com/repos/ogham/exa/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
curl -Lo exa.zip "https://github.com/ogham/exa/releases/latest/download/exa-linux-x86_64-v${EXA_VERSION}.zip"
sudo unzip -q exa.zip bin/exa -d /usr/local
exa --version
rm -rf exa.zip
#
printf "install ohmyzsh...\n"
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
#
#printf "install starship.rs...\n"
#curl -sS https://starship.rs/install.sh | sh
#
printf "install zsh plugins...\n"
# Instalando o Antigen
curl -L git.io/antigen > ~/antigen.zsh
#git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
#git clone https://github.com/bhilburn/powerlevel9k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel9k
#git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
#git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
#
printf "restarting terminal..."
exec zsh
p10k configure
#
printf "copying config files...\n"
cp ./p10k/.p10k.zsh ~/.p10k.zsh
cp ./zsh/.zshrc ~/.zshrc
exec zsh
cp ./p10k/.p10k.zsh ~/.p10k.zsh
cp ./zsh/.zshrc ~/.zshrc