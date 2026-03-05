brew update
sudo gem install cocoapods
brew install the_silver_searcher
brew install --cask wireshark
brew install --cask wezterm
brew install zsh-syntax-highlighting
brew install xwmx/taps/nb
brew install fortune cowsay
brew install gh ghq git-delta
brew install --cask Zettlr

brew install zsh-autosuggestions
# brew install zsh-autocomplete
# brew install zsh-completions
brew install zsh-syntax-highlighting


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
