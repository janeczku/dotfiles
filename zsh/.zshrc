#-------------------------------------------
# ZSH Options
#-------------------------------------------

# History
HISTSIZE=10000
SAVEHIST=5000
HISTFILE=~/.zsh_history

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
# setopt complete_aliases
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# Use emacs keymap


# Bind up/down arrow to select history-substring-search result
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down

#-------------------------------------------
# OMZ Options
#-------------------------------------------

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

#-------------------------------------------
# Terminal
#-------------------------------------------

# Keep term colors in sync across Linux and MacOS
#export LSCOLORS='Gxfxcxdxbxegedabagacad'
#export LS_COLORS='di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

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
# Spaceship Theme Settings
#-------------------------------------------

# Prompt order
SPACESHIP_PROMPT_ORDER=(
    time          # Time stampts section
    user          # Username section
    dir           # Current directory section
    host          # Hostname section
    git           # Git section (git_branch + git_status)
    golang        # Go section
    docker        # Docker section
    kubecontext   # Kubectl context section
    terraform     # Terraform workspace section
    exec_time     # Execution time
    line_sep      # Line break
    battery       # Battery level and status
    vi_mode       # Vi-mode indicator
    jobs          # Background jobs indicator
    exit_code     # Exit code section
    char          # Prompt character
)

#SPACESHIP_PROMPT_SEPARATE_LINE=false
# SPACESHIP_PROMPT_ADD_NEWLINE=false
# SPACESHIP_CHAR_SYMBOL="❯"
# SPACESHIP_CHAR_SUFFIX=" "

SPACESHIP_GOLANG_SYMBOL="·"
SPACESHIP_DOCKER_SYMBOL="·"
SPACESHIP_KUBECONTEXT_SYMBOL="ﴱ·"

#-------------------------------------------
# Plugin Settings
#-------------------------------------------

#-------------------------------------------
# Configure Prompt
#-------------------------------------------

# export DEFAULT_USER=janek
# PROMPT=$PROMPT'$(kube_ps1) '

#-------------------------------------------
# Load zgen
#-------------------------------------------

source ~/.zgen-setup

#-------------------------------------------
# Source additional files
#-------------------------------------------

source ~/.zsh_aliases
source ~/.zsh_functions

#-------------------------------------------
# Various
#-------------------------------------------

if [ "$TERM" = "screen" -a ! "$SHOWED_SCREEN_MESSAGE" = "true" ]; then
  detached_screens=$(screen -list | grep Detached)
  if [ ! -z "$detached_screens" ]; then
    echo "+---------------------------------------+"
    echo "| Detached screens are available:       |"
    echo "  $detached_screens"
    echo "+---------------------------------------+"
  fi
fi

bindkey -e