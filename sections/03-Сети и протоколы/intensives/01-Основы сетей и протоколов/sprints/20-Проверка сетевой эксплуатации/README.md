# Спринт 20. Проверка сетевой эксплуатации

Ориентировочный объём: 10–16 часов.

Новая теория не вводится. Первая попытка выполняется без повторного чтения спринтов 11–19.

## Проверяемые области

- DNS and DHCP;
- HTTP/proxy;
- TLS/PKI;
- application protocols;
- NAT, firewall and VPN;
- load balancing;
- container/overlay networking;
- performance and observability.

## Исходная система

Create `work/network-ops-check/`:

```text
client segment -- DHCP/DNS -- edge firewall/NAT -- TLS load balancer
                                                ├── app-a
                                                └── app-b
admin segment ===== WireGuard ===== management path
container-a ==== VXLAN overlay ==== container-b
```

### Required baseline

- client receives IPv4 config through DHCP;
- IPv6 uses SLAAC or static dual stack;
- local recursive resolver resolves `api.example.test`;
- TLS certificate validates through local CA;
- load balancer routes requests to healthy backends;
- firewall permits only documented flows;
- admin path uses WireGuard;
- one backend/sidecar runs in namespace/overlay segment;
- application emits request IDs and small metrics;
- captures/counters available on each boundary.

## Часть 1. Dependency and evidence map

Before faults, create one diagram:

```text
client config → DNS → route/neighbor → firewall/NAT → TCP
→ TLS/SNI/ALPN → load balancer → backend route/socket
→ HTTP semantics → response
```

For each arrow specify one command or artifact proving the transition. This map is prebuilt once and updated only when topology changes.

Baseline evidence:

- addresses/routes/neighbors;
- DHCP lease and options;
- DNS authoritative/recursive answers and TTL;
- nftables and conntrack state;
- WireGuard peers/routes;
- certificates and TLS negotiation;
- HAProxy/backend health;
- namespace/VXLAN state;
- request success, latency and backend ID;
- selected captures.

## Часть 2. Failure scenarios

Apply one fault at a time, restore and verify baseline.

### A. DHCP wrong DNS option

Client has address and route but uses nonexistent resolver. Distinguish configuration from DNS authority failure.

### B. Stale DNS cache

Authoritative address changes while resolver/client still caches old record. Prove TTL/cache layer and avoid arbitrary flush as only design.

### C. Broken delegation

Resolver receives lame/missing glue path. Identify authority/additional sections and server logs.

### D. IPv6 preference with broken path

AAAA resolves and client attempts IPv6 first, while proxy listens IPv4 only or route is broken. Use explicit family tests and capture.

### E. Firewall drops DNS TCP fallback

Small DNS replies work, large/truncated response fails. Identify UDP/TCP transition.

### F. NAT/DNAT without return path

SYN reaches backend but response cannot return through state. Use conntrack and both-side captures.

### G. WireGuard handshake without inner connectivity

Outer UDP succeeds; AllowedIPs, routes or inner firewall are wrong.

### H. TLS unknown CA

Network/TCP works; validation fails at trust anchor.

### I. TLS wrong SNI/certificate

Load balancer serves default certificate or wrong virtual host.

### J. TLS missing intermediate

Some clients with cached chain may work while clean client fails. Diagnose exact chain.

### K. Proxy wrong upstream port

TLS terminates successfully but backend connect fails.

### L. Health check false positive

Backend port responds to health but dependency/work endpoint fails.

### M. Health check false negative

Check too strict/short and removes healthy but slow backend, causing overload elsewhere.

### N. HTTP timeout/retry duplication

Backend completes POST after proxy timeout; retry duplicates without idempotency key.

### O. Forwarded identity spoofing

Client injects trusted header and application accepts fake identity. Fix trust boundary.

### P. VXLAN MTU

Small health checks work, large response stalls/fragments due to overlay overhead.

### Q. VNI/FDB mismatch

Container route exists but overlay delivery fails.

### R. CPU-limited backend misdiagnosed as network

Connection and network metrics are normal while application queue/CPU causes latency.

### S. Bufferbloat

Bulk flow raises latency without packet loss. Diagnose qdisc/queue and compare fair queueing.

### T. UDP service receive-buffer drops

Network captures show arrival, application misses datagrams; inspect socket/kernel counters.

### U. Load balancer connection skew

Persistent connections concentrate requests despite expected round-robin.

### V. Firewall state persists after rule change

Existing connections work, new ones fail; explain conntrack.

### W. NTP/clock skew breaks TLS

All routing/packets work but certificate validity fails.

### X. Log/capture blind spot

Capture is taken on wrong namespace/interface and falsely suggests no traffic. Correct observation point.

## Часть 3. Blind incident selection

Randomly select eight scenarios without reading their repair section during the first attempt. For each record a compact card:

```text
Symptom and scope
Known-good baseline difference
Layer hypotheses
Discriminating observations
Root cause
Minimal repair
Verification
Rollback
```

One screen per incident is enough; raw evidence remains in files.

## Часть 4. Rebuild

Delete complete topology using cleanup script and rebuild from clean VM state. Verify:

- no stale namespaces/interfaces/rules/processes;
- certificates/DNS/DHCP configs regenerate;
- all baseline tests pass;
- captured test traffic contains no external data;
- repeated setup is deterministic.

## Теоретическая защита

1. How can a client have correct IP but fail name resolution?
2. What evidence separates DNS timeout, NXDOMAIN and SERVFAIL?
3. How do TCP and TLS failures differ?
4. How do TLS and HTTP virtual hosting interact?
5. What can conntrack explain that packet capture alone may not?
6. Why can VPN handshake work without service access?
7. How can load balancer health be misleading?
8. Why can retry worsen partial failure?
9. How does overlay MTU affect application traffic?
10. Why can existing firewall connections behave differently from new ones?
11. How do endpoint saturation and network congestion differ?
12. How does observation point affect conclusion?

## Критерии прохождения

- baseline is reproducible end to end;
- all 24 faults are injected and reverted safely;
- eight blind incidents are solved from evidence;
- no broad firewall disable, `-k`, DNS replacement or MTU reduction is accepted as final unexplained fix;
- request identity and idempotency remain correct;
- cleanup/rebuild succeeds;
- at least 10 of 12 defense answers are mechanism-based.

При затруднении:

- DNS → sprint 11;
- DHCP → sprint 12;
- HTTP/proxy → sprint 13;
- TLS → sprint 14;
- application protocols/time → sprint 15;
- NAT/firewall/VPN → sprint 16;
- balancing → sprint 17;
- virtual/overlay → sprint 18;
- metrics/performance → sprint 19.

## Результат для базы знаний

Новых checkpoint-specific заметок не требуется. Обновить только заметки, где incident evidence выявила неполную модель.