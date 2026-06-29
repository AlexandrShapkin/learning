#!/usr/bin/env bash

set -u

required=(
  bash git make
  go gofmt
  cc ld as
  file readelf objdump nm
  gdb strace lsof
  python3 jq
)

recommended=(
  dlv clang lldb perf valgrind
  shellcheck cmake pkg-config
  node npm tsc
  java javac javap
  rustc cargo
  protoc graphviz dot
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

printf 'Toolchain versions:\n'
go version 2>/dev/null || true
cc --version 2>/dev/null | head -n 1 || true
python3 --version 2>/dev/null || true
node --version 2>/dev/null || true
java -version 2>&1 | head -n 1 || true
rustc --version 2>/dev/null || true
printf '\n'

if go env GOROOT GOPATH GOMODCACHE GOOS GOARCH CGO_ENABLED >/dev/null 2>&1; then
  printf '[ok] Go environment is readable.\n'
else
  printf '[warning] Go environment is not fully available.\n'
fi

if [[ -r /proc/self/status ]]; then
  printf '[ok] Linux procfs is available for runtime/process diagnostics.\n'
else
  printf '[warning] /proc is unavailable; several diagnostics labs require Linux.\n'
fi

if command -v perf >/dev/null 2>&1; then
  if perf stat -e task-clock true >/dev/null 2>&1; then
    printf '[ok] perf basic counters are accessible.\n'
  else
    printf '[warning] perf is installed but restricted by kernel/container policy.\n'
  fi
fi

if ulimit -c >/dev/null 2>&1; then
  printf '[ok] shell resource limits are available.\n'
fi

if (( EUID == 0 )); then
  printf '[warning] Running as root. Development and tests should normally run unprivileged.\n'
fi

if (( missing_required != 0 )); then
  printf '\nInstall missing required tools before beginning the relevant sprints.\n'
  exit 1
fi

printf '\nCore programming environment is ready. Optional runtimes can be installed per sprint.\n'
