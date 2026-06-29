# Спринт 21. Системная диагностика сети

Ориентировочный объём: 16–24 часа.

## Центральный вопрос

How can an unknown network failure be localized safely from application symptom to the first broken layer or state transition?

## Результат спринта

После завершения необходимо уметь:

- define symptom, scope, timeline and expected path before changing configuration;
- distinguish control/configuration state from data-plane evidence;
- collect volatile network evidence with bounded impact;
- reconstruct forward and return paths;
- rank falsifiable hypotheses by layer;
- choose one discriminating test rather than changing several variables;
- distinguish primary failure, secondary symptom and recovery side effect;
- compare current state with known-good topology/configuration;
- diagnose link, VLAN, neighbor, address, route, MTU, firewall, NAT, transport, DNS, TLS, proxy and application failures;
- handle intermittent loss/latency and partial failure;
- use captures from correct observation points;
- preserve remote access and rollback;
- produce concise incident evidence and prevention improvement;
- know when network is healthy and investigation must move to endpoint/application.

## Диагностический цикл

Use:

```text
stabilize and preserve access
→ define exact symptom and affected endpoints
→ draw expected forward/return path
→ collect low-risk state and counters
→ test nearest known-good boundary
→ rank hypotheses
→ perform one discriminating observation
→ make minimal reversible change
→ verify end-to-end and regressions
→ remove temporary diagnostics
```

Do not begin with cache flush, firewall disable, reboot or random MTU/DNS changes.

## Evidence layers

### Application

- exact request, timeout/error/status;
- request ID and server logs;
- protocol-specific diagnostics.

### Name and configuration

- client lease/address;
- resolver/NSS configuration;
- DNS answer/TTL/authority;
- proxy/discovery target.

### Transport and sockets

- listener bind;
- TCP state/retransmissions/windows;
- UDP error/loss accounting;
- local firewall/socket queue.

### Network path

- route lookup and source address;
- neighbors;
- interface/link/VLAN/bridge;
- per-hop capture/ICMP;
- NAT/conntrack/firewall;
- tunnel/overlay state and MTU.

### Endpoint capacity

- CPU/run queue;
- memory/socket buffers;
- application queue;
- proxy/backend saturation.

## Основной маршрут

Review relevant RFC/man pages only when evidence points to mechanism. Study troubleshooting case methodology from Practical Packet Analysis and performance sources, but treat commands as questions, not checklist.

Create a personal compact decision tree:

```text
Can client construct target? → DNS/config
Can it select route/source? → addressing/routing
Can next hop resolve? → L2/neighbor
Does packet leave/arrive each boundary? → path/firewall/NAT/tunnel
Does transport establish? → listener/TCP/UDP
Does TLS validate? → PKI/SNI/time
Does application exchange complete? → HTTP/proxy/backend
Does behavior degrade under load? → queue/loss/capacity
```

## Лабораторная работа

Create `work/network-diagnostics/` with:

### `nettriage`

A read-only bounded collector accepting source namespace/host, destination name/address and protocol:

```text
nettriage target api.example.test:443 --protocol https
```

Collects, where available:

- timestamp and clock sync summary;
- client addresses/routes/rules;
- resolver config and DNS queries;
- neighbor/interface/bridge/VLAN state;
- socket/listener state for local endpoints;
- nftables counters and selected conntrack entries;
- WireGuard/VXLAN state when present;
- ping/tracepath/traceroute bounded probes;
- curl/openssl protocol checks;
- selected interface/qdisc/TCP counters;
- optional 10-second filtered pcap;
- manifest with tool versions and hashes.

It must not:

- dump secrets, full environments or private keys;
- capture unrelated traffic;
- modify network state by default;
- run unbounded scans;
- claim root cause automatically.

### `path-map`

Generate expected/observed path diagram from route tables, namespaces, bridges and config. Unknown hops remain explicitly unknown.

### `fault-lab`

Supports named reversible faults with safety guards and status/rollback.

## Incident catalogue

Solve at least 16 of the following without snapshot rollback; all may be used in final project.

