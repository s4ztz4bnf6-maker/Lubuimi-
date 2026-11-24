#!/bin/sh
# Run manually inside the worker image. The probe uses an isolated local Tor process.
set -eu

for tool in tor curl bun; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    printf 'Missing probe dependency: %s\n' "$tool" >&2
    exit 1
  fi
done

probe_dir=$(mktemp -d)
tor_pid=
cleanup() {
  if [ -n "$tor_pid" ]; then
    kill "$tor_pid" 2>/dev/null || true
    wait "$tor_pid" 2>/dev/null || true
  fi
  rm -rf -- "$probe_dir"
}
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

tor --version | sed -n '1p'
tor -f /dev/null --DataDirectory "$probe_dir" \
  --SocksPort 127.0.0.1:auto \
  --Log "notice stdout" >"$probe_dir/tor.log" 2>&1 &
tor_pid=$!

attempt=0
while [ "$attempt" -lt 60 ]; do
  if ! kill -0 "$tor_pid" 2>/dev/null; then
    echo 'Tor exited before completing bootstrap.' >&2
    exit 1
  fi
  if grep -q 'Bootstrapped 100%' "$probe_dir/tor.log"; then
    break
  fi
  attempt=$((attempt + 1))
  sleep 1
done

if [ "$attempt" -eq 60 ]; then
  echo 'Tor did not complete bootstrap within 60 seconds.' >&2
  exit 1
fi

port=$(sed -n 's/.*Opened Socks listener connection (ready) on 127\.0\.0\.1:\([0-9][0-9]*\).*/\1/p' "$probe_dir/tor.log" | head -n 1)
if [ -z "$port" ]; then
  echo 'Tor did not report a loopback SOCKS port.' >&2
  exit 1
fi

if ! curl --disable --noproxy '' --proxy "socks5h://127.0.0.1:$port" \
  --fail --silent --show-error --connect-timeout 10 --max-time 25 \
  --output "$probe_dir/check.json" https://check.torproject.org/api/ip; then
  echo 'Tor Project endpoint could not be reached through SOCKS.' >&2
  exit 1
fi
if ! bun -e 'const r = await Bun.stdin.json(); if (r.IsTor !== true) process.exit(1);' <"$probe_dir/check.json"; then
  echo 'Tor Project endpoint did not confirm Tor egress.' >&2
  exit 1
fi
echo 'Tor bootstrap and HTTPS egress verified (IsTor=true).'
