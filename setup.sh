#!/bin/env bash
##### CHECK FOR SUDO or ROOT ##################################
if ! [ $(id -u) = 0 ]; then
  echo "This script must be run as sudo or root, try again..."
  exit 1
fi


#Add repositories
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

dnf install -y mesa-va-drivers mesa-vdpau-drivers
dnf install -y intel-media-driver

#gnome
dnf install \
gdm \
gnome-shell \
gnome-console \
nautilus \
gnome-calculator \
gnome-disk-utility \
gnome-system-monitor \
fastfetch \
gnome-tweaks \
rocm-hip\
unzip

#virtualization
dnf install @virtualization
systemctl enable --now libvirtd
systemctl enable --now virtnetworkd.service
usermod -aG libvirt $(whoami)

#flatpaks
flatpak install -y bazzar
flatpak install flathub io.mango3d.LycheeSlicer -y
flatpak install flathub com.vivaldi.Vivaldi -y
flatpak install flathub com.rtosta.zapzap -y
flatpak install flathub com.valvesoftware.Steam -y
flatpak install flathub com.discordapp.Discord -y
flatpak install flathub com.spotify.Client -y
flatpak install flathub com.visualstudio.code -y

#extras
curl -s https://ohmyposh.dev/install.sh | bash -s
oh-my-posh font install FiraCode

#remover
dnf remove gnome-tour

#file movement


