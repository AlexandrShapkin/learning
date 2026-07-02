#!/usr/bin/env bash

set -u

required=(bash git make curl jq go docker psql python3)
recommended=(yq sqlite3 duckdb jupyter mermaid mmdc plantuml dot playwright axe pandas)
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

printf '\nPython libraries:\n'
python3 - <<'PY'
mods = ['pandas', 'matplotlib', 'numpy', 'scipy', 'statsmodels']
for mod in mods:
    try:
        m = __import__(mod)
        print(f'  [ok]      {mod:<18} {getattr(m, "__version__", "installed")}')
    except Exception:
        print(f'  [optional] {mod}')
PY

printf '\nCapabilities:\n'
if docker info >/dev/null 2>&1; then
  printf '[ok] Container runtime is accessible.\n'
else
  printf '[warning] Container runtime is unavailable.\n'
fi
if psql -lqt >/dev/null 2>&1; then
  printf '[ok] PostgreSQL is reachable.\n'
else
  printf '[info] PostgreSQL is not currently reachable; container setup is acceptable.\n'
fi
python3 - <<'PY'
import csv, json, random, statistics
sample = [random.Random(42).random() for _ in range(10)]
print(f'[ok] Python analytics baseline works; sample mean={statistics.mean(sample):.4f}')
PY

printf '\nHost capacity:\n'
printf 'CPU threads: %s\n' "$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo unknown)"
printf 'Memory: %s\n' "$(awk '/MemTotal/ {printf "%.1f GiB", $2/1024/1024}' /proc/meminfo 2>/dev/null || echo unknown)"
df -h / 2>/dev/null | tail -n 1 || true

if (( EUID == 0 )); then
  printf '[warning] Use an unprivileged user for research files, analysis and application data.\n'
fi

if (( missing != 0 )); then
  printf '\nInstall missing required tools before beginning the relevant route.\n'
  exit 1
fi

printf '\nCore user/business environment is ready. Diagram, accessibility and statistical tools may be added before their corresponding sprints.\n'
