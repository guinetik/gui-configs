#before running, set permissions chmod +x init5.sh
printf "updating pkgs...\n"
apt-get update
apt-get upgrade
#
printf "install zsh...\n"
apt install zsh
#
printf "install ohmyzsh...\n"
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
#
printf "install starship.rs...\n"
curl -sS https://starship.rs/install.sh | sh
#
printf "install zsh plugins...\n"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
#
printf "copying config files...\n"
mkdir -p ~/.config && touch ~/.config/starship.toml
cp ./zsh/.zshrc ~/.zshrc
cp ./zsh/nerd-font-symbols.toml ~/.config/starship.toml
#
printf "installing docker..."
apt-get install docker
#
printf "installing docker compose...\n"
DOCKER_COMPOSE_DESTINATION=/usr/local/bin/docker-compose
DOCKER_COMPOSE_VERSION=1.29.0
curl -L https://github.com/docker/compose/releases/download/$\{DOCKER_COMPOSE_VERSION\}/docker-compose-$\(uname -s)-$(uname -m) -o $DOCKER_COMPOSE_DESTINATION
#
printf "restarting terminal..."
reset