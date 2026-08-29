# NOTE: zsh は対話ログインシェルで .zprofile -> .zshrc の順に自動で読む。
#       ここから source すると .zshrc が二重に実行される (compinit も 2 回走る)。


export PATH="$HOME/.cargo/bin:$PATH"

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
