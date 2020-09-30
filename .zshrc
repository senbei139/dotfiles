export PATH=/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin

PROMPT='%F{044}@%m%f %c $ '

export TERM=xterm-256color

export HISTCONTROL=ignoredups

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if [ -d "${PYENV_ROOT}" ]; then
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
alias ll='ls -lFG'
alias la='ls -alFG'
alias glog='git log --graph --all --format="%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s"'

alias julia='/usr/local/bin/julia'

# fzf
# export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border --inline-info --preview 'head -100 {}'"
alias vimf='vim `find "$1" -type f | fzf`'
alias vimd='vim `find "$1" -type d | fzf`'

fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

asis() {
  curl -XPOST -u "apikey:VjcQkdj-rCxaRc0hdyUtGqGZlmJtB3Tkc0CHwblKlubC" --header "Content-Type:application/json" --data "{\"input\": {\"text\": \"${1}\"}}" "https://gateway-tok.watsonplatform.net/assistant/api/v1/workspaces/513cf3af-82d7-4229-818c-03beee65ab82/message?version=2018-09-20" | jq
}

bomy() {
  local output
  output='bom_'${1}
  cat <(printf "\xEF\xBB\xBF") ${1} > $output
}


alias ls='ls -GF'
alias ll='ls -lFG'
alias la='ls -alFG'
