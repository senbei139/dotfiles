#!/bin/sh
ln -sf $DOTFILES_DIR/.vimrc ~/.vimrc
ln -sf $DOTFILES_DIR/.vim/rc/dein.toml ~/.vim/rc/dein.toml
ln -sf $DOTFILES_DIR/.vim/rc/dein_lazy.toml ~/.vim/rc/dein_lazy.toml
ln -sf $DOTFILES_DIR/.zshrc ~/.zshrc
ln -sf $DOTFILES_DIR/.zprofile ~/.zprofile
ln -sf $DOTFILES_DIR/.tmux.conf ~/.tmux.conf
ln -sf $DOTFILES_DIR/.agignore ~/.agignore
ln -sf $DOTFILES_DIR/.gitconfig ~/.gitconfig
ln -sf $DOTFILES_DIR/nvim/init.lua ~/.config/nvim/init.lua
ln -sf $DOTFILES_DIR/nvim/lua/*.lua ~/.config/nvim/lua/
ln -sf $DOTFILES_DIR/nvim/lua/plugins/*.lua ~/.config/nvim/lua/plugins/
ln -sf $DOTFILES_DIR/nvim/lazy-lock.json ~/.config/nvim/lazy-lock.json
# /usr/local/bin は root 所有なので sudo なしで置ける ~/.local/bin を使う
ln -sf $DOTFILES_DIR/tmux-status ~/.local/bin/tmux-status
ln -sf $DOTFILES_DIR/tmux-switch ~/.local/bin/tmux-switch
ln -sf $DOTFILES_DIR/tmux-oil ~/.local/bin/tmux-oil
ln -sf $DOTFILES_DIR/lazygit/config.yml ~/.config/lazygit/config.yml
ln -sf $DOTFILES_DIR/wezterm/*.lua ~/.config/wezterm/
ln -sf $DOTFILES_DIR/.claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf $DOTFILES_DIR/.claude/settings.json ~/.claude/settings.json
ln -sf $DOTFILES_DIR/.claude/statusline.sh ~/.claude/statusline.sh
# .gpgディレクトリは手動でセットアップしてください
