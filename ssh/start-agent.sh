#!/usr/bin/env bash

# Enable strict mode ONLY when executed, not when sourced
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  set -euo pipefail
fi

KEY_PATH="${1:-$HOME/.ssh/id_ed25519}"

echo "== SSH Agent Starter =="

# If we're already connected to an agent, show status
if [[ -n "${SSH_AUTH_SOCK:-}" ]]; then
    if ssh-add -l >/dev/null 2>&1; then
        echo "[OK] Agent is available in this shell (SSH_AUTH_SOCK is set)."
        echo "Loaded keys:"
        ssh-add -l || true
        return 0 2>/dev/null || exit 0
    fi
fi

echo "[INFO] No usable agent in this shell. Starting a new agent..."

# IMPORTANT: must be sourced to persist env vars in current shell
eval "$(ssh-agent -s)" >/dev/null

# Add key
if [[ -f "$KEY_PATH" ]]; then
    ssh-add "$KEY_PATH"
    echo "[OK] Key added: $KEY_PATH"
else
    echo "[ERROR] Key not found: $KEY_PATH"
    exit 1
fi

ssh-add -l || true