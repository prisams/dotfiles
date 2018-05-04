#!/bin/bash

# KeyPoints --- {{{
# To search for a specific command and details of the same
# 1. man -k

# }}}


# Import from other bash files --- {{{

include () {
  [[ -f "$1" ]] && source "$1"
}
include ~/.profile
include ~/.bashrc_local
include ~/.bash/sensitive

# }}}
# Executed commands --- {{{

# turn off ctrl-s and ctrl-q from freezing / unfreezing terminal
stty -ixon

#run cowsay
if [ -x /usr/bin/mint-fortune ]; then
     /usr/bin/mint-fortune
fi

if [ -x /usr/games/cowsay -a -x /usr/games/fortune ]; then
    fortune | cowsay -f tux
    fortune | lolcat
fi

# configure "cd" so it only shows directories
complete -d cd

# Color the directories
export LS_OPTIONS='--color=auto'
eval "$(dircolors -b)"

# }}}

# Aliases --- {{{

alias ll='ls -lrt'
alias ls='ls $LS_OPTIONS'
alias la='ls -A'
alias l='ls -CF'
alias .='cd ..'
alias ..='cd ../..'
alias ...='cd ../../..'
alias p='python3'
alias gopen='gnome-open'
alias ddot='/home/firefly/UTILS/convert-dot-file.sh'
alias uml='java -jar ~/java/plantuml.jar'
alias t='tmux new -s main'
alias kvpn='sudo openvpn \
    --config ~/openvpn/echo.conf \
    --up /etc/openvpn/update-resolv-conf \
    --down /etc/openvpn/update-resolv-conf \
    --script-security 2'
alias utest='python -W ignore -m unittest'
# Regex ignore few directories
alias ggrep="grep --perl-regexp -Ir \
  --exclude=*~ \
  --exclude=*.pyc \
  --exclude=*.csv \
  --exclude=*.tsv \
  --exclude=*.md \
  --exclude-dir=.bzr \
  --exclude-dir=.git \
  --exclude-dir=.svn \
  --exclude-dir=node_modules \
  --exclude-dir=venv"
alias push='git push origin HEAD'
alias pull='git pull origin master'
alias vim='nvim'
# remove stopped containers
alias drm="docker ps --no-trunc -aq | xargs docker rm"
# remove all untagged images
alias drmi="docker images -q --filter 'dangling=true' | xargs docker rmi"

# }}}

# Functions --- {{{
# Get the weather

ve() {
  if [ ! -d venv ]; then
    echo "Making your virtual env ....."
    python3.6 -m venv venv
    source venv/bin/activate
    pip install -U pip
    pip install bpython
    pip install neovim
  else
    source venv/bin/activate
  fi
}

vn(){
  ve
}

# Get the weather
weather() {  # arg1: Optional<location>
  if [ $# -eq 0 ]; then
    curl wttr.in/new_york
  else
    curl wttr.in/$1
  fi
}

# Reload bashrc
so(){
  source ~/.bashrc
}

# Create a new Python repo
pynew () {
  if [ $# -ne 1 ]; then
    echo "pynew <directory>"
    exit 1
  fi
  local dir_name="$1"
  mkdir "$dir_name"
  cd "$dir_name"
  git init

  mkdir instance
  cat > instance/.gitignore <<EOL
*
!.gitignore
EOL

  # venv/
  vn
  cat > .gitignore <<EOL
# Python
venv/
.venv/
__pycache__/
.tox/
.cache/
.coverage
.mypy_cache/
*.coverage*
EOL
  touch main.py
  chmod +x main.py
}
# }}}

# Command line prompt (PS1) --- {{{

COLOR_BRIGHT_GREEN="\033[38;5;10m"
COLOR_BRIGHT_BLUE="\033[38;5;115m"
COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_PURPLE="\033[1;35m"
COLOR_ORANGE="\033[38;5;202m"
COLOR_BLUE="\033[34;5;115m"
COLOR_WHITE="\033[0;37m"
COLOR_GOLD="\033[38;5;142m"
COLOR_SILVER="\033[38;5;248m"
COLOR_RESET="\033[0m"
BOLD="$(tput bold)"

function git_color {
  local git_status="$(git status 2> /dev/null)"
  local branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
  local git_commit="$(git --no-pager diff --stat origin/${branch} 2>/dev/null)"
  if [[ $git_status == "" ]]; then
    echo -e $COLOR_SILVER
  elif [[ ! $git_status =~ "working directory clean" ]]; then
    echo -e $COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "nothing to commit" ]] && \
      [[ ! -n $git_commit ]]; then
    echo -e $COLOR_GREEN
  else
    echo -e $COLOR_ORANGE
  fi
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "($branch)"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "($commit)"
  else
    echo "(no git)"
  fi
}

# Set Bash PS1

PS1_DIR="\[$BOLD\]\[$COLOR_BRIGHT_BLUE\]\w"
PS1_GIT="\[\$(git_color)\]\[$BOLD\]\$(git_branch)\[$BOLD\]\[$COLOR_RESET\]"
PS1_USR="\[$BOLD\]\[$COLOR_GOLD\]\u@\h"
PS1_END="\[$BOLD\]\[$COLOR_SILVER\]$ \[$COLOR_RESET\]"

PS1="${PS1_DIR} ${PS1_GIT}\
${PS1_USR} ${PS1_END}\n ===>  "
# }}}




# If not running interactively, don't do anything
#case $- in
#    *i*) ;;
#      *) return;;
#esac


# Environment Variables --- {{{
# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# }}}

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1) --- {{{
HISTSIZE=1000
HISTFILESIZE=2000

# }}}

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if ! shopt -oq posix; then
#  if [ -f /usr/share/bash-completion/bash_completion ]; then
#    . /usr/share/bash-completion/bash_completion
#  elif [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#  fi
#fi


# Path variables --- {{{
#pyenv
PYENV_ROOT="$HOME/.pyenv"
if [ -d "$PYENV_ROOT" ]
then
    export PYENV_ROOT
      PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"
      fi

#      # Make sure you're also exporting PATH somewhere...
      export PATH

# Spark
export PATH=$PATH:/usr/local/spark/bin

#Scala
export PATH=$PATH:/usr/local/scala/bin

#Rust
export PATH=$PATH:$HOME/.cargo/env

export PATH="$HOME/.nodenv/bin:$PATH"

#PIPENV
export PIPENV_VENV_IN_PROJECT='doit'
# }}}

cd ~/KEPLER
