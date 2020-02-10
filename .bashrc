export PATH=/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin

export PS1='\[\033[36m\]\h\[\033[00m\]:\[\033[01m\]\W\[\033[00m\] \t\[\033[1;31m\]$(__git_ps1)\[\033[00m\]\\$ '

export TERM=xterm-256color

export HISTCONTROL=ignoredups

# git
source $HOME/.git-completion.bash
source $HOME/.git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=
GIT_PS1_SHOWSTASHSTATE=1

# pyenv
export PYENV_ROOT="$HOME/.pyenv"

if [ -d "${PYENV_ROOT}" ]; then
  export PATH="$PATH:$HOME/.pyenv/bin"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# rbenv
[[ -d ~/.rbenv  ]] && \
export PATH=${HOME}/.rbenv/bin:${PATH} && \
eval "$(rbenv init -)"

# node
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$PATH:./node_modules/.bin
export NODE_PATH=`npm root -g`

alias julia='/usr/local/bin/julia'

alias ls='ls -FG'
alias ll='ls -alFG'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
