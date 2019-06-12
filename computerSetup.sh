#!/usr/bin/env bash
# Installs and sets up apps for macOs Dev setup

currentUser=`ls -l /dev/console | cut -d " " -f4`

sudo -u $currentUser defaults write com.apple.menuextra.battery ShowPercent YES

sudo -u $currentUser killall SystemUIServer

git clone https://github.com/kerma/defaultbrowser.git ~/Downloads/defaultbrowser && cd ~/Downloads/defaultbrowser && make && make install && cd ~/computerSetup.sh


#Mac App Store Apps First
mas install 803453959  # Slack

xcode-select --install


echo Install Homebrew packages
brew install wget
brew install mackup
brew install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

brew install bash-completion

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
defaultbrowser chrome 
rm -rf defaultbrowser

# Install docker
brew cask install docker       # Install Docker

# Install Jetbrains Toolbox
brew cask install jetbrains-toolbox

# cleanup
brew cleanup --prune

echo Install DockUtil and run ./dock_setup.sh
open https://github.com/kcrawford/dockutil/downloads

cd Downloads
curl -O https://raw.githubusercontent.com/MartinSeeler/iterm2-material-design/master/material-design-colors.itermcolors

echo Go to iTerm2 > Preferences > Profiles > Colors Tab
echo Click Color Presets… at the bottom right
echo Click Import…
echo Select the material-design-colors.itermcolors file
echo Select the material-design-colors from Load Presets…

