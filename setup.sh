#!/usr/bin/env bash
set -euo pipefail
##### CHECK FOR SUDO or ROOT ##################################
if ! [ $(id -u) = 0 ]; then
  echo "This script must be run as sudo or root, try again..."
  exit 1
fi

#Add repositories
dnf install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm


#media
dnf install -y mesa-dri-drivers mesa-vulkan-drivers mesa-va-drivers ffmpeg
dnf install -y gstreamer1-vaapi rocm-opencl 



#gnome
dnf install -y gdm gnome-shell ptyxis nautilus gnome-calculator 
dnf install -y gnome-disk-utility gnome-system-monitor gnome-weather gnome-backgrounds fastfetch gnome-tweaks rocm-hip unzip steam
dnf install -y gnome-text-editor htop gnome-calendar baobab

#virtualization
dnf -y install @virtualization 

#flatpaks
flatpak install flathub io.github.kolunmi.Bazaar -y
flatpak install flathub com.mattjakeman.ExtensionManager -y 
flatpak install flathub io.mango3d.LycheeSlicer -y
flatpak install flathub com.vivaldi.Vivaldi -y
flatpak install flathub com.rtosta.zapzap -y
flatpak install flathub com.discordapp.Discord -y
flatpak install flathub com.spotify.Client -y
flatpak install flathub com.visualstudio.code -y
flatpak install flathub io.missioncenter.MissionCenter -y
flatpak install flathub org.freecad.FreeCAD -y
flatpak install flathub com.vysp3r.ProtonPlus -y
flatpak install flathub org.gnome.Geary -y

#remover
dnf remove -y gnome-tour 

#file movement
systemctl enable --now libvirtd
systemctl enable --now virtnetworkd.service
usermod -aG libvirt "$SUDO_USER"
systemctl enable gdm.service
systemctl set-default graphical.target

#bridge network for QEMU/KVM

nmcli connection add type bridge ifname br0 con-name br0
nmcli connection add type ethernet ifname enp6s0 con-name br0-slave master br0
nmcli connection modify br0 ipv4.method auto ipv6.method auto
nmcli connection up br0