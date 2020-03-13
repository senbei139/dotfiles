export PATH=/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin

PROMPT='%F{4}@%m%f %c $ '
# RPROMPT='%*'

eval $(gdircolors ~/dotfiles/colors/dircolors-solarized/dircolors.ansi-universal)

export TERM=xterm-256color

export HISTCONTROL=ignoredups

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

# rbenv
[[ -d ~/.rbenv  ]] && \
export PATH=${HOME}/.rbenv/bin:${PATH} && \
eval "$(rbenv init -)"

# node
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$PATH:./node_modules/.bin
export NODE_PATH=`npm root -g`

# git
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit

# alias
alias julia='/usr/local/bin/julia'
alias less='less -qR'
alias ls='gls --color=auto'
alias ll='ls -l'
alias glog='git log --graph --all --format="%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s"'

