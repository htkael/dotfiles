#!/bin/bash

SESSION_DOCKER="LEVELUPSERVE"
SESSION_DEV="LEVELUPCODE"
ROOT_DIR="$HOME/Work/levelUp/"

# DOCKER
if tmux has-session -t $SESSION_DOCKER 2>/dev/null; then
  echo "Session $SESSION_DOCKER exists..."
else
  echo "Creating session $SESSION_DOCKER..."
  tmux new-session -d -s $SESSION_DOCKER -n "docker"
  tmux send-keys -t $SESSION_DOCKER:docker "cd $ROOT_DIR" C-m
  tmux send-keys -t $SESSION_DOCKER:docker "docker compose up --build" C-m
  tmux new-window -n "term" -t $SESSION_DOCKER:
  tmux send-keys -t $SESSION_DOCKER:term "cd $ROOT_DIR" C-m
fi

# DEV
if tmux has-session -t $SESSION_DEV 2>/dev/null; then
  echo "Session $SESSION_DEV exists..."
else
  echo "Creating session $SESSION_DEV..."

  tmux new-session -d -s $SESSION_DEV -n "playground"
  tmux send-keys -t $SESSION_DEV:frontend "cd $ROOT_DIR/playground" C-m
  tmux send-keys -t $SESSION_DEV:frontend "vim ." C-m

  tmux new-window -n "factory" -t $SESSION_DEV:
  tmux send-keys -t $SESSION_DEV:backend "cd $ROOT_DIR/factory/" C-m
  tmux send-keys -t $SESSION_DEV:backend "vim ." C-m

  tmux new-window -n "term" -t $SESSION_DEV:
  tmux send-keys -t $SESSION_DEV:term "cd $ROOT_DIR" C-m
fi