1. Physical/link down or carrier absent.
2. Wrong access VLAN.
3. VLAN missing on trunk.
4. ARP/NDP neighbor failure.
5. Duplicate address.
6. Wrong prefix/source address.
7. Missing default/return route.
8. More-specific black-hole route.
9. Routing loop/asymmetry.
10. PMTU black hole.
11. IPv6 preferred but broken.
12. DHCP wrong option/stale lease.
13. DNS NXDOMAIN/NODATA confusion.
14. DNS SERVFAIL due validation/delegation.
15. DNS stale cache.
16. TCP closed versus filtered port.
17. TCP loss/retransmission.
18. Slow/zero-window receiver.
19. SYN backlog/listener saturation.
20. UDP destination/application drop.
21. TLS unknown CA/missing intermediate.
22. TLS SNI/hostname/time mismatch.
23. HTTP wrong virtual host/redirect loop.
24. Proxy timeout/header trust issue.
25. Load balancer unhealthy/overloaded backend.
26. Retry storm or duplicate POST.
27. NAT missing/asymmetric return path.
28. Conntrack stale/state exhaustion.
29. WireGuard AllowedIPs/route/firewall mismatch.
30. VXLAN underlay/VNI/FDB/MTU failure.
31. Endpoint CPU/application queue masquerading as network.
32. Bufferbloat/high jitter.
33. Wrong capture point/offload artifact.
34. Security policy blocks only IPv6 or DNS TCP.
35. Intermittent packet loss on one direction.
36. Multiple simultaneous faults creating misleading evidence.

## Combined incidents

At least four exercises combine two causes:

- stale DNS plus old TLS certificate;
- PMTU black hole plus proxy retry;
- asymmetric route plus stateful firewall;
- backend CPU saturation plus load balancer health flapping;
- VXLAN MTU plus IPv6 preference;
- DHCP wrong gateway plus cached DNS success.

The diagnostic goal is causal chain, not first visible error.

## Incident record

For each exercise keep:

```text
Symptom and user impact
Scope and start time
Expected path
Evidence preserved
Hypotheses ranked
Discriminating tests
Root cause, trigger and secondary effects
Minimal repair
Verification and rollback
Prevention/detection improvement
```

References to pcap/log/config artifacts replace long prose.

## Additional experiment

Ask another person or tool to inject one hidden fault and provide only user-visible symptom. Use `nettriage` first, then choose maximum three targeted commands before stating primary hypothesis.

Alternative: reproduce one real historical public networking incident from published evidence in simplified lab, clearly separating confirmed facts from inferred mechanism.

## Самопроверка

1. Why is forward path insufficient without return path?
2. What is the nearest known-good boundary?
3. How do configuration state and packet evidence differ?
4. When is ping irrelevant or misleading?
5. How to distinguish DNS, TCP, TLS and HTTP errors?
6. Why can packet arrive but application not receive it?
7. How do conntrack and NAT change diagnosis?
8. Why can one direction lose packets?
9. How does MTU produce size-dependent failure?
10. How to prove endpoint bottleneck rather than network congestion?
11. Why can reboot/cache flush destroy evidence?
12. What makes a change safely reversible?
13. How can observation tooling alter traffic or conclusions?
14. When should investigation leave the network layer?

Практическая проверка: receive unknown broken topology, collect bounded triage, reconstruct path, identify causal chain, repair, verify and clean all diagnostic state.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Network diagnostic method** — scope, expected path, evidence and discriminating tests.
- **Forward and return path analysis** — route, state and asymmetry.
- **Layered fault isolation** — L2 through application.
- **Intermittent network failures** — timing, direction and capture strategy.
- **Known-good network state** — topology/configuration baselines.
- **Network incident evidence** — captures, counters, logs and limitations.
- **Safe network change and rollback** — management preservation and verification.

## Когда переходить дальше

Можно переходить к итоговой работе, когда at least 16 incidents and four combined scenarios are solved from evidence, and `nettriage` remains read-only, bounded and safe.