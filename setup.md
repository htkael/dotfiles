Pop OS Development Setup - Quick Reference
1. Initial System Setup
bashsudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential curl wget git ca-certificates gnupg lsb-release
2. Create Directory Structure
bashmkdir -p ~/.local/env ~/.local/bin ~/bin ~/scripts/{system,backup,dev,utils} ~/Work ~/Backups ~/notes
3. Create Master Environment File
Create ~/.local/env/env.sh with all aliases, functions, and exports (see main guide)
4. Install Zsh and Oh My Zsh
bashsudo apt install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
5. Install Zsh Plugins
bashgit clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
6. Install Starship Prompt
Look up how to download latest
7. Set Zsh as Default Shell
bashchsh -s $(which zsh)
8. Install Mononoki Nerd Font
bash# Download and extract to ~/.fonts
mkdir -p ~/.fonts
cd ~/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Mononoki.zip
unzip Mononoki.zip
rm Mononoki.zip
fc-cache -fv
9. Install Alacritty (Latest)
bashsudo add-apt-repository ppa:aslatter/ppa -y
sudo apt update
sudo apt install -y alacritty
10. Install and Configure Tmux
bashsudo apt install -y tmux
# Create ~/.tmux.conf with custom config (Ctrl-a prefix, hjkl navigation)
11. Install Node.js via NVM
Look up how to download latest
12. Install Neovim (Latest)
Look up how to download latest
13. Install Development Tools (Latest Versions)
bash# Ripgrep - look up how to download latest
# fd-find - look up how to download latest  
# shfmt - look up how to download latest

# Other tools
sudo apt install -y htop httpie jq tree
14. Install Desktop Tools
bashsudo apt install -y telegram-desktop timeshift
15. Generate SSH Key
bashssh-keygen -t ed25519 -C "your_email@example.com"
# Add to GitHub/GitLab
cat ~/.ssh/id_ed25519.pub
16. Final Steps
bash# Source environment
source ~/.local/env/env.sh
source ~/.zshrc

# Test nvim (plugins will auto-install)
nvim

# Test tmux
tmux
