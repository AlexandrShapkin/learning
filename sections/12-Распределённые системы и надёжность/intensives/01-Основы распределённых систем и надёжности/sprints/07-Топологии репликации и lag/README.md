# Спринт 07. Топологии репликации и lag

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как копировать состояние между узлами и что означают lag, failover and stale reads для каждой topology?

## Результат спринта

После завершения необходимо уметь:

- сравнивать leader-follower, multi-leader and leaderless replication;
- различать synchronous and asynchronous replication;
- определять replication log/position and lag;
- понимать stale reads and read-your-writes gaps;
- проектировать follower promotion and old-leader fencing;
- учитывать topology and failure domains;
- различать replication durability from backup;
- понимать resynchronization and snapshot/bootstrap;
- оценивать write availability and conflict risk;
- диагностировать divergent replicas.

## Основной маршрут

1. Implement a small replicated key-value log or use controlled database/broker replication.
2. Compare synchronous and asynchronous acknowledgement.
3. Pause a follower, measure lag and stale reads.
4. Promote a follower and prevent old leader writes.

## Лабораторная работа

Создать `work/replication-topologies/`.

### Requirements

- topology, acknowledgement and durability semantics are explicit;
- replica position/lag is observable;
- stale-read policy and client routing are documented;
- promotion requires term/epoch and old-writer fencing;
- snapshot/bootstrap catches up a new replica;
- replica divergence is detected by version/checksum/history;
- synchronous mode demonstrates latency/availability trade-off;
- replication is not accepted as backup.

### Failure scenarios

1. Leader acknowledges before durable/replicated state expected by contract.
2. Follower serves stale data after user write.
3. Old leader resumes and accepts writes.
4. New replica restores inconsistent snapshot/log position.
5. Multi-leader nodes accept conflicting updates.
6. Lag metric is zero because replication stream stopped entirely.

## Результат для базы знаний

- **Leader-follower, multi-leader and leaderless replication**.
- **Synchronous and asynchronous replication**.
- **Replication lag and stale reads**.
- **Replica promotion, epochs and stale-writer fencing**.
- **Replication versus backup**.

## Когда переходить дальше

Можно переходить, когда acknowledgement, stale-read and promotion behavior are measured under replica pause, network delay and old-leader recovery.