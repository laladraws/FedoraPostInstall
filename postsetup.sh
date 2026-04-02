#!/usr/bin/env bash
set -euo pipefail
#misc
#oh-my-posh
curl -s https://ohmyposh.dev/install.sh | bash -s
oh-my-posh font install FiraCode

#move and copy
cp -r .ohmyposh "$HOME"/
cp -r .bashrc "$HOME"/
sudo cp -r extensions/* /usr/share/gnome-shell/extensions
cp -r wallpapers "$HOME"/Imágenes

#icons
git clone https://github.com/vinceliuice/Tela-icon-theme.git /tmp/Tela-icon-theme && bash /tmp/Tela-icon-theme/install.sh -a && rm -rf /tmp/Tela-icon-theme

sudo reboot
  
