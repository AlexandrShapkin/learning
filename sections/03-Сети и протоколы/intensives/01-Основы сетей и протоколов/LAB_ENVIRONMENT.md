# Лабораторное окружение

Интенсив предполагает создание изолированных L2/L3-топологий, DHCP/DNS-сервисов, firewall/NAT, VPN, packet capture и controlled packet loss. Основная рабочая сеть не должна участвовать в экспериментах.

## Эталонная схема

Использовать одну disposable Linux VM:

```text
host
└── network-lab
    ├── 4 vCPU
    ├── 8 GiB RAM
    ├── 40 GiB disk
    ├── NAT management interface
    └── optional host-only interface
```

Внутри VM создаются network namespaces:

```text
client-a -- switch/bridge -- router-a -- transit -- router-b -- switch/bridge -- server-a
                                      |
                                   services
```

Для части заданий добавляются client-b, server-b, DNS, DHCP, proxy, load balancer и VPN namespaces.

Эталонный guest — актуальный stable Debian/Ubuntu/Fedora с systemd, iproute2, nftables и cgroup v2. Команды сверяются с man pages установленной версии.

## Установка базовых инструментов на Debian-like системе

```bash
sudo apt update
sudo apt install \
  build-essential git curl wget ca-certificates jq make \
  iproute2 iputils-ping arping ethtool bridge-utils vlan \
  tcpdump tshark wireshark-common termshark \
  traceroute mtr-tiny tracepath netcat-openbsd socat nmap \
  iperf3 nuttcp conntrack nftables wireguard-tools \
  dnsutils ldnsutils dnsmasq unbound bind9-utils \
  nginx haproxy openssl \
  frr radvd chrony \
  python3 python3-venv golang-go shellcheck
```

Названия packages могут отличаться. Не устанавливать все инструменты заранее, если distribution предлагает более безопасную поэтапную установку.

Wireshark может запрашивать разрешение non-root capture. Для лаборатории допустимо использовать `sudo tcpdump -w`, затем анализировать pcap без root.

## Directory layout практики

Каждый спринт создаёт собственный `work/`. Общие helper scripts можно разместить в:

```text
work/lablib/
├── namespaces.sh
├── capture.sh
├── wait-port.sh
├── assert-route.sh
└── cleanup-all.sh
```

Скрипты должны использовать уникальный prefix ресурсов, например `nl-`, чтобы cleanup не затрагивал чужие namespaces/interfaces/nftables tables.

## Адресные диапазоны

В документации и лабораториях использовать:

- IPv4 private: `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`;
- IPv4 documentation: `192.0.2.0/24`, `198.51.100.0/24`, `203.0.113.0/24`;
- IPv6 documentation: `2001:db8::/32`;
- IPv6 ULA: генерировать отдельный `fdxx:...::/48` только внутри лаборатории;
- loopback: `127.0.0.0/8`, `::1`.

Не использовать случайные публичные адреса как фиктивные endpoints.

## Packet capture

Для каждого capture сохранять:

- точную interface/namespace;
- capture filter;
- display filter;
- start/stop condition;
- краткое ожидаемое событие;
- sanitized pcap только если он мал и не содержит secrets.

Пример:

```bash
sudo ip netns exec nl-client tcpdump -i any -nn -s 0 -w /tmp/dns.pcap 'port 53'
tshark -r /tmp/dns.pcap -Y 'dns.flags.response == 1' -T fields -e frame.time_relative -e ip.src -e dns.qry.name -e dns.a
```

## Traffic shaping

Loss, delay, reordering и rate limits задаются только на laboratory veth:

```bash
sudo tc qdisc add dev nl-veth root netem delay 40ms 10ms loss 1%
```

Cleanup обязателен:

```bash
sudo tc qdisc del dev nl-veth root
```

## Сетевые сервисы

DHCP, DNS, HTTP, TLS, proxy и routing daemons запускаются:

- внутри namespace;
- на loopback/private addresses;
- с отдельным config directory under `work/`;
- без system-wide install/enable, если это не требуется спринтом;
- с явными PID files/log paths;
- с cleanup script.

## Root и безопасность

Root требуется для namespaces, links, routing, firewall и capture. Все privileged scripts должны:

- проверять `EUID`;
- проверять, что target resources имеют laboratory prefix;
- использовать `set -euo pipefail` с explicit cleanup;
- не выполнять broad `ip link delete`, `nft flush ruleset` или `pkill`;
- выводить план изменений до применения;
- поддерживать `cleanup` command;
- не изменять management interface/default route host VM.

## Wi-Fi

Обязательная часть Wi-Fi выполняется через изучение captures и собственного client state. Monitor mode, deauthentication и frame injection не требуются и не должны выполняться в чужой сети.

При отсутствии Wi-Fi adapter используются публичные sanitized sample captures из Wireshark SampleCaptures или собственный capture обычного managed connection без credentials.

## Хранение результатов

Коммитить:

- topology and cleanup scripts;
- Go source/tests;
- sanitized configs;
- small synthetic pcaps;
- display/capture filters;
- concise observations and metrics.

Не коммитить:

- private keys и real certificates;
- captures с cookies, authorization headers, DNS activity пользователя или unrelated traffic;
- large pcaps, binaries, container images;
- реальные public IPs, MACs и hostnames;
- downloaded RFC/books/tools.