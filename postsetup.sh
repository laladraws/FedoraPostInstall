#misc
#oh-my-posh
curl -s https://ohmyposh.dev/install.sh | bash -s
oh-my-posh font install FiraCode

#move and copy
cp -r .ohmyposh /home/laura/
cp -r .bashrc /home/laura/
sudo cp -r extensions/* /usr/share/gnome-shell/extensions
cp -r wallpapers /home/laura/Imágenes

#icong
git clone https://github.com/vinceliuice/Tela-icon-theme.git /tmp/Tela-icon-theme && bash /tmp/Tela-icon-theme/install.sh -a && rm -rf /tmp/Tela-icon-theme

sudo reboot
  
