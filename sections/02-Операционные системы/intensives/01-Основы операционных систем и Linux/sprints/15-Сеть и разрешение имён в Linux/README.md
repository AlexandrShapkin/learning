# Спринт 15. Сеть и разрешение имён в Linux

Ориентировочный объём: 14–18 часов.

## Центральный вопрос

Как Linux represents interfaces, routes, sockets, name resolution and packet filtering, and how can a connectivity failure be localized to one layer?

## Результат спринта

После завершения необходимо уметь:

- distinguish link, interface, address, route, neighbor and socket;
- inspect and configure interfaces using iproute2;
- read main and policy routing tables;
- explain loopback and default route;
- create veth pairs and network namespaces;
- observe ARP/ND neighbor state;
- inspect listening/connected sockets and owning processes;
- distinguish bind address, local port and remote endpoint;
- explain NSS and resolver path from name to address;
- diagnose `/etc/hosts`, `nsswitch.conf`, `resolv.conf` and systemd-resolved/NetworkManager interactions;
- capture traffic with tcpdump and correlate with socket/application state;
- create narrow nftables rules and test transactionally;
- distinguish connection failure due to process, bind, route, DNS or firewall;
- preserve remote access while changing network/firewall.

## Место в интенсиве

Services need network reachability and security policy. Protocol internals are covered in the network section; here the focus is Linux configuration, process/socket ownership and host troubleshooting.

## Основной маршрут

### Шаг 1. Interfaces and routing

Read:

- `ip(8)`;
- `ip-link(8)`;
- `ip-address(8)`;
- `ip-route(8)`;
- `ip-rule(8)`;
- `ip-neighbour(8)`.

Use `ip -json` where machine-readable output is needed.

### Шаг 2. Sockets

Read:

- `socket(7)`;
- `ip(7)`, `tcp(7)`, `udp(7)` overview;
- `ss(8)`;
- `bind(2)`, `listen(2)`, `connect(2)` overview.

Understand wildcard bind, loopback-only bind, dual-stack behavior and port ownership.

### Шаг 3. Name resolution

Read:

- `nsswitch.conf(5)`;
- `resolv.conf(5)`;
- `getaddrinfo(3)`;
- `systemd-resolved(8)` and `resolvectl(1)` if used;
- NetworkManager/systemd-networkd docs for actual system.

Distinguish DNS query tools from application NSS resolution path.

### Шаг 4. nftables

Read official nftables documentation and local `nft(8)` man page:

- https://www.netfilter.org/projects/nftables/
- https://www.netfilter.org/documentation/

Focus on tables, chains, hooks, priorities, stateful rules, sets and atomic ruleset replacement.

## Ресурсы

### Обязательный маршрут

- iproute2 man pages.
- socket and resolver man pages.
- nftables official documentation.
- actual network manager documentation for lab distribution.

### Альтернативные объяснения

- Debian Handbook network chapters.
- Linux Advanced Routing & Traffic Control, selected conceptual sections.
- ArchWiki network configuration/nftables pages verified against upstream.

### Углубление

- policy routing and VRF;
- bridges and VLANs;
- network namespaces as test topology;
- conntrack and NAT;
- traffic control and qdisc;
- eBPF/XDP;
- IPv6 neighbor discovery and SLAAC.

### Справочные материалы

- `network_namespaces(7)`.
- `tcpdump(8)`, `pcap-filter(7)`.
- `conntrack(8)` if installed.

## Практические задания

### 1. Host network map

Determine:

- interfaces and state;
- addresses/scopes;
- default route and route selection for several destinations;
- neighbor table;
- DNS servers/search domains;
- listening sockets and owning units/processes;
- firewall rules and counters;
- which manager owns interface configuration.

Do not infer public reachability from local bind alone.

### 2. Bind matrix

Run test server bound to:

- `127.0.0.1`;
- `0.0.0.0`;
- one specific interface address;
- `::1`;
- `::`.

From host and another namespace/VM determine reachable combinations. Verify with `ss` and packet capture.

### 3. Resolver path

For test names compare:

```bash
getent ahosts name
dig name
resolvectl query name
```

Modify only isolated test entries in `/etc/hosts` and a network namespace resolver setup. Explain differences between NSS and direct DNS query.

### 4. Route diagnosis

Use `ip route get DEST` and policy rules to predict egress interface/source address. Add temporary more-specific route in namespace, verify and remove.

## Лабораторная работа

Create `work/netlab/` and topology:

```text
ns-client --- veth --- ns-router --- veth --- ns-server
```

Address plan uses private ranges documented in config. Host forwarding is not changed globally; routing happens inside router namespace.

### Requirements

- setup and cleanup scripts are idempotent;
- interfaces, addresses and routes are explicit;
- router enables forwarding only inside its namespace;
- server runs HTTP on configurable address;
- client uses IP and hostname;
- tcpdump captures each link;
- optional DNS server or `/etc/netns/<name>/resolv.conf` provides test name;
- nftables rules run in router/server namespace;
- scripts abort if namespaces already contain unexpected resources.

### Firewall stages

1. Allow all baseline.
2. Default drop input/forward with established/related allowance.
3. Permit client → server HTTP only.
4. Permit DNS/ICMP as justified.
5. Add counters/logging with rate limit.
6. Apply rules atomically from file after `nft -c -f` validation.

### Diagnostic scenarios

1. Server bound to loopback instead of namespace interface.
2. Interface administratively down.
3. Missing route on client.
4. Forwarding disabled in router namespace.
5. Wrong prefix length.
6. Stale/failed neighbor resolution.
7. Resolver uses wrong server or NSS order.
8. nft rule drops SYN.
9. Service listens on TCP while client uses UDP or wrong port.
10. Existing connection works after rule change due to conntrack, while new one fails.

For each, use layered evidence: `ip`, `ss`, `getent`, `nft counters`, `tcpdump`, application logs.

## Дополнительный эксперимент

Add second route and source-based policy routing. Prove route selection with `ip rule`, `ip route get` and packet capture.

Alternative: add bridge namespace topology and compare L2 switching with L3 routing.

## Самопроверка

1. What makes an interface UP versus carrier present?
2. How is source address selected?
3. What does default route mean?
4. How does neighbor table differ from route table?
5. Why can service listen but remain unreachable?
6. Why can `dig` work while application name resolution fails?
7. What is difference between `0.0.0.0` and `127.0.0.1` bind?
8. Where does nftables hook packet path?
9. Why should firewall rules be validated atomically?
10. How does network namespace change view of interfaces, routes and sockets?

Practical check: given «cannot connect», identify the first failing layer using one observation per layer and avoid changing DNS, route and firewall simultaneously.

## Результат для базы знаний

Recommended notes:

- **Linux network interface** — links, addresses, state and ownership.
- **Linux routing** — routes, rules, source selection and namespaces.
- **Neighbor table** — ARP/ND state and resolution.
- **Sockets in Linux** — bind, listen, endpoints and process ownership.
- **Name resolution** — NSS, resolver configuration and DNS tools.
- **nftables** — hooks, chains, stateful filtering and atomic rulesets.
- **Network diagnosis** — layered evidence with ip/ss/tcpdump.

## Когда переходить дальше

Proceed when topology setup/cleanup is reliable, each failure is localized with evidence, and firewall changes do not endanger host access.