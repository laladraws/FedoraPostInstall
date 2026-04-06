#!/bin/bash

# ============================================================
#  CONFIGURACIÓN - Editá estas variables antes de ejecutar
# ============================================================

IP="192.168.x.x"                        # IP fija del servidor
SHARE="Shared"                           # Nombre del recurso compartido
MOUNT="/home/tu_usuario/Compartido"      # Punto de montaje local
UID_USER=1000                            # UID de tu usuario (verificá con: id tu_usuario)
GID_USER=1000                            # GID de tu usuario

# ============================================================

OPTIONS="guest,noperm,uid=${UID_USER},gid=${GID_USER},iocharset=utf8,vers=3.0,_netdev"
ENTRY="//${IP}/${SHARE}  ${MOUNT}  cifs  ${OPTIONS}  0  0"

# Verificar que se ejecuta como root
if [ "$EUID" -ne 0 ]; then
    echo "Por favor ejecutá el script con sudo"
    exit 1
fi

# Verificar que cifs-utils está instalado
if ! command -v mount.cifs &> /dev/null; then
    echo "Instalando cifs-utils..."
    apt install -y cifs-utils
fi

# Crear punto de montaje si no existe
if [ ! -d "$MOUNT" ]; then
    mkdir -p "$MOUNT"
    echo "Directorio $MOUNT creado"
fi

# Agregar al fstab solo si no está ya
if ! grep -qF "//${IP}/${SHARE}" /etc/fstab; then
    echo "$ENTRY" >> /etc/fstab
    echo "Entrada agregada al fstab"
else
    echo "Ya existe una entrada para //${IP}/${SHARE} en fstab, no se modificó"
fi

# Montar
echo "Montando..."
mount -a && echo "✓ Montado correctamente en $MOUNT" || echo "✗ Error al montar, revisá los parámetros"
