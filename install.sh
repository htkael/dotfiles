#!/bin/bash
DATE="[$(date +%T)] -"
CURRENT_DIR="$(basename "$PWD")"
EXPECTED_DIR="dotfiles"

echo "Beginning installation of desired environment..."
echo "$DATE Beginning installation of desired environment..." >>./install.log

if [[ "$EXPECTED_DIR" == "$CURRENT_DIR" ]]; then
  echo "Current working dir is correct. Continuing..."
  echo "$DATE Current working dir is correct. Continuing..." >>./install.log
  touch install.log
else
  echo "Error: Current directory is incorrect. Please navigate to dotfiles"
  echo "$DATE Error: Current directory is incorrect. Please navigate to dotfiles" >>./install.log
  exit 1

fi

echo "Running system update..."
echo "$DATE Running system update..." >>./install.log
sudo apt update && sudo apt upgrade

echo "Installing essential build tools..."
echo "$DATE Installing essential build tools..." >>./install.log
sudo apt install build-essential curl wget git ca-certificates gnupg lsb-release

echo "Making all required directories for structure..."
echo "$DATE Making all required directories for structure..." >>./install.log
mkdir -p ~/.local/bin ~/bin ~/scripts ~/Work ~/.config

echo "Installing zsh and making it default shell..."
echo "$DATE Installing zsh..." >>./install.log
sudo apt install -y zsh

if command -v zsh &>/dev/null; then
  chsh -s $(which zsh)
  echo "Zsh installed successfully!"
  echo "$DATE Zsh installed successfully!" >>./install.log
else

  echo "Zsh installation failed! Please install on your own and retry."
  echo "$DATE Zsh installation failed! Please install on your own and retry." >>./install.log
  exit 1
fi

echo "Installing Oh My Zsh..."
echo "$DATE Installing Oh My Zsh..." >>./install.log
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended

echo "Installing zsh plugins..."
echo "$DATE Installing zsh plugins..." >>./install.log
sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sudo git clone https://github.com/zsh-users/zsh-history-substring-search.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

echo "Installing Mononoki Nerd Font..."
echo "$DATE Installing Mononoki Nerd Font..." >>./install.log
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Mononoki.zip
unzip Mononoki.zip -d mononoki-font &&
  mkdir -p ~/.local/share/fonts/mononoki &&
  cp mononoki-font/*.ttf ~/.local/share/fonts/mononoki/ &&
  fc-cache -fv &&
  rm Mononoki.zip && rm -rf mononoki-font

echo "Installing Alacritty and making it default terminal..."
echo "$DATE Installing Alacritty..." >>./install.log
sudo apt install -y alacritty

if [[ -f /usr/bin/alacritty ]]; then
  sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty
  echo "Alacritty set as default terminal!"
  echo "$DATE Alacritty set as default terminal!" >>./install.log
else
  echo "Alacritty install failed. Please install on your own and try again."
  echo "$DATE Alacritty install failed. Please install on your own and try again." >>./install.log
  exit 1
fi

echo "Installing Starship..."
echo "$DATE Installing Starship..." >>./install.log
curl -sS https://starship.rs/install.sh | sh

echo "Installing tmux..." >>./install.log
sudo apt install -y tmux

echo "Installing Node Version Manager..."
echo "$DATE Installing Node Version Manager..." >>./install.log
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "Installing node.js..."
echo "$DATE Installing node.js..." >>./install.log
nvm install --lts

echo "Installing golang..."
echo "$DATE Installing golang..." >>./install.log
sudo apt install golang-go

echo "Installing docker..."
echo "$DATE Installing docker..." >>./install.log
sudo apt install apt-transport-https software-properties-common
sudo apt remove $(dpkg --get-selections docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc | cut -f1)
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo groupadd docker
sudo usermod -aG docker $USER

echo "Installing neovim..."
echo "$DATE Installing neovim..." >>./install.log
sudo apt-get install ninja-build gettext cmake curl build-essential git
git clone https://github.com/neovim/neovim
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build && cpack -G DEB && sudo dpkg -i nvim-linux-x86_64.deb
rm -rf ./neovim
echo "Neovim installed and cleaned up!"
echo "$DATE Neovim installed and cleaned up!" >>./install.log

echo "Installing neovim config dependencies..."
echo "$DATE Installing neovim config dependencies..." >>./install.log
sudo apt install -y ripgrep
sudo apt install -y fd-find
sudo apt install -y shfmt

echo "Installing various CLI tools..."
echo "$DATE Installing various CLI tools..." >>./install.log
sudo apt install -y htop
sudo apt install -y httpie
sudo apt install -y jq
sudo apt install -y tree
sudo apt install -y bat
sudo apt install -y imagemagick

echo "Installing LazyVim dependencies..."
echo "$DATE Installing LazyVim dependencies..." >>./install.log
sudo apt install -y tar
npm install -g tree-sitter-cli
sudo apt install -y fzf

echo "Creating symlinks, grabbing env file from git, and copying dotfiles over..."
echo "$DATE Creating symlinks and grabbing env file from git..." >>./install.log
git clone git@github.com:htkael/env.git ~/.local/env
sudo chmod +x ~/.local/env/reap.sh
sudo chmod +x ~/.local/env/levelUp.sh
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml
ln -sf ~/dotfiles/scripts ~/scripts
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/alacritty ~/.config/alacritty
ln -sf ~/dotfiles/nvim ~/.config/nvim

read -p "Would you like desktop apps to be added? (Telegram)? (y/n):" CONFIRMATION

if [[ "$CONFIRMATION" != [yY] ]]; then
  echo "Skipping to next step..."
  echo "$DATE Skipping to next step..." >>./install.log
else
  echo "Installing Telegram..."
  echo "$DATE Installing Telegram..." >>./install.log
  sudo apt install flatpak
  flatpak install flathub org.telegram.desktop
fi

echo ""
echo "============================================"
echo "Installation Complete!"
echo "============================================"
echo ""
echo "$DATE Installation complete!" >>./install.log

echo "Installed tools:"
echo "  - Zsh with Oh My Zsh"
echo "  - Alacritty terminal"
echo "  - Starship prompt"
echo "  - Tmux"
echo "  - Node.js (via NVM)"
echo "  - Docker"
echo "  - Neovim with dependencies"
echo "  - Various CLI tools (ripgrep, fd, htop, jq, etc.)"
echo ""

echo "Manual steps remaining:"
echo "  1. Log out and log back in for Zsh and Docker group changes to take effect"
echo "  3. Open Neovim to trigger LazyVim plugin installation: nvim"
echo ""

echo "Log file saved to: ./install.log"
echo ""
echo "Please log out and log back in now!"
