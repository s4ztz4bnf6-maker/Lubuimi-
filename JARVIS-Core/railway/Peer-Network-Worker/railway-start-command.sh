sh -lc 'set -eu
apt-get update -qq
apt-get install -y tor curl
mkdir -p /tmp/tor-data
chown debian-tor:debian-tor /tmp/tor-data
tor --SocksPort 127.0.0.1:9050 --DataDirectory /tmp/tor-data --User debian-tor --Log notice stdout >/tmp/tor.log 2>&1 &
tor_ok=0
for i in $(seq 1 90); do
  if curl -fsS --max-time 8 --socks5-hostname 127.0.0.1:9050 https://check.torproject.org/api/ip 2>/dev/null | grep -Eq "\"IsTor\"[[:space:]]*:[[:space:]]*true"; then
    tor_ok=1
    break
  fi
  sleep 2
done
if [ "$tor_ok" -ne 1 ]; then
  echo "JARVIS Tor bootstrap failed"
  tail -n 80 /tmp/tor.log || true
  exit 1
fi
echo "JARVIS Tor egress verified"
onion_code=$(curl -L -sS --max-time 90 --socks5-hostname 127.0.0.1:9050 -o /tmp/jarvis-onion-check.html -w "%{http_code}" "http://2gzyxa5ihm7nsggfxnu52rck2vv4rvmdlkiu3zzui5du4xyclen53wid.onion/" || true)
echo "JARVIS onion HTTP status: ${onion_code:-unavailable}"
exec node /app/cli.js --headless --browser chromium --no-sandbox --port 8931 --host 0.0.0.0 --allowed-hosts "*" --user-data-dir=/data --shared-browser-context --caps vision --proxy-server=socks5://127.0.0.1:9050'
