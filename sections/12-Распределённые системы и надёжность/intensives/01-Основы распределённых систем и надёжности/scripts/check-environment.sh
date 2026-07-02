#!/usr/bin/env bash

set -u

required=(bash git make curl jq go docker kubectl psql ss tcpdump tc)
recommended=(yq kind k3d k3s nats rpk kafka-topics toxiproxy-cli redis-cli etcdctl k6 vegeta stress-ng fio nft iptables)
missing=0

printf 'System: %s\n' "$(uname -srm 2>/dev/null || echo unknown)"
if [[ -r /etc/os-release ]]; then
  . /etc/os-release
  printf 'Distribution: %s %s\n' "${NAME:-unknown}" "${VERSION_ID:-unknown}"
fi

printf '\nRequired tools:\n'
for tool in "${required[@]}"; do
  if command -v "$tool" >/dev/null 2>&1; then
    printf '  [ok]      %-18s %s\n' "$tool" "$(command -v "$tool")"
  else
    printf '  [missing] %s\n' "$tool"
    missing=1
  fi
done

printf '\nRecommended tools:\n'
for tool in "${recommended[@]}"; do
  if command -v "$tool" >/dev/null 2>&1; then
    printf '  [ok]      %-18s %s\n' "$tool" "$(command -v "$tool")"
  else
    printf '  [optional] %s\n' "$tool"
  fi
done

printf '\nVersions:\n'
git --version 2>/dev/null || true
go version 2>/dev/null || true
docker --version 2>/dev/null || true
docker compose version 2>/dev/null || true
kubectl version --client 2>/dev/null || true
psql --version 2>/dev/null || true

printf '\nCapabilities:\n'
if docker info >/dev/null 2>&1; then
  printf '[ok] Container runtime is accessible.\n'
else
  printf '[warning] Container runtime is unavailable.\n'
fi
if kubectl cluster-info >/dev/null 2>&1; then
  printf '[ok] Kubernetes context: %s\n' "$(kubectl config current-context 2>/dev/null || echo unknown)"
else
  printf '[info] No reachable Kubernetes cluster.\n'
fi
if tc qdisc show dev lo >/dev/null 2>&1; then
  printf '[ok] tc can inspect loopback qdisc.\n'
else
  printf '[warning] tc/netem experiments may require capabilities or a network namespace.\n'
fi
if [[ -r /proc/sys/net/ipv4/ip_forward ]]; then
  printf 'IPv4 forwarding: %s\n' "$(cat /proc/sys/net/ipv4/ip_forward)"
fi

printf '\nHost capacity:\n'
printf 'CPU threads: %s\n' "$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo unknown)"
printf 'Memory: %s\n' "$(awk '/MemTotal/ {printf "%.1f GiB", $2/1024/1024}' /proc/meminfo 2>/dev/null || echo unknown)"
df -h / 2>/dev/null | tail -n 1 || true

if (( EUID == 0 )); then
  printf '[warning] Run services as an unprivileged user; elevate only explicit namespace/network setup.\n'
fi

if (( missing != 0 )); then
  printf '\nInstall missing required tools before beginning the relevant route.\n'
  exit 1
fi

printf '\nCore distributed-systems environment is ready. Broker, fault proxy, cluster and optional model tools may be completed before their corresponding sprints.\n'
