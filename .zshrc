export PATH=/usr/local/bin:/usr/bin:/bin:/sbin:/usr/sbin:/usr/local/sbin:$HOME/workspace/ml-agents/ml-agents

export LANG=ja_JP.UTF-8
export TERM=xterm-256color
export KEYTIMEOUT=1
export HISTCONTROL=ignoredups
setopt nonomatch
export HISTSIZE=1000

eval $(/opt/homebrew/bin/brew shellenv)

. /opt/homebrew/opt/asdf/libexec/asdf.sh


function precmd() {
  if [ ! -z $TMUX ]; then
    tmux refresh-client -S
  fi
}

# python
export PYTHONIOENCODING=utf-8

export PATH=$PATH:./node_modules/.bin
export NODE_PATH=`npm root -g`

# flutter
export PATH=$HOME/flutter/bin:$PATH

# git
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit

setopt transient_rprompt
PROMPT='%F{006}[%*] %#%f %c $ '

alias glog='git log --graph --all --format="%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset <%ad> %C(magenta reverse)%d%Creset %s" --date=format:"%Y/%m/%d %H:%M"'


# fzf
export PATH="$PATH:$HOME/.fzf/bin"
#export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
#export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border --inline-info --preview 'head -100 {}'"
source <(fzf --zsh)

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

alias vim='nvim'
alias lg='lazygit'

# lazydocker
alias lzd='lazydocker'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/google-cloud-sdk/path.zsh.inc' ]; then . '~/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '~/google-cloud-sdk/completion.zsh.inc' ]; then . '~/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="$PATH:$HOME/.orbstack/bin"

# bun completions
[ -s "~/.bun/_bun" ] && source "~/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
