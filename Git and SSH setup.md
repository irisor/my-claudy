# Git & SSH Setup – Windows + DevContainer (Node)

> Terminal key:
> - **Windows PowerShell (Admin)** → run as Administrator  
> - **Windows PowerShell (User)** → normal user terminal  
> - **Container Bash** → inside DevContainer shell  

---

## 1. Generate SSH Keys & Add to GitHub  
**Terminal:** Windows PowerShell (User)

```powershell
# Personal key
ssh-keygen -t ed25519 -f $env:USERPROFILE\.ssh\id_ed25519_private -C "personal@example.com"

# Work key
ssh-keygen -t ed25519 -f $env:USERPROFILE\.ssh\id_ed25519_work -C "work@example.com"

# Add the public keys (~/.ssh/*.pub) to GitHub under Settings > SSH Keys
```

## 2. Windows Host Setup

### a) Start SSH Agent Automatically

Terminal: Windows PowerShell (Admin)

```powershell
Set-Service ssh-agent -StartupType Automatic   # Must run as Admin
Start-Service ssh-agent
```
### b) Load Keys Automatically on Login

Add this to your PowerShell profile ($PROFILE) by using the following command:

Terminal: Windows PowerShell (User)

```powershell
notepad $PROFILE
```

Then add the following code to the profile script and save:
```powershell
# Start ssh-agent if not running
if ((Get-Service ssh-agent).Status -ne 'Running') { Start-Service ssh-agent }

# Load all private keys from .ssh if not already loaded
$sshDir = "$env:USERPROFILE\.ssh"
Get-ChildItem $sshDir -File | Where-Object { $_.Name -notmatch '\.pub$' } | ForEach-Object {
    if (-not (ssh-add -l | Select-String $_.FullName)) { ssh-add $_.FullName | Out-Null }
}
```

### c) Verify keys:

```powershell
ssh-add -l
```

## 3. DevContainer Setup (devcontainer.json)

Terminal: edit on host (VS Code)

```json
{
  "name": "Node DevContainer",
  "build": { "dockerfile": "Dockerfile" },
  "remoteUser": "node",
  "forwardAgent": true,
  "postCreateCommand": "mkdir -p ~/.ssh && chmod 700 ~/.ssh && echo 'Host github-private\n  HostName github.com\n  User git\n  IdentitiesOnly yes\n\nHost github-work\n  HostName github.com\n  User git\n  IdentitiesOnly yes' > ~/.ssh/config && chmod 600 ~/.ssh/config"
}
```

forwardAgent: true → uses host keys inside container

.ssh/config defines aliases for personal/work keys

## 4. Using SSH Aliases in Git

Terminal: Container Bash

```bash
# Personal repo
git clone git@github-private:username/repo.git

# Work repo
git clone git@github-work:workuser/workrepo.git
```

Test SSH connections:

```bash
ssh -T github-private
ssh -T github-work
```

Expected output:

Hi <username>! You've successfully authenticated, but GitHub does not provide shell access.
Notes

Do not mount .ssh from Windows → avoids root ownership/permission issues

.ssh → 700, config → 600 inside container

Agent forwarding keeps private keys on host

Multiple keys supported via aliases


---

✅ **Key point:**  

- The only command that must be run as **Administrator** is:  

```powershell
Set-Service ssh-agent -StartupType Automatic
```

Everything else can run in normal user PowerShell or inside the container shell.