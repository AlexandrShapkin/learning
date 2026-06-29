# Спринт 99. Итоговая работа

Ориентировочный объём: 32–50 часов.

## Задача

Создать `network-lab-platform` — воспроизводимую многоуровневую сетевую лабораторию, в которой можно проследить путь данных от приложения до Ethernet/IP/TCP/TLS/HTTP, безопасно внедрять неисправности и диагностировать их по доказательствам.

Проект не является production-сетью или Kubernetes-платформой. Его задача — подтвердить связное понимание протоколов, промежуточных компонентов, производительности и диагностики.

## Итоговая архитектура

```text
remote-admin === WireGuard === edge firewall/NAT
                                  |
clients VLAN10/VLAN20 -- routers -- TLS load balancer
        |                         ├── app-a
        |                         └── app-b
        +-- DHCP/RA/DNS services

container-a -- bridge/VXLAN overlay -- container-b/backend

DNS: root-lab → test TLD → authoritative zone → recursive resolver
Observability: captures, counters, socket metrics, synthetic probes
```

## Структура проекта

```text
work/network-lab-platform/
├── apps/
├── topology/
├── routing/
├── dns/
├── dhcp/
├── proxy/
├── pki/
├── firewall/
├── vpn/
├── overlay/
├── observability/
├── faults/
├── incidents/
├── scripts/
├── docs/
├── Makefile
└── README.md
```

`README.md` проекта содержит только prerequisites, безопасный порядок запуска, verification и known limitations. Теория переносится в `knowledge`.

## Документы итоговой работы

- [`IMPLEMENTATION.md`](IMPLEMENTATION.md) — обязательная архитектура, функциональные требования и порядок реализации.
- [`FAULTS.md`](FAULTS.md) — каталог из 50 контролируемых и обратимых неисправностей.
- [`ASSESSMENT.md`](ASSESSMENT.md) — blind incidents, итоговая защита и критерии завершения.

## Ключевые результаты

Готовая лаборатория должна включать:

- иерархический IPv4-план и IPv6 `/64`-сегменты;
- VLAN, bridges, ARP/NDP и dual-stack routing;
- static routing и OSPF mode;
- DHCPv4 relay, SLAAC/RA и local DNS hierarchy;
- UDP, TCP и HTTP Go-приложения;
- local CA, TLS, mTLS, SNI и ALPN;
- reverse proxy/load balancer с health checks и safe retries;
- nftables, NAT, conntrack и WireGuard;
- container-like namespace и VXLAN overlay;
- packet capture, counters, performance baseline и `nettriage`;
- безопасный fault injector и автоматический rollback.

## Обязательные артефакты

Коммитить:

- application source и tests;
- topology/config generation scripts;
- sanitized DNS/DHCP/proxy/nft/WireGuard/VXLAN configs;
- PKI generation scripts без private keys;
- setup/verify/capture/triage/fault/rollback/cleanup scripts;
- небольшие synthetic pcaps и fixtures;
- architecture и packet-path diagrams;
- generated baseline/incident summaries;
- команды для воспроизведения крупных измерений;
- ссылки на обновлённые заметки `knowledge`.

Не коммитить:

- private keys и реальные certificates;
- captures с credentials, cookies или unrelated traffic;
- большие pcaps, binaries, VM/container images;
- реальные public addresses, MACs и hostnames;
- результаты сканирования внешних сетей.

## Порядок выполнения

1. Спроектировать адресацию, trust zones, allowed flows и management rollback.
2. Собрать L2/L3 dual-stack baseline.
3. Добавить DHCP/RA и DNS.
4. Реализовать UDP/TCP/HTTP приложения.
5. Добавить TLS, proxy и load balancing.
6. Включить firewall/NAT и WireGuard.
7. Добавить VXLAN/container-like segment.
8. Зафиксировать performance/observability baseline.
9. Реализовать fault catalogue.
10. Выполнить blind incidents и delayed assessment.

## Ограничения безопасности

- все topologies создаются в disposable VM/namespaces;
- fault injector отказывается работать без laboratory prefix и expected topology marker;
- traffic rates/durations ограничены;
- firewall changes имеют validated rollback;
- packet captures фильтруются и проверяются перед commit;
- management interface/default route VM не изменяются без отдельного safeguarded experiment.

## Результат для базы знаний

Итоговая работа должна завершить или уточнить заметки по packet flow, Ethernet/VLAN, IPv4/IPv6, routing, UDP/TCP, DNS, DHCP, HTTP, TLS, NAT/firewall/VPN, load balancing, overlay networks, performance и диагностике.

Raw addresses, packet captures, generated configs и incident-specific evidence остаются в `learning`.