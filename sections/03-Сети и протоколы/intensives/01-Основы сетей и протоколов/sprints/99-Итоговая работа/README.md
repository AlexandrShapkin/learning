# Спринт 99. Итоговая работа

Ориентировочный объём: 32–50 часов.

## Задача

Create `network-lab-platform` — reproducible multi-segment network environment that demonstrates packet flow from application to physical/link/network/transport/application layers, supports controlled failures and can be diagnosed from evidence.

The project is not a production network or Kubernetes platform. Its purpose is to prove coherent understanding of protocols, intermediaries, performance and troubleshooting.

## Итоговая архитектура

```text
                               +-------------------+
remote-admin === WireGuard === | edge-a / firewall |
                               +---------+---------+
                                         |
                           public/DMZ DNS + TLS VIP
                                         |
clients VLAN10/VLAN20 -- access bridges -- routers -- HAProxy pair(optional)
        |                     |                         ├── app-a
        |                     |                         └── app-b
        |                     +-- DHCP relay/services
        |
        +-- IPv4 + IPv6

container-a -- bridge/VXLAN overlay -- container-b/backend

local DNS hierarchy: root-lab → test TLD → auth zone → recursive resolver
observability: captures, counters, socket metrics, synthetic probes
```

## Repository structure

Create inside sprint:

```text
work/network-lab-platform/
├── apps/
│   ├── backend/
│   ├── udp-probe/
│   └── traffic-client/
├── topology/
│   ├── addresses.yaml
│   ├── namespaces.yaml
│   ├── setup.sh
│   ├── verify.sh
│   └── cleanup.sh
├── routing/
├── dns/
├── dhcp/
├── proxy/
├── pki/
├── firewall/
├── vpn/
├── overlay/
├── observability/
├── faults/
├── incidents/
├── scripts/
│   ├── build.sh
│   ├── provision.sh
│   ├── capture.sh
│   ├── nettriage.sh
│   ├── inject-fault.sh
│   └── rollback-fault.sh
├── docs/
│   ├── architecture.md
│   ├── packet-paths.md
│   ├── evidence-map.md
│   └── recovery.md
├── Makefile
└── README.md
```

README contains prerequisites, safe run order, verification and known limitations. General theory belongs in `knowledge`.

## Functional requirements

### Addressing

- hierarchical IPv4 plan from one `/16` with VLSM and summarization;
- IPv6 `/48` documentation prefix split into `/64` LANs;
- management, client, DMZ, backend, service and transit networks;
- no overlap;
- generated configuration from one address source of truth;
- route and DNS records derived or validated against plan.

### Layer 2

- at least two VLAN client segments;
- access and trunk-like bridge ports;
- MAC learning and FDB inspection;
- optional redundant link with STP experiment;
- explicit MTU and interface naming.

### Routing

- minimum three routers;
- static baseline and OSPF mode through FRR;
- summarized site routes where possible;
- IPv4/IPv6 forwarding;
- backup path and controlled convergence;
- policy route for management or alternate source;
- ICMP/PMTU preserved.

### DHCP and IPv6 configuration

- DHCPv4 server with relay for at least two subnets;
- reservations and correct gateway/DNS options;
- SLAAC/RA for IPv6;
- optional DHCPv6 for additional options;
- lease and RA lifecycle tests.

### DNS

- local root/TLD/authoritative hierarchy or simplified delegated authoritative structure;
- recursive validating resolver;
- A/AAAA/CNAME/NS/SOA/MX/TXT/PTR/SRV records;
- TTL and negative-cache tests;
- DNSSEC signing/validation for lab zone;
- DNS over TCP path permitted;
- client applications use resolver through normal NSS.

### Applications and transport

Go components:

- HTTP backend with instance/version/request ID;
- idempotent and non-idempotent endpoints;
- streaming/large/slow endpoints;
- UDP probe with sequence/loss report;
- TCP framed echo/bulk endpoint;
- deterministic checksums and tests;
- graceful shutdown;
- bounded fault modes.

### TLS and proxy/load balancing

- local root + intermediate CA;
- TLS certificate for `api.example.test`;
- optional backend TLS;
- mTLS management endpoint;
- SNI and ALPN;
- HAProxy/nginx L7 balancing between backends;
- L4 mode comparison;
- health/readiness and graceful drain;
- forwarded identity trust rules;
- cache only explicitly safe endpoints.

### Firewall/NAT/VPN

- nftables default-deny zone policy;
- required ICMP/ICMPv6 allowed;
- SNAT for client egress to simulated public network;
- DNAT/VIP only to DMZ/proxy;
- conntrack observation;
- WireGuard management tunnel;
- IPv4 and IPv6 policy explicit;
- atomic validation/apply/rollback.

### Virtual and overlay network

- one application/backend in container-like namespace;
- VXLAN between two simulated hosts;
- VNI segmentation;
- overlay MTU calculation;
- CNI-style ADD/DEL/CHECK helper;
- inner and outer captures.

### Observability

- bounded synthetic HTTP/TCP/UDP/DNS/TLS checks;
- interface/bridge/route/neighbor/socket/nft/conntrack/WireGuard/VXLAN state;
- selected pcap capture profiles;
- latency/loss/throughput measurements;
- request IDs across proxy/backends;
- `nettriage` bundle;
- generated report linking symptom to evidence source.

## Stage 1. Design and threat/failure boundaries

Create architecture diagram and define:

- trust zones;
- allowed flow matrix;
- address/prefix ownership;
- control versus data-plane components;
- management recovery path;
- capture points;
- expected packet path for HTTP, DNS, DHCP and VPN;
- resource/traffic safety limits.

No long UML documentation required; one main diagram and concise flow descriptions are enough.

## Stage 2. Topology and L2/L3 baseline

Implement setup/cleanup and verify:

- VLAN membership;
- dual-stack addressing;
- ARP/NDP;
- static routes;
- end-to-end ICMP;
- MTU/PMTU;
- captures showing frame and per-hop IP behavior.

Then enable OSPF and test link failover/convergence.

## Stage 3. Configuration services

Deploy DHCP/RA and DNS. Verify cold/warm resolution, delegation, TTL, reverse records, DNSSEC and lease lifecycle.

## Stage 4. Application and transport

Run UDP/TCP/HTTP applications. Verify stream framing, datagram accounting, loss behavior, connection lifecycle and application correctness before proxies/security.

## Stage 5. TLS and load balancing

Issue certificates, configure TLS proxy/load balancer and test:

- hostname/chain validation;
- ALPN;
- mTLS;
- backend health;
- connection/request distribution;
- safe retry/idempotency;
- drain/failover.

## Stage 6. Edge security and VPN

Apply nftables, NAT and WireGuard. Test every allowed/denied flow and management rollback. Inspect conntrack and captures before/after translation/tunnel.

## Stage 7. Overlay

Add VXLAN/container-like backend, calculate MTU and test CNI helper lifecycle. Ensure tenant VNI isolation.

## Stage 8. Performance baseline

For HTTP/TCP/UDP flows record:

- RTT/latency percentiles;
- throughput/goodput;
- retransmissions/loss;
- qdisc/queue stats;
- backend/proxy capacity indicators;
- baseline under no impairment and controlled delay/loss/rate limits.

## Fault injection catalogue

`inject-fault.sh` supports named, reversible, bounded faults. Mandatory faults:

### Link and L2

1. `link-down`;
2. `wrong-access-vlan`;
3. `missing-trunk-vlan`;
4. `duplicate-ip`;
5. `stale-neighbor`;
6. `l2-loop-stp`.

### Addressing and routing

7. `wrong-prefix`;
8. `missing-default-route`;
9. `missing-return-route`;
10. `blackhole-specific-route`;
11. `routing-loop`;
12. `ospf-adjacency`;
13. `ipv6-ra-missing`;
14. `icmpv6-blocked`;
15. `pmtu-blackhole`.

### DHCP and DNS

16. `dhcp-wrong-dns`;
17. `dhcp-pool-exhausted`;
18. `dhcp-relay`;
19. `dns-stale-cache`;
20. `dns-delegation`;
21. `dns-dnssec`;
22. `dns-tcp-blocked`.

### Transport and application

23. `udp-loss-duplicate`;
24. `tcp-filtered`;
25. `tcp-slow-receiver`;
26. `tcp-reset`;
27. `http-framing`;
28. `http-redirect-loop`;
29. `retry-duplicate`.

### TLS and proxy

30. `tls-unknown-ca`;
31. `tls-missing-intermediate`;
32. `tls-wrong-sni`;
33. `tls-clock-skew`;
34. `proxy-wrong-upstream`;
35. `health-false-positive`;
36. `lb-skew`.

### Firewall, VPN and overlay

37. `nat-return-path`;
38. `firewall-state`;
39. `wireguard-allowedips`;
40. `wireguard-inner-firewall`;
41. `vxlan-vni`;
42. `vxlan-fdb`;
43. `overlay-mtu`;
44. `cni-residue`.

### Performance and observation

45. `packet-loss`;
46. `bufferbloat`;
47. `backend-cpu`;
48. `udp-recv-drops`;
49. `wrong-capture-point`;
50. `log-rate-limit`.

Each fault defines:

- precondition;
- exact scoped change;
- expected symptoms/evidence;
- safety limit;
- rollback;
- verification that baseline returned.

## Blind incident exercise

Solve at least twelve hidden incidents, including:

- two L2/L3;
- one IPv6;
- one DNS/DHCP;
- two TCP/TLS/HTTP;
- one firewall/NAT/VPN;
- one overlay;
- one performance;
- three combined incidents.

Combined examples:

- stale DNS + rotated certificate;
- asymmetric route + stateful firewall;
- overlay MTU + HTTP retry;
- CPU saturation + health-check flapping;
- broken IPv6 + valid AAAA;
- log rate limit + wrong capture point.

Use incident format from sprint 21.

## Required artifacts

Commit:

- application source and tests;
- topology/config generation scripts;
- sanitized DNS/DHCP/proxy/nft/WireGuard/VXLAN configs;
- PKI generation scripts without private keys;
- setup/verify/capture/triage/fault/rollback/cleanup scripts;
- small synthetic pcaps and fixtures;
- architecture and packet-path diagrams;
- generated baseline/incident summaries;
- commands to reproduce large measurements;
- links to updated `knowledge` notes.

Do not commit:

- private keys or real certificates;
- real network captures/credentials/cookies;
- large pcaps, binaries or container images;
- unrelated host/network state;
- public scanning results.

## Final defense

Answer with project evidence:

1. How does application data travel end to end?
2. What transformations occur at each layer/hop?
3. How do MAC and IP address roles differ?
4. How is next hop selected and resolved?
5. How are subnets and routes planned?
6. How do UDP and TCP differ?
7. How does TCP establish, recover and close?
8. How does DNS resolution/delegation/cache work?
9. How does TLS authenticate/protect traffic?
10. How do forward proxy, reverse proxy and load balancer differ?
11. How does firewall/NAT decide and transform traffic?
12. How do VPN and overlay networks encapsulate packets?
13. How do VM/container/cloud network abstractions map to mechanisms?
14. How is a DNS/routing/TCP/TLS/application failure localized?
15. Which metrics describe health and performance?
16. How do network design choices affect availability, security and performance?

Every answer references at least one capture, state table, counter or incident.

## Completion criteria

The intensive is complete when:

- clean VM builds the full topology from repository;
- setup and cleanup are repeatable and scoped;
- dual-stack L2/L3, DNS, DHCP, transport, TLS, proxy/LB, firewall/NAT/VPN and overlay paths work;
- applications pass tests and preserve semantics under retries/failures;
- baseline performance and evidence map exist;
- all 50 fault modes are safe/reversible or unsupported environmental limitations are documented with substitute evidence;
- at least twelve blind incidents and three combined incidents are diagnosed;
- no secrets or unrelated traffic are committed;
- all main section questions are answered through project evidence;
- generalized knowledge is transferred to `knowledge`.

## Delayed assessment

After 7–14 days without rereading:

1. draw packet path from client process to backend and return;
2. answer sixteen final questions;
3. rebuild or inspect topology from scripts;
4. diagnose four random faults, including one combined;
5. manually decode one L2/L3/TCP/DNS/TLS capture sequence;
6. identify one design improvement that reduces failure or diagnostic ambiguity.

Only after delayed assessment should level 3–4 be considered retained.