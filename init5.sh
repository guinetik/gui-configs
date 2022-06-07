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
cp ./zsh/.zshrc ~/.zshrc
cp ./zsh/nerd-font-symbols.toml ~/.config/starship.toml
#
printf "insntalling docker repository software..."
apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
#
printf "Add Docker official GPG key..."
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
#
printf "setting up docker repository"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#
printf "installing docker..."
apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
#
printf "installing docker compose...\n"
DOCKER_COMPOSE_DESTINATION=/usr/local/bin/docker-compose
DOCKER_COMPOSE_VERSION=1.29.0
curl -L https://github.com/docker/compose/releases/download/$\{DOCKER_COMPOSE_VERSION\}/docker-compose-$\(uname -s)-$(uname -m) -o $DOCKER_COMPOSE_DESTINATION
#
printf "restarting terminal..."
reset