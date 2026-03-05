# Installation & Setup Guide

## 1. Prerequisites (Host Machine)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [VS Code](https://code.visualstudio.com/) with the "Dev Containers" extension.
- [Ollama](https://ollama.com/) (Running).

## 2. Configure Host Networking
Run these in Windows PowerShell (Admin):
```powershell
[System.Environment]::SetEnvironmentVariable('OLLAMA_HOST', '0.0.0.0', 'User')
[System.Environment]::SetEnvironmentVariable('OLLAMA_ORIGINS', '*', 'User')