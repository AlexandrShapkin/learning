# Спринт 29. Failover, multi-zone и multi-region

Ориентировочный объём: 21–31 час.

## Центральный вопрос

Как перенести serving and authoritative state после потери zone/region without split brain, stale writers or unacceptable data loss?

## Результат спринта

После завершения необходимо уметь:

- distinguish redundancy, high availability and disaster recovery;
- design active-passive, active-active and read-local/write-primary patterns;
- choose quorum placement across zones;
- understand synchronous versus asynchronous cross-region replication;
- define promotion and traffic-shift authority;
- fence old primary and prevent dual writers;
- account for DNS, load balancer and client-cache delays;
- measure failover detection and recovery time;
- define data-loss window and replication position;
- plan failback/reconciliation;
- avoid correlated dependencies/control planes;
- test degraded capacity after zone/region loss.

## Основной маршрут

1. Simulate three zones and two regions locally.
2. Lose one zone and maintain quorum/capacity.
3. Lose primary region under asynchronous replication.
4. Promote secondary with epoch and traffic switch.
5. Reconcile or fail back without overwriting newer state.

## Лабораторная работа

Создать `work/multizone-failover/`.

### Requirements

- failure-domain and dependency map includes control plane, identity, DNS and storage;
- quorum replicas are distributed across independent zones;
- promotion generates new epoch and fences old region/writers;
- traffic shift accounts for TTL, cached connections and retries;
- replication position and possible data loss are measured;
- degraded region capacity supports stated minimum service;
- active-active conflict/ownership rules are explicit if used;
- failback/new-primary procedure reconciles state safely;
- backups and recovery tooling do not share all failure domains;
- exercise records detection, decision, traffic and data recovery times.

### Failure scenarios

1. Majority replicas are placed in one zone.
2. Secondary promotion occurs while old primary still accepts writes.
3. DNS points some clients to each region.
4. Async replica is promoted without measuring lag/data loss.
5. Secondary lacks capacity or dependencies.
6. Shared identity/control plane fails both regions.
7. Failback overwrites newer primary data.
8. Active-active concurrent updates violate invariant.

## Результат для базы знаний

- **Multi-zone and multi-region architecture**.
- **Active-passive and active-active failover**.
- **Cross-region replication and data-loss windows**.
- **Failover epochs, stale-writer fencing and split brain**.
- **Traffic failover and failback**.

## Когда переходить дальше

Можно переходить, когда zone and region loss produce one authoritative writer, measured degraded capacity and explicit data-loss/recovery evidence.