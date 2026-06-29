#!/usr/bin/env bash

set -u

required=(
  bash git make
  go gofmt
  docker
  psql
  curl jq
  diff grep awk sed find
  ps ss lsof
)

recommended=(
  staticcheck
  golangci-lint
  govulncheck
  dot
  mermaid
  go-callvis
  shellcheck
  perf
  strace
)

missing_required=0

printf 'System: %s\n' "$(uname -srm 2>/dev/null || echo unknown)"
if [[ -r /etc/os-release ]]; then
  . /etc/os-release
  printf 'Distribution: %s %s\n' "${NAME:-unknown}" "${VERSION_ID:-unknown}"
fi
printf 'Architecture: %s\n\n' "$(uname -m 2>/dev/null || echo unknown)"

check_group() {
  local title="$1"
  shift
  printf '%s\n' "$title"
  for command_name in "$@"; do
    if command -v "$command_name" >/dev/null 2>&1; then
      printf '  [ok]      %-18s %s\n' "$command_name" "$(command -v "$command_name")"
    else
      printf '  [missing] %s\n' "$command_name"
      if [[ "$title" == "Required tools:" ]]; then
        missing_required=1
      fi
    fi
  done
  printf '\n'
}

check_group 'Required tools:' "${required[@]}"
check_group 'Recommended tools:' "${recommended[@]}"

printf 'Versions:\n'
go version 2>/dev/null || true
git --version 2>/dev/null || true
psql --version 2>/dev/null || true
docker --version 2>/dev/null || true
if docker compose version >/dev/null 2>&1; then
  docker compose version 2>/dev/null || true
else
  printf '[warning] Docker Compose plugin is unavailable.\n'
fi
if command -v staticcheck >/dev/null 2>&1; then
  staticcheck -version 2>/dev/null || true
fi
if command -v dot >/dev/null 2>&1; then
  dot -V 2>&1 || true
fi
printf '\n'

if docker info >/dev/null 2>&1; then
  printf '[ok] Container runtime daemon is accessible.\n'
else
  printf '[warning] Docker daemon is not accessible; use Podman or local services.\n'
fi

if command -v psql >/dev/null 2>&1 && command -v pg_isready >/dev/null 2>&1; then
  if pg_isready -q 2>/dev/null; then
    printf '[ok] PostgreSQL is reachable through default connection settings.\n'
  else
    printf '[info] No PostgreSQL server on default settings; start it only for relevant sprints.\n'
  fi
fi

if (( EUID == 0 )); then
  printf '[warning] Run development and refactoring tools as an unprivileged user.\n'
fi

if (( missing_required != 0 )); then
  printf '\nInstall missing required tools before beginning relevant sprints.\n'
  exit 1
fi

printf '\nCore software-design environment is ready. Optional analysis and diagram tools may be installed per sprint.\n'
