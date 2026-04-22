#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#oh-my-posh
curl -fsSL https://ohmyposh.dev/install.sh | bash -s
oh-my-posh font install FiraCode
oh-my-posh font install IosevkaTerm

#move and copy
cp -r "$SCRIPT_DIR/.ohmyposh" "$HOME"/
cp "$HOME/.bashrc" "$HOME/.bashrc.bak"
cp "$SCRIPT_DIR/.bashrc" "$HOME/.bashrc"

#icons
git clone https://github.com/vinceliuice/Tela-icon-theme.git /tmp/Tela-icon-theme
bash /tmp/Tela-icon-theme/install.sh -a
rm -rf /tmp/Tela-icon-theme

#claude
curl -fsSL https://claude.ai/install.sh | bash

read -r -p "Setup completo. ¿Reiniciar ahora? [y/N] " response
[[ "$response" =~ ^[Yy]$ ]] && sudo reboot
