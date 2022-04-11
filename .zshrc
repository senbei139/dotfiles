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
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# rbenv
[[ -d ~/.rbenv  ]] && \
export PATH=${HOME}/.rbenv/bin:${PATH} && \
eval "$(rbenv init -)"
export SECRET_KEY_BASE=`rails secret`

# node
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

export PATH=$PATH:./node_modules/.bin
export NODE_PATH=`npm root -g`

# golang
export GOPATH=/usr/local/bin/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$GOPATH/bin:$PATH
export PATH=$PATH:$GOPATH/bin

# git
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit

setopt transient_rprompt
PROMPT='%F{006}@%m%f %c $ '

alias glog='git log --graph --all --format="%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset <%ad> %C(magenta reverse)%d%Creset %s" --date=format:"%Y/%m/%d %H:%M"'


# fzf
export PATH="$PATH:$HOME/.fzf/bin"
#export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
#export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border --inline-info --preview 'head -100 {}'"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias vimf='vim `find "$1" -type f | fzf`'
alias vimd='vim `find "$1" -type d | fzf`'

fd() {
  local dir
  dir=$(find ${1:-~/workspace} -type d \( -name 'node_modules' -o -name 'vendors' -o -name 'data' -o -name 'dataset' -o -name 'tmp' -o -name '.git' \) -prune -path '*/\.*' -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

bomy() {
  local output
  output='bom_'${1}
  cat <(printf "\xEF\xBB\xBF") ${1} > $output
}

# BOM確認 16進数表示
bomcheck() {
  hexdump ${1} | head -n 1
}

alias ls='ls -GF'
alias ll='ls -lFG'
alias la='ls -alFG'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/senbei139/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/senbei139/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/senbei139/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/senbei139/google-cloud-sdk/completion.zsh.inc'; fi
