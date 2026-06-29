#!/usr/bin/env bash

set -u

required=(bash git make curl jq go docker terraform ansible kubectl ip ss dig tcpdump lsblk mount df ps systemctl journalctl openssl ssh)
recommended=(virsh qemu-system-x86_64 cloud-init packer podman kind k3d k3s helm kustomize crictl ctr skopeo cosign yq fio iostat traceroute)
missing=0

printf 'System: %s\n' "$(uname -srm 2>/dev/null || echo unknown)"
if [[ -r /etc/os-release ]]; then
  . /etc/os-release
  printf 'Distribution: %s %s\n' "${NAME:-unknown}" "${VERSION_ID:-unknown}"
fi
printf 'Architecture: %s\n\n' "$(uname -m 2>/dev/null || echo unknown)"

printf 'Required tools:\n'
for tool in "${required[@]}"; do
  if command -v "$tool" >/dev/null 2>&1; then
    printf '  [ok]      %-22s %s\n' "$tool" "$(command -v "$tool")"
  else
    printf '  [missing] %s\n' "$tool"
    missing=1
  fi
done

printf '\nRecommended tools:\n'
for tool in "${recommended[@]}"; do
  if command -v "$tool" >/dev/null 2>&1; then
    printf '  [ok]      %-22s %s\n' "$tool" "$(command -v "$tool")"
  else
    printf '  [optional] %s\n' "$tool"
  fi
done

printf '\nVersions:\n'
git --version 2>/dev/null || true
go version 2>/dev/null || true
docker --version 2>/dev/null || true
docker compose version 2>/dev/null || true
terraform version 2>/dev/null | head -n 2 || true
ansible --version 2>/dev/null | head -n 1 || true
kubectl version --client 2>/dev/null || true
helm version --short 2>/dev/null || true

printf '\nCapabilities:\n'
if [[ -r /dev/kvm ]]; then
  printf '[ok] /dev/kvm is available.\n'
else
  printf '[warning] /dev/kvm is unavailable; VM labs require nested virtualization or reduced alternatives.\n'
fi
if docker info >/dev/null 2>&1; then
  printf '[ok] Docker daemon is accessible.\n'
else
  printf '[warning] Docker daemon is unavailable; configure Docker or use Podman equivalents.\n'
fi
if command -v virsh >/dev/null 2>&1 && virsh uri >/dev/null 2>&1; then
  printf '[ok] libvirt connection is accessible.\n'
else
  printf '[info] libvirt is not ready; required before VM sprints.\n'
fi

printf '\nHost capacity:\n'
printf 'CPU threads: %s\n' "$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo unknown)"
printf 'Memory: %s\n' "$(awk '/MemTotal/ {printf "%.1f GiB", $2/1024/1024}' /proc/meminfo 2>/dev/null || echo unknown)"
df -h / 2>/dev/null | tail -n 1 || true

if (( EUID == 0 )); then
  printf '[warning] Run normal laboratory commands as an unprivileged user with explicit sudo where needed.\n'
fi

if (( missing != 0 )); then
  printf '\nInstall missing required tools before beginning the relevant route.\n'
  exit 1
fi

printf '\nCore infrastructure environment is ready. VM, cloud and Kubernetes tools may be completed before their corresponding sprints.\n'
