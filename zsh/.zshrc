#-------------------------------------------
# ZSH Options
#-------------------------------------------

# History
HISTSIZE=10000
SAVEHIST=5000
HISTFILE=~/.zsh_history
HISTORY_IGNORE='(bg|fg|clear|exit|h|history|l|l[als]|pwd)'

setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt share_history

# Changing directories
setopt AUTO_CD
setopt AUTO_PUSHD
unsetopt pushd_ignore_dups
setopt pushdminus

# Autocorrection of commands
unsetopt correct_all

# Disable autocomplete beep
unsetopt list_beep

# Completion
setopt auto_menu
setopt always_to_end
setopt complete_in_word
unsetopt flow_control
unsetopt menu_complete

#-------------------------------------------
# OMZ Options
#-------------------------------------------

ZSH_THEME=""

ZSH_HIGHLIGHT_MAXLENGTH=60

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

#-------------------------------------------
# Powerlevel9k Theme Settings
#-------------------------------------------

POWERLEVEL9K_ALWAYS_SHOW_USER=false
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_OS_ICON_BACKGROUND="white"
POWERLEVEL9K_OS_ICON_FOREGROUND="blue"
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M \uE868  %d.%m.%y}"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true


#-------------------------------------------
# Configure Prompt
#-------------------------------------------

# export DEFAULT_USER=jan
# PROMPT=$PROMPT'$(kube_ps1) '

#-------------------------------------------
# Load zgenom
#-------------------------------------------

source ~/.zgenom/zgenom.zsh
zgenom autoupdate
if ! zgenom saved; then
  echo "zgenom init..."
  zgenom ohmyzsh
  zgenom ohmyzsh plugins/git
  zgenom ohmyzsh plugins/docker
  zgenom ohmyzsh plugins/common-aliases
  zgenom ohmyzsh plugins/golang
  zgenom ohmyzsh plugins/kubectl
  zgenom ohmyzsh plugins/kubectx
  zgenom ohmyzsh plugins/macos
  zgenom ohmyzsh plugins/tmux
  zgenom load zsh-users/zsh-autosuggestions
  # zgenom load zsh-users/zsh-completions
  zgenom load zsh-users/zsh-history-substring-search
  zgenom load zsh-users/zsh-syntax-highlighting
  # Theme
  # zgen load romkatv/powerlevel10k powerlevel10k
  zgenom save

#-------------------------------------------
# Starship
#-------------------------------------------

eval "$(starship init zsh)"

#-------------------------------------------
# Source
#-------------------------------------------

source ~/.zsh_functions

if [ -f ~/.zsh_secrets ]; then
  source ~/.zsh_secrets
fi

# Source AWS creds
if [ -f ~/.aws/aws_variables ]; then
  source ~/.aws/aws_variables
fi

#-------------------------------------------
# Aliases
#-------------------------------------------

# IP lookup
alias publicip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ip="ipconfig getifaddr en0"
# System
alias update='mas upgrade; brew cleanup; brew upgrade; brew update; brew cask cleanup; brew cu -a -y'
alias show_files='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
alias hide_files='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'
# Copy/paste public key
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | printf '=> Public key copied to pasteboard.\n'"
# Better directory listing
alias l='ls -aF'
alias ll='ls -ahlF'
alias ls='ls --color=auto --group-directories-first'

#-------------------------------------------
# Paths
#-------------------------------------------

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
export PATH=$(brew --prefix)/bin:$PATH
export PATH=$(brew --prefix)/sbin:$PATH

#-------------------------------------------
# Keymap
#-------------------------------------------

bindkey -e
#bindkey '^[[A' history-substring-search-up
#bindkey '^[[B' history-substring-search-down
