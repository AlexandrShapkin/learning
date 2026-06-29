# Спринт 10. Проверка транспортного уровня

Ориентировочный объём: 8–12 часов.

Новая теория не вводится. Спринт проверяет sockets, UDP and TCP вместе с routing/MTU.

## Исходный проект

Create `work/transport-checkpoint/` with topology:

```text
client -- r1 -- impaired transit -- r2 -- server
```

Run one Go service exposing:

- UDP request/reply endpoint;
- TCP framed request/reply endpoint;
- TCP bulk stream endpoint;
- metrics endpoint on separate local socket;
- deterministic request IDs/checksums.

## Часть 1. Baseline prediction

Before capture answer:

1. Which packets establish TCP connection?
2. Which identifiers demultiplex UDP and TCP?
3. How many application messages may map to reads/segments?
4. Which MTU/MSS values should be negotiated?
5. What happens when UDP destination port is closed?
6. What state remains after graceful TCP close?
7. How will RTT affect short request and bulk stream differently?

## Часть 2. Baseline evidence

Collect:

```bash
ss -uanp
ss -tanpi
nstat -az
tc -s qdisc
ip route get
tcpdump/tshark captures
```

Verify application checksums and exact endpoints.

## Часть 3. Failure scenarios

### A. UDP wrong port

Client times out or receives ICMP. Determine whether ICMP reaches connected/unconnected socket and how application reports it.

### B. UDP loss/duplication

Netem causes missing and duplicated request. Verify application request IDs and idempotent handling.

### C. TCP listener absent

Observe SYN retries versus immediate RST depending on host/path behavior.

### D. Firewall silent drop

Compare with closed port. Establish evidence from retransmissions, nft counters and missing RST.

### E. MTU/PMTU failure

Handshake/small messages work but bulk payload stalls when ICMP is blocked. Prove with packet size and retransmission pattern.

### F. Slow receiver

Receive window shrinks/zeroes. Distinguish receiver/application limitation from network congestion.

### G. Packet loss

Observe duplicate ACK/SACK/retransmission and throughput reduction.

### H. Server reset

RST after partial request. Determine whether application can safely retry.

### I. Framing bug

Server assumes one read equals one message. Reproduce with split/coalesced writes and fix length-prefix parsing.

### J. TIME_WAIT exhaustion misconception

Generate many short connections and inspect states. Explain actual local port limits and why lowering timers blindly is not first fix.

## Часть 4. Protocol choice

For scenarios choose UDP, TCP or another higher-level protocol and justify:

- metrics telemetry;
- file transfer;
- real-time voice;
- transactional payment request;
- service discovery;
- DNS query;
- game state updates;
- remote shell.

Justification must include delivery, ordering, latency, congestion and application semantics, not only “fast/reliable”.

## Часть 5. Defense

1. How do UDP and TCP differ in state and data model?
2. What does a port identify?
3. How does kernel choose receiving socket?
4. What does UDP checksum guarantee?
5. How does TCP recover loss?
6. How do rwnd and cwnd differ?
7. Why can small packets work during PMTU black hole?
8. How do closed port and filtered port differ?
9. When is retry unsafe?
10. Why must TCP application define framing?

## Критерии прохождения

- service implements correct UDP/TCP semantics and tests;
- all ten failures are reproduced and reverted;
- captures and socket state support each diagnosis;
- UDP duplicate processing is controlled;
- TCP partial I/O/framing is correct;
- PMTU failure is identified without arbitrary global tuning;
- protocol choices include application-level requirements;
- at least 8 of 10 defense answers are correct.

При затруднении:

- routing/ICMP/MTU → sprint 06;
- UDP → sprint 08;
- TCP → sprint 09.

## Результат для базы знаний

Новые заметки не обязательны. Обновить UDP/TCP/socket/PMTU notes только по выявленным неверным assumptions.