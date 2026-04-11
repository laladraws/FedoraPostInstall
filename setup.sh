#!/usr/bin/env bash
# set -euo pipefail
##### CHECK FOR SUDO or ROOT ##################################
if ! [ $(id -u) = 0 ]; then
  echo "This script must be run as sudo or root, try again..."
  exit 1
fi

#Add repositories
dnf install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf copr enable wehagy/protonplus -y

#media and libs
dnf install -y mesa-dri-drivers mesa-vulkan-drivers mesa-va-drivers ffmpeg
dnf install -y gstreamer1-vaapi rocm-opencl rocm-hip rocm-info
dnf install -y firefox fuse-libs cifs-utils
dnf install -y protonplus

#gnome
dnf install -y gdm gnome-shell ptyxis nautilus gnome-calculator 
dnf install -y gnome-disk-utility gnome-system-monitor gnome-weather fastfetch gnome-tweaks  unzip steam 
dnf install -y gnome-text-editor htop gnome-calendar baobab evince

#virtualization
dnf -y install @virtualization 

#flatpaks
flatpak install flathub org.gnome.Boxes -y
flatpak install flathub io.github.kolunmi.Bazaar -y
flatpak install flathub com.mattjakeman.ExtensionManager -y 
flatpak install flathub io.mango3d.LycheeSlicer -y
flatpak install flathub com.rtosta.zapzap -y
flatpak install flathub com.discordapp.Discord -y
flatpak install flathub com.spotify.Client -y
flatpak install flathub com.visualstudio.code -y
flatpak install flathub io.missioncenter.MissionCenter -y
flatpak install flathub org.freecad.FreeCAD -y
flatpak install flathub com.vysp3r.ProtonPlus -y
flatpak install flathub com.heroicgameslauncher.hgl -y

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


cp -r extensions/* /usr/share/gnome-shell/extensions

echo "Wallpapers"

#wallpapers
cp ./wallpapers/*.* /usr/share/backgrounds/
mkdir /usr/share/gnome-background-properties

cat > /usr/share/gnome-background-properties/mis-fondos.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
<wallpapers>
  <wallpaper deleted="false">
    <name>back1</name>
    <filename>/usr/share/backgrounds/1.jpg</filename>
    <options>zoom</options>
  </wallpaper>
   <wallpaper deleted="false">
    <name>back2</name>
    <filename>/usr/share/backgrounds/2.jpg</filename>
    <options>zoom</options>
  </wallpaper>
   <wallpaper deleted="false">
    <name>back3</name>
    <filename>/usr/share/backgrounds/3.jpg</filename>
    <options>zoom</options>
  </wallpaper>
    <wallpaper deleted="false">
    <name>back4</name>
    <filename>/usr/share/backgrounds/4.jpg</filename>
    <options>zoom</options>
  </wallpaper>
    <wallpaper deleted="false">
    <name>back5</name>
    <filename>/usr/share/backgrounds/5.jpg</filename>
    <options>zoom</options>
  </wallpaper>
    <wallpaper deleted="false">
    <name>back6</name>
    <filename>/usr/share/backgrounds/6.jpg</filename>
    <options>zoom</options>
  </wallpaper>
    <wallpaper deleted="false">
    <name>back7</name>
    <filename>/usr/share/backgrounds/7.jpg</filename>
    <options>zoom</options>
  </wallpaper>  
    <wallpaper deleted="false">
    <name>back8</name>
    <filename>/usr/share/backgrounds/8.jpg</filename>
    <options>zoom</options>
  </wallpaper>
   <wallpaper deleted="false">
    <name>back9</name>
    <filename>/usr/share/backgrounds/9.jpg</filename>
    <options>zoom</options>
  </wallpaper>
   <wallpaper deleted="false">
    <name>back10</name>
    <filename>/usr/share/backgrounds/10.jpg</filename>
    <options>zoom</options>
  </wallpaper>
    <wallpaper deleted="false">
    <name>back11</name>
    <filename>/usr/share/backgrounds/11.jpg</filename>
    <options>zoom</options>
  </wallpaper>
    <wallpaper deleted="false">
    <name>back12</name>
    <filename>/usr/share/backgrounds/12.jpg</filename>
    <options>zoom</options>
  </wallpaper>
    <wallpaper deleted="false">
    <name>back13</name>
    <filename>/usr/share/backgrounds/13.jpg</filename>
    <options>zoom</options>
  </wallpaper>
    <wallpaper deleted="false">
    <name>back14</name>
    <filename>/usr/share/backgrounds/14.png</filename>
    <options>zoom</options>
  </wallpaper>  
</wallpapers>
EOF

dconf load /org/gnome/shell/extensions/ < gnome-extensions-backup.conf
