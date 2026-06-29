# Ресурсы интенсива

Это общая библиография. Конкретные обязательные главы и RFC указаны в спринтах. Читать все документы последовательно не требуется.

## Основные учебники

### Computer Networking: A Top-Down Approach

James Kurose, Keith Ross. Основной связующий учебник: application layer, transport, network layer, link layer, wireless, security и network management.

Официальный сайт и материалы: https://gaia.cs.umass.edu/kurose_ross/

### TCP/IP Illustrated, Volume 1, Second Edition

Kevin Fall, W. Richard Stevens. Подробное практическое объяснение Internet protocols через captures и experiments.

Книга коммерческая. Используется как углубление для ARP, IP, ICMP, UDP, TCP и DNS.

### Computer Networks

Andrew S. Tanenbaum, David J. Wetherall. Альтернативный системный обзор physical/link/network/transport/application layers.

### Beej's Guide to Network Programming

Бесплатный практический источник по sockets и client/server programming:

- https://beej.us/guide/bgnet/

### Practical Packet Analysis

Chris Sanders. Практический маршрут по Wireshark и packet-level troubleshooting. Книга коммерческая.

## RFC и стандарты

Официальный каталог: https://www.rfc-editor.org/

### Базовые протоколы

- ARP — RFC 826;
- IPv4 — RFC 791 и обновляющие документы;
- ICMPv4 — RFC 792;
- IPv6 — RFC 8200;
- ICMPv6 — RFC 4443;
- Neighbor Discovery — RFC 4861;
- SLAAC — RFC 4862;
- UDP — RFC 768;
- TCP — RFC 9293;
- TCP congestion control principles — RFC 5681 и последующие updates;
- Path MTU Discovery IPv4 — RFC 1191;
- Path MTU Discovery IPv6 — RFC 8201.

### Addressing и routing

- CIDR — RFC 4632;
- private IPv4 — RFC 1918;
- special-purpose IPv4 — IANA registries;
- IPv6 addressing — RFC 4291;
- OSPFv2 — RFC 2328;
- BGP-4 — RFC 4271;
- router requirements and route selection — использовать current RFCs и implementation docs.

### DNS и DHCP

- DNS concepts and facilities — RFC 1034;
- DNS implementation and specification — RFC 1035;
- negative caching — RFC 2308;
- EDNS — RFC 6891;
- DNSSEC overview — RFC 4033–4035;
- DHCPv4 — RFC 2131 и options RFC 2132;
- DHCPv6 — RFC 8415.

### HTTP, TLS и QUIC

- HTTP Semantics — RFC 9110;
- HTTP/1.1 — RFC 9112;
- HTTP/2 — RFC 9113;
- HTTP/3 — RFC 9114;
- QUIC transport — RFC 9000;
- TLS 1.3 — RFC 8446;
- PKIX certificate profile — RFC 5280;
- ALPN — RFC 7301;
- Server Name Indication — TLS extensions specifications.

### Email, time и remote access

- SMTP — RFC 5321;
- Internet Message Format — RFC 5322;
- IMAP4rev2 — RFC 9051;
- NTPv4 — RFC 5905;
- SSH architecture — RFC 4251 and related RFCs;
- FTP — RFC 959, изучается как исторический контраст с SFTP/HTTPS.

## Packet analysis

- Wireshark User's Guide: https://www.wireshark.org/docs/wsug_html_chunked/
- Wireshark Display Filter Reference: https://www.wireshark.org/docs/dfref/
- tshark manual: https://www.wireshark.org/docs/man-pages/tshark.html
- tcpdump/libpcap: https://www.tcpdump.org/manpages/
- Wireshark SampleCaptures: https://wiki.wireshark.org/SampleCaptures

## Linux networking

- Linux kernel networking documentation: https://docs.kernel.org/networking/
- iproute2 project and man pages: https://www.kernel.org/pub/linux/utils/net/iproute2/
- `network_namespaces(7)`, `socket(7)`, `packet(7)`;
- `ip(8)`, `bridge(8)`, `ss(8)`, `tc(8)`;
- nftables project: https://www.netfilter.org/projects/nftables/
- Netfilter documentation: https://www.netfilter.org/documentation/
- conntrack tools: https://conntrack-tools.netfilter.org/

## Routing

- FRRouting documentation: https://docs.frrouting.org/
- Bird documentation: https://bird.network.cz/
- Linux routing policy database: `ip-rule(8)` and `ip-route(8)`.

Основной интенсив использует static routing и небольшой OSPF experiment. BGP рассматривается обзорно и в итоговой topology; полноценная policy engineering относится к углублению.

## DNS

- BIND 9 Administrator Reference Manual: https://bind9.readthedocs.io/
- Unbound documentation: https://unbound.docs.nlnetlabs.nl/
- DNSViz: https://dnsviz.net/
- IANA DNS parameters: https://www.iana.org/assignments/dns-parameters/

## HTTP и proxies

- MDN HTTP overview: https://developer.mozilla.org/docs/Web/HTTP
- curl documentation: https://curl.se/docs/
- nginx documentation: https://nginx.org/en/docs/
- HAProxy documentation: https://www.haproxy.org/documentation/

## TLS и PKI

- OpenSSL documentation: https://docs.openssl.org/
- Mozilla Server Side TLS guidance: https://ssl-config.mozilla.org/
- Certificate Transparency: https://certificate.transparency.dev/

## VPN

- WireGuard documentation: https://www.wireguard.com/
- WireGuard whitepaper: https://www.wireguard.com/papers/wireguard.pdf
- Linux XFRM/IPsec documentation for optional comparison.

## Virtual и container networking

- Linux bridge documentation: https://docs.kernel.org/networking/bridge.html
- VXLAN documentation: https://docs.kernel.org/networking/vxlan.html
- network namespaces man pages;
- CNI specification: https://www.cni.dev/docs/spec/
- OCI runtime/network-related concepts: https://opencontainers.org/
- Docker networking docs: https://docs.docker.com/network/
- Kubernetes networking model: https://kubernetes.io/docs/concepts/services-networking/

Container and cloud products are used only to map abstractions to mechanisms; platform administration belongs to another section.

## Производительность и диагностика

- iperf3: https://software.es.net/iperf/
- `ping`, `tracepath`, `traceroute`, `mtr`, `ss`, `nstat`, `ethtool`, `tc` man pages;
- Linux network statistics under `/proc/net` and `ip -s`;
- Brendan Gregg network performance materials: https://www.brendangregg.com/networking.html
- Cloudflare blog articles may be used as secondary case studies, with mechanisms verified against RFCs and captures.

## Беспроводные сети

- Linux wireless documentation: https://wireless.docs.kernel.org/
- Wi-Fi Alliance resources: https://www.wi-fi.org/
- Wireshark 802.11 documentation and sample captures.

Обязательная часть не требует monitor mode или frame injection.

## Правило использования

1. Начинать с обязательного маршрута спринта.
2. RFC читать по указанным sections и diagrams, а не полностью без цели.
3. Поведение конкретной Linux version проверять по local man pages и packet capture.
4. Вторичные статьи использовать для объяснения, но поля и state machines сверять с RFC/upstream docs.
5. Не копировать RFC, books, large pcaps или downloaded binaries в repository.