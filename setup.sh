#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
##### CHECK FOR SUDO or ROOT ##################################
if ! [ "$(id -u)" = 0 ]; then
  echo "This script must be run as sudo or root, try again..."
  exit 1
fi

#Add repositories
dnf install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
FEDORA_VERSION=$(rpm -E %fedora)
dnf install -y \
  "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${FEDORA_VERSION}.noarch.rpm" \
  "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${FEDORA_VERSION}.noarch.rpm"
dnf copr enable wehagy/protonplus -y



#media and libs
dnf install -y mesa-dri-drivers mesa-vulkan-drivers mesa-va-drivers ffmpeg
dnf install -y gstreamer1-vaapi rocm-opencl rocm-hip rocminfo
dnf install -y firefox fuse-libs cifs-utils unzip
dnf install -y protonplus fastfetch baobab htop evince steam remmina

#wifi
dnf install -y iwl*-firmware

#gnome
dnf install -y gdm gnome-shell ptyxis nautilus gnome-calculator 
dnf install -y gnome-disk-utility gnome-system-monitor gnome-weather  gnome-tweaks    
dnf install -y gnome-text-editor  gnome-calendar  

systemctl enable gdm.service
systemctl set-default graphical.target

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
flatpak install flathub com.heroicgameslauncher.hgl -y
flatpak install flathub com.github.tchx84.Flatseal -y

#remover
dnf remove -y gnome-tour 


#wallpapers
cp "$SCRIPT_DIR/wallpapers/"* /usr/share/backgrounds/
mkdir -p /usr/share/gnome-background-properties

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

