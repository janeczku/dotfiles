#!/usr/bin/env bash

source utils.sh

log_heading "Setting up ZSH shell"

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
CHSH="no" RUNZSH="no" sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
if [ $? -ne 0 ]; then
  log_err "Failed to install OhMyZSH"
  exit 1
fi
log_ok

log_task "Installing zgen"
git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen" && log_ok || log_err

if [ -f "${HOME}/.zshrc" ]; then
    log_task "Backing up existing .zshrc file"
    mv ${HOME}/.zshrc ${HOME}/.zshrc.bak && log_ok || log_err
fi

for dir in git iterm2 secrets ssh zsh; do
  log_task "Stowing dotfiles: $dir"
  stow --ignore='\.gitkeep' --ignore='\.gitignore' --ignore='\.DS_Store' --target=${HOME} $dir && log_ok || log_err
done

log_task "Adding SSH key to ssh-agent"
ssh-add -K ${HOME}/.ssh/id_rsa && log_ok || log_err

log_task "Setting default shell to: $(which zsh)"
chsh -s $(which zsh) && log_ok || log_err

echo "
Done!
Finish by importing ITerm2 preferences from ~/iterm2:
Preferences > General > 'Load preferences from a custom folder or URL'
"
