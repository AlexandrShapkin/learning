# Спринт 04. IPv4, CIDR и планирование адресов

Ориентировочный объём: 12–17 часов.

## Центральный вопрос

Как IPv4 address and prefix define local/remote destinations, subnet boundaries and scalable allocation of finite address space?

## Результат спринта

После завершения необходимо уметь:

- convert IPv4 addresses and masks between binary, dotted decimal and prefix length;
- calculate network, broadcast, first/last usable and host count;
- perform subnetting and route summarization;
- distinguish private, public, loopback, link-local, multicast, unspecified and documentation ranges;
- explain local route, connected route and default route;
- explain IPv4 header fields and checksum;
- distinguish host fragmentation and router fragmentation rules conceptually;
- explain DF/MF flags and fragment offset;
- design address plan with growth and summarization;
- detect overlap, wrong mask and unusable address assignment;
- use `ipcalc`/custom tool for verification without replacing reasoning;
- decode IPv4 packet manually from hex/pcap.

## Место в интенсиве

L2 topology has one or more broadcast domains. IPv4 prefixes define which destinations are local and which require a router.

## Основной маршрут

### Шаг 1. IPv4 addressing

Read Kurose & Ross network-layer addressing sections and RFC 791 header overview.

Study:

- 32-bit address;
- prefix/host parts;
- subnet mask and CIDR;
- network/broadcast addresses;
- special-purpose registries.

### Шаг 2. Subnetting

Practice manually:

- equal-size subnetting;
- variable-length subnet masks;
- longest common prefix and summarization;
- point-to-point prefix choices conceptually;
- overlap detection.

### Шаг 3. IPv4 header and fragmentation

Decode:

- version/IHL;
- DSCP/ECN;
- total length;
- identification/flags/fragment offset;
- TTL;
- protocol;
- checksum;
- source/destination;
- options overview.

### Шаг 4. Linux addresses and routes

Study:

```bash
ip -4 address
ip -4 route
ip route get DEST
ipcalc
```

Understand automatic connected/local/broadcast routes created by address assignment.

## Ресурсы

### Обязательный маршрут

- Kurose & Ross IPv4 addressing sections.
- RFC 791 selected header/fragmentation sections.
- RFC 4632 CIDR overview.
- RFC 1918 and IANA IPv4 Special-Purpose Address Registry.
- `ip-address(8)` and `ip-route(8)`.

### Альтернативные объяснения

- TCP/IP Illustrated IPv4 chapters.
- Cisco subnetting materials without vendor configuration dependency.
- Practical Networking subnetting articles as exercises, verified mathematically.

### Углубление

- IPv4 options;
- directed broadcast;
- anycast operational use;
- address planning at enterprise scale;
- IPAM systems.

## Практические задания

### 1. Manual subnet calculations

For each prefix `/8`, `/16`, `/20`, `/24`, `/25`, `/26`, `/27`, `/28`, `/30`, `/31`, `/32` determine mask, address count and common use/constraints.

For addresses:

- `10.17.34.129/20`;
- `172.20.8.65/27`;
- `192.0.2.14/30`;
- `198.51.100.9/31`;
- `203.0.113.44/32`;

calculate network, broadcast where applicable and range.

### 2. Address plan

Allocate `10.40.0.0/16` for:

- 4 sites;
- each site: users up to 500, servers 120, management 60, point-to-point links 20, reserve 50%;
- site-level summarization required.

Produce plan and prove no overlap. Avoid one subnet per arbitrary department if not justified.

### 3. Wrong prefix experiment

Two hosts on same veth/bridge receive addresses that visually look close but have different masks. Predict ARP versus gateway behavior, capture and fix. Repeat with overlap across router interfaces.

### 4. IPv4 packet decode

Take one ICMP and one UDP packet. Manually validate IHL, total length, TTL, protocol, addresses and header checksum using small helper.

## Лабораторная работа

Create `work/ipcalc-lab/` with Go CLI `netcalc`.

### Commands

```text
netcalc subnet 10.17.34.129/20
netcalc split 10.40.0.0/16 --prefix 20
netcalc allocate 10.40.0.0/16 requirements.yaml
netcalc summarize 10.40.0.0/20 10.40.16.0/20 ...
netcalc overlap prefixes.txt
netcalc decode-ipv4 packet.hex
```

### Requirements

- use standard library `net/netip` where suitable;
- explain calculations in verbose mode;
- support `/31` and `/32` without false universal usable-host rules;
- reject invalid/noncanonical/overlapping allocations clearly;
- preserve requested order or output deterministic sorted plan;
- unit/property tests for boundaries;
- no reliance on shelling out to `ipcalc`.

### Topology test

Generate namespace topology from produced YAML:

```text
site-a users -- router -- transit -- router -- site-b servers
```

Verification script checks:

- no overlapping connected prefixes;
- expected local ARP behavior;
- gateway used for remote subnet;
- broadcast addresses not assigned;
- `ip route get` matches plan.

### Fragmentation experiment

Using namespace link with MTU 600:

- send IPv4 UDP datagram larger than MTU with DF off where tool allows;
- capture fragments;
- repeat with DF and observe ICMP/EMSGSIZE or PMTU behavior;
- decode ID, MF and offsets.

Use bounded payload; fragmentation is not encouraged as application design.

## Дополнительный эксперимент

Implement subnet trie or longest-prefix matching function and test route lookup over thousands of synthetic prefixes. Compare correctness with linear search; performance optimization is optional.

Alternative: model address waste for fixed `/24` allocation versus VLSM and discuss operational simplicity trade-off.

## Самопроверка

1. How does a host decide destination is on-link?
2. What does prefix length mean?
3. How are network and broadcast addresses derived?
4. What changes for `/31` and `/32`?
5. What is route summarization and its risk?
6. Why can overlapping subnets cause ambiguous routing?
7. Which IPv4 header field prevents indefinite loops?
8. How do DF, MF and fragment offset work?
9. Why is IP header checksum not end-to-end data integrity?
10. Why is private address not automatically secure?

Practical check: receive unfamiliar address plan, detect overlap, wasted space, missing growth and unsummarizable allocation, then generate corrected topology and tests.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **IPv4 address** — binary structure and special ranges.
- **CIDR and subnet mask** — prefix semantics and calculations.
- **Subnetting and VLSM** — allocation and growth.
- **Route summarization** — aggregation and black-hole risks.
- **IPv4 header** — fields and forwarding relevance.
- **IPv4 fragmentation** — MTU, flags, offsets and reassembly.
- **Address planning** — hierarchy, reserves and overlap controls.

## Когда переходить дальше

Можно переходить, когда `netcalc` passes boundary tests, address plan creates working topology, and local/remote decisions are predicted before packet capture.