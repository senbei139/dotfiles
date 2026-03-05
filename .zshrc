export PATH=/usr/local/bin:/usr/bin:/bin:/sbin:/usr/sbin:/usr/local/sbin:/.orbstack/bin
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="$PATH":"$HOME/.pub-cache/bin"

# java
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@17/include"

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH

# dotfiles
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
export DOTFILES_DIR="$HOME/workspace/github.com/$USERNAME/dotfiles"

export LANG=ja_JP.UTF-8
export TERM=xterm-256color
export KEYTIMEOUT=1
export HISTCONTROL=ignoredups
setopt nonomatch
export HISTSIZE=1000 # シェル実行中にメモリへ保存するコマンド履歴の最大数
setopt sharehistory # 別セッションと履歴を共有
export HISTFILE=~/.zsh_history # 永続化する履歴ファイルのパスを指定
export SAVEHIST=5000 # .zsh_historyに書きこまれるコマンド履歴の最大数

eval $(/opt/homebrew/bin/brew shellenv)

. /opt/homebrew/opt/asdf/libexec/asdf.sh

function precmd() {
  if [ ! -z $TMUX ]; then
    tmux refresh-client -S
  fi
}

# python
export PYTHONIOENCODING=utf-8

# node
export PATH=$PATH:`npm prefix --location=global`/bin

# flutter
export PATH=$HOME/flutter/bin:$PATH

# go
export GOPATH=$(go env GOPATH)
export PATH=$PATH:$GOPATH/bin
#
# git
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit

setopt transient_rprompt
PROMPT='%F{006}[%*] %n%f $ '

alias glog='git log --graph --all --format="%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset <%ad> %C(magenta reverse)%d%Creset %s" --date=format:"%Y/%m/%d %H:%M"'

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

killport() {
  kill -9 $(lsof -t -i:$1)
}

alias kp='killport'

alias ls='ls -GF'
alias ll='ls -lFG'
alias la='ls -alFG'

alias vim='nvim'
alias lg='lazygit'

# lazydocker
alias lzd='lazydocker'

alias ns='caffeinate -i'
alias ccu='npx ccusage@latest'
alias cdr="cd \$(ghq root)/\$(ghq list | fzf)"

# wezterm
imgcat() {
  wezterm imgcat ${1}
}

export PATH="$PATH:$HOME/.orbstack/bin"

# bun completions
[ -s "~/.bun/_bun" ] && source "~/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/Downloads/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/Downloads/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc"; fi
source "$HOME/.rye/env"

. "$HOME/.local/bin/env"


# nb
alias memo='nb e memo.md'
alias todo='nb e todo.md'

# claude

# kiro
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"
