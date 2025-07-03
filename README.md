My Pop OS Development Environment
This repository contains my complete development environment setup for Pop OS, optimized for JavaScript/React/Node.js development.
🚀 Quick Setup
1. Run the Install Script
bashgit clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod +x install.sh
./install.sh
2. Create Directory Structure
bashmkdir -p ~/.local/env ~/.local/bin ~/bin ~/scripts/{system,backup,dev,utils} ~/Work ~/Backups ~/notes
3. Link Configuration Files
bash# Link the master environment file
ln -sf ~/.dotfiles/env.sh ~/.local/env/env.sh

# Link other configs
ln -sf ~/.dotfiles/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/starship.toml ~/.config/starship.toml

# Create nvim config directory and link
mkdir -p ~/.config/nvim
ln -sf ~/.dotfiles/nvim/init.lua ~/.config/nvim/init.lua

# Create alacritty config directory and link
mkdir -p ~/.config/alacritty
ln -sf ~/.dotfiles/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
4. Install Manual Tools
Follow setup.md for installing the latest versions of:

Starship prompt
Node.js (via NVM)
Neovim

5. Complete Setup
bash# Set Zsh as default shell
chsh -s $(which zsh)

# Install Oh My Zsh and plugins (see setup.md)

# Source environment
source ~/.local/env/env.sh
source ~/.zshrc

# Generate SSH key
ssh-keygen -t ed25519 -C "your_email@example.com"
📁 Repository Structure
.
├── README.md           # This file
├── setup.md           # Detailed setup instructions
├── install.sh         # Automated sudo installations
├── env.sh             # Master environment file (aliases, functions, exports)
├── .zshrc             # Zsh configuration
├── .tmux.conf         # Tmux configuration
├── starship.toml      # Starship prompt configuration
├── alacritty/         # Alacritty terminal config
│   └── alacritty.toml
└── nvim/              # Neovim configuration
    └── init.lua
⚙️ Key Features
Terminal Setup

Shell: Zsh with Oh My Zsh
Terminal: Alacritty with Mononoki Nerd Font
Prompt: Starship
Multiplexer: Tmux with vim-style navigation

Development Tools

Editor: Neovim with LSP, Telescope, Harpoon
Languages: JavaScript, TypeScript, Node.js
Tools: ripgrep, fd-find, shfmt, httpie, jq

Key Bindings
Tmux (Prefix: Ctrl-a)

Ctrl-a + | - Split vertically
Ctrl-a + - - Split horizontally
Ctrl-a + h/j/k/l - Navigate panes (left/down/up/right)
Ctrl-a + Ctrl-d - Kill window
Ctrl-a + r - Reload config

Neovim (Leader: Space)

Space + pf - Find files (Telescope)
Space + ps - Live grep
Space + gs - Git status
Space + a - Add to Harpoon
Space + e - Harpoon menu
Space + 1-4 - Harpoon files

Custom Functions

devstart - Start development environment in tmux
devend - Stop docker containers
gstat - Enhanced git status
sysinfo - System information overview
project - Navigate to project directories
mckd - Make directory and cd into it

🔄 Updating
To update your dotfiles:
bashcd ~/.dotfiles
git pull
# Re-link any new files as needed
📝 Notes

All configurations are symlinked, so changes in this repo automatically apply
The env.sh file contains all aliases, functions, and exports in one place
Neovim plugins auto-install on first run via Lazy.nvim
See setup.md for detailed step-by-step instructions
