brew update
sudo gem install cocoapods
brew install the_silver_searcher
brew install --cask wireshark
brew install --cask wezterm

# --- tmux ---
# このリポジトリの中心。tmux-switch (prefix + w) が fzf 必須で、.zshrc も fzf 前提なので
# セットで入れる。これが無いと選択画面が丸ごと動かない
brew install tmux fzf
brew install zsh-syntax-highlighting
brew install xwmx/taps/nb
brew install fortune cowsay
brew install gh ghq git-delta

# --- pre-commit ---
# 機密情報の混入を防ぐフック。.git/hooks は git 管理外なので、
# clone した環境ごとに install しないと .pre-commit-config.yaml があっても動かない
brew install pre-commit
(cd "$(dirname "$0")" && pre-commit install)


gopls version
pyright --version
typescript-language-server --version
lua-language-server --version
rust-analyzer --version
terraform-ls version


# --- Go ---
brew install go
go install golang.org/x/tools/gopls@latest

# --- Node / Web ---
brew install node
npm install -g \
  typescript \
  typescript-language-server \
  vscode-langservers-extracted \
  eslint

# --- Python ---
brew install python
pip3 install --user \
  pyright \
  python-lsp-server

# --- Lua (Neovim) ---
brew install lua
brew install lua-language-server

# --- Rust ---
brew install rust-analyzer

# --- YAML / Docker / Terraform ---
brew install \
  yaml-language-server \
  dockerfile-language-server \
  terraform-ls
