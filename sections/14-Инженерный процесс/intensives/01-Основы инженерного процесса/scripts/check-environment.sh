#!/usr/bin/env bash

set -u

required=(bash git make curl jq go docker psql diff patch)
recommended=(yq gh act python3 sqlite3 shellcheck markdownlint staticcheck golangci-lint govulncheck dot plantuml mmdc)
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
psql --version 2>/dev/null || true
python3 --version 2>/dev/null || true

printf '\nGit configuration:\n'
printf 'user.name: %s\n' "$(git config --global user.name 2>/dev/null || echo unset)"
printf 'user.email: %s\n' "$(git config --global user.email 2>/dev/null || echo unset)"
printf 'init.defaultBranch: %s\n' "$(git config --global init.defaultBranch 2>/dev/null || echo unset)"
printf 'pull.rebase: %s\n' "$(git config --global pull.rebase 2>/dev/null || echo unset)"

printf '\nCapabilities:\n'
if docker info >/dev/null 2>&1; then
  printf '[ok] Container runtime is accessible.\n'
else
  printf '[warning] Container runtime is unavailable.\n'
fi
if git diff --no-index /dev/null /dev/null >/dev/null 2>&1; then
  printf '[ok] Git diff tooling is available.\n'
fi
if go test ./... >/dev/null 2>&1; then
  printf '[info] Current directory contains a passing Go module.\n'
else
  printf '[info] No passing Go module in current directory; this is acceptable before workspace creation.\n'
fi

printf '\nHost capacity:\n'
printf 'CPU threads: %s\n' "$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo unknown)"
printf 'Memory: %s\n' "$(awk '/MemTotal/ {printf "%.1f GiB", $2/1024/1024}' /proc/meminfo 2>/dev/null || echo unknown)"
df -h / 2>/dev/null | tail -n 1 || true

if (( EUID == 0 )); then
  printf '[warning] Use an unprivileged user for repositories, builds and metrics.\n'
fi

if (( missing != 0 )); then
  printf '\nInstall missing required tools before beginning the relevant route.\n'
  exit 1
fi

printf '\nCore engineering-process environment is ready. Optional review, diagram, lint and metrics tools may be added before their corresponding sprints.\n'
