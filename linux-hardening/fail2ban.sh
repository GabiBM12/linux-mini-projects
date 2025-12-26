#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Installing fail2ban..."
sudo apt update
sudo apt install -y fail2ban

sudo tee /etc/fail2ban/jail.local >/dev/null <<EOF
[sshd]
enabled = true
port    = ssh
logpath = /var/log/auth.log
maxretry = 3
bantime = 1h
EOF

sudo systemctl enable fail2ban
sudo systemctl restart fail2ban

echo "[SUCCESS] fail2ban enabled for SSH"