#!/usr/bin/env bash

set -u

required=(
  bash ip ss bridge tc
  ping arping tracepath traceroute
  tcpdump tshark
  nft conntrack
  curl openssl dig getent
  nc socat
  jq make go git
)

recommended=(
  mtr nmap iperf3 ethtool
  dnsmasq unbound-checkconf named-checkconf
  nginx haproxy
  wg vtysh radvd chronyd
  termshark shellcheck python3
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

if [[ -e /proc/self/ns/net ]]; then
  printf '[ok] network namespaces are supported.\n'
else
  printf '[warning] network namespace interface is unavailable.\n'
fi

namespace_name="nl-check-$$"
if ip netns add "$namespace_name" >/dev/null 2>&1; then
  ip netns del "$namespace_name" >/dev/null 2>&1 || true
  printf '[ok] namespace creation works with current privileges.\n'
else
  printf '[warning] namespace creation failed; run labs with sudo inside a disposable VM.\n'
fi

if nft list ruleset >/dev/null 2>&1; then
  printf '[ok] nftables is accessible.\n'
else
  printf '[warning] nftables inspection requires additional privileges or kernel support.\n'
fi

if [[ -r /proc/sys/net/ipv6/conf/all/disable_ipv6 ]]; then
  ipv6_disabled="$(cat /proc/sys/net/ipv6/conf/all/disable_ipv6 2>/dev/null || echo unknown)"
  if [[ "$ipv6_disabled" == "0" ]]; then
    printf '[ok] IPv6 is enabled.\n'
  else
    printf '[warning] IPv6 appears disabled; sprint 05 requires it.\n'
  fi
fi

if [[ -d /sys/class/net ]]; then
  printf '[ok] network device sysfs is available.\n'
else
  printf '[warning] /sys/class/net is unavailable.\n'
fi

if (( EUID == 0 )); then
  printf '[warning] Running as root. Prefer an unprivileged shell and sudo only for topology commands.\n'
fi

if (( missing_required != 0 )); then
  printf '\nInstall missing required tools before beginning the relevant sprints.\n'
  exit 1
fi

printf '\nCore networking environment is ready. Recommended tools can be installed per sprint.\n'
