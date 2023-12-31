#!/bin/bash
# This is a script to quickly set up the dotfiles on a new setup.

DOTS="$HOME/dotfiles"

if ! command -v git &> /dev/null
then
    osascript -e 'display notification "Installing Xcode command line tools..."'
    xcode-select --install
fi

# homebrew setup
osascript -e 'display notification "Installing homebrew..."'
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew tap homebrew/cask
brew tap homebrew/cask-fonts
brew tap homebrew/cask-versions

brew install bat tmux tpm nvm neovim ripgrep fzf fd lazygit pfetch gnu-sed gh starship zoxide lsd make pip python npm node cargo thefuck
brew install --cask alacritty alt-tab discord-canary font-jetbrains-mono-nerd-font rectangle 1password 1password-cli firefox microsoft-edge obsidian raycast slack spotify visual-studio-code ngrok docker dozer postman

# zsh setup
osascript -e 'display notification "Setting up zsh..."'
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
source zshrc
ln -s $DOTS/zshrc $HOME/.zshrc
ln -s $DOTS/zprestorc $HOME/.zprestorc

# .config folder setup
osascript -e 'display notification "Setting up .config folder"'
ln -s $DOTS/config/* $HOME/.config

# ----------------------- Dock and finder settings ---------------------------
# Show all files in finder (hiddens included)
defaults write com.apple.finder AppleShowAllFiles -boolean true; killall Finder;

# Change minimize/maximize window effect
defaults write com.apple.dock mineffect -string "scale"

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don't use
# the Dock to launch apps.
defaults write com.apple.dock persistent-apps -array

# Group windows by application in Mission Control
defaults write com.apple.dock expose-group-by-app -bool true

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Don't show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

defaults write com.apple.dock static-only -bool true

defaults write com.apple.dock tilesize -int 18

# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Move dock to the left
defaults write com.apple.dock orientation -string "left"
# --------------------- End dock and finder settings ------------------------
