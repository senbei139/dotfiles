export PATH=/usr/local/bin:/usr/bin:/bin:/sbin:/usr/sbin:/usr/local/sbin:$HOME/workspace/ml-agents/ml-agents

export LANG=ja_JP.UTF-8
export TERM=xterm-256color
KEYTIMEOUT=1
export HISTCONTROL=ignoredups
setopt nonomatch
export HISTSIZE=1000

export PATH=$PATH:/Users/senbei139/Library/Android/sdk/platform-tools
export JAVA_HOME=/Applications/Android\ Studio.app/Contents/jre/Contents/Home

export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export SDKROOT="$(xcrun --sdk macosx --show-sdk-path)"

# c
export PATH="/usr/local/opt/llvm/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"

# python
export PYTHONIOENCODING=utf-8

export PATH=$PATH:./node_modules/.bin
export NODE_PATH=`npm root -g`

# golang
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOROOT/bin

# git
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit

setopt transient_rprompt
PROMPT='%F{006}%n@%*%f %c $ '

alias glog='git log --graph --all --format="%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset <%ad> %C(magenta reverse)%d%Creset %s" --date=format:"%Y/%m/%d %H:%M"'


# fzf
export PATH="$PATH:$HOME/.fzf/bin"
#export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
#export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border --inline-info --preview 'head -100 {}'"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

. /usr/local/opt/asdf/libexec/asdf.sh
