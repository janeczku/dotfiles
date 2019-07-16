#!/usr/bin/env bash

echo "Tweaking some MacOS system settings"

# Ask for the administrator password upfront
sudo -v

# Disable auto-correct
# defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Save screenshots to a screenshots folder on the desktop
mkdir -p "$HOME/Desktop/screenshots"
defaults write com.apple.screencapture location -string "$HOME/Desktop/screenshots"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Show hidden files by default
defaults write com.apple.finder AppleShowAllFiles YES

# key rates, normal minimum is 15 (225 ms)
defaults write -g InitialKeyRepeat -float 10.0
defaults write NSGlobalDomain InitialKeyRepeat -float 10.0

# key rates, normal minimum is 2 (30 ms)
defaults write NSGlobalDomain KeyRepeat -float 1.0
defaults write -g KeyRepeat -float 1.0

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Set Safari’s home page to ‘about:blank’ for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

echo "Done!"
