#!/usr/bin/env bash

set -u

required=(bash git make curl jq go docker kubectl psql openssl ss tcpdump)
recommended=(yq kind k3d k3s helm opa conftest step vault trivy grype syft cosign gitleaks semgrep gosec govulncheck zap-baseline.py falco auditctl nft iptables age sops)
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
openssl version 2>/dev/null || true
trivy --version 2>/dev/null | head -n 1 || true
syft version 2>/dev/null | head -n 1 || true
cosign version 2>/dev/null | head -n 3 || true

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
if openssl rand -hex 16 >/dev/null 2>&1; then
  printf '[ok] Cryptographic random generation is available.\n'
fi
if [[ -r /proc/sys/kernel/yama/ptrace_scope ]]; then
  printf 'ptrace_scope: %s\n' "$(cat /proc/sys/kernel/yama/ptrace_scope)"
fi
if [[ -r /proc/sys/kernel/unprivileged_bpf_disabled ]]; then
  printf 'unprivileged_bpf_disabled: %s\n' "$(cat /proc/sys/kernel/unprivileged_bpf_disabled)"
fi

printf '\nHost capacity:\n'
printf 'CPU threads: %s\n' "$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo unknown)"
printf 'Memory: %s\n' "$(awk '/MemTotal/ {printf "%.1f GiB", $2/1024/1024}' /proc/meminfo 2>/dev/null || echo unknown)"
df -h / 2>/dev/null | tail -n 1 || true

if (( EUID == 0 )); then
  printf '[warning] Run applications and scanners as an unprivileged user; elevate only explicit host-audit/network setup.\n'
fi

if (( missing != 0 )); then
  printf '\nInstall missing required tools before beginning the relevant route.\n'
  exit 1
fi

printf '\nCore security environment is ready. Identity, policy, scanning, signing and detection tools may be completed before their corresponding sprints.\n'
