# Conventions

## Bash
- Use: `#!/usr/bin/env bash`
- Use: `set -euo pipefail`
- Quote variables: `"$VAR"`
- Prefer small, readable scripts over clever one-liners.

## Security
- Never commit keys, tokens, or `.env` files.
- Prefer key-based SSH.