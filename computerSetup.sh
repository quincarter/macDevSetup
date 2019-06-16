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
defaults write com.apple.systemuiserver menuExtras -array "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" "/System/Library/CoreServices/Menu Extras/Volume.menu" "/System/Library/CoreServices/Menu Extras/Displays.menu"

echo Resetting UI
sudo -u $currentUser killall SystemUIServer

echo Installing Xcode stuff for development -- git included in this
xcode-select --install

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
echo Installing Virtualbox
brew cask install virtualbox

echo Installing SourceTree
brew cask install sourcetree

echo Install Some additional Apps

echo Installing Slack
brew cask install slack

echo Installing Spotify
brew cask install spotify

echo Installing Google Backup and Sync Formerly Google Drive
brew cask install google-backup-and-sync
#########################################################################





#########################################################################
##############################VSCode#####################################
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
###################Google Chrome - Set as Default browser################
#########################################################################
echo "Installing Google Chrome"
brew cask install google-chrome
defaultbrowser chrome 
rm -rf defaultbrowser

#########################################################################



#########################################################################
#########################Dev Apps Continued##############################
#########################################################################
# Install docker
brew cask install docker       # Install Docker

# Install Jetbrains Toolbox
brew cask install jetbrains-toolbox
open /Applications/Jetbrains\ Toolbox.app
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
######Downloading Angular console and installing to /Applications #######
#########################################################################
echo Downloading Angular Console disk image
wget https://github.com/nrwl/angular-console/releases/download/v8.0.0/AngularConsole-8.0.0.dmg

echo Mounting Angular Console disk image to /Volumes/Angular Console 8.0.0
hdiutil attach AngularConsole-8.0.0.dmg

echo Copying Angular Console.app to the Applications directory
cp -a /Volumes/Angular\ Console\ 8.0.0/Angular\ Console.app /Applications/Angular\ Console.app

echo unmounting Angular Console
hdiutil detach /Volumes/Angular\ Console\ 8.0.0/

echo Cleaning up disk image
rm -rf AngularConsole-8.0.0.dmg
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
cd ~/Downloads
wget https://github.com/downloads/kcrawford/dockutil/dockutil-1.1.2.pkg.dmg
hdiutil attach dockutil-1.1.2.pkg.dmg
sudo installer -pkg /Volumes/dockutil-1.1.2/dockutil-1.1.2.pkg -target /
hdiutil detach /Volumes/dockutil-1.1.2/
rm -rf dockutil-1.1.2.pkg.dmg
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

#########################################################################
