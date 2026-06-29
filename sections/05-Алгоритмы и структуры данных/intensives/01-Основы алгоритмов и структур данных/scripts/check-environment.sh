#!/usr/bin/env bash

set -u

required=(
  bash git make
  go gofmt
  python3
  jq dot
  time sort uniq awk sed
)

recommended=(
  benchstat hyperfine perf valgrind
  sqlite3 shellcheck taskset numactl
  gnuplot
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
python3 --version 2>/dev/null || true
dot -V 2>&1 || true
printf '\n'

if go test -run=NONE -bench=NONE ./... >/dev/null 2>&1; then
  printf '[ok] Current directory contains a buildable Go module/package set.\n'
else
  printf '[info] No buildable Go module in current directory; run inside a sprint work directory later.\n'
fi

if command -v perf >/dev/null 2>&1; then
  if perf stat -e task-clock true >/dev/null 2>&1; then
    printf '[ok] perf basic counters are accessible.\n'
  else
    printf '[warning] perf is installed but restricted by kernel/container policy.\n'
  fi
fi

if (( EUID == 0 )); then
  printf '[warning] Run algorithms and benchmarks as an unprivileged user.\n'
fi

if (( missing_required != 0 )); then
  printf '\nInstall missing required tools before beginning relevant sprints.\n'
  exit 1
fi

printf '\nCore algorithms environment is ready. Optional measurement tools can be installed per sprint.\n'
