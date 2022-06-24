#
# Inspirado por: https://gist.github.com/otonii/e6bae9fabe0f19daa969f10e9047970d
# Atualizando bibliotecas MSYS2
pacman -Syu
pacman -Su
# Essential utilities
pacman -S man vim nano
pacman -S openssh rsync make
pacman -S zip unzip
pacman -S mingw64/mingw-w64-x86_64-jq
pacman -S diffutils
# 
pacman -S zsh
#
# Instalando o Oh My Zsh
cd ~
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#
# Instalando o Antigen
curl -L git.io/antigen > ~/antigen.zsh
#
# Copiando os dotfiles
#
cp ./.bashrc ~/.bashrc
cp ./.zshrc ~/.zshrc
cp ../p10k/.p10k.zsh ~/.p10k.zsh