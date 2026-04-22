#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
sudo cp /etc/dnf/dnf.conf /etc/dnf/dnf.conf.bak
sudo cp "$SCRIPT_DIR/dnf.conf" /etc/dnf/dnf.conf
