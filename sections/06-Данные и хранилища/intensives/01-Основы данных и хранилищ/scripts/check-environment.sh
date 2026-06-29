#!/usr/bin/env bash

set -u

required=(
  bash git make
  go gofmt
  psql pg_config pgbench
  sqlite3
  jq curl openssl
  python3
  docker
  ss lsof
)

recommended=(
  podman
  redis-cli
  mongosh
  mc
  nats
  kcat
  perf strace iostat pidstat
  shellcheck dot
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
psql --version 2>/dev/null || true
pg_config --version 2>/dev/null || true
pgbench --version 2>/dev/null || true
sqlite3 --version 2>/dev/null | head -n 1 || true
go version 2>/dev/null || true
python3 --version 2>/dev/null || true
docker --version 2>/dev/null || true
if docker compose version >/dev/null 2>&1; then
  docker compose version 2>/dev/null || true
else
  printf '[warning] Docker Compose plugin is unavailable.\n'
fi
printf '\n'

if docker info >/dev/null 2>&1; then
  printf '[ok] Docker daemon is accessible.\n'
else
  printf '[warning] Docker daemon is not accessible; use Podman or install local services.\n'
fi

if command -v psql >/dev/null 2>&1; then
  if pg_isready -q 2>/dev/null; then
    printf '[ok] A PostgreSQL server is reachable through default connection settings.\n'
  else
    printf '[info] No PostgreSQL server on default settings; start the sprint laboratory before use.\n'
  fi
fi

if [[ -r /proc/meminfo && -r /proc/mounts ]]; then
  printf '[ok] Linux process/storage diagnostics are available.\n'
else
  printf '[warning] Linux /proc is unavailable; some diagnostics require a VM.\n'
fi

if (( EUID == 0 )); then
  printf '[warning] Run clients and application code unprivileged; use elevated access only for isolated storage experiments.\n'
fi

if (( missing_required != 0 )); then
  printf '\nInstall missing required tools before beginning relevant sprints.\n'
  exit 1
fi

printf '\nCore data-storage environment is ready. Auxiliary services can be started per sprint.\n'
