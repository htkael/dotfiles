#!bin/bash
# Dotfiles installer
ln -sf ~/dotfiles/shell_aliases ~/.shell_aliases
ln -sf ~/dotfiles/shell_functions ~/.shell_functions
ln -sf ~/dotfiles/shell_exports ~/.shell_exports
ln -sf ~/dotfiles/zshrc ~/.zshrc
mkdir -p ~/.config/alacritty
ln -sf ~/dotfiles/alacritty.yml ~/.config/alacritty/alacritty.yml
echo "Dotfiles installed!"
