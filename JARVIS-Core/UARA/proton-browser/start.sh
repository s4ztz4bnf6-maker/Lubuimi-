#!/bin/sh
set -eu
umask 077
: "${VNC_PASSWORD:?Runtime VNC password required}"
test -d /data
mountpoint -q /data || { echo "Persistent volume required"; exit 1; }
mkdir -p /data/proton-profil
x11vnc -storepasswd "$VNC_PASSWORD" /tmp/vncpass
unset VNC_PASSWORD
exec supervisord -n -c /app/supervisord.conf
