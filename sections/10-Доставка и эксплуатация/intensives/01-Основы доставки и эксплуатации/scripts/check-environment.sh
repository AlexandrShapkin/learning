#!/usr/bin/env bash

set -u

required=(bash git make curl jq go docker kubectl helm kustomize psql openssl sha256sum)
recommended=(gh yq cosign syft trivy grype kind k3d k3s argocd flux act mc pg_dump pg_restore)
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
helm version --short 2>/dev/null || true
kustomize version 2>/dev/null || true
psql --version 2>/dev/null || true
cosign version 2>/dev/null | head -n 1 || true
syft version 2>/dev/null | head -n 1 || true

printf '\nCapabilities:\n'
if docker info >/dev/null 2>&1; then
  printf '[ok] Container runtime is accessible.\n'
else
  printf '[warning] Container runtime is unavailable.\n'
fi
if kubectl cluster-info >/dev/null 2>&1; then
  printf '[ok] Kubernetes context is reachable: %s\n' "$(kubectl config current-context 2>/dev/null || echo unknown)"
else
  printf '[info] No reachable Kubernetes cluster; create one before deployment sprints.\n'
fi
if git diff --quiet --ignore-submodules HEAD -- 2>/dev/null && git diff --cached --quiet --ignore-submodules HEAD -- 2>/dev/null; then
  printf '[ok] Git worktree is clean.\n'
else
  printf '[warning] Git worktree has changes; reproducibility exercises require an explicit source state.\n'
fi

if (( EUID == 0 )); then
  printf '[warning] Run delivery tools as an unprivileged user; elevate only explicit host setup.\n'
fi

if (( missing != 0 )); then
  printf '\nInstall missing required tools before beginning the relevant route.\n'
  exit 1
fi

printf '\nCore delivery environment is ready. Configure repository Actions and isolated lab environments before CI/CD exercises.\n'
