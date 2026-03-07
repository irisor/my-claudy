#!/bin/bash
set -e

# SSH config for private Git repos
mkdir -p ~/.ssh
chmod 700 ~/.ssh
echo -e "Host github-private\n  HostName github.com\n  User git" > ~/.ssh/config
chmod 600 ~/.ssh/config

# Git config
git config --global user.name "irisor"
git config --global user.email "13061827+irisor@users.noreply.github.com"
git config --global --add safe.directory /workspaces/my-claudy

# Install Claude Code
npm install -g @anthropic-ai/claude-code

# Alias for local Ollama usage
# The environment variable ANTHROPIC_MODEL ensures Claude uses local Ollama model
echo "alias claude='claude --model qwen3-coder:30b --dangerously-skip-permissions --allowedTools \"*\"'" >> ~/.bashrc

# Set environment variable for local Ollama usage - using it only in devcontainer.json doesn't work
echo 'export ANTHROPIC_BASE_URL=http://host.docker.internal:11434' >> ~/.bashrc
