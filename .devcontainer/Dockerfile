FROM mcr.microsoft.com/devcontainers/javascript-node:24
RUN apt-get update && apt-get install -y curl git
# Install UV for Python-based tool handling
RUN curl -LsSf https://astral.sh/uv/install.sh | sh