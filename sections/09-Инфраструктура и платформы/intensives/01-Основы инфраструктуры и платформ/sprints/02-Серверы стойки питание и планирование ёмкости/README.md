# Спринт 02. Серверы, стойки, питание и планирование ёмкости

Ориентировочный объём: 15–21 час.

## Центральный вопрос

Как physical placement, power, cooling, network uplinks and hardware capacity constrain the logical platform above them?

## Результат спринта

После завершения необходимо уметь:

- различать server, rack, row, room and datacenter failure domains;
- понимать CPU sockets/cores/NUMA at planning level;
- оценивать memory channels/capacity and storage controllers;
- различать local disks, RAID, HBA and network storage roles;
- понимать power feeds, PSU redundancy, UPS and generator layers;
- учитывать cooling and thermal throttling;
- проектировать rack/network/power placement for redundancy;
- оценивать headroom, growth, spare capacity and replacement lead time;
- различать capacity planning and performance tuning;
- использовать inventory and lifecycle records;
- учитывать firmware, hardware compatibility and end-of-life risk;
- понимать why “two servers” may still share rack, PDU or uplink fate.

## Основной маршрут

1. Inspect host hardware through `lscpu`, `numactl`, `dmidecode`, `lsblk`, `lspci`, SMART where available.
2. Build a logical rack for eight servers with dual power and network paths.
3. Allocate workloads with CPU, memory, disk, bandwidth and failure-domain constraints.
4. Add 30% growth, one-host maintenance and one-rack failure scenarios.

## Ресурсы

- server vendor architecture guides used generically;
- Linux hardware/NUMA/storage inspection docs;
- datacenter resource/failure references;
- capacity chapters from systems-performance literature.

## Лабораторная работа

Создать `work/physical-capacity/`.

### Requirements

- host inventory script outputs safe hardware/resource summary;
- synthetic rack diagram includes power, top-of-rack switches and uplinks;
- capacity model includes allocatable versus reserved/system headroom;
- placement plan survives one planned host maintenance;
- critical replicas do not share the same defined rack/power/uplink domain;
- storage endurance/throughput and network oversubscription are included;
- spare and replacement assumptions are explicit;
- one scenario shows why capacity in aggregate is insufficient because placement constraints block scheduling;
- no real serial numbers or infrastructure identifiers are committed.

### Failure scenarios

1. Total cluster RAM is enough but no host has enough contiguous capacity.
2. Redundant PSUs connect to one PDU/feed.
3. Dual NICs connect to one switch.
4. Replicas are on different hosts in one rack.
5. RAID is treated as backup.
6. CPU count ignores NUMA and memory locality for sensitive workload.
7. SSD capacity ignores endurance and write amplification.
8. Forecast has no maintenance or failure headroom.

## Самопроверка

1. Host, rack and datacenter failure domains?
2. NUMA matters when?
3. Capacity versus allocatable capacity?
4. Headroom purpose?
5. RAID provides what and not what?
6. Power-path redundancy requirements?
7. Network oversubscription?
8. Placement constraints can strand capacity how?
9. Hardware lifecycle risk?
10. Why aggregate capacity is insufficient?

## Результат для базы знаний

- **Physical infrastructure failure domains**.
- **Server CPU, NUMA, memory and storage capacity**.
- **Rack power and network redundancy**.
- **Capacity headroom and stranded capacity**.
- **Hardware inventory and lifecycle**.

## Когда переходить дальше

Можно переходить, когда logical placement can be mapped to physical shared fate and capacity plans include maintenance, growth, resource shape and replacement constraints.