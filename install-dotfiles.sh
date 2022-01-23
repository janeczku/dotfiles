f#!/usr/bin/env bash

source utils.sh

log_heading "Setting up your shell"

log_task "Checking Prerequisites"
if ! [ -x "$(command -v zsh)" ]; then
  log_err "zsh must be installed"
  exit 1
fi
if ! [ -x "$(command -v stow)" ]; then
  log_err "stow must be installed"
  exit 1
fi
log_ok

log_task "Installing OhMyZSH"
CHSH="no" RUNZSH="no" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
if [ $? -ne 0 ]; then
  log_err "Failed to install OhMyZSH"
  exit 1
fi
log_ok

log_task "Installing zgenom"
git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom" && log_ok || log_err

if [ -f "${HOME}/.zshrc" ]; then
    log_task "Backing up existing .zshrc file"
    mv ${HOME}/.zshrc ${HOME}/.zshrc.bak && log_ok || log_err
fi

for dir in git iterm2 secrets ssh zsh hyper.js; do
  log_task "Stowing dotfiles: $dir"
  stow --ignore='\.gitkeep' --ignore='\.gitignore' --ignore='\.DS_Store' --target=${HOME} $dir && log_ok || log_err
done

mkdir -p ${HOME}/.config
stow --ignore='\.gitkeep' --ignore='\.gitignore' --ignore='\.DS_Store' --target=${HOME}/.config dot.config && log_ok || log_err

# log_task "Generating SSH key pair"
# ssh-keygen -t ed25519 -C "jabruder@gmail.com" -q -N "" -f ${HOME}/.ssh/id_ed25519

log_task "Adding SSH key to ssh-agent"
ssh-add -K ${HOME}/.ssh/id_ed25519 && log_ok || log_err
ssh-add -K ${HOME}/.ssh/id_rsa && log_ok || log_err

# log_task "Setting default shell to: $(which zsh)"
# chsh -s $(which zsh) && log_ok || log_err

echo "
Done!
Finish by importing ITerm2 preferences from ~/iterm2:
Change the iTerm2 theme to Minimal
Change profile -> color presets
Select Hack Nerd Font Mono under iTerm2 Preference > Profile > Text
"
