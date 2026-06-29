# Спринт 01. Сетевые модели, инкапсуляция и packet capture

Ориентировочный объём: 10–14 часов.

## Центральный вопрос

Как данные приложения превращаются в последовательность protocol headers и bytes, передаваемых через interfaces, а затем снова собираются в данные другого приложения?

## Результат спринта

После завершения необходимо уметь:

- объяснять назначение уровней TCP/IP и OSI как моделей ответственности;
- различать service, protocol, interface и implementation;
- использовать термины frame, packet, datagram, segment, stream и message в правильном контексте;
- объяснять encapsulation и decapsulation;
- различать адреса link/network/transport/application уровней;
- объяснять bandwidth, throughput, goodput, latency, jitter и loss;
- различать host, interface, link, subnet, router и endpoint;
- находить sockets и connections через `ss`;
- выполнять capture через tcpdump и анализ через Wireshark/tshark;
- применять capture filters и display filters;
- сопоставлять application action, syscall, socket state и packets;
- объяснять ограничения packet capture: offloading, encryption, capture point и missing packets.

## Место в интенсиве

Спринт задаёт язык всего курса. Каждый следующий механизм будет изучаться через один и тот же цикл: прогноз packet flow → capture → декодирование → controlled change → проверка.

## Основной маршрут

### Шаг 1. Сетевое взаимодействие и уровни

Прочитать Kurose & Ross:

- chapter 1 полностью;
- overview application, transport, network and link layers;
- delay, loss and throughput sections.

Сформировать собственную схему:

```text
process → socket → transport → IP → link → medium
→ link → IP → transport → socket → process
```

Отдельно указать, где меняются headers и какие identifiers используются.

### Шаг 2. OSI и TCP/IP

Изучить OSI и TCP/IP mapping как модели, не как физически существующие семь программных блоков.

Для HTTP over TLS over TCP over IPv6 over Ethernet определить:

- responsibility каждого протокола;
- PDU;
- local/remote identifiers;
- stateful/stateless aspects;
- какие промежуточные устройства читают конкретный header.

### Шаг 3. Packet capture

Изучить:

- tcpdump manual;
- Wireshark User's Guide: capture, packet list/details/bytes, name resolution, profiles;
- tshark basic options;
- pcap capture versus display filters.

Минимальные команды:

```bash
tcpdump -D
tcpdump -i lo -nn -s 0 -w capture.pcap
tshark -r capture.pcap -q -z conv,tcp
tshark -r capture.pcap -Y 'tcp.flags.syn == 1'
```

### Шаг 4. Sockets и kernel state

Изучить обзорно:

- `socket(7)`;
- `ss(8)`;
- `/proc/net/*` только как implementation interface;
- `strace -e trace=%network`.

## Ресурсы

### Обязательный маршрут

- Kurose & Ross, chapter 1.
- Wireshark User's Guide: capture and analysis basics.
- tcpdump/tshark/ss man pages.
- `socket(7)` overview.

### Альтернативные объяснения

- Tanenbaum, introductory networking chapters.
- Practical Packet Analysis, chapters 1–4.
- Stanford CS144 networking introduction materials.

### Углубление

- libpcap file format and capture architecture;
- AF_PACKET and raw sockets;
- Linux network stack receive/transmit path;
- hardware offloads and capture artifacts.

## Практические задания

### 1. Терминологическая карта

Для сценария `curl http://127.0.0.1:8080/hello` определить:

- application message;
- local/remote socket addresses;
- transport protocol;
- IP packet fields;
- link-layer behavior on loopback;
- payload at each layer;
- response path.

Не называть TCP segment «HTTP packet» без указания уровня.

### 2. Baseline captures

Снять отдельные captures:

- `ping 127.0.0.1`;
- DNS query;
- HTTP request to local server;
- HTTPS request to public test site только при отсутствии sensitive data;
- failed connection to unused local port.

Для каждого до capture записать ожидаемые protocols и число основных exchanges. После capture сравнить.

### 3. Capture point

Запустить Go HTTP server на loopback и затем на namespace veth. Снять capture на:

- `lo`;
- host `any`;
- конкретном veth;
- client namespace interface.

Объяснить, почему packets/headers могут выглядеть по-разному и где link-layer header отсутствует или synthetic.

### 4. Filters

Написать минимум 15 useful filters:

- capture filters для host/net/port/protocol;
- display filters для DNS query, TCP SYN, reset, retransmission, HTTP method, TLS handshake, ICMP error;
- fields output through tshark.

Каждый filter проверить на synthetic capture.

## Лабораторная работа

Создать `work/packet-path/`.

### Topology

```text
client namespace -- veth -- server namespace
```

Addresses:

- client `192.0.2.10/24`;
- server `192.0.2.20/24`.

### Applications

Написать на Go:

- TCP echo server/client;
- UDP echo server/client;
- HTTP server/client;
- command `socket-info`, выводящий local/remote addresses и transport.

### Capture workflow

`run.sh` должен:

1. создать topology;
2. запустить servers;
3. начать captures на обеих сторонах;
4. выполнить UDP, TCP and HTTP exchanges;
5. выполнить failed TCP connection;
6. остановить capture cleanly;
7. сформировать summary через tshark;
8. удалить namespaces по отдельной cleanup command.

### Обязательный анализ

Для каждого exchange указать:

- application operation;
- socket endpoints;
- frame/packet/transport sequence;
- payload location;
- state visible through `ss`;
- timing relative to capture;
- отличие UDP, TCP и HTTP.

Сохранить не screenshots, а:

```text
captures/*.pcapng        # только small sanitized files
filters.txt
summary/*.txt
README.md                # topology, commands, 8–12 conclusions
```

### Tests

- Go unit/integration tests;
- topology setup is idempotent or fails clearly;
- cleanup leaves no `pp-` namespaces/interfaces;
- packet counts are not hardcoded exactly where kernel behavior may vary;
- expected protocols are asserted through tshark fields.

## Дополнительный эксперимент

Disable selected offloads on a laboratory veth where supported through `ethtool -K`, repeat capture and compare checksums/segmentation. Explain why outbound TCP checksums may appear invalid in capture before NIC processing.

Alternative: use `strace` and packet timestamps to correlate `connect`, `accept`, `sendto`, `recvfrom`, `read`, `write` with network packets.

## Самопроверка

1. Why is OSI useful if Internet stack does not literally implement seven independent layers?
2. What is encapsulation?
3. How do service and protocol differ?
4. What identifiers are used at link, network and transport layers?
5. How do latency and bandwidth differ?
6. Why is throughput lower than link rate?
7. What does a capture point determine?
8. Why can absence in pcap fail to prove absence on the wire?
9. How do capture and display filters differ?
10. What information is hidden by TLS?

Практическая проверка: получить неизвестный small pcap, reconstruct endpoints, protocols, request/response direction and likely application action without relying on automatic protocol summary alone.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Сетевое взаимодействие** — nodes, interfaces, links, endpoints and data path.
- **Сетевые модели OSI и TCP/IP** — responsibilities and limitations of models.
- **Инкапсуляция** — headers, payloads and decapsulation.
- **Сетевые единицы данных** — frame, packet, datagram, segment, stream and message.
- **Сетевые показатели** — latency, bandwidth, throughput, goodput, jitter and loss.
- **Packet capture** — capture points, filters, evidence and limitations.
- **Socket** — application/transport boundary at overview level.

## Когда переходить дальше

Можно переходить, когда topology and captures reproduce with one command, protocol sequence is explained manually, and filter set distinguishes expected exchanges and failures.