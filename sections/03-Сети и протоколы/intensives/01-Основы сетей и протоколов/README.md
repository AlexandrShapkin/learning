# Основы сетей и протоколов

Основной интенсив раздела «Сети и протоколы». Сеть изучается через фактический путь пакета, packet captures, лабораторные топологии и controlled failures, а не через запоминание уровней и номеров портов.

## Результат прохождения

После завершения необходимо уметь самостоятельно:

- объяснять назначение сетевых уровней и инкапсуляцию без превращения OSI в догму;
- различать frame, packet, datagram, segment, stream, message и application request;
- читать capture в Wireshark/tshark и связывать поля пакета с поведением приложения;
- объяснять физические ограничения: signal, medium, duplex, bandwidth, latency и error rate;
- строить Ethernet-сегменты с Linux bridge, MAC learning, VLAN и STP;
- различать MAC- и IP-адреса, ARP и IPv6 Neighbor Discovery;
- рассчитывать подсети, summarization, broadcast boundaries и адресный план;
- объяснять IPv4, IPv6, ICMP, TTL/Hop Limit, fragmentation и Path MTU Discovery;
- выбирать маршрут по longest prefix match, metric и policy;
- собирать topology со static routing и базовой динамической маршрутизацией;
- программировать UDP/TCP sockets и объяснять kernel socket state;
- прослеживать TCP handshake, retransmission, flow control, congestion control и teardown;
- строить authoritative и recursive DNS, управлять TTL, delegation и validation failures;
- воспроизводить DHCP lease lifecycle и сравнивать DHCPv4, DHCPv6 и SLAAC;
- исследовать HTTP/1.1, HTTP/2 и HTTP/3 на уровне различий transport/application semantics;
- объяснять forward proxy, reverse proxy, gateway и L4/L7 load balancer;
- создавать локальную CA, сертификаты, mTLS и диагностировать TLS validation;
- применять NAT, conntrack, nftables и WireGuard в isolated topology;
- объяснять virtual, container, overlay и cloud networks через общие механизмы;
- измерять latency, jitter, loss, throughput, goodput, retransmissions и queueing;
- системно локализовать сетевую неисправность и доказывать root cause.

Целевой уровень: 3 по всему разделу и 4 по packet flow, IP/routing, TCP, DNS/TLS и диагностике.

## Границы

Интенсив не заменяет:

- полный курс радиотехники и проектирования физической сети;
- профессиональную сертификацию уровня CCNP/CCIE/JNCIP;
- глубокое изучение BGP policy, MPLS, EVPN и carrier networking;
- production-эксплуатацию DNS, PKI, CDN или DDoS-защиты;
- Kubernetes CNI и cloud networking во всём объёме;
- разработку kernel network stack или high-performance DPDK applications.

Эти темы рассматриваются только настолько, насколько нужны для связного понимания сети и диагностики.

## Предварительные знания

Рекомендуется завершить основные интенсивы:

- [«Основы вычислительных систем»](../../../01-Вычислительные%20системы/intensives/01-Основы%20вычислительных%20систем/);
- [«Основы операционных систем и Linux»](../../../02-Операционные%20системы/intensives/01-Основы%20операционных%20систем%20и%20Linux/).

Минимально необходимы:

- Linux shell;
- процессы и file descriptors;
- network namespaces и basic `ip`/`ss`;
- двоичная и шестнадцатеричная системы;
- базовый Go;
- Git.

## Лабораторное окружение

Эталонная среда — disposable Linux VM с root/sudo, systemd и network namespaces. Подробная схема находится в [`LAB_ENVIRONMENT.md`](LAB_ENVIRONMENT.md).

Проверка инструментов:

```bash
bash scripts/check-environment.sh
```

Большинство топологий создаётся локально через namespaces, veth, bridges, nftables и traffic control. Дополнительное физическое оборудование не требуется.

## Правила безопасности

1. Packet capture выполняется только на собственной лабораторной системе и разрешённых сетях.
2. Active scanning, spoofing, DHCP/DNS servers и firewall experiments ограничиваются isolated namespaces/VM.
3. Не запускать rogue DHCP, ARP spoofing или routing daemon в рабочей LAN.
4. Firewall/VPN changes не применяются к management interface host без rollback и second session.
5. Test certificates и private keys не используются вне лаборатории и не коммитятся, кроме специально созданных non-secret fixtures.
6. Public IP addresses в документации заменяются RFC 5737, RFC 3849 и RFC 1918 ranges.
7. Generated pcaps проверяются на secrets, credentials и unrelated traffic перед commit.
8. Traffic generators имеют bounded duration/rate и не направляются на внешние hosts без разрешения.

## Правила прохождения

1. Спринты выполняются по порядку.
2. Перед каждым capture фиксируется ожидаемая последовательность пакетов или state transitions.
3. После capture объясняются только наблюдаемые поля; assumptions отделяются от evidence.
4. Сохраняются topology scripts, application source, small sanitized pcaps, filters и существенные результаты.
5. Полные screenshots Wireshark и длинные transcripts не требуются.
6. Проверочные спринты выполняются без повторного чтения до первой попытки.
7. Обобщённые механизмы переносятся в `knowledge`; addresses, machine-specific outputs и raw test data остаются в `work/`.
8. Исправление сети считается подтверждённым только после проверки data plane и control/configuration state.

## Порядок спринтов

1. [Сетевые модели, инкапсуляция и packet capture](sprints/01-Сетевые%20модели%20инкапсуляция%20и%20packet%20capture/) — уровни, PDUs, interfaces, sockets и Wireshark.
2. [Физическая передача, Ethernet и Wi-Fi](sprints/02-Физическая%20передача%20Ethernet%20и%20Wi-Fi/) — media, signal, duplex, Ethernet frames и wireless overview.
3. [Коммутация, ARP, VLAN и STP](sprints/03-Коммутация%20ARP%20VLAN%20и%20STP/) — MAC learning, broadcast domains, VLAN trunks и loops.
4. [IPv4, CIDR и планирование адресов](sprints/04-IPv4%20CIDR%20и%20планирование%20адресов/) — addressing, subnetting, fragmentation и address design.
5. [IPv6 и Neighbor Discovery](sprints/05-IPv6%20и%20Neighbor%20Discovery/) — address types, NDP, SLAAC, DHCPv6 и dual stack.
6. [Маршрутизация и ICMP](sprints/06-Маршрутизация%20и%20ICMP/) — route lookup, forwarding, static/dynamic routes, traceroute и PMTUD.
7. [Проверка сетевого основания](sprints/07-Проверка%20сетевого%20основания/) — интеграция L2/L3 без новой теории.
8. [UDP, порты и sockets](sprints/08-UDP%20порты%20и%20sockets/) — datagrams, multiplexing, multicast и socket API.
9. [TCP: соединение, надёжность и congestion control](sprints/09-TCP%20соединение%20надёжность%20и%20congestion%20control/) — handshake, sequence space, windows, retransmission и teardown.
10. [Проверка транспортного уровня](sprints/10-Проверка%20транспортного%20уровня/) — диагностика UDP/TCP path.
11. [DNS](sprints/11-DNS/) — hierarchy, delegation, recursive/authoritative servers, caching и DNSSEC overview.
12. [DHCP и автоматическая конфигурация](sprints/12-DHCP%20и%20автоматическая%20конфигурация/) — lease lifecycle, options, relay и IPv6 alternatives.
13. [HTTP, proxy и application path](sprints/13-HTTP%20proxy%20и%20application%20path/) — HTTP semantics, versions, forward/reverse proxy и caching.
14. [TLS, сертификаты и PKI](sprints/14-TLS%20сертификаты%20и%20PKI/) — handshake, SNI, ALPN, certificate validation и mTLS.
15. [Прикладные сетевые протоколы](sprints/15-Прикладные%20сетевые%20протоколы/) — SSH, SMTP, IMAP, NTP, FTP/SFTP и protocol inspection.
16. [NAT, firewall и VPN](sprints/16-NAT%20firewall%20и%20VPN/) — conntrack, SNAT/DNAT, nftables и WireGuard.
17. [Балансировка нагрузки и отказоустойчивость](sprints/17-Балансировка%20нагрузки%20и%20отказоустойчивость/) — L4/L7, health checks, affinity, failover и retries.
18. [Виртуальные, контейнерные и облачные сети](sprints/18-Виртуальные%20контейнерные%20и%20облачные%20сети/) — veth, bridge, overlay, VXLAN, CNI и cloud abstractions.
19. [Производительность, наблюдаемость и сетевая безопасность](sprints/19-Производительность%20наблюдаемость%20и%20сетевая%20безопасность/) — metrics, packet loss, jitter, queues, scanning boundaries и evidence.
20. [Проверка сетевой эксплуатации](sprints/20-Проверка%20сетевой%20эксплуатации/) — комплексный DNS/TLS/proxy/firewall incident.
21. [Системная диагностика сети](sprints/21-Системная%20диагностика%20сети/) — методика fault isolation и recovery.
22. [Итоговая работа](sprints/99-Итоговая%20работа/) — построение и диагностика многоуровневой сетевой лаборатории.

## Покрытие основных вопросов раздела

| Основной вопрос | Спринты |
|---|---|
| Как данные передаются от одного приложения к другому? | 01–06, 08–15 |
| Какие преобразования происходят на сетевых уровнях? | 01–06, 08–09, 13–14 |
| Чем MAC отличается от IP? | 02–05 |
| Как узел определяет, куда передать пакет? | 03–06 |
| Как рассчитываются подсети и выбирается маршрут? | 04–06 |
| Чем TCP отличается от UDP? | 08–10 |
| Что происходит при установлении и завершении TCP? | 09–10 |
| Как имя преобразуется в IP? | 11–12 |
| Как TLS защищает данные? | 14 |
| Чем proxy отличается от reverse proxy и load balancer? | 13, 17 |
| Как firewall принимает решение? | 16, 20 |
| Как взаимодействуют containers и VMs? | 18 |
| Как локализовать DNS/routing/TCP/TLS/application failure? | 20–21, 99 |
| Какие показатели описывают состояние сети? | 19–21 |
| Как решения влияют на availability, security и performance? | 16–21, 99 |

Таблица является частью готового маршрута и не требует ручного сопровождения.

## Итоговая работа

Итогом станет `network-lab-platform` — многоуровневая topology в Linux namespaces/VM с:

- двумя client segments и несколькими routers;
- VLAN или эквивалентной L2 segmentation;
- IPv4/IPv6 addressing и routing;
- DHCP и локальной DNS hierarchy;
- TLS reverse proxy/load balancer;
- несколькими Go application backends;
- NAT/firewall и WireGuard management path;
- container-like namespace segment и VXLAN overlay;
- packet capture, metrics и fault injection;
- минимум двадцатью диагностическими сценариями.

## Вклад в базу знаний

Каждый спринт содержит конкретные рекомендации по заметкам, их границам и связям. Отдельный backlog не ведётся.

Заметка создаётся тогда, когда после лаборатории сформирована устойчивая модель. Raw capture, topology addresses и machine-specific commands остаются в `learning`.

## Общая библиография

Основные книги, RFC, официальная документация и инструменты собраны в [`RESOURCES.md`](RESOURCES.md). Внутри каждого спринта указан минимальный обязательный маршрут.

## Продолжение

После интенсива логично перейти к разделам «Прикладные системы и интерфейсы», «Инфраструктура и платформы», «Распределённые системы и надёжность», «Безопасность» или к тематическому углублению по routing, DNS, TCP/QUIC либо datacenter networking.