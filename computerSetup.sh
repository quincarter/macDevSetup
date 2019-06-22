#!/usr/bin/env bash
# Installs and sets up apps for macOs Dev setup


#########################################################################
######################## Initial Setup ##################################
#########################################################################

echo Setting Current user Variable
currentUser=`ls -l /dev/console | cut -d " " -f4`

echo Showing battery percentage
sudo -u $currentUser defaults write com.apple.menuextra.battery ShowPercent YES

echo Adding some system icons to the menu bar Volume, Bluetooth, Displays
defaults write com.apple.systemuiserver menuExtras -array "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" "/System/Library/CoreServices/Menu Extras/Clock.menu" "/System/Library/CoreServices/Menu Extras/Volume.menu" "/System/Library/CoreServices/Menu Extras/Displays.menu"

echo Resetting UI
sudo -u $currentUser killall SystemUIServer

echo Installing Xcode stuff for development -- git included in this
xcode-select --install


#########################################################################
################### Setting up Global Git configs #######################
#########################################################################
echo Setting global git configs for your system...
read -p 'What is your first and last name? ' fullName
read -p 'What is your email address you would like to be recognized by when you do git commits? ' emailAddress
echo

echo Setting Global Git Config: "git config --global ... located at ~/.gitconfig"
sudo git config --global user.name "$fullName"
sudo git config --global user.email "$emailAddress"

echo Setting System Git Config with sudo: "sudo git config --system ... located at /etc/gitconfig"
sudo git config --system user.name "$fullName"
sudo git config --system user.email "$emailAddress"

echo "####################### Global Git Config ###############################"
sudo git config --list --global
echo "#########################################################################"

echo "####################### System Git Config ###############################"
sudo git config --list --system
echo "#########################################################################"
#########################################################################

echo Cloning the Default Browser tool for later. Will be removed later.
git clone https://github.com/kerma/defaultbrowser.git ~/Downloads/defaultbrowser && cd ~/Downloads/defaultbrowser && make && make install && cd ~/computer_setup
# Un comment if the keyboard config gets messed up. this will set the key repeat back to default.
# defaults write NSGlobalDomain KeyRepeat -int 25 && defaults write NSGlobalDomain InitialKeyRepeat -int 6

#########################################################################


#########################################################################
###########################Homebrew Packages#############################
#########################################################################
echo Installing Homebrew and Cask
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null ; brew install caskroom/cask/brew-cask 2> /dev/null

echo Install Homebrew packages
brew install wget
brew install mackup
brew install zsh
brew install node@10
echo 'export PATH="/usr/local/opt/node@10/bin:$PATH"' >> ~/.zshrc
brew install yarn --ignore-dependencies

echo Installing Oh My ZSH! for bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo Installing Bash Completion
brew install bash-completion

echo Installing Cask for brew
brew tap phinze/cask
brew install brew-cask

echo Installing iTerm2 -- You need this more than you know!
brew cask install iterm2
echo Configuring iTerm2 to have shell integration
curl -L https://iterm2.com/misc/install_shell_integration.sh | bash

echo Installing Java
brew cask install java

#########################################################################
####################### Spectacle.app ###################################
#########################################################################
echo Installing SpectacleApp
brew cask install spectacle
echo Opening Spectacle -- Make sure to open at login
open /Applications/Spectacle.app
echo Adding Spectacle to Login Items
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Spectacle.app", hidden:true}'
#########################################################################




#########################################################################
#############################Dev Apps####################################
#########################################################################
echo Install Dev Apps...

#Installing VirtualBox
echo Installing Virtualbox
brew cask install virtualbox

#Install SourceTree
echo Installing SourceTree
brew cask install sourcetree

# Install Postman
echo Installing Postman
brew cask install postman

# Install docker
echo Installing Docker for Mac
brew cask install docker       # Install Docker

# Install Jetbrains Toolbox
echo Installing and opening Jetbrains Toolbox
brew cask install jetbrains-toolbox

# Opening Jetbrains Toolbox So you can install apps inside the toolbox
open /Applications/Jetbrains\ Toolbox.app

# Installing DBKoda - MongoDB Yoda Tool
echo installing DBKoda so you can develop MongoDB Like Yoda
brew cask install dbkoda
#########################################################################



#########################################################################
######Downloading Angular console and installing to /Applications #######
#########################################################################
echo Installing Latest angular-cli
npm i @angular/cli@latest -g --n

echo Installing Angular Console
brew cask install angular-console

echo Installing NestJS for Node and TypeScript API Development
npm i -g @nestjs/cli
#########################################################################



#########################################################################
############################# VSCode ####################################
#########################################################################
echo Installing VSCode because you need a decent text editor other than TextEdit 
brew cask install visual-studio-code

echo Uncomment the \#\# tags to add vscode \`code\` command to the PATH if it isn\'t already available
##cat << EOF >> ~/.bash_profile
# Add Visual Studio Code (code)
##export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
##EOF

#########################################################################





#########################################################################
######################### Additional Apps ###############################
#########################################################################
echo Install Some additional Apps

echo Installing Slack
brew cask install slack

echo Installing Spotify
brew cask install spotify

echo Installing Google Backup and Sync Formerly Google Drive
brew cask install google-backup-and-sync
#########################################################################





#########################################################################
###################Google Chrome - Set as Default browser################
#########################################################################
echo "Installing Google Chrome"
brew cask install google-chrome
defaultbrowser chrome 
rm -rf ~/Downloads/defaultbrowser

#########################################################################



#########################################################################
###############################Cleanup###################################
#########################################################################
brew cleanup --prune
#########################################################################

cd Downloads
curl -O https://raw.githubusercontent.com/MartinSeeler/iterm2-material-design/master/material-design-colors.itermcolors

#########################################################################





#########################################################################
#########################Generating SSH Keys#############################
#########################################################################
echo Generating SSH Key Pairs with default name as "macDevSetup"
cd ~/.ssh/
ssh-keygen -o -t rsa -b 4096 -C "macDevSetup"
cd ~/computer_setup
#########################################################################


########################################################################
######################## Running DockUtil ##############################
########################################################################
echo Install DockUtil and run ./dockSetup.sh
brew install dockutil
exec ~/computer_setup/dockSetup.sh

########################################################################


#########################################################################
####################### Tear Down #######################################
#########################################################################
### Changing back to home directory
cd ~/

echo Go to iTerm2 > Preferences > Profiles > Colors Tab
echo Click Color Presets… at the bottom right
echo Click Import…
echo Select the material-design-colors.itermcolors file
echo Select the material-design-colors from Load Presets…
echo also be sure to change the default font to powerline fonts

echo Opening iTerm for you...
open /Applications/iTerm.app

#########################################################################
