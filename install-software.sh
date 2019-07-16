#!/usr/bin/env bash

#-------------------------------------------
# Extra Package Sources
#-------------------------------------------

# URLs of remote DMG files
REMOTE_INSTALL_URLS=(
  # Docker for Mac CE 2.0.0.3
  https://download.docker.com/mac/stable/31259/Docker.dmg
)

# Directory containing DMG files for installation
LOCAL_INSTALL_DIR="./pkgs"

echo "MacOS Software Installation"

source utils.sh

#-------------------------------------------
# Homebrew
#-------------------------------------------

log_heading "Setting up package management"

if ! xcode-select -p &> /dev/null; then
  log_task "Installing Command Line Tools for Xcode"
  xcode-select --install >/dev/null
  read -p "Accept prompt and install Xcode, then press return."
  log_ok
fi

if which brew > /dev/null; then
  log_task "Upgrading Homebrew"
  brew upgrade > /dev/null && log_ok || log_err
else
  log_task "Installing Homebrew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && log_ok || log_err
fi

log_task "Updating Homebrew"
brew update > /dev/null && log_ok || log_err

log_heading "Installing brew packages"

log_task "Running brew bundle install"
brew bundle && log_ok || log_err

#-------------------------------------------
# DMG Installation
#-------------------------------------------

if [ ${#REMOTE_INSTALL_URLS[@]} -gt 0 ]; then
  log_heading "Installing remote packages"
  for url in "${REMOTE_INSTALL_URLS[@]}"; do
    install_from_dmg_url $url
  done
fi

if [ ! -d "$LOCAL_INSTALL_DIR" ]; then
   echo "Skipping, Directory not found: ${LOCAL_INSTALL_DIR}"
else
  files=(`find "$LOCAL_INSTALL_DIR" -maxdepth 1 -name "*.dmg"`)
  if [ ${#files[@]} -eq 0 ]; then
    echo "Skipping, No files in ${LOCAL_INSTALL_DIR}."
  else
    log_heading "Installing from local directory"
    for f in "${files[@]}"; do
      install_from_dmg $f
    done/Volumes/Untitled/dotfiles/lib_utils.sh
  fi
fi

echo "Done!"
