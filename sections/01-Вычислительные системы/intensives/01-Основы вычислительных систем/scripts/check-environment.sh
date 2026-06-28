#!/usr/bin/env bash

set -u

required=(go cc make gdb objdump readelf nm strace lscpu)
recommended=(perf taskset file ldd fio qemu-system-x86_64 docker python3)
missing_required=0

printf 'System: %s\n' "$(uname -srm 2>/dev/null || echo unknown)"
printf 'Architecture: %s\n\n' "$(uname -m 2>/dev/null || echo unknown)"

check_group() {
  local title="$1"
  shift
  printf '%s\n' "$title"
  for command_name in "$@"; do
    if command -v "$command_name" >/dev/null 2>&1; then
      printf '  [ok]      %-24s %s\n' "$command_name" "$(command -v "$command_name")"
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

if [[ ! -r /proc/self/maps ]]; then
  printf '[warning] /proc/self/maps is unavailable; virtual-memory labs require Linux procfs.\n'
fi

if [[ -r /sys/fs/cgroup/cgroup.controllers ]]; then
  printf '[ok] cgroup v2 detected.\n'
else
  printf '[warning] cgroup v2 was not detected; the isolation lab may need another host or VM.\n'
fi

if [[ -e /dev/kvm ]]; then
  printf '[ok] /dev/kvm is available.\n'
else
  printf '[warning] /dev/kvm is unavailable; QEMU can still use software emulation, but KVM experiments will be skipped.\n'
fi

if (( missing_required != 0 )); then
  printf '\nInstall the missing required tools before starting the relevant sprint.\n'
  exit 1
fi

printf '\nCore environment is ready. Recommended tools may be installed later.\n'
