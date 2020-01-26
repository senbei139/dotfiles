export PATH=/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH=$HOME/.nodebrew/current/bin:$PATH

PROMPT='@%F{6}%n%f %c $ '
RPROMPT='%*'

export TERM=xterm-256color

export HISTCONTROL=ignoredups

export PATH=$PATH:./node_modules/.bin

export NODE_PATH=`npm root -g`


alias julia='/usr/local/bin/julia'
alias less='less -qR' 
