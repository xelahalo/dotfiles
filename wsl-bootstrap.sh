#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Error: Please provide the path to the dotfiles folder as an argument."
    exit 1
fi


DOTS=$1

sudo apt install neovim bat tmux zoxide fzf gh

# tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit

source zshrc
# oh my zsh install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# remove boilerplate
rm $HOME/.zshrc
ln -s "$DOTS"/zshrc $HOME/.zshrc

mkdir $HOME/.config 
ln -s "$DOTS"/config/* $HOME/.config
