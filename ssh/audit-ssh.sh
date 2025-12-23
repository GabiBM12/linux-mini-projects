#!/usr/bin/env bash
set -euo pipefail

echo "== SSH Hardening Audit (effective sshd config) =="

if ! command -v sshd >/dev/null 2>&1; then
  echo "[ERROR] sshd not found. Are you running this on a machine with OpenSSH server installed?"
  exit 1
fi

echo
echo "-- Key settings --"
sudo sshd -T | grep -E "^(passwordauthentication|permitrootlogin|allowusers|maxauthtries|logingracetime|pubkeyauthentication)\b" || true

echo
echo "-- Listening ports --"
sudo ss -lntp | grep -E "sshd|:22" || true

echo
echo "-- Authorized keys file permissions (current user) --"
ls -la "$HOME/.ssh" || true
ls -la "$HOME/.ssh/authorized_keys" 2>/dev/null || echo "[INFO] No authorized_keys in $HOME/.ssh (may be fine)."