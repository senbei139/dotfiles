export PATH=/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin

export LANG=ja_JP.UTF-8
export TERM=xterm-256color
KEYTIMEOUT=1
export HISTCONTROL=ignoredups
setopt nonomatch
export HISTSIZE=1000

# python
export PYTHONIOENCODING=utf-8

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# rbenv
[[ -d ~/.rbenv  ]] && \
export PATH=${HOME}/.rbenv/bin:${PATH} && \
eval "$(rbenv init -)"

# node
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"
export PATH=$PATH:./node_modules/.bin
export NODE_PATH=`npm root -g`

# golang
export GOPATH=$HOME/go
export GOROOT=$( go env GOROOT )
export PATH=$GOPATH/bin:$PATH

# git
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit

setopt transient_rprompt
PROMPT='%F{006}@%m%f %c $ '

alias glog='git log --graph --all --format="%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset <%ad> %C(magenta reverse)%d%Creset %s" --date=format:"%Y/%m/%d %H:%M"'


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


alias uuid='uuidgen | tr [:upper:] [:lower:]'
alias puuid='echo e7ac4d91-d1bc-f151-babc-cd0e50243e99'
alias suuid='echo a65d9977-eba3-bc2a-1ff5-1f585d06da15'

alias ls='ls -GF'
alias ll='ls -lFG'
alias la='ls -alFG'
