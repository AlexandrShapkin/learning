# Спринт 18. Виртуальные, контейнерные и облачные сети

Ориентировочный объём: 16–22 часа.

## Центральный вопрос

How are logical networks composed from virtual interfaces, switches, namespaces, tunnels and policy while sharing physical hosts and underlay links?

## Результат спринта

После завершения необходимо уметь:

- explain veth, tap/tun, Linux bridge, namespace and virtual router roles;
- map container network path from process socket to host interface;
- distinguish bridge, host, none and overlay-like container network modes;
- explain underlay and overlay;
- understand VXLAN VNI, VTEP and encapsulation;
- build multi-host simulation with VXLAN over routed underlay;
- explain CNI plugin lifecycle and responsibilities conceptually;
- distinguish container IP, service/VIP and external endpoint;
- explain cloud VPC/VNet, subnet, route table, security group, NACL, Internet/NAT gateway and load balancer as abstractions;
- distinguish VM virtual NIC/switch from container shared-kernel networking;
- diagnose MTU, route, bridge, namespace, NAT and policy failures;
- understand overlapping CIDR and encapsulation overhead problems;
- avoid confusing product-specific objects with protocol fundamentals.

## Место в интенсиве

All core mechanisms now combine into virtual platforms. This sprint maps them to containers/cloud without turning into Kubernetes or cloud administration course.

## Основной маршрут

### Шаг 1. Linux virtual networking

Review:

- veth pairs;
- namespaces;
- Linux bridge;
- tun/tap;
- routes and NAT;
- virtual machine tap/bridge path.

### Шаг 2. Container networking

Study Docker networking and CNI specification overview:

- runtime creates namespace;
- plugin adds interface/address/routes;
- host/bridge/overlay choices;
- port publishing/NAT;
- DNS/service discovery differences.

### Шаг 3. VXLAN overlay

Read Linux VXLAN docs. Understand:

```text
inner Ethernet frame → VXLAN/UDP/IP → underlay → decapsulation
```

Identify VNI, VTEP, FDB and MTU overhead.

### Шаг 4. Cloud network abstractions

Map cloud objects to fundamentals:

- VPC/VNet → isolated logical routing domain;
- subnet → prefix/placement boundary;
- route table → forwarding policy;
- security group/NACL → stateful/stateless policy depending platform;
- NAT/Internet gateway → managed edge functions;
- load balancer → L4/L7 endpoint;
- peering/transit gateway → inter-network routing.

Do not assume identical semantics across providers.

## Ресурсы

### Обязательный маршрут

- Linux bridge and VXLAN kernel docs.
- network namespaces/veth/tun/tap man pages.
- CNI specification overview.
- Docker networking docs as concrete example.
- Kubernetes networking model overview.
- one major cloud provider network concepts documentation for mapping only.

### Альтернативные объяснения

- Container Networking: From Docker to Kubernetes, selected resources.
- Cilium networking docs as eBPF comparison.
- Open vSwitch architecture overview.

### Углубление

- EVPN/VXLAN control plane;
- Open vSwitch/OVN;
- Kubernetes kube-proxy/eBPF datapaths;
- service mesh;
- cloud transit routing;
- SR-IOV and device passthrough;
- DPDK.

## Практические задания

### 1. Manual container path

Create process namespace with veth to host bridge, address, route and NAT. Trace packet from process to remote test server through every interface/capture point.

### 2. VM versus container

Compare topology/evidence for:

- process in namespace;
- Docker/Podman container;
- QEMU VM with tap bridge if available.

Identify kernel, interface, MAC/IP, bridge, NAT and isolation boundary.

### 3. Published port

Expose container-like service through DNAT. Inspect listener versus NAT rule and show no host process necessarily listens on published address in all implementations.

### 4. Overlapping CIDRs

Create two isolated tenant namespaces using same prefix, then attempt interconnection. Demonstrate need for separate routing domains/VRF/NAT/remapping.

## Лабораторная работа

Create `work/overlay-lab/`.

### Topology

Simulate two hosts:

```text
host-a namespace                         host-b namespace
├── container-a -- bridge-a              ├── container-b -- bridge-b
└── VTEP vxlan100 ===== routed underlay ===== VTEP vxlan100
```

Underlay uses separate transit IPs; overlay uses one L2 subnet.

### Requirements

- host namespaces with underlay routing;
- bridges and container namespaces;
- VXLAN VNI 100;
- static FDB or multicast/learning method explicitly chosen;
- reduced overlay MTU accounting for encapsulation;
- IPv4 mandatory, IPv6 optional;
- packet capture inner and outer packets;
- verify container-a ↔ container-b;
- separate tenant VNI 200;
- cleanup all devices/namespaces.

### CNI-style interface

Write small `netplugin` script/Go tool accepting JSON:

```text
ADD container-id netns ifname network-config
DEL container-id netns ifname
CHECK ...
```

It creates veth, attaches bridge, assigns address/route and records state idempotently. It is educational and not production CNI implementation.

### Cloud model exercise

Represent local topology as provider-neutral diagram with:

- VPC A/B;
- public/private subnets;
- route tables;
- security boundaries;
- NAT gateway;
- load balancer;
- peering/transit.

For each object identify corresponding route/filter/NAT/proxy mechanism and provider-specific uncertainty.

### Failure scenarios

1. veth peer in wrong namespace.
2. Bridge port down.
3. Missing container default route.
4. Host forwarding/NAT missing.
5. VXLAN VNI mismatch.
6. VTEP endpoint unreachable in underlay.
7. FDB missing/wrong remote VTEP.
8. Overlay MTU too high.
9. Tenant VLAN/VNI leakage.
10. Overlapping CIDR route ambiguity.
11. Published port rule points stale container IP.
12. Policy allows underlay but blocks overlay inner flow.
13. Container DNS points wrong resolver.
14. CNI ADD partially fails and leaves residue.

## Дополнительный эксперимент

Use VRF to create separate tenant routing tables on one host and compare with network namespaces. Explain isolation boundaries.

Alternative: use Open vSwitch for same overlay and compare control/observation tools with Linux bridge.

## Самопроверка

1. What does veth pair model?
2. How does container packet reach host network?
3. How do VM and container virtual NIC paths differ?
4. What are underlay and overlay?
5. What does VXLAN encapsulate?
6. What are VNI and VTEP?
7. Why does overlay reduce effective MTU?
8. What does CNI plugin configure?
9. Why can overlapping CIDRs coexist only with separate domains/translation?
10. How do cloud security group and route table differ?
11. Why are provider abstractions not identical protocols?

Практическая проверка: given broken container/overlay path, trace namespace → veth → bridge → VTEP → underlay → remote bridge and identify first missing state.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Virtual network interface** — veth, tap/tun and use cases.
- **Container network path** — namespace, bridge, route and NAT.
- **Underlay and overlay** — transport substrate versus logical topology.
- **VXLAN** — VNI, VTEP, encapsulation and MTU.
- **CNI** — runtime/plugin responsibilities and lifecycle.
- **VM networking** — virtual NIC, tap and virtual switch.
- **Cloud network abstractions** — VPC, subnet, route table, gateways and policies.
- **Overlapping networks** — routing domains, VRF and translation.

## Когда переходить дальше

Можно переходить, когда overlay and netplugin build/cleanup reliably, inner/outer captures are explained, and cloud/container objects are mapped to concrete routing/filtering/tunneling mechanisms.