#!/bin/sh
set -eu
umask 077
export XDG_DATA_HOME=/tmp/caddy-data XDG_CONFIG_HOME=/tmp/caddy-config
mountpoint -q /data || { echo "Persistent volume required"; exit 1; }
mkdir -p /data/proton-profil
chmod 700 /data/proton-profil
case "${MODE:-agent}" in
login)
 : "${ACCESS_USER:?Required}" "${ACCESS_PASSWORD:?Required}" "${VNC_PASSWORD:?Required}" "${PORT:?Required}"
 export ACCESS_HASH="$(printf '%s' "$ACCESS_PASSWORD" | caddy hash-password)"
 x11vnc -storepasswd "$VNC_PASSWORD" /tmp/vncpass >/dev/null 2>&1
 chmod 600 /tmp/vncpass
 unset ACCESS_PASSWORD VNC_PASSWORD
 CONF=/app/supervisord.conf
 ;;
agent)
 unset ACCESS_PASSWORD VNC_PASSWORD ACCESS_HASH
 CONF=/app/supervisord.agent.conf
 ;;
*) exit 1 ;;
esac
exec supervisord -n -c "$CONF"
