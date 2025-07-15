#!/bin/bash

# Pop OS Development Environment Quick Install Script
# Run this first to install all sudo-required packages

echo "🚀 Starting Pop OS Development Environment Setup..."
echo "This will install all packages that require sudo permissions."
echo ""

# Update system
echo "📦 Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install essential build tools
echo "🔧 Installing essential build tools..."
sudo apt install -y build-essential curl wget git ca-certificates gnupg lsb-release

# Install Zsh
echo "🐚 Installing Zsh..."
sudo apt install -y zsh

# Add Alacritty PPA and install
echo "💻 Installing Alacritty (latest)..."
sudo apt install alacritty

# Install Tmux
echo "🖥️  Installing Tmux..."
sudo apt install -y tmux

# Install other development tools
echo "🛠️  Installing development tools..."
sudo apt install -y htop httpie jq tree ripgrep fd-find shfmt

# Install desktop tools
echo "🖥️  Installing desktop applications..."
sudo apt install -y telegram-desktop timeshift

echo ""
echo "✅ All sudo installations complete!"
echo ""
echo "Next steps:"
echo "1. Create directory structure"
echo "2. Create env.sh file"
echo "3. Install Oh My Zsh and plugins"
echo "4. Look up and install latest versions of:"
echo "   - Starship prompt"
echo "   - Node.js (via NVM)"
echo "   - Neovim"
echo "5. Configure dotfiles"
echo ""
echo "🎉 Ready for manual installations!"
