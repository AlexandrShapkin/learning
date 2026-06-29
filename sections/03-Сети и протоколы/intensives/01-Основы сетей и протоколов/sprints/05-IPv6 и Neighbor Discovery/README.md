# Спринт 05. IPv6 и Neighbor Discovery

Ориентировочный объём: 13–18 часов.

## Центральный вопрос

Как IPv6 expands address space and redesigns local discovery, autoconfiguration and packet handling without broadcast and router fragmentation?

## Результат спринта

После завершения необходимо уметь:

- write/compress/expand IPv6 addresses correctly;
- distinguish global unicast, link-local, ULA, multicast, loopback and unspecified addresses;
- explain prefix length and subnet convention;
- identify scope and interface zone identifiers;
- read IPv6 base header and extension-header concept;
- explain Neighbor Discovery messages and multicast groups;
- distinguish ARP from NDP;
- explain Router Solicitation/Advertisement and SLAAC;
- distinguish SLAAC, stateless DHCPv6 and stateful DHCPv6;
- explain Duplicate Address Detection;
- configure dual-stack namespace topology;
- diagnose missing RA, wrong prefix, neighbor failure and IPv6 route issue;
- explain Path MTU and prohibition of router fragmentation;
- avoid treating IPv6 as IPv4 with longer addresses.

## Место в интенсиве

IPv6 provides a second network-layer model with different local-control protocols. Understanding it prevents IPv4-only assumptions in DNS, TLS, firewalls and cloud/container networks.

## Основной маршрут

### Шаг 1. Addressing and header

Read:

- RFC 8200 selected sections on header and forwarding;
- RFC 4291 addressing architecture;
- Kurose & Ross IPv6 overview.

Practice canonical text representation and scopes.

### Шаг 2. ICMPv6 and Neighbor Discovery

Read selected sections:

- RFC 4443 ICMPv6;
- RFC 4861 Neighbor Discovery;
- RFC 4862 SLAAC.

Understand message types:

- Router Solicitation/Advertisement;
- Neighbor Solicitation/Advertisement;
- Redirect;
- Duplicate Address Detection use of NS.

### Шаг 3. Linux IPv6

Study:

```bash
ip -6 address
ip -6 route
ip -6 neigh
ping -6
tracepath6
sysctl net.ipv6.conf.*
```

Use namespaces so forwarding/RA sysctls do not affect host management network.

### Шаг 4. DHCPv6 and DNS interaction

Read RFC 8415 overview and compare:

- M/O flags in RA;
- SLAAC address plus RDNSS;
- stateless DHCPv6 options;
- stateful DHCPv6 leases;
- why default gateway still comes from RA.

## Ресурсы

### Обязательный маршрут

- RFC 8200 selected sections.
- RFC 4291.
- RFC 4443 and RFC 4861/4862 selected message/state sections.
- `ip-address`, `ip-route`, `ip-neighbour` IPv6 usage.

### Альтернативные объяснения

- TCP/IP Illustrated IPv6 chapters.
- Kurose & Ross IPv6 section.
- APNIC IPv6 educational materials.

### Углубление

- extension headers and filtering;
- privacy addresses and stable identifiers;
- DHCPv6 Prefix Delegation;
- NAT64/DNS64;
- Happy Eyeballs;
- IPv6 routing protocols.

## Практические задания

### 1. Address notation

Expand/compress and classify:

- `::1`;
- `::`;
- `fe80::a00:27ff:fe4e:66a1`;
- `2001:db8:10:20::1234`;
- `fd12:3456:789a::1`;
- `ff02::1`;
- `ff02::1:ff00:1234`;
- IPv4-mapped forms.

Identify scope and whether interface zone is needed.

### 2. Static dual stack

Create two hosts and router with IPv4 and IPv6. Test independent failure: remove IPv4 route while IPv6 works, then reverse. Use explicit `curl -4/-6`, `ping -4/-6` and DNS records later.

### 3. NDP capture

Clear IPv6 neighbors and capture first ping. Decode NS/NA, solicited-node multicast destination and target link-layer option. Compare with ARP capture from sprint 03.

### 4. SLAAC

Run `radvd` in router namespace advertising `2001:db8:100:10::/64`. Observe:

- RS/RA;
- generated address;
- DAD;
- default route lifetime;
- prefix expiration;
- behavior after RA stops.

## Лабораторная работа

Create `work/ipv6lab/`.

### Topology

```text
client-a -- router -- server
client-b --/
```

IPv6:

- client LAN `2001:db8:100:10::/64`;
- server LAN `2001:db8:100:20::/64`;
- optional ULA parallel addressing.

### Modes

```text
setup static
setup slaac
setup slaac-rdnss
setup dhcpv6
```

### Requirements

- router forwarding enabled only in router namespace;
- RA config generated under `work/`;
- optional dnsmasq/other DHCPv6 server isolated;
- capture RS/RA/NS/NA/DAD and DHCPv6 messages;
- verify link-local and global route selection;
- test source address selection with multiple addresses;
- cleanup all daemon processes and namespaces.

### Failure scenarios

1. Wrong `/64` prefix on one host.
2. Missing link-local address.
3. RA lifetime zero/default route removed.
4. Forwarding router suppresses RA acceptance on wrong interface due to sysctl.
5. Duplicate static address triggers DAD.
6. Firewall drops ICMPv6 and breaks NDP/PMTUD.
7. DNS has AAAA but service listens only IPv4.
8. Client prefers broken IPv6 path before fallback.

### MTU experiment

Set reduced MTU on transit and send oversized IPv6 payload. Observe Packet Too Big and source adaptation. Confirm router does not fragment packet.

## Дополнительный эксперимент

Investigate temporary/privacy versus stable addresses on actual system or namespace. Record address flags/lifetimes and explain operational implications for logging and allowlists.

Alternative: configure NAT64/DNS64 using an available lab tool and show IPv6-only client reaching IPv4 server; this is optional and not a substitute for native dual-stack knowledge.

## Самопроверка

1. Why does IPv6 use link-local addresses?
2. How is NDP different from ARP?
3. What replaces broadcast in many IPv6 mechanisms?
4. How is default route learned with SLAAC/DHCPv6?
5. What does DAD detect?
6. Why is `/64` common for LANs?
7. How do global, ULA and link-local scopes differ?
8. Who fragments IPv6 packets?
9. Why must ICMPv6 not be broadly blocked?
10. How can a broken AAAA path affect applications?

Practical check: given dual-stack failure, determine whether address, DAD, RA, route, NDP, ICMPv6 firewall or service bind is responsible.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **IPv6 address architecture** — format, types and scopes.
- **IPv6 header** — base header and extension concept.
- **ICMPv6** — errors and control role.
- **Neighbor Discovery** — NS/NA/RS/RA/Redirect.
- **SLAAC** — prefix/default route/address lifecycle.
- **DHCPv6** — stateful/stateless configuration and limits.
- **Duplicate Address Detection** — purpose and packet flow.
- **IPv6 Path MTU Discovery** — Packet Too Big and source fragmentation.
- **Dual stack** — independent paths and application selection.

## Когда переходить дальше

Можно переходить, когда static/SLAAC topologies work, NDP/RA/DAD packets are decoded, and ICMPv6 failures are diagnosed without disabling IPv6.