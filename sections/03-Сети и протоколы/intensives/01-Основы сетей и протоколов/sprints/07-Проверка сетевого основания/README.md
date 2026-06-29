# Спринт 07. Проверка сетевого основания

Ориентировочный объём: 8–12 часов.

Новая теория не вводится. Первая попытка выполняется без повторного чтения спринтов 01–06.

## Проверяемые области

- сетевые модели и packet capture;
- Ethernet frames and interface state;
- switching, ARP, VLAN and STP;
- IPv4 subnetting;
- IPv6/NDP/SLAAC;
- routing, ICMP and PMTU.

## Исходная задача

Создать `work/l2l3-checkpoint/` с topology:

```text
client-a VLAN10 -- sw1 == trunk == sw2 -- router-a -- transit -- router-b -- server VLAN30
client-b VLAN20 --/                                      
```

Требования:

- dual-stack IPv4/IPv6;
- VLAN-aware bridges;
- static routing;
- SLAAC on client segments;
- explicit MTU values;
- captures on access, trunk and routed links;
- setup/verify/fault/cleanup scripts.

## Часть 1. Addressing plan

Allocate from:

- IPv4 `10.70.0.0/16`;
- IPv6 `2001:db8:70::/48`.

Requirements:

- separate prefixes for VLAN10, VLAN20, VLAN30 and transit;
- summarizable site plan;
- no overlap;
- reserve documented;
- generated plan consumed by scripts rather than duplicated manually.

## Часть 2. Baseline

Before traffic predict:

1. Which frames appear for first IPv4 connection?
2. Which NDP/RA messages appear for IPv6?
3. Where VLAN tags are visible?
4. Which MAC is destination on each routed hop?
5. How TTL/Hop Limit changes?
6. Which route entry wins?
7. What happens at MTU boundary?

Collect:

- bridge FDB/VLAN tables;
- ARP/NDP tables;
- IPv4/IPv6 routes;
- interface counters/MTU;
- packet captures;
- end-to-end ping and simple UDP exchange.

## Часть 3. Failure scenarios

Inject one at a time and restore baseline.

### A. Wrong access VLAN

Client cannot reach gateway. Prove absence/presence of frames on access/trunk and incorrect bridge VLAN state.

### B. Missing VLAN on trunk

Local access port works but frame does not cross bridge link. Diagnose with tagged capture and VLAN table.

### C. Duplicate IPv4

Two clients claim same address. Observe ARP conflict and nondeterministic neighbor state.

### D. Wrong IPv4 prefix

Client considers remote address local or local gateway remote. Prove through ARP attempts and route selection.

### E. Missing return route

Forward packet reaches server but response never reaches client. Capture both directions.

### F. IPv6 RA missing

Client has link-local only/no default route. Diagnose RS without RA.

### G. ICMPv6 blocked

Neighbor/PMTU behavior fails. Identify exact ICMPv6 type being dropped.

### H. MTU black hole

Small ping works; large application/DF traffic fails. Locate reduced link and missing ICMP.

### I. Routing loop

One prefix loops until TTL. Capture safely with rate/duration bounds.

### J. STP/topology issue

Redundant L2 link is blocked or loop forms when STP is disabled. Explain intended/actual path.

## Часть 4. Manual packet decode

Select one IPv4 and one IPv6 application packet from access capture. Without Wireshark field tree first, decode:

- Ethernet addresses/EtherType/VLAN;
- IPv4 or IPv6 header;
- TTL/Hop Limit;
- transport protocol and ports;
- payload length;
- next-hop identity.

Then verify with tshark.

## Часть 5. Defense

Answer without materials:

1. How does application data become frame?
2. How does switch decide port?
3. What does ARP/NDP resolve?
4. How does prefix determine local versus routed traffic?
5. How does router replace link header?
6. How do IPv4 and IPv6 autoconfiguration differ?
7. What information does ICMP provide?
8. How does PMTU failure appear?
9. Why are VLAN and subnet related but not identical?
10. What evidence distinguishes L2 from L3 failure?

## Критерии прохождения

- topology builds and removes cleanly;
- address plan has no overlap and is used by scripts;
- dual-stack baseline works;
- all ten failures are reproduced and diagnosed;
- manual packet decode matches tshark;
- no fix is broad `flush`, disabling IPv6 or flattening VLANs;
- minimum 8 of 10 defense answers are correct and mechanism-based.

При затруднении:

- layers/capture → sprint 01;
- physical/frame/MTU → sprint 02;
- bridge/ARP/VLAN/STP → sprint 03;
- IPv4 plan → sprint 04;
- IPv6/NDP/RA → sprint 05;
- routes/ICMP → sprint 06.

## Результат для базы знаний

Новые checkpoint-specific заметки не нужны. Исправить только заметки, где packet evidence опровергла текущую модель.