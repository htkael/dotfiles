#!/bin/bash

# ====================================================================
# PATH EXPORTS
# ====================================================================
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/scripts:$PATH"
export PATH="$HOME/scripts/system:$PATH"
export PATH="$HOME/scripts/backup:$PATH"
export PATH="$HOME/scripts/dev:$PATH"
export PATH="$HOME/scripts/utils:$PATH"
export PATH="/snap/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin

# ====================================================================
# ENVIRONMENT VARIABLES
# ====================================================================
export EDITOR="nvim"
export BROWSER="google-chrome"
export WORK="$HOME/Work"
export REAMP="$HOME/Work/rei-auto-pilot"

# ====================================================================
# ALIASES
# ====================================================================
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias cls='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias gs='git status'
alias gf='git fetch --all'
alias gmh='git merge origin/hunters-testing-grounds'
alias gb='git branch'
alias dup='docker compose up --build'
alias dd='docker compose down'
alias vim='nvim'
alias sysupdate='sudo apt update && sudo apt upgrade -yy && flatpak update -yy'

# Shell-specific aliases
if [ -n "$BASH_VERSION" ]; then
  alias edit-env='$EDITOR ~/.local/env/env.sh'
  alias reload-env='source ~/.local/env/env.sh && source ~/.bashrc'
elif [ -n "$ZSH_VERSION" ]; then
  alias edit-env='$EDITOR ~/.local/env/env.sh'
  alias reload-env='source ~/.local/env/env.sh && source ~/.zshrc'
fi

# ====================================================================
# FUNCTIONS
# ====================================================================
mckd() {
  mkdir -p "$1" && cd "$1"
}

gstat() {
  echo "=== Git Status ==="
  git status -s
  echo ""
  echo "=== Current Branch ==="
  git branch --show-current
  echo ""
  echo "=== Recent Commits ==="
  git log --oneline -5
}

devstart() {
  echo "Starting development environment..."
  cd ~/Work/rei-auto-pilot || {
    echo "Project directory not found!"
    return 1
  }

  if ! docker info >/dev/null 2>&1; then
    echo "Docker daemon not running. Starting Docker Desktop..."
    systemctl --user start docker-desktop

    echo "Waiting for Docker daemon to start..."
    local timeout=60
    local count=0
    while ! docker info >/dev/null 2>&1; do
      if [ $count -ge $timeout ]; then
        echo "❌ Timeout waiting for Docker daemon to start"
        return 1
      fi
      sleep 2
      count=$((count + 2))
      printf "."
    done
    echo " ✅ Docker daemon ready!"
  fi

  echo "🚀 Starting containers..."
  docker compose up --build -d
  sleep 5

  if [ -n "$TMUX" ]; then
    tmux split-window -h
    tmux split-window -v
    tmux send-keys -t 0 "cd ~/Work/rei-auto-pilot && nvim ." Enter
    tmux send-keys -t 1 "cd ~/Work/rei-auto-pilot && docker compose logs -f" Enter
    tmux send-keys -t 2 "cd ~/Work/rei-auto-pilot && pwd && echo 'CLI ready in rei-auto-pilot'" Enter
    tmux select-pane -t 0
  else
    echo "This function works best in tmux. Run 'tmux' first!"
    nvim .
    return
  fi

  google-chrome http://127.0.0.1:5678 >/dev/null 2>&1 &
  telegram-desktop >/dev/null 2>&1 &
  echo "Development environment ready!"
}

devend() {
  echo "Shutting docker down..."
  docker compose down
}

sysinfo() {
  echo "=========================="
  echo "    SYSTEM INFORMATION    "
  echo "=========================="

  echo ""
  echo "=== SYSTEM ==="
  echo "Hostname: $(hostname)"
  echo "OS: $(lsb_release -d | cut -f2)"
  echo "Kernel: $(uname -r)"
  echo "Uptime: $(uptime -p)"

  echo ""
  echo "=== CPU ==="
  echo "Processor: $(lscpu | grep 'Model name' | cut -d':' -f2 | xargs)"
  echo "Cores: $(nproc)"
  echo "Load Average: $(uptime | cut -d',' -f3-5 | cut -d':' -f2)"

  echo ""
  echo "=== MEMORY ==="
  free --mega

  echo ""
  echo "=== DISK USAGE ==="
  df -h | grep -E '^/dev/'

  echo ""
  echo "=== NETWORK ==="
  echo "IP Address: $(hostname -I | awk '{print $1}')"
  echo "External IP: $(curl -s ifconfig.me)"

  echo ""
  echo "=== TOP PROCESSES (CPU) ==="
  ps aux --sort=-%cpu | head -6

  echo ""
  echo "=== TOP PROCESSES (MEMORY) ==="
  ps aux --sort=-%mem | head -6

  echo ""
  echo "=== DOCKER (if running) ==="
  if command -v docker &>/dev/null; then
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" 2>/dev/null || echo "Docker not running"
  else
    echo "Docker not installed"
  fi

  echo ""
  echo "=== LISTENING PORTS ==="
  ss -tuln | grep LISTEN | head -10
}

note() {
  local note_file="$HOME/notes/$(date +%Y-%m-%d).md"
  mkdir -p "$HOME/notes"

  if [ -z "$1" ]; then
    nvim "$note_file"
  else
    echo "$(date +%H:%M) - $*" >>"$note_file"
    echo "Note added to $(basename "$note_file")"
  fi
}

backup() {
  local backup_dir="$HOME/Backups/$(date +%Y-%m-%d)"
  mkdir -p "$backup_dir/"

  cp -r ~/.local/env "$backup_dir/"
  cp -r ~/Work "$backup_dir/" 2>/dev/null || echo "Work dir backup skipped"

  echo "backup created in $backup_dir"
}

project() {
  if [ -z "$1" ]; then
    echo "Available projects:"
    ls -1 "$WORK"
    return
  fi

  cd "$WORK/$1" || {
    echo "Project $1 not found"
    return 1
  }

  if [ -f "docker-compose.yml" ]; then
    echo "Docker compose file found. Run 'devstart' to start environment."
  fi
}

monitor() {
  local cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
  local mem_usage=$(free | grep Mem | awk '{printf "%.1f", $3/$2 * 100.0}')

  echo "CPU: ${cpu_usage}% | Memory: ${mem_usage}%"

  if (($(echo "$cpu_usage > 80" | bc -l))); then
    notify-send "High CPU Usage" "CPU at ${cpu_usage}%"
  fi
}

commit() {
  git add . && git commit -m "${1:-Quick update}"
}

# ====================================================================
# DOCKER FUNCTION WRAPPER
# ====================================================================
function docker() {
  if ! command -v docker >/dev/null; then
    echo "Docker not found"
    return 1
  fi
  unfunction docker
  command docker "$@"
}

export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
