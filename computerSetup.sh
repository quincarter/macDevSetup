#!/usr/bin/env bash
# Installs and sets up apps for macOs Dev setup

#Mac App Store Apps First
mas install 803453959  # Slack

xcode-select --install


echo Install Homebrew packages
brew install wget
brew install mackup

brew install bash-completion
brew tap homebrew/completions
brew install homebrew/completions/packer-completion

brew tap phinze/cask
brew install brew-cask

brew cask install iterm2
brew cask install java

echo Installing SpectacleApp
brew cask install spectacle

echo Install Dev Apps
echo Installing Virtualbox
brew cask install virtualbox

echo Installing SourceTree
brew cask install sourcetree

echo Install Some additional Apps
brew cask install spotify

echo "Installing Google Chrome"
brew cask install google-chrome

# Install docker
open https://www.docker.com/products/docker\#/mac

# Install Jetbrains Toolbox
open https://www.jetbrains.com/toolbox/app/

# cleanup
brew cleanup --force
rm -f -r /Library/Caches/Homebrew/*

# restore dot files
mackup restore

# mac defaults
defaults write com.apple.screencapture type jpg
