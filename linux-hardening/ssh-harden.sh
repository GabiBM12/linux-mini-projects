#!/usr/bin/env bash
set -euo pipefail

SSHD_CONFIG="/etc/ssh/sshd_config"
BACKUP="/etc/ssh/sshd_config.bak.$(date +%F_%H%M%S)"
ALLOWED_USER="gbadmin"

echo "[INFO] Backing up sshd_config to $BACKUP"
sudo cp "$SSHD_CONFIG" "$BACKUP"

echo "[INFO] Applying SSH hardening..."

sudo sed -i \
  -e "s/^#\?PermitRootLogin.*/PermitRootLogin no/" \
  -e "s/^#\?PasswordAuthentication.*/PasswordAuthentication no/" \
  -e "s/^#\?PubkeyAuthentication.*/PubkeyAuthentication yes/" \
  -e "s/^#\?MaxAuthTries.*/MaxAuthTries 3/" \
  -e "s/^#\?LoginGraceTime.*/LoginGraceTime 30/" \
  "$SSHD_CONFIG"

if ! grep -q "^AllowUsers" "$SSHD_CONFIG"; then
  echo "AllowUsers $ALLOWED_USER" | sudo tee -a "$SSHD_CONFIG"
fi

echo "[INFO] Validating sshd configuration..."
sudo sshd -t

echo "[INFO] Restarting sshd..."
sudo systemctl restart sshd

echo "[SUCCESS] SSH hardening applied."