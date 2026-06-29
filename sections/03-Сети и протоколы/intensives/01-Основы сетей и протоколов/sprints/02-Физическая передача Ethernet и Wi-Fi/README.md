# Спринт 02. Физическая передача, Ethernet и Wi-Fi

Ориентировочный объём: 10–14 часов.

## Центральный вопрос

Как bits превращаются в signals and frames on a shared or point-to-point medium, and which physical/link limitations become visible to upper-layer protocols?

## Результат спринта

После завершения необходимо уметь:

- distinguish bit rate, baud rate, symbol, encoding and modulation conceptually;
- explain attenuation, noise, interference, error rate and signal-to-noise ratio;
- distinguish copper, fiber and radio media by operational properties;
- explain simplex, half-duplex and full-duplex;
- read Ethernet frame fields;
- distinguish unicast, multicast and broadcast MAC addresses;
- explain MTU, frame size, preamble/FCS conceptually and inter-frame overhead;
- understand autonegotiation, speed/duplex mismatch and link state;
- use `ethtool` and interface counters;
- explain Wi-Fi station/access point association and shared radio medium;
- distinguish Ethernet switching from Wi-Fi contention at overview level;
- identify physical/link symptoms: errors, drops, carrier, duplex, signal and queueing.

## Место в интенсиве

The first sprint showed protocol layers. This sprint examines the lowest observable boundary and prepares for switching, ARP and VLANs.

## Основной маршрут

### Шаг 1. Physical communication concepts

Read Kurose & Ross physical/link overview and Tanenbaum physical layer sections selectively:

- guided/unguided media;
- signal and noise;
- bandwidth versus data rate;
- multiplexing overview;
- propagation and transmission delay.

No advanced Fourier analysis is required.

### Шаг 2. Ethernet frame

Study Ethernet overview and Wireshark Ethernet reference. Understand fields:

```text
destination MAC | source MAC | optional 802.1Q | EtherType/length | payload | FCS
```

Note that preamble and FCS may not appear in host capture due to NIC/capture location.

### Шаг 3. Linux link observation

Study:

- `ip-link(8)`;
- `ethtool(8)`;
- `ip -s link`;
- `/sys/class/net/<if>/statistics`;
- `ethtool -S` where supported.

### Шаг 4. Wi-Fi overview

Study:

- infrastructure mode: station, access point, BSSID, SSID;
- management/control/data frames;
- association/authentication overview;
- channels and contention;
- signal strength versus throughput;
- WPA2/WPA3 boundaries at overview level.

Use Linux wireless docs and sanitized captures. Active attacks and deauthentication are outside scope.

## Ресурсы

### Обязательный маршрут

- Kurose & Ross, link layer and wireless introduction.
- Wireshark Ethernet/802.11 protocol references.
- `ip-link`, `ethtool` and interface statistics docs.
- Linux wireless documentation overview.

### Альтернативные объяснения

- Tanenbaum, physical and data-link chapters.
- Practical Packet Analysis Ethernet chapters.
- vendor-neutral cabling/fiber references.

### Углубление

- line coding and modulation mathematics;
- PHY negotiation and Energy Efficient Ethernet;
- optical budgets;
- 802.11 frame exchange and roaming;
- enterprise Wi-Fi authentication.

## Практические задания

### 1. Delay calculations

Calculate for examples:

- transmission delay of 1500-byte frame on 10 Mbps, 100 Mbps and 1 Gbps;
- propagation delay over 100 m copper/fiber and 3000 km fiber using stated assumptions;
- bandwidth-delay product for 100 Mbps, 50 ms RTT;
- effect of Ethernet/IP/TCP headers on goodput for small and large payloads.

State assumptions and units explicitly.

### 2. Interface inventory

For VM interfaces collect:

```bash
ip -details -statistics link show
ethtool IFACE
ethtool -k IFACE
ethtool -S IFACE
cat /sys/class/net/IFACE/{mtu,operstate,speed,duplex,carrier}
```

Missing virtual-interface fields are expected. Distinguish physical capability from virtual device representation.

### 3. Ethernet frame decode

Using capture from veth topology manually decode:

- destination/source MAC;
- EtherType;
- optional VLAN tag;
- payload protocol;
- frame length;
- why FCS may be absent;
- whether address is unicast/multicast/broadcast.

### 4. Link impairment

On one veth apply:

```bash
tc qdisc add dev IFACE root netem delay 20ms loss 0.5%
tc qdisc add dev IFACE root tbf rate 10mbit burst 32kbit latency 100ms
```

Use one qdisc hierarchy at a time and cleanup. Measure ping/iperf behavior, interface drops and queue effects.

## Лабораторная работа

Create `work/linklab/`.

### Topology

```text
host-a ns -- veth -- host-b ns
```

Support selectable MTU and qdisc profile.

### Workloads

- ICMP echo;
- UDP iperf3;
- TCP iperf3;
- custom Go sender with payload sizes 1, 64, 512, 1400 and 9000 bytes;
- capture on both veth endpoints.

### Experiments

1. Baseline at MTU 1500.
2. Rate limit 10 Mbps.
3. Added 50 ms one-way delay.
4. 1% packet loss.
5. MTU mismatch producing failure or fragmentation behavior.
6. Queue limit small enough to produce drops under burst.

### Required evidence

- interface counters before/after;
- packet/frame lengths;
- measured throughput/goodput;
- RTT distribution;
- retransmissions for TCP loss case;
- UDP loss report;
- qdisc statistics `tc -s qdisc`;
- explanation of which effect is physical analogy and which is software emulation.

### Wi-Fi observation

If Wi-Fi is available, collect only own interface state:

```bash
iw dev
ip link
nmcli dev wifi list   # do not commit neighboring identifiers
```

Analyze a sanitized 802.11 sample capture: identify beacon, probe, authentication/association and data frame categories. Redact SSID/BSSID if personal.

## Дополнительный эксперимент

Use two virtual links with same bandwidth but different delay. Show equal raw link rate and different TCP behavior. Relate to bandwidth-delay product without tuning TCP yet.

Alternative: compare small-message throughput with large stream throughput and calculate protocol/syscall overhead.

## Самопроверка

1. How do bandwidth and symbol rate differ?
2. What creates transmission versus propagation delay?
3. Why can a 1 Gbps link deliver less than 1 Gbps application goodput?
4. What does Ethernet EtherType identify?
5. Why might FCS be absent in pcap?
6. What does MTU limit?
7. How do half-duplex and full-duplex differ?
8. Why does Wi-Fi throughput fall with contention/interference?
9. Which interface counters suggest physical/link problems?
10. Why is software netem not an exact physical medium model?

Practical check: given interface counters, qdisc stats and capture, distinguish rate limit, packet loss, MTU issue and application underutilization.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Физическая передача данных** — signals, media, bandwidth and errors.
- **Transmission and propagation delay** — formulas and examples.
- **Ethernet frame** — fields, addressing, EtherType, payload and FCS.
- **MAC address types** — unicast, multicast and broadcast.
- **MTU** — layer boundary and upper-layer effects.
- **Ethernet link negotiation** — speed, duplex and carrier.
- **Wi-Fi architecture** — stations, access points, channels and frame categories.
- **Network interface counters** — errors, drops and operational interpretation.

## Когда переходить дальше

Можно переходить, когда frame fields are manually decoded, impairment profiles produce measurable effects, and physical/link observations are separated from transport behavior.