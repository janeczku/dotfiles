#!/usr/bin/env bash

ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"

function log_heading() {
  echo -en "\n$COL_YELLOW[$1]$COL_RESET"
}

function log_task() {
  echo -e "\n⇒ $1..."
}

function log_ok() {
  echo -e "$COL_GREEN[✔]$COL_RESET Done!"
}

function log_err() {
  msg=${1:-Something went wrong}
  echo -e "$COL_RED[error]$COL_RESET $msg"
}

function install_from_dmg_url() {
  tempd=$(mktemp -d)
  log_task "Downloading $1"
  curl -sSL -o $tempd/pkg.dmg $1
  if [[ $? != 0 ]]; then
    log_err
  else
    log_ok
    install_from_dmg "$tempd/pkg.dmg"
  fi
}

function install_from_dmg() {
  listing=$(hdiutil attach -nobrowse $1 | grep Volumes)
  volume=$(echo "$listing" | cut -f 3)
  IFS=$'\n'
  apps=(`find "$volume" -maxdepth 1 -name "*.app"`)
  pkgs=(`find "$volume" -maxdepth 1 -name "*.pkg"`)
  if [ ${#apps[@]} -gt 0 ]; then
    log_task "Install binary ${apps[0]}"
    base=`basename "${apps[0]}"`
    dest="/Applications/$base" 
    cp -r "${apps[0]}" "$dest"
    # Disable gatekeeper
    xattr -r -d com.apple.quarantine "$dest"
  elif [ ${#pkgs[@]} -gt 0 ]; then
    log_task "Install pkg ${pkgs[0]}"
    installer -pkg ${pkgs[0]} -target /
  fi
  if [[ $? != 0 ]]; then
    log_err
  else
    log_ok
  fi
  hdiutil detach "$volume" > /dev/null
  rm -rf $tempd
}
