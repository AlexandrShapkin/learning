# Спринт 08. UDP, порты и sockets

Ориентировочный объём: 11–15 часов.

## Центральный вопрос

Как приложение адресует transport endpoint and exchanges independent datagrams without connection-level reliability?

## Результат спринта

После завершения необходимо уметь:

- explain transport multiplexing through address/protocol/port tuples;
- distinguish socket API from network protocol;
- explain UDP header and checksum;
- distinguish unconnected and connected UDP sockets;
- explain datagram boundaries, maximum practical payload and truncation;
- handle timeout, packet loss, duplication, reordering and sender identity;
- use `bind`, `sendto`, `recvfrom`, `connect` for UDP conceptually and in Go;
- inspect UDP sockets through `ss`;
- explain ephemeral ports;
- use broadcast and multicast in isolated topology;
- understand ICMP Port Unreachable interaction;
- design simple application reliability/idempotency where needed;
- avoid assuming UDP is always faster or real-time.

## Место в интенсиве

IP delivers best-effort packets between hosts. UDP exposes similar datagram semantics to applications with ports and checksums but minimal additional state.

## Основной маршрут

### Шаг 1. UDP protocol

Read RFC 768 and Kurose & Ross UDP sections. Decode:

```text
source port | destination port | length | checksum | payload
```

Understand IPv4 optional/IPv6 mandatory checksum semantics historically and operationally.

### Шаг 2. Socket API

Read Beej's Guide UDP sections and:

- `socket(7)`;
- `udp(7)`;
- `recvfrom(2)`, `sendto(2)`, `connect(2)`;
- Go `net.PacketConn`, `net.UDPConn`.

### Шаг 3. Multiplexing and errors

Observe:

- wildcard versus specific bind;
- same port on different addresses;
- ephemeral client port;
- ICMP Port Unreachable;
- connected UDP error reporting differences;
- socket receive buffer and drops.

### Шаг 4. Broadcast and multicast

Study IPv4 broadcast and multicast overview, IGMP conceptually and Linux multicast socket options. Use isolated namespace only.

## Ресурсы

### Обязательный маршрут

- RFC 768.
- Kurose & Ross UDP section.
- Beej's Guide datagram sockets.
- `udp(7)`, `socket(7)` and Go `net` docs.

### Альтернативные объяснения

- TCP/IP Illustrated UDP chapters.
- Stevens Unix Network Programming datagram chapters.

### Углубление

- UDP-Lite;
- multicast routing;
- RTP/RTCP;
- QUIC over UDP;
- kernel timestamping;
- recvmmsg/sendmmsg;
- eBPF/XDP UDP processing.

## Практические задания

### 1. Datagram boundaries

Send two messages of different sizes. Receive with buffers smaller/equal/larger than datagram and observe truncation/API behavior. Compare with stream semantics later.

### 2. Connected UDP

Use Go `DialUDP` and unconnected `ListenUDP`. Send to closed port and compare errors/timing through capture and application output.

### 3. Loss/reorder/duplication

Apply netem to laboratory link:

```bash
loss 10%
duplicate 5%
reorder 25% 50%
delay 50ms 20ms
```

Add sequence number/timestamp to messages and report missing, duplicate, reordered and late datagrams.

### 4. Multicast

Create three receiver namespaces joining one IPv4 multicast group and one sender. Verify membership and delivery, then remove one membership. Scope traffic to lab bridge.

## Лабораторная работа

Create `work/udplab/` with Go application `udp-lab`.

### Commands

```text
udp-lab server --listen 192.0.2.20:9000
udp-lab client --server 192.0.2.20:9000 --count 100 --interval 20ms
udp-lab relay --listen ... --upstream ...
udp-lab multicast-send --group 239.70.0.1:9001
udp-lab multicast-recv --group 239.70.0.1:9001 --interface ...
```

### Message format

Include:

- magic/version;
- client ID;
- sequence number;
- send timestamp;
- payload length;
- payload checksum.

This is an application format, not a replacement for UDP checksum.

### Server modes

- echo;
- drop every Nth;
- delay/reorder bounded queue;
- duplicate every Nth;
- rate-limit per client;
- reply from alternate socket/address for validation experiment.

### Client report

- sent/received;
- loss estimate;
- duplicates;
- reordering;
- RTT min/median/p95/p99;
- invalid checksum/version;
- source endpoint changes.

### Requirements

- bounded buffers and duration;
- context cancellation/signals;
- deterministic fault mode seed;
- tests for encoding/decoding and sequence accounting;
- no assumption that receive timeout proves packet loss cause;
- packet capture correlates app sequence with UDP/IP fields;
- topology/cleanup scripts.

### Failure scenarios

1. Wrong destination port.
2. Server bound only to loopback.
3. Firewall drops datagrams silently.
4. Receive buffer too small.
5. Application message exceeds path/fragmentation expectation.
6. Client trusts response from wrong source.
7. Duplicate/reordered request causes non-idempotent action twice.
8. Multicast receiver joined wrong interface/group.

## Дополнительный эксперимент

Implement at-least-once request/reply with request IDs, retransmission timeout and duplicate suppression. Show that reliability design introduces state and trade-offs, approaching but not reproducing TCP semantics.

Alternative: use `SO_TIMESTAMPNS`/Go syscall support for receive timestamps and compare application versus kernel timing.

## Самопроверка

1. What identifies a UDP endpoint?
2. Does UDP establish a connection?
3. What does `connect()` mean for UDP socket?
4. Are datagram boundaries preserved?
5. How does checksum differ from delivery guarantee?
6. What happens when destination port is closed?
7. Why can UDP loss be in application/kernel/network?
8. Why is retransmission timeout an application concern?
9. When are broadcast/multicast appropriate?
10. Why isn't UDP automatically lower latency under all conditions?

Practical check: given client report, pcap, socket state and firewall counters, distinguish server absence, closed port, path loss, application drop and receive-buffer overflow.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Transport ports and multiplexing** — endpoints and ephemeral ports.
- **UDP** — header, datagram semantics and checksum.
- **UDP sockets** — bind/connect/sendto/recvfrom.
- **Datagram loss, duplication and reordering** — application consequences.
- **Broadcast and multicast** — delivery scope and membership.
- **Application reliability over UDP** — IDs, retries, idempotency and state.

## Когда переходить дальше

Можно переходить, когда udplab reports controlled impairments correctly, multicast is isolated, and failures are localized through application, socket, ICMP and capture evidence.