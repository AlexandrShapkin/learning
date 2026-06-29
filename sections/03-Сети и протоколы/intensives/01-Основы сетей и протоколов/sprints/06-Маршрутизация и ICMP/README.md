# Спринт 06. Маршрутизация и ICMP

Ориентировочный объём: 14–19 часов.

## Центральный вопрос

Как router выбирает next hop, пересылает packet между сетями и сообщает об ошибках пути?

## Результат спринта

После завершения необходимо уметь:

- различать connected, static, default и dynamically learned routes;
- объяснять longest prefix match;
- различать routing table, forwarding information base и neighbor resolution;
- объяснять next hop, outgoing interface, metric и administrative preference концептуально;
- использовать `ip route get`, multiple tables и policy rules;
- объяснять TTL/Hop Limit и ICMP Time Exceeded;
- объяснять ICMP Echo, Destination Unreachable, Redirect и Packet Too Big/Fragmentation Needed;
- понимать принцип traceroute для UDP, ICMP и TCP probes;
- объяснять asymmetry и почему обратный путь может отличаться;
- настраивать IPv4/IPv6 forwarding в namespace;
- строить статическую многохоповую topology;
- выполнять базовый OSPF experiment через FRR;
- отличать control plane от data plane;
- диагностировать missing route, wrong gateway, black hole, loop и MTU failure.

## Место в интенсиве

После L2 и addressing узлы могут определить локальные destinations. Этот спринт строит взаимодействие между подсетями и создаёт основу для transport, NAT, VPN и cloud networking.

## Основной маршрут

### Шаг 1. Route lookup

Прочитать Kurose & Ross network layer forwarding/routing sections и `ip-route(8)`.

Для каждой route понимать:

```text
prefix → next hop/interface → metric/table/protocol → scope
```

Разобрать longest prefix match на overlapping `/0`, `/8`, `/16`, `/24`, `/32`.

### Шаг 2. Forwarding

Сформировать sequence:

1. receive frame;
2. validate/decode IP packet;
3. decrement TTL/Hop Limit;
4. route lookup;
5. resolve next-hop link address;
6. create new link frame;
7. transmit or generate ICMP error.

Router replaces link-layer header on every hop but preserves source/destination IP unless NAT is applied later.

### Шаг 3. ICMP and path tools

Read selected sections:

- RFC 792;
- RFC 4443;
- traceroute/tracepath/ping man pages;
- PMTUD RFCs.

Study how firewall/rate limiting/asymmetry can make diagnostic tools incomplete.

### Шаг 4. Dynamic routing overview

Study concepts:

- distance-vector versus link-state;
- topology database and shortest path;
- adjacency, hello, convergence and route installation;
- interior versus exterior gateway protocol;
- OSPF as link-state IGP;
- BGP as path-vector policy protocol.

Use FRRouting docs for a small OSPF lab. Full OSPF/BGP engineering is outside scope.

## Ресурсы

### Обязательный маршрут

- Kurose & Ross network layer forwarding/routing sections.
- `ip-route(8)`, `ip-rule(8)`.
- RFC 792 and RFC 4443 selected message descriptions.
- traceroute/tracepath docs.
- FRRouting basic OSPF documentation.

### Альтернативные объяснения

- TCP/IP Illustrated IP/ICMP/routing chapters.
- Tanenbaum routing chapters.
- Practical Networking route lookup and traceroute explanations.

### Углубление

- ECMP;
- policy-based routing;
- OSPF areas/LSAs;
- BGP attributes and route policy;
- VRF;
- MPLS;
- fast reroute and convergence measurement.

## Практические задания

### 1. Longest prefix match

Given routes:

```text
0.0.0.0/0 via A
10.0.0.0/8 via B
10.20.0.0/16 via C
10.20.30.0/24 via D
10.20.30.40/32 via E
```

Predict next hop for a set of destinations, then reproduce using multiple namespace route tables and `ip route get`.

### 2. Router forwarding

Build three subnets through two routers. Before enabling forwarding predict:

- local ARP/NDP;
- packet reaching router but not remote host;
- return-path requirement;
- TTL values observed at each capture point.

Enable forwarding and verify.

### 3. traceroute mechanics

Capture `traceroute` in ICMP, UDP and TCP modes through three routers. Identify probes, TTL progression and returned ICMP. Explain final-hop behavior differences.

### 4. Routing loop

Create bounded loop for one documentation prefix with low TTL and no production traffic. Capture repeated packet and final ICMP Time Exceeded. Remove immediately.

## Лабораторная работа

Create `work/routing-lab/`.

### Topology

```text
lan-a -- r1 -- transit-1 -- r2 -- transit-2 -- r3 -- lan-b
                     \                         /
                      -------- backup --------
```

Support IPv4 and IPv6.

### Stage A. Static routing

- configure all connected prefixes;
- add explicit routes;
- verify forward and return paths;
- remove one route and diagnose;
- add more-specific route through backup;
- demonstrate asymmetric forward/return paths.

### Stage B. Policy routing

Client has two source addresses. Create second routing table and `ip rule from` selecting a different path. Verify through capture and `ip route get from`.

### Stage C. OSPF

Run FRR in r1/r2/r3 namespaces:

- loopback router IDs;
- one OSPF area;
- advertise LAN/transit prefixes;
- observe neighbors and learned routes;
- fail primary link;
- measure convergence and path change;
- restore and cleanup.

If FRR cannot run namespaced on distribution, use separate containers/VMs while preserving topology.

### Stage D. PMTU

Set one transit MTU below edges. Test:

- IPv4 DF traffic;
- IPv6 traffic;
- ICMP errors allowed;
- ICMP errors dropped.

Demonstrate PMTU black-hole symptom with bounded application request and fix by restoring ICMP or proper MSS/MTU design, not arbitrary small global MTU.

### Failure scenarios

1. IP forwarding disabled.
2. Missing return route.
3. Wrong next-hop address.
4. More-specific black-hole route.
5. Routing loop.
6. Policy rule selects empty table.
7. OSPF adjacency mismatch.
8. Link failure without dynamic alternative.
9. ICMP filtered causing PMTU issue.
10. Asymmetric path conflicts with later stateful firewall assumption.

## Дополнительный эксперимент

Run a minimal BGP peering between two FRR routers with private ASNs. Advertise only documentation prefixes, apply prefix-list and show that route policy, not shortest hop count, controls accepted routes.

Alternative: configure ECMP and observe per-flow hashing rather than per-packet round-robin.

## Самопроверка

1. What does longest prefix match choose?
2. How do route lookup and neighbor resolution differ?
3. What changes in packet/frame at each router hop?
4. Why is return route required?
5. How does traceroute reveal hops?
6. Why can traceroute show `*` while application works?
7. What causes routing loop to end?
8. What do control plane and data plane mean?
9. How do static and dynamic routes differ operationally?
10. Why can blocking ICMP break valid traffic?
11. How can asymmetric routing affect stateful devices?

Практическая проверка: given route tables, rules, captures and traceroute, reconstruct forward and reverse paths and identify first incorrect lookup.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **IP routing** — forwarding decision and next hop.
- **Longest prefix match** — route selection rule.
- **Routing table and policy rules** — tables, metrics and source-based selection.
- **IP forwarding** — per-hop frame replacement and TTL.
- **ICMP** — diagnostics and error signaling.
- **Traceroute** — TTL probes and limitations.
- **Path MTU Discovery** — ICMP dependency and black holes.
- **Static and dynamic routing** — configuration versus learned topology.
- **OSPF and BGP overview** — link-state versus policy path-vector.

## Когда переходить дальше

Можно переходить, когда static and OSPF topologies converge and clean up, traceroute/ICMP are decoded, and routing failures are proven through route lookup plus captures.