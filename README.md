# Linux Mini Projects

A collection of small, practical Linux scripts and notes used in day-to-day cloud engineering work.I created these linux projects as part of my daily learning journey of linux systems. They do help me to control a linux VM in Azure , that i use as a workstation for my projects. Since I tried to keep the cost as low as possible, I opted out to connect to my machine trough a public IP + SSH.  

## Projects

- [`ssh/`](./ssh)
  — 1 .ssh/start-agent.sh — starts `ssh-agent` (or reuses an existing one) and loads a key so Git/SSH works smoothly

- [`linux-hardening/`](./linux-hardening) -This folder contains hardening scripts I use on an Azure Linux VM to improve security and reduce common risks.

   1. [`linux-hardening/audit-ssh.sh'](./linux-hardening/audit-ssh.sh)

Purpose: audit the current SSH configuration and print a human-readable report.
What it checks (high level):
- SSH daemon settings (`sshd_config` + effective config)
- Whether password authentication is enabled
- Whether root login is allowed
- Which users/groups are allowed (e.g., `AllowUsers`, `AllowGroups`)
- Authentication limits (e.g., `MaxAuthTries`, `LoginGraceTime`)
- File permissions on SSH config and keys (common misconfigurations)
Typical use:
bash
bash linux-hardening/audit-ssh.sh

        2. [`linux-hardening/ssh-harden.sh`](./linux-hardening/ssh-harden.sh)

Purpose: apply safer SSH defaults on the VM.

What it typically does:
-  Disables password authentication( key only login)
-  Disables direct root login
-  Restricts who can SSH in
-  Reduce brute-force asurface with safer limits (tries/timeouts)
-  Validades config (sshd -T/sshd -t) before reload/restart to avoid lockout
-  Reloads SSh safely after changes

Typical use:

bash
bash linux-hardening/ssh-harden.sh
Important: Always keep an active SSH session open when hardening SSH, in case you need to rollback.

          3. [`linux-hardening/fail2ban.sh`](./linux-hardening/fail2ban.sh)

Purpose: install and configure Fail2ban to temporarily ban IPs that repeatedly fail SSH authentication.

What it typically does:
-	Installs Fail2ban
-	Enables and configures the SSH jail
-	Sets sane defaults (ban time / find time / max retries)
-	Starts and enables the service
-	Shows status and basic verification commands

Typical use:
`bash
sudo bash linux-hardening/fail2ban.sh



## Standards

- Scripts are written for bash: `#!/usr/bin/env bash`
- Defensive mode: `set -euo pipefail`
- No secrets committed to Git
