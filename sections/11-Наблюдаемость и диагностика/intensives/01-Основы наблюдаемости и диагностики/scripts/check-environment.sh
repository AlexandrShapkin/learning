#!/usr/bin/env bash

set -u

required=(bash git make curl jq go docker kubectl helm psql perf strace tcpdump ss lsof vmstat iostat)
recommended=(yq kind k3d k3s promtool amtool otelcol-contrib logcli jaeger grafana-server loki tempo pyroscope bpftrace bpftool k6 vegeta tc fio stress-ng)
missing=0

printf 'System: %s\n' "$(uname -srm 2>/dev/null || echo unknown)"
if [[ -r /etc/os-release ]]; then
  . /etc/os-release
  printf 'Distribution: %s %s\n' "${NAME:-unknown}" "${VERSION_ID:-unknown}"
fi
printf '\nRequired tools:\n'
for tool in "${required[@]}"; do
  if command -v "$tool" >/dev/null 2>&1; then
    printf '  [ok]      %-20s %s\n' "$tool" "$(command -v "$tool")"
  else
    printf '  [missing] %s\n' "$tool"
    missing=1
  fi
done

printf '\nRecommended tools:\n'
for tool in "${recommended[@]}"; do
  if command -v "$tool" >/dev/null 2>&1; then
    printf '  [ok]      %-20s %s\n' "$tool" "$(command -v "$tool")"
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
helm version --short 2>/dev/null || true
psql --version 2>/dev/null || true
perf --version 2>/dev/null || true
strace --version 2>/dev/null | head -n 1 || true

printf '\nCapabilities:\n'
if docker info >/dev/null 2>&1; then
  printf '[ok] Container runtime is accessible.\n'
else
  printf '[warning] Container runtime is unavailable.\n'
fi
if kubectl cluster-info >/dev/null 2>&1; then
  printf '[ok] Kubernetes context is reachable: %s\n' "$(kubectl config current-context 2>/dev/null || echo unknown)"
else
  printf '[info] No reachable Kubernetes cluster; create one before platform sprints.\n'
fi
if [[ -r /proc/sys/kernel/perf_event_paranoid ]]; then
  printf 'perf_event_paranoid: %s\n' "$(cat /proc/sys/kernel/perf_event_paranoid)"
fi
if [[ -d /sys/kernel/debug/tracing || -d /sys/kernel/tracing ]]; then
  printf '[ok] Kernel tracing filesystem is present.\n'
else
  printf '[info] Kernel tracing filesystem is unavailable or not mounted.\n'
fi
if command -v bpftrace >/dev/null 2>&1; then
  bpftrace --info 2>/dev/null | head -n 8 || true
fi

printf '\nHost capacity:\n'
printf 'CPU threads: %s\n' "$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo unknown)"
printf 'Memory: %s\n' "$(awk '/MemTotal/ {printf "%.1f GiB", $2/1024/1024}' /proc/meminfo 2>/dev/null || echo unknown)"
df -h / 2>/dev/null | tail -n 1 || true

if (( EUID == 0 )); then
  printf '[warning] Run applications and telemetry services as an unprivileged user; elevate only bounded host diagnostics.\n'
fi

if (( missing != 0 )); then
  printf '\nInstall missing required tools before beginning the relevant route.\n'
  exit 1
fi

printf '\nCore observability environment is ready. Collector, stores and optional profiling/eBPF tools may be completed before their corresponding sprints.\n'
