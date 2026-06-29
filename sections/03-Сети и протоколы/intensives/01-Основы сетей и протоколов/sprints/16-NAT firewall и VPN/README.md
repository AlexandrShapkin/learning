# Спринт 16. NAT, firewall и VPN

Ориентировочный объём: 16–22 часа.

## Центральный вопрос

Как stateful middleboxes transform, permit, reject or tunnel traffic while preserving enough connection state for return packets?

## Результат спринта

После завершения необходимо уметь:

- distinguish routing, NAT and filtering;
- explain source NAT, destination NAT, masquerade and port address translation;
- explain conntrack tuple/state and return-path dependence;
- distinguish stateless and stateful firewall behavior;
- understand netfilter hooks and nftables chains conceptually;
- create default-deny policy with explicit allowances;
- explain reject versus drop;
- use nftables sets, counters and atomic ruleset loading;
- inspect conntrack entries;
- diagnose NAT hairpin, asymmetric routing and stale-state issues;
- explain tunneling and VPN encapsulation;
- configure WireGuard peers, routes and allowed IPs;
- distinguish VPN encryption, routing and access policy;
- explain split tunnel versus full tunnel;
- preserve management access during firewall/VPN changes;
- avoid treating NAT as security boundary.

## Место в интенсиве

Routing connects networks, but production paths commonly include stateful policy, address translation and encrypted tunnels. These mechanisms strongly affect diagnostics and availability.

## Основной маршрут

### Шаг 1. Netfilter and nftables

Read:

- nftables official documentation;
- `nft(8)`;
- Netfilter hook overview;
- stateful filtering and connection tracking.

Understand packet path through prerouting/input/forward/output/postrouting and where route decisions occur.

### Шаг 2. NAT

Study:

- SNAT/MASQUERADE;
- DNAT/redirect;
- tuple translation;
- first-packet rule evaluation and conntrack reuse;
- port exhaustion overview;
- hairpin NAT;
- why application payload addresses can break through NAT.

### Шаг 3. Firewall policy

Build policy from zones and allowed flows. Avoid broad `accept established,related` without understanding existing state and protocol helpers.

### Шаг 4. WireGuard

Read WireGuard quick start and conceptual documentation:

- key pairs;
- peer endpoint;
- allowed IPs as routing and cryptokey routing selectors;
- handshake/keepalive;
- interface routes;
- MTU overhead;
- no built-in user authentication or application authorization.

## Ресурсы

### Обязательный маршрут

- nftables official docs and `nft(8)`.
- conntrack-tools documentation.
- WireGuard official docs/whitepaper overview.
- Linux network namespace/routing docs.

### Альтернативные объяснения

- Kurose & Ross firewall/NAT overview.
- TCP/IP Illustrated NAT traversal discussions.
- Debian nftables handbook sections.

### Углубление

- IPsec/XFRM;
- NAT64/DNS64;
- state synchronization and HA firewalls;
- application-layer gateways;
- eBPF firewalls;
- WireGuard roaming and policy routing;
- zero-trust overlay architecture.

## Практические задания

### 1. Hook tracing

Create one routed path and use nftables counters/trace to identify which hooks/chains see local, forwarded and NATed traffic. Correlate with packet captures before/after translation.

### 2. SNAT/DNAT

Build private client → router → server topology:

- SNAT client traffic;
- DNAT public-like address/port to internal server;
- inspect conntrack original/reply tuples;
- capture each side to prove translated fields.

### 3. Stateful policy

Implement default drop forward chain allowing:

- client-initiated HTTP/DNS;
- return traffic;
- ICMP/ICMPv6 needed for diagnostics/PMTU;
- no server-initiated connection unless explicit.

Use counters and named sets.

### 4. WireGuard tunnel

Create two site namespaces with routed subnets and WireGuard peers over transit. Verify encrypted outer UDP packets and inner private traffic. Test endpoint/route/AllowedIPs failures.

## Лабораторная работа

Create `work/security-path-lab/`.

### Topology

```text
remote-client -- internet-sim -- edge-router -- dmz-web
                                |
                                +-- internal-app

admin-site ===== WireGuard tunnel ===== internal management subnet
```

All networks are synthetic/private.

### Requirements

- nftables ruleset in version-controlled file;
- `nft -c -f` validation before apply;
- dedicated `inet` table with lab prefix;
- atomic apply and rollback script;
- counters/logging rate-limited;
- SNAT outbound internal traffic;
- DNAT only public HTTP test port to DMZ;
- no direct Internet-sim access to internal-app;
- WireGuard grants management subnet access only;
- IPv4 mandatory, IPv6 firewall policy explicit even if no NAT;
- conntrack snapshots and captures;
- cleanup removes only lab table/interfaces/namespaces.

### Failure scenarios

1. Forwarding disabled.
2. DNAT exists but forward rule missing.
3. SNAT missing return route.
4. Wrong hook/priority.
5. Stateful rule accepts stale connection after policy change.
6. Asymmetric return path bypasses stateful firewall.
7. Hairpin client cannot access DNAT address.
8. Port collision/exhaustion under bounded synthetic load.
9. ICMP filtered causing PMTU failure.
10. WireGuard peer endpoint wrong.
11. AllowedIPs overlap/wrong direction.
12. Tunnel up but routes absent.
13. Firewall allows UDP handshake but blocks inner forwarded traffic.
14. Full-tunnel route accidentally captures management path.
15. IPv6 bypasses IPv4-only policy.

### Verification

Automated tests assert allowed and denied flows, not only ping. Include HTTP, DNS, TCP connect, UDP and ICMP/PMTU cases.

## Дополнительный эксперимент

Implement WireGuard policy routing for split tunnel and failover endpoint. Observe source-based rule/table behavior and tunnel MTU.

Alternative: compare nftables stateful firewall with simple stateless filter in a synthetic model and explain connection-tracking costs/benefits.

## Самопроверка

1. How do routing and NAT differ?
2. What does conntrack store?
3. Why are NAT rules often applied only to first packet?
4. How do SNAT and DNAT differ?
5. Why is NAT not a firewall?
6. How do drop and reject differ operationally?
7. Where can firewall hook packet path?
8. Why can asymmetry break stateful filtering?
9. What do WireGuard AllowedIPs control?
10. Why can tunnel handshake succeed while inner traffic fails?
11. How can IPv6 bypass IPv4-only assumptions?
12. What must a rollback protect?

Практическая проверка: given captures, nft counters, conntrack and routes, identify translation, filter, state, return-path or tunnel-policy failure.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **NAT** — tuple translation, SNAT/DNAT/PAT and limitations.
- **Connection tracking** — states and original/reply tuples.
- **Netfilter packet path** — hooks and route interaction.
- **Stateful firewall** — policy, established flows, drop/reject and counters.
- **nftables** — tables, chains, sets and atomic deployment.
- **VPN and tunneling** — inner/outer packets and routing.
- **WireGuard** — peers, cryptokey routing and AllowedIPs.
- **Split/full tunnel** — route scope and management risks.

## Когда переходить дальше

Можно переходить, когда firewall/NAT/VPN topology is fully tested, management rollback works, and each failure is explained through route, conntrack, rule and capture evidence.