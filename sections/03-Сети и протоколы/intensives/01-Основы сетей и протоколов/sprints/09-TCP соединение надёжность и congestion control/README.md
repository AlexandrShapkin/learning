# Спринт 09. TCP: соединение, надёжность и congestion control

Ориентировочный объём: 16–22 часа.

## Центральный вопрос

Как TCP turns an unreliable packet network into a reliable ordered byte stream while adapting to receiver and network capacity?

## Результат спринта

После завершения необходимо уметь:

- explain TCP byte-stream semantics and connection tuple;
- decode TCP header, flags, sequence and acknowledgment numbers;
- explain three-way handshake and initial sequence numbers;
- distinguish flow control from congestion control;
- explain receive window, congestion window and effective send window conceptually;
- explain segmentation, ACKs, retransmission and RTT estimation;
- recognize duplicate ACK, fast retransmit, timeout and selective acknowledgment;
- understand slow start, congestion avoidance and loss response at practical level;
- explain Nagle algorithm, delayed ACK and small writes interaction;
- explain half-close, FIN sequence, RST and TIME_WAIT;
- inspect TCP state with `ss -ti`, `nstat` and captures;
- reproduce loss, delay, reordering, zero-window and reset scenarios;
- distinguish connection establishment, application protocol and TLS failures;
- avoid treating one packet as one application message.

## Место в интенсиве

UDP exposed best-effort datagrams. TCP adds per-connection state and feedback loops used by HTTP, TLS, SSH and many other protocols.

## Основной маршрут

### Шаг 1. TCP specification and stream model

Read:

- RFC 9293 selected sections on header, state machine and connection lifecycle;
- Kurose & Ross reliable transport and TCP sections;
- Beej's Guide stream sockets.

### Шаг 2. Reliability

Understand:

- sequence space counts bytes;
- cumulative acknowledgments;
- retransmission timers;
- duplicate ACKs;
- SACK options;
- out-of-order queue;
- checksum limits.

### Шаг 3. Flow and congestion control

Study:

- receive window;
- slow start;
- congestion avoidance;
- fast retransmit/recovery overview;
- modern algorithms vary by OS (`cubic`, `bbr`, etc.);
- queueing and bufferbloat.

Use actual `sysctl net.ipv4.tcp_congestion_control` only for observation; do not tune host globally.

### Шаг 4. State and teardown

Study TCP states and Linux observation:

```bash
ss -tanpi
ss -ti dst ADDRESS
nstat -az
cat /proc/sys/net/ipv4/tcp_fin_timeout
```

Do not interpret kernel tuning parameter name as exact protocol state timer without docs.

## Ресурсы

### Обязательный маршрут

- RFC 9293 selected sections.
- Kurose & Ross reliable data transfer and TCP chapters.
- Beej's Guide stream sockets.
- `tcp(7)`, `ss(8)`, Wireshark TCP analysis docs.

### Альтернативные объяснения

- TCP/IP Illustrated TCP chapters.
- Stevens Unix Network Programming TCP chapters.
- Cloudflare TCP case studies as secondary material.

### Углубление

- RACK/TLP loss recovery;
- BBR;
- TCP Fast Open;
- ECN;
- pacing;
- SYN cookies;
- kernel TCP implementation;
- multipath TCP.

## Практические задания

### 1. Handshake decode

Capture a local connection and manually calculate relative/absolute sequence numbers for SYN, SYN-ACK, ACK and first data. Identify MSS, window scale, SACK permitted and timestamps options.

### 2. Stream boundaries

Client performs two writes; server reads in arbitrary buffer sizes. Demonstrate that read calls do not preserve write/message boundaries. Implement length-prefix framing.

### 3. Teardown variants

Observe:

- graceful client close;
- server half-close;
- process killed causing FIN or RST depending on buffered/unread data;
- connection to closed port;
- listener backlog pressure.

Map states through `ss` and capture.

### 4. Loss and delay

Use netem with fixed workload:

- baseline;
- 50 ms RTT;
- 1% loss;
- reordering;
- rate limit;
- excessive queue causing latency.

Collect throughput, RTT, retransmissions, cwnd/rwnd where visible and TCP analysis flags.

## Лабораторная работа

Create `work/tcplab/` with Go application.

### Commands

```text
tcplab server --listen 192.0.2.20:9000 --mode echo
tcplab client --server ... --messages 100 --size 4096
tcplab stream --bytes 1GiB --hash
tcplab slow-reader --rate 64KiB/s
tcplab reset-server --after-bytes N
tcplab report --connection ...
```

### Application protocol

Use framed messages:

```text
version | type | request ID | payload length | payload | checksum
```

Server supports echo, bulk receive and request/reply. Safe defaults and upper bounds required.

### Experiments

1. Handshake/options.
2. Multiple writes versus reads.
3. Slow receiver and shrinking receive window.
4. Loss causing retransmissions.
5. Delay affecting throughput and cwnd growth.
6. Reset mid-stream and partial application work.
7. Half-close request then response.
8. Many short connections causing TIME_WAIT.
9. One persistent connection versus repeated connections.
10. Backlog saturation with slow accept mode.

### Evidence

- application hashes/counts;
- captures;
- `ss -ti` snapshots;
- `nstat` before/after;
- iperf3 comparison;
- netem/qdisc stats;
- raw timing samples.

### Requirements

- handle partial `Read`/`Write` correctly;
- deadlines and context cancellation;
- no unbounded goroutines/buffers;
- tests for framing and abrupt EOF;
- server reports accepted/completed/failed requests separately;
- cleanup resets qdisc/topology;
- conclusions distinguish application latency from transport RTT.

## Дополнительный эксперимент

Compare congestion controls available inside VM/network namespace where per-namespace/kernel support permits. Use same path/workload and report limitations; do not claim universal superiority.

Alternative: reproduce bufferbloat with large queue under bulk flow while measuring ping, then apply smaller/fair queue discipline and compare latency/throughput trade-off.

## Самопроверка

1. What does TCP sequence number count?
2. Why does handshake need three messages?
3. How do flow and congestion control differ?
4. What triggers retransmission?
5. Why can one write become multiple segments and one read combine writes?
6. What do MSS and MTU relate to?
7. Why does TIME_WAIT exist?
8. How do FIN and RST differ?
9. How can slow receiver affect sender?
10. Why does loss reduce throughput more on high-RTT path?
11. What can `ss -ti` show that pcap alone may not?

Practical check: given capture and socket metrics, identify handshake failure, retransmission loss, zero-window receiver limitation, reset and application framing bug.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **TCP connection** — tuple, state and byte stream.
- **TCP header and flags** — sequence, acknowledgment and options.
- **TCP handshake** — synchronization and negotiation.
- **TCP reliability** — ACKs, retransmission, SACK and ordering.
- **TCP flow control** — receive window.
- **TCP congestion control** — cwnd, slow start and network feedback.
- **TCP teardown and TIME_WAIT** — FIN, half-close, RST and lifecycle.
- **Application framing over TCP** — stream versus messages.
- **TCP diagnostics** — captures, ss and counters.

## Когда переходить дальше

Можно переходить, когда tcplab handles partial I/O and failures, transport effects are reproduced with netem, and connection states/sequences are explained from evidence.