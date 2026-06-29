#!/usr/bin/env bash

set -u

required=(
  bash sh man info less grep sed awk find xargs
  ps top free vmstat pgrep pkill kill
  systemctl journalctl systemd-analyze
  lsblk blkid findmnt mount umount
  ip ss getent
  id getent passwd groupadd useradd
  tar gzip sha256sum
)

recommended=(
  strace ltrace lsof fuser pidstat iostat mpstat sar
  stress-ng fio iotop nft tcpdump dig
  setfacl getfacl getcap setcap capsh
  pvcreate vgcreate lvcreate dmsetup
  unshare nsenter lsns
  auditctl ausearch coredumpctl
  shellcheck bats go cc make git jq
)

missing_required=0

printf 'System: %s\n' "$(uname -srm 2>/dev/null || echo unknown)"
printf 'Distribution: '
if [[ -r /etc/os-release ]]; then
  . /etc/os-release
  printf '%s %s\n' "${NAME:-unknown}" "${VERSION_ID:-unknown}"
else
  printf 'unknown\n'
fi
printf 'PID 1: %s\n' "$(ps -p 1 -o comm= 2>/dev/null || echo unknown)"
printf 'Architecture: %s\n\n' "$(uname -m 2>/dev/null || echo unknown)"

check_group() {
  local title="$1"
  shift
  printf '%s\n' "$title"
  for command_name in "$@"; do
    if command -v "$command_name" >/dev/null 2>&1; then
      printf '  [ok]      %-22s %s\n' "$command_name" "$(command -v "$command_name")"
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

if [[ -d /proc/1 ]]; then
  printf '[ok] procfs is mounted.\n'
else
  printf '[warning] procfs is unavailable.\n'
fi

if [[ -d /sys/class ]]; then
  printf '[ok] sysfs is mounted.\n'
else
  printf '[warning] sysfs is unavailable.\n'
fi

if [[ -r /sys/fs/cgroup/cgroup.controllers ]]; then
  printf '[ok] cgroup v2 detected.\n'
else
  printf '[warning] unified cgroup v2 was not detected.\n'
fi

if [[ "$(ps -p 1 -o comm= 2>/dev/null)" == "systemd" ]]; then
  printf '[ok] systemd is PID 1.\n'
else
  printf '[warning] systemd is not PID 1; several sprints need adaptation.\n'
fi

if systemd-detect-virt >/dev/null 2>&1; then
  printf '[ok] virtualization detected: %s\n' "$(systemd-detect-virt 2>/dev/null)"
else
  printf '[warning] no virtualization detected; destructive labs should not run on the host.\n'
fi

if (( EUID == 0 )); then
  printf '[warning] Script is running as root. Use an unprivileged account with sudo for labs.\n'
fi

if (( missing_required != 0 )); then
  printf '\nInstall missing required tools before starting.\n'
  exit 1
fi

printf '\nCore environment is ready. Recommended tools may be installed before their sprint.\n'
