#!/bin/env bash
##### CHECK FOR SUDO or ROOT ##################################
if ! [ $(id -u) = 0 ]; then
  echo "This script must be run as sudo or root, try again..."
  exit 1
fi


#Add repositories
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

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
rocm-hip

#flatpaks
flatpak install -y bazzar

#remover
dnf remove gnome-tour


