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

# Alias to use local Ollama model
echo 'alias claude-local="export ANTHROPIC_BASE_URL=http://host.docker.internal:11434; export ANTHROPIC_MODEL=qwen3-coder:30b; export ANTHROPIC_AUTH_TOKEN=ollama; export ANTHROPIC_API_KEY=\"\"; claude --dangerously-skip-permissions --allowedTools \"*\""' >> ~/.bashrc

# Alias for cloud subscription
echo 'alias claude-sub="claude --dangerously-skip-permissions --allowedTools \"*\""' >> ~/.bashrc

