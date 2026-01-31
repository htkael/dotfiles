# Source our master environment configuration
if [ -f ~/.local/env/env.sh ]; then
    source ~/.local/env/env.sh
fi

# Path to your Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set theme
ZSH_THEME="robbyrussell"

# Enable command auto-correction
ENABLE_CORRECTION="true"

# Show completion waiting dots
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(
    git
    sudo
    colored-man-pages
    extract
    z
    zsh-autosuggestions
    zsh-syntax-highlighting
    history-substring-search
    docker
    docker-compose
    npm
    node
    systemd
    rsync
    copyfile
)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Initialize Starship prompt (will be installed later)
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/home/hunterkael/.bun/_bun" ] && source "/home/hunterkael/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
