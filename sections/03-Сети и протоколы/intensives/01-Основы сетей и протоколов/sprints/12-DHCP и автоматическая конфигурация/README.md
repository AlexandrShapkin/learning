# Спринт 12. DHCP и автоматическая конфигурация

Ориентировочный объём: 10–14 часов.

## Центральный вопрос

Как host without a configured address discovers a configuration service and receives an address, routes, DNS settings and lease lifecycle?

## Результат спринта

После завершения необходимо уметь:

- explain DHCPv4 DORA sequence;
- identify client/server UDP ports and broadcast use;
- decode transaction ID, client identifier, offered address and options;
- explain lease, T1, T2, renewal, rebinding, release and decline;
- distinguish address allocation from route/DNS configuration;
- explain DHCP relay and why broadcasts do not cross routers normally;
- create isolated DHCP server/client topology;
- diagnose missing offer, wrong scope, exhausted pool and conflicting option;
- understand DHCP snooping/rogue-server risk conceptually;
- compare DHCPv4, SLAAC, stateless DHCPv6 and stateful DHCPv6;
- explain why IPv6 default gateway is normally learned through RA, not DHCPv6;
- inspect lease/client state on Linux without relying on one network manager.

## Место в интенсиве

Addressing and DNS were configured manually. DHCP automates host configuration and introduces broadcast discovery, stateful leases and relay behavior.

## Основной маршрут

### Шаг 1. DHCPv4 protocol

Read RFC 2131 selected sections and RFC 2132 common options. Study:

- DISCOVER;
- OFFER;
- REQUEST;
- ACK/NAK;
- transaction/client identifiers;
- `yiaddr`, `siaddr`, relay fields;
- broadcast flag.

### Шаг 2. Lease lifecycle

Understand INIT, SELECTING, REQUESTING, BOUND, RENEWING and REBINDING conceptually. Observe actual client state/logs for installed implementation.

### Шаг 3. Relay

Study `giaddr`, relay-agent behavior and option 82 overview. Build router relay in lab rather than placing one server per subnet.

### Шаг 4. IPv6 alternatives

Review RFC 8415 and sprint 05:

- SLAAC-only;
- RA + RDNSS;
- stateless DHCPv6;
- stateful DHCPv6;
- Prefix Delegation overview.

## Ресурсы

### Обязательный маршрут

- RFC 2131 selected sections.
- RFC 2132 common options.
- RFC 8415 overview.
- dnsmasq or Kea documentation for lab.
- Linux network-manager/client logs and man pages.

### Альтернативные объяснения

- Kurose & Ross DHCP overview.
- TCP/IP Illustrated DHCP chapter.
- ISC/Kea DHCP administrator docs.

### Углубление

- DHCP failover/HA;
- option 82 and access networks;
- PXE/iPXE boot options;
- DHCPv6 Prefix Delegation;
- secure dynamic DNS updates.

## Практические задания

### 1. DORA capture

Start client with no address in isolated segment. Capture and decode discover/offer/request/ack, including broadcast/unicast choices and options:

- subnet mask;
- router;
- DNS servers;
- lease time;
- server identifier;
- requested IP.

### 2. Renewal

Use short lab lease. Observe T1 renewal to server, then stop server and observe rebinding/expiry. Ensure duration remains bounded.

### 3. Pool exhaustion

Create more client namespaces than addresses. Observe server/client behavior and distinguish no offer from network failure.

### 4. Relay

Put DHCP server in another subnet and configure relay on router namespace. Capture client link and server link to show transformation/relay identity.

## Лабораторная работа

Create `work/dhcplab/`.

### Topology

```text
client-a/client-b -- access LAN -- relay-router -- server LAN -- dhcp server
```

Dual-stack optional but DHCPv4 mandatory.

### Requirements

- dnsmasq or Kea config under `work/`;
- pool, reservations and options explicit;
- relay process isolated;
- client command selected based on distribution and wrapped by scripts;
- lease database preserved for inspection then cleaned;
- captures on client/server links;
- setup/verify/fault/cleanup commands.

### Failure scenarios

1. Server bound to wrong interface.
2. Firewall blocks UDP 67/68.
3. Relay missing/wrong server address.
4. Pool exhausted.
5. Wrong subnet mask option.
6. Wrong default gateway option.
7. Wrong DNS option.
8. Duplicate reservation/address conflict.
9. Rogue second server offers conflicting configuration.
10. Client retains stale lease after topology change.
11. DHCPv6 configured but no RA/default route.

Rogue-server test remains fully isolated and low-rate.

### Verification

- client receives expected address and routes;
- DNS resolution uses supplied server;
- reservation stable for test client ID;
- lease renewal succeeds;
- relay topology works;
- unexpected server offers are detected by capture;
- cleanup leaves no addresses/processes/namespaces.

## Дополнительный эксперимент

Configure network boot metadata (TFTP/PXE options) without actually booting a machine. Decode options and explain separate roles of DHCP, TFTP/HTTP and bootloader.

Alternative: compare dnsmasq and Kea lease/config models.

## Самопроверка

1. Why does initial DHCP use broadcast?
2. What identifies one transaction/client?
3. How do offer and ACK differ?
4. What are T1 and T2?
5. Why is relay needed?
6. What configuration besides address can DHCP provide?
7. Why is a rogue DHCP server dangerous?
8. How do SLAAC and DHCPv6 differ?
9. Where does IPv6 default route come from?
10. How can stale lease create misleading symptoms?

Практическая проверка: given DORA capture and client state, identify server absence, relay failure, pool exhaustion, rejected request or incorrect options.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **DHCPv4** — DORA and message fields.
- **DHCP options** — address, route, DNS and lease configuration.
- **DHCP lease lifecycle** — renewal, rebinding and expiry.
- **DHCP relay** — cross-subnet discovery and relay identity.
- **DHCP conflicts and rogue servers** — operational/security failures.
- **IPv6 autoconfiguration comparison** — SLAAC, RDNSS and DHCPv6.

## Когда переходить дальше

Можно переходить, когда DORA/renewal/relay are captured and explained, wrong options are diagnosed separately from transport, and all DHCP services remain isolated.