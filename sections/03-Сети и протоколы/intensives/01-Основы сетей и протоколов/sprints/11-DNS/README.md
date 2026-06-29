# Спринт 11. DNS

Ориентировочный объём: 15–21 час.

## Центральный вопрос

Как distributed hierarchy of authoritative and recursive servers turns a domain name into validated, cached resource records?

## Результат спринта

После завершения необходимо уметь:

- explain DNS namespace, labels, zones and delegation;
- distinguish stub resolver, recursive resolver, authoritative server and root/TLD servers;
- explain iterative versus recursive queries;
- decode DNS header, question and resource records;
- use A, AAAA, CNAME, NS, SOA, MX, TXT, PTR, SRV and CAA appropriately;
- explain TTL, positive/negative caching and cache invalidation limitations;
- distinguish NXDOMAIN, NODATA, SERVFAIL, REFUSED and timeout;
- use `dig`, `delv`, `drill`, `getent` and packet capture;
- explain UDP/TCP DNS transport and truncation/EDNS;
- create authoritative zone and local recursive cache;
- understand glue records and lame delegation;
- explain DNSSEC chain of trust conceptually and validate a signed zone;
- diagnose delegation, cache, resolver, transport and application NSS failures;
- avoid treating DNS as a simple global key-value database.

## Место в интенсиве

Transport endpoints use addresses, while applications usually use names. DNS introduces a distributed control plane with delegation, caching and failure propagation.

## Основной маршрут

### Шаг 1. Namespace and delegation

Read RFC 1034 selected sections and Kurose & Ross DNS chapter. Understand:

```text
root → TLD → authoritative zone → record
```

Separate domain namespace from zone boundaries.

### Шаг 2. Message and records

Read RFC 1035 message format and use Wireshark/tshark to decode:

- ID and flags;
- QNAME/QTYPE/QCLASS;
- answer/authority/additional sections;
- name compression;
- response codes.

### Шаг 3. Recursive resolution and caching

Study:

- resolver cache;
- TTL expiration;
- CNAME chain;
- negative caching RFC 2308;
- bailiwick/glue overview;
- EDNS and TCP fallback.

### Шаг 4. DNSSEC overview

Read RFC 4033 overview and use `delv` or `dig +dnssec` against signed public test domains and a local signed zone. Understand DNSKEY, DS, RRSIG and validation result without mastering key operations at production scale.

## Ресурсы

### Обязательный маршрут

- RFC 1034 and 1035 selected sections.
- RFC 2308 negative caching.
- Kurose & Ross DNS chapter.
- BIND/Unbound docs for lab.
- `dig(1)`, `resolv.conf(5)`, `nsswitch.conf(5)`.

### Альтернативные объяснения

- DNS and BIND, Cricket Liu and Paul Albitz.
- Julia Evans DNS materials as visual explanation.
- APNIC DNS tutorials.

### Углубление

- DNSSEC operations;
- QNAME minimization;
- aggressive negative caching;
- DoT/DoH/DoQ;
- anycast authoritative service;
- resolver cache poisoning defenses;
- DNS load balancing limitations.

## Практические задания

### 1. Resolution trace

Use:

```bash
dig +trace example.com A
dig @SERVER name TYPE +norecurse
dig @RESOLVER name TYPE +stats
```

Reconstruct delegation path, authoritative answers and glue. Explain why `+trace` behavior is not identical to local application resolver.

### 2. Record semantics

Create examples for:

- apex A/AAAA;
- `www` CNAME;
- MX and mail host addresses;
- reverse PTR;
- SRV service discovery;
- TXT verification;
- CAA.

Identify invalid/fragile combinations such as CNAME at zone apex under traditional DNS rules.

### 3. Cache behavior

Query before/after TTL expiration and after authoritative record change. Observe stale answer until cache expiry. Test negative caching for nonexistent name.

### 4. UDP/TCP/EDNS

Request response large enough to exercise EDNS and possibly TCP fallback. Capture flags, advertised UDP size and transport change. Do not intentionally amplify against public servers.

## Лабораторная работа

Create `work/dnslab/`.

### Topology

```text
client -- recursive resolver -- root-lab
                             ├── tld-lab
                             └── auth example.test
```

All servers run in isolated namespaces. Use reserved `.test` names.

### Components

- root and TLD authoritative zones using BIND or another authoritative server;
- authoritative `example.test` zone;
- Unbound recursive resolver;
- client configured to use only lab resolver;
- optional secondary authoritative server for zone transfer overview.

### Required records

- A/AAAA;
- CNAME;
- NS and glue;
- SOA;
- MX;
- TXT;
- PTR reverse zone;
- SRV.

### Experiments

1. Cold recursive lookup.
2. Warm cache lookup.
3. TTL expiry.
4. Negative caching.
5. CNAME chain.
6. Large response/EDNS/TCP.
7. Delegation with missing glue.
8. Lame delegation.
9. Authoritative server unavailable.
10. Resolver cache flush and recovery.
11. DNSSEC signed zone and validation success.
12. Broken signature/DS and SERVFAIL validation.

### Diagnostics

Use:

```bash
dig +trace
dig +norecurse
dig +dnssec
delv
unbound-control stats
named-checkzone
tcpdump/tshark port 53
```

### Requirements

- configuration generated from repository files;
- no modification of host global resolver outside namespace;
- all daemons have explicit PID/log/config paths;
- tests assert answers and response codes;
- cleanup removes namespaces/processes;
- pcap files contain only synthetic lab names.

## Дополнительный эксперимент

Configure DNS over TLS locally between stub and Unbound. Compare encrypted transport visibility with ordinary DNS while confirming destination/connection metadata remains observable.

Alternative: deploy secondary authoritative server and observe NOTIFY/AXFR/IXFR in lab.

## Самопроверка

1. How do domain and zone differ?
2. What is delegation?
3. How do recursive and authoritative servers differ?
4. What is glue and when is it needed?
5. Why does DNS change not propagate immediately?
6. How do NXDOMAIN and NODATA differ?
7. Why can `dig` succeed while application lookup fails?
8. When does DNS use TCP?
9. What does DNSSEC authenticate and not encrypt?
10. Why can DNSSEC failure appear as SERVFAIL?
11. What is negative caching?

Практическая проверка: given client error, resolver logs, `dig` outputs and capture, locate failure in NSS/stub, recursive cache, delegation, authoritative data, transport or DNSSEC validation.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **DNS namespace and zones** — labels, zones and delegation.
- **Recursive and authoritative DNS** — roles and query paths.
- **DNS message** — sections, flags and response codes.
- **DNS record types** — semantics and dependencies.
- **DNS caching** — TTL and negative caching.
- **Glue and delegation failures** — bootstrap and lame delegation.
- **EDNS and DNS over TCP** — response size and transport.
- **DNSSEC** — chain of trust and validation outcomes.
- **DNS diagnostics** — dig, traces, captures and resolver logs.

## Когда переходить дальше

Можно переходить, когда local hierarchy resolves cold/warm queries, delegation and DNSSEC failures are diagnosed, and application NSS is distinguished from direct DNS tools.