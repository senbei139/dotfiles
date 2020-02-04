export PATH=/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin

PROMPT='%F{4}@%m%f %c $ '
# RPROMPT='%*'

eval $(gdircolors ~/dotfiles/colors/dircolors-solarized/dircolors.ansi-universal)

export TERM=xterm-256color

export HISTCONTROL=ignoredups

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

alias less='less -qR'
alias ls='gls --color=auto'
alias ll='ls -l'

# git
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit
