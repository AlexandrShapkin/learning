# Спринт 19. Производительность, наблюдаемость и сетевая безопасность

Ориентировочный объём: 16–22 часа.

## Центральный вопрос

How can network health and performance be measured without confusing symptoms, and how can observation/security controls be applied without destroying the evidence or traffic they protect?

## Результат спринта

После завершения необходимо уметь:

- distinguish latency, RTT, jitter, loss, throughput, goodput and utilization;
- explain bandwidth-delay product and queueing;
- measure TCP/UDP performance with iperf3 and application workload;
- use ping, mtr, traceroute, tracepath, ss, nstat, ip/ethtool stats and tc;
- interpret retransmissions, resets, listen drops and socket queues;
- identify MTU/PMTU and bufferbloat symptoms;
- use packet capture and flow/log summaries appropriately;
- establish baseline and compare controlled change;
- explain passive versus active observation;
- define network trust boundaries and segmentation goals;
- perform limited service inventory/scanning only in own lab;
- recognize spoofing, scanning, flooding and MITM classes conceptually;
- explain IDS/IPS placement and false positives overview;
- sanitize pcaps/logs and protect sensitive metadata;
- build a layered diagnostic dashboard/report without inventing metrics;
- avoid using ping alone as availability proof.

## Место в интенсиве

This sprint consolidates measurements across all protocols and introduces security-focused interpretation before operational checkpoints and final diagnostics.

## Основной маршрут

### Шаг 1. Performance metrics

Review Kurose & Ross delay/loss/throughput and derive:

- serialization delay;
- propagation delay;
- queueing delay;
- bandwidth-delay product;
- goodput after headers/retransmissions;
- percentile latency.

### Шаг 2. Linux observations

Study:

```bash
ip -s -s link
ethtool -S
ss -s
ss -ti
nstat
sar -n DEV,TCP,ETCP
iperf3
mtr
tracepath
tc -s qdisc
```

Metric names vary by kernel/NIC. Record exact source/version.

### Шаг 3. Capture and flow visibility

Compare:

- full packet capture;
- sampled/filtered capture;
- connection/socket logs;
- flow records;
- application logs;
- synthetic probes.

Define what each can and cannot prove.

### Шаг 4. Network security overview

Study:

- segmentation and least connectivity;
- spoofing and source validation;
- scan/reconnaissance;
- volumetric/state exhaustion;
- encrypted traffic visibility;
- IDS versus IPS;
- control plane/data plane protection;
- rate limiting and logging costs.

No offensive activity outside the isolated lab.

## Ресурсы

### Обязательный маршрут

- Kurose & Ross performance/security overview sections.
- iperf3 documentation.
- Linux networking statistics and `ss/nstat/tc` man pages.
- Wireshark statistics/conversations/IO graph docs.
- nmap reference guide for authorized lab inventory.

### Альтернативные объяснения

- Brendan Gregg networking performance materials.
- Practical Packet Analysis troubleshooting chapters.
- Google SRE monitoring/latency chapters.

### Углубление

- eBPF network tracing;
- NetFlow/IPFIX/sFlow;
- packet brokers;
- continuous network verification;
- DDoS architecture;
- Suricata/Zeek;
- hardware timestamping/PTP;
- kernel queue disciplines.

## Практические задания

### 1. Measurement matrix

For a fixed topology measure:

- idle baseline;
- added delay;
- jitter;
- loss;
- bandwidth limit;
- small queue versus oversized queue;
- CPU-limited endpoint;
- receiver-limited endpoint.

Determine which metrics change and which remain misleadingly normal.

### 2. BDP and throughput

Calculate expected in-flight data for 10/100/1000 Mbps links at 1/20/100 ms RTT. Use TCP stream to observe when window/path capacity limits throughput.

### 3. Packet loss localization

Create drops at:

- sender qdisc;
- router firewall;
- receiver queue/application;
- UDP application intentionally.

Use counters/capture/application metrics to distinguish locations.

### 4. Authorized inventory

Scan only lab prefixes with bounded nmap options. Compare open/closed/filtered states to listener/firewall evidence. Explain limitations and avoid aggressive scripts.

## Лабораторная работа

Create `work/net-observe-lab/`.

### Components

- client, router, server namespaces;
- Go HTTP/TCP/UDP service with metrics;
- traffic profiles via `tc`;
- nftables counters/rate limits;
- capture wrapper;
- report generator.

### Report command

```text
netreport baseline
netreport run PROFILE
netreport compare RUN_A RUN_B
netreport diagnose BUNDLE
```

### Collected data

- topology/config hashes;
- timestamps and clock info;
- interface/qdisc counters;
- routes/neighbors;
- socket state and TCP info;
- protocol-specific app metrics;
- iperf/ping/mtr samples;
- selected tshark summaries;
- firewall/conntrack counters;
- CPU/memory only where endpoint limitation matters.

Do not collect full environment/secrets.

### Profiles

1. latency 80 ms;
2. jitter 30 ms;
3. loss 2%;
4. bandwidth 20 Mbps;
5. bufferbloat queue;
6. MTU mismatch;
7. TCP receiver slow;
8. server CPU throttled;
9. firewall rate limit;
10. DNS intermittent failure;
11. SYN backlog pressure;
12. UDP receive-buffer drops.

### Security observations

- detect bounded port scan through nft counters/logs;
- compare encrypted and plaintext visibility;
- demonstrate source spoofing limit in routed namespace and reverse-path considerations conceptually;
- add rate-limited logging without log flood;
- optionally run Zeek/Suricata on synthetic pcap, not required for passing.

### Analysis requirements

For each profile:

```text
Question
Expected signals
Observed evidence
Root mechanism
Application effect
Corrective options
Measurement limitations
```

This is generated/concise evidence, not a diary.

## Дополнительный эксперимент

Compare fq_codel/cake-like fair queueing if available with large FIFO under competing bulk and latency-sensitive flows. Measure throughput and latency trade-off.

Alternative: use eBPF/bpftrace tools to observe TCP retransmit/reset events if kernel supports them.

## Самопроверка

1. How do throughput and goodput differ?
2. What is bandwidth-delay product?
3. Why can ping be normal while application is slow?
4. What creates jitter?
5. How does bufferbloat appear?
6. Which evidence localizes packet drop?
7. How do passive and active measurements differ?
8. Why can retransmission be symptom, not root cause?
9. What can encrypted pcap still reveal?
10. How do IDS and IPS differ?
11. Why can excessive logging become failure/security risk?
12. What does open/closed/filtered from scanner actually prove?

Практическая проверка: given metrics bundle, rank hypotheses for latency/loss/endpoint saturation and choose one discriminating next measurement.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Network latency and jitter** — components and measurement.
- **Bandwidth, throughput and goodput** — capacity versus delivered payload.
- **Packet loss and retransmission** — locations, symptoms and evidence.
- **Bandwidth-delay product** — in-flight capacity.
- **Queueing and bufferbloat** — latency under load.
- **Network observability sources** — packets, flows, sockets, counters and probes.
- **Network segmentation and attack surface** — trust boundaries and allowed flows.
- **IDS/IPS overview** — observation versus enforcement.
- **Authorized network scanning** — scope and interpretation.

## Когда переходить дальше

Можно переходить, когда report profiles are reproducible, metrics identify distinct failure mechanisms, and security observations remain bounded, authorized and evidence-driven.