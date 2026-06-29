# Реализация итоговой работы

## 1. Addressing

- hierarchical IPv4 plan from one `/16` with VLSM and summarization;
- IPv6 documentation `/48` split into `/64` LANs;
- separate management, client, DMZ, backend, services and transit networks;
- no overlap;
- one source of truth `topology/addresses.yaml`;
- generated or validated routes, DNS records and service configs.

## 2. Layer 2

- at least two VLAN client segments;
- access and trunk-like bridge ports;
- MAC learning/FDB inspection;
- optional redundant link with STP experiment;
- explicit interface names and MTU;
- captures on access and trunk boundaries.

## 3. Routing

- minimum three routers;
- static routing baseline;
- OSPF mode through FRR;
- summarized routes where possible;
- IPv4 and IPv6 forwarding;
- backup path and controlled convergence;
- one policy-routing case;
- ICMP/ICMPv6 and PMTU preserved.

## 4. DHCP and IPv6 configuration

- DHCPv4 server with relay for at least two subnets;
- reservations and correct gateway/DNS options;
- SLAAC/RA for IPv6;
- optional DHCPv6 for additional options;
- lease, renewal, expiry and RA-lifetime tests.

## 5. DNS

- local root/TLD/authoritative hierarchy or equivalent delegated structure;
- recursive validating resolver;
- A, AAAA, CNAME, NS, SOA, MX, TXT, PTR and SRV records;
- TTL and negative-cache tests;
- DNSSEC signing/validation;
- DNS over TCP path;
- clients use normal resolver/NSS path.

## 6. Applications and transport

Go components:

- HTTP backend with instance/version/request ID;
- idempotent and non-idempotent endpoints;
- streaming, large and slow endpoints;
- UDP probe with sequence/loss/duplicate report;
- TCP framed echo/bulk endpoint;
- deterministic checksums;
- graceful shutdown;
- bounded fault modes;
- unit/integration tests and race detector.

## 7. TLS, proxy and load balancing

- local root and intermediate CA;
- TLS certificate for `api.example.test`;
- optional backend TLS;
- mTLS management endpoint;
- SNI and ALPN;
- HAProxy/nginx L7 balancing between backends;
- L4 mode comparison;
- health/readiness and graceful drain;
- forwarded identity trust rules;
- cache only explicitly safe endpoints;
- retry policy tied to idempotency.

## 8. Firewall, NAT and VPN

- nftables default-deny zone policy;
- required ICMP/ICMPv6 allowed;
- SNAT for simulated egress;
- DNAT/VIP only to DMZ/proxy;
- conntrack observation;
- WireGuard management tunnel;
- explicit IPv4/IPv6 policy;
- atomic validate/apply/rollback.

## 9. Overlay and container-like network

- one backend in container-like namespace;
- VXLAN between two simulated hosts;
- VNI segmentation;
- overlay MTU calculation;
- CNI-style ADD/DEL/CHECK helper;
- inner and outer captures;
- cleanup after partial failure.

## 10. Observability

- bounded HTTP/TCP/UDP/DNS/TLS synthetic checks;
- interface, bridge, route, neighbor and socket state;
- nftables, conntrack, WireGuard and VXLAN evidence;
- selected filtered captures;
- latency/loss/throughput baseline;
- request IDs across proxy/backends;
- read-only `nettriage` bundle;
- evidence map linking each symptom to source.

## Этапы реализации

### Stage 1. Design

Create one architecture diagram and define:

- trust zones;
- allowed flow matrix;
- address/prefix ownership;
- control and data plane components;
- management recovery path;
- capture points;
- expected packet paths;
- safety limits.

### Stage 2. L2/L3 baseline

Implement setup/cleanup and verify VLANs, addressing, ARP/NDP, static routes, end-to-end ICMP and PMTU. Then enable OSPF and test failover/convergence.

### Stage 3. Configuration services

Deploy DHCP/RA and DNS. Verify cold/warm resolution, delegation, TTL, reverse records, DNSSEC and lease lifecycle.

### Stage 4. Applications

Run UDP/TCP/HTTP applications. Prove framing, datagram accounting, connection lifecycle and correctness before adding proxies/security.

### Stage 5. TLS and balancing

Issue certificates, configure proxy/load balancer and test hostname/chain validation, ALPN, mTLS, health, distribution, retries and drain.

### Stage 6. Edge security

Apply nftables, NAT and WireGuard. Test every allowed and denied flow. Inspect conntrack and packet transformations.

### Stage 7. Overlay

Add VXLAN/container-like backend, calculate MTU and verify CNI helper lifecycle and VNI isolation.

### Stage 8. Performance baseline

Record for HTTP/TCP/UDP:

- RTT and latency percentiles;
- throughput/goodput;
- retransmissions/loss;
- qdisc/queue stats;
- proxy/backend capacity indicators;
- behavior under controlled delay/loss/rate limits.

### Stage 9. Fault system

Implement named, reversible faults from `FAULTS.md`. Each fault has precondition, exact scoped change, expected evidence, safety limit, rollback and baseline verification.

### Stage 10. Incident exercises

Complete blind and combined incidents from `ASSESSMENT.md`, then run cleanup and full rebuild from clean VM state.