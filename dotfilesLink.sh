#!/bin/sh
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.vim/rc/dein.toml ~/.vim/rc/dein.toml
ln -sf ~/dotfiles/.vim/rc/dein_lazy.toml ~/.vim/rc/dein_lazy.toml
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.zprofile ~/.zprofile
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.agignore ~/.agignore
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/nvim/init.lua ~/.config/nvim/init.lua
ln -sf ~/dotfiles/nvim/lua/*.lua ~/.config/nvim/lua/
ln -sf ~/dotfiles/nvim/lua/plugins/*.lua ~/.config/nvim/lua/plugins/
ln -sf ~/dotfiles/nvim/lazy-lock.json ~/.config/nvim/lazy-lock.json
sudo ln -sf ~/dotfiles/tmux-border /usr/local/bin/tmux-border
ln -sf ~/dotfiles/lazygit/config.yml ~/.config/lazygit/config.yml
ln -sf ~/dotfiles/wezterm/*.lua ~/.config/wezterm/
ln -sf ~/dotfiles/.claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf ~/dotfiles/.claude/settings.json ~/.claude/settings.json
ln -sf ~/dotfiles/.claude/statusline.sh ~/.claude/statusline.sh
ln -sf ~/dotfiles/.gpg/.* ~/.gpg/
