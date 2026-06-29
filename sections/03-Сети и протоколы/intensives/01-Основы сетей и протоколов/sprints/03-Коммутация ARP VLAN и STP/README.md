# Спринт 03. Коммутация, ARP, VLAN и STP

Ориентировочный объём: 13–18 часов.

## Центральный вопрос

Как Ethernet-сегмент доставляет frame нужному узлу, как узнаётся destination MAC для IPv4 и как segmentation prevents uncontrolled broadcast/loops?

## Результат спринта

После завершения необходимо уметь:

- explain switch/bridge forwarding and MAC learning;
- distinguish unknown unicast, broadcast and multicast flooding;
- inspect Linux bridge forwarding database;
- explain ARP request/reply, cache and neighbor states;
- diagnose duplicate IP, stale neighbor and missing ARP reply;
- explain broadcast domain and collision domain;
- configure access/trunk-like VLAN topology with 802.1Q tags;
- explain native/untagged traffic risks conceptually;
- distinguish VLAN segmentation from security policy;
- explain Layer 2 loop and broadcast storm;
- configure and observe Linux bridge STP at basic level;
- interpret bridge/VLAN/neighbor state and packet capture together.

## Место в интенсиве

Ethernet frames need a forwarding mechanism and address resolution. This sprint builds one subnet before introducing IP subnetting and routers.

## Основной маршрут

### Шаг 1. Learning bridge

Read Kurose & Ross link-layer switching sections and Linux bridge docs:

- self-learning;
- forwarding/filtering;
- flooding;
- forwarding database aging;
- loop problem.

Study:

```bash
bridge link
bridge fdb show
bridge vlan show
ip -d link show type bridge
```

### Шаг 2. ARP and neighbor cache

Read RFC 826 and Linux neighbor docs:

- `arping(8)`;
- `ip-neighbour(8)`;
- NUD states as Linux operational model;
- gratuitous ARP overview.

ARP resolves next-hop IPv4 address to link-layer address, not arbitrary remote Internet address.

### Шаг 3. VLAN

Study IEEE 802.1Q conceptually:

- VLAN ID;
- tagged/untagged frame;
- access and trunk ports as operational terms;
- VLAN-aware Linux bridge;
- subinterfaces.

### Шаг 4. STP

Study Spanning Tree goals and states at overview level. Linux bridge supports STP but is not a replacement for vendor switch training.

## Ресурсы

### Обязательный маршрут

- Kurose & Ross switching section.
- RFC 826.
- Linux bridge documentation and `bridge(8)`.
- Wireshark ARP/802.1Q references.

### Альтернативные объяснения

- Tanenbaum Ethernet switching/VLAN chapters.
- Practical Packet Analysis ARP and switching examples.
- vendor-neutral STP introduction.

### Углубление

- RSTP/MSTP;
- multicast snooping;
- LACP and bonding;
- EVPN control-plane MAC learning;
- ARP inspection and port security.

## Практические задания

### 1. MAC learning

Build bridge with three host namespaces. Clear FDB, send one frame/packet at a time and observe:

- empty FDB;
- source learning;
- unknown destination flooding;
- learned unicast forwarding;
- aging after configured interval.

Capture on all ports to prove which frames were copied.

### 2. ARP lifecycle

Clear neighbor cache and perform first/second ping. Compare packet sequences and latency. Force states by inactivity and inspect `REACHABLE`, `STALE`, `DELAY`, `PROBE`, `FAILED` where observable.

### 3. Duplicate IPv4

Assign same IPv4 to two isolated lab hosts. Observe ARP replies, neighbor instability and connection behavior. Restore unique address immediately after evidence.

### 4. VLAN separation

Create hosts in VLAN 10 and VLAN 20 through VLAN-aware bridge. Verify same-VLAN communication and cross-VLAN isolation before router is added. Capture tagged trunk and untagged access-side frames.

## Лабораторная работа

Create `work/l2lab/`.

### Topology

```text
h1 VLAN10 --- access port \
                            bridge br0 --- tagged trunk --- bridge br1
h2 VLAN10 --- access port /                                  / access --- h3 VLAN10
h4 VLAN20 --- access port                                   \ access --- h5 VLAN20
```

Optional second parallel bridge link creates controlled loop for STP experiment.

### Scripts

```text
setup.sh
show-state.sh
capture.sh
inject-fault.sh
verify.sh
cleanup.sh
```

### Verification

Automated checks:

- expected bridge ports and VLAN membership;
- same-VLAN connectivity;
- cross-VLAN denial without L3 router;
- FDB contains learned MACs after traffic;
- ARP cache points to correct host;
- cleanup removes only `l2-` resources.

### Failure scenarios

1. Wrong access VLAN.
2. VLAN missing on trunk.
3. Interface down.
4. Duplicate IP.
5. Stale/static neighbor entry with wrong MAC.
6. Bridge port isolated or learning disabled.
7. L2 loop with STP disabled.
8. STP blocks expected path after redundant link.

For loop experiment generate low-rate bounded broadcast and monitor counters; do not create unbounded storm.

### Required analysis

- frame path before and after learning;
- ARP request/reply details;
- tagged versus untagged capture;
- FDB and VLAN table relation;
- effect of STP on redundant topology;
- why VLAN alone does not implement authorization/firewall.

## Дополнительный эксперимент

Use Linux bonding/team or two bridge links to compare redundancy with and without loop-prevention. Observe failover time and duplicate/loop behavior.

Alternative: implement a tiny learning switch simulation in Go that processes synthetic Ethernet frames and applies FDB aging. This is a model, not raw packet forwarding.

## Самопроверка

1. What does a switch learn from source or destination MAC?
2. When is a frame flooded?
3. How does broadcast domain differ from collision domain?
4. What exactly does ARP resolve?
5. Why is ARP limited to local link/broadcast domain?
6. What changes in an 802.1Q tagged frame?
7. Why can't VLAN replace firewall policy?
8. What causes Layer 2 loop?
9. What does STP intentionally sacrifice?
10. How do FDB and neighbor table differ?

Practical check: given failed same-subnet connectivity, use link state, bridge VLAN/FDB, ARP capture and neighbor state to identify exact layer-2 cause.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Ethernet switching** — learning, forwarding, flooding and aging.
- **MAC address table** — FDB entries and lifecycle.
- **ARP** — request/reply, next-hop resolution and cache.
- **Linux neighbor states** — operational NUD model.
- **VLAN** — tagged segmentation and broadcast domains.
- **Layer 2 loop** — amplification and failure symptoms.
- **STP** — loop-free topology and blocked paths.
- **Linux bridge** — software switching and VLAN-aware behavior.

## Когда переходить дальше

Можно переходить, когда VLAN topology and failure injection are reproducible, frame path is proven by captures/FDB, and ARP failures are distinguished from IP routing failures.