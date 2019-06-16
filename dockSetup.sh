#!/usr/bin/env bash

dockutil --add /Applications/Docker.app
dockutil --add /Applications/iTerm.app
dockutil --add /Applications/Angular\ Console.app
dockutil --add /Applications/Google\ Chrome.app
dockutil --add /Applications/Spotify.app
dockutil --add /Applications/Sourcetree.app
dockutil --add /Applications/VirtualBox.app

# Removing unneccessary default items
dockutil --remove Safari
dockutil --remove Books
dockutil --remove Calculator
dockutil --remove Contacts
dockutil --remove Calendar
dockutil --remove Mission Control
dockutil --remove Mail
dockutil --remove News
dockutil --remove Photo Booth
dockutil --remove Photos
dockutil --remove Reminders
dockutil --remove Stickies
dockutil --remove Time Machine
dockutil --remove Voice Memos
dockutil --remove Messages
dockutil --remove Maps
dockutil --remove iTunes
dockutil --remove FaceTime

killall Dock
