# Спринт 20. Репликация, высокая доступность и failover

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как maintain additional copies of data for availability and read scaling, понимая lag, data-loss boundary, promotion, client routing and split-brain risk?

## Результат спринта

После завершения необходимо уметь:

- различать replication, backup and cache;
- объяснять physical streaming and logical replication;
- понимать WAL sender, receiver, replay and replication slots;
- различать synchronous and asynchronous commit/replication;
- измерять send, write, flush and replay lag;
- определять RPO for failover configuration;
- понимать read replicas and stale reads;
- проектировать read-after-write strategy;
- понимать hot standby conflicts and recovery cancellation;
- выполнять planned switchover and controlled failover;
- проверять promotion and timeline changes at operational level;
- обеспечивать fencing and one writable primary;
- понимать connection discovery/routing implications;
- восстанавливать/rebuild old primary as replica;
- понимать replication-slot WAL retention risk;
- сравнивать physical and logical replication use cases;
- диагностировать lag, missing WAL, slot growth and replica divergence;
- отделять HA from durability and disaster recovery.

## Основной маршрут

### Шаг 1. Replication semantics

Trace:

```text
primary change → WAL generation/flush → network send
→ standby write/flush → replay → query visibility
```

A replica can be connected but behind.

### Шаг 2. Sync versus async

Measure latency and possible data loss boundary. Synchronous replication improves acknowledgement guarantees but can reduce availability or increase latency depending policy.

### Шаг 3. Read traffic

Define which queries may tolerate lag. Do not route read-after-write or invariant decisions to stale replicas without a protocol.

### Шаг 4. Failover

Promotion alone is insufficient. Clients must discover the new primary; old primary must be fenced; replication lineage and lost/divergent writes must be assessed.

## Ресурсы

- PostgreSQL warm standby, streaming replication, replication slots and monitoring docs.
- PostgreSQL logical replication docs.
- DDIA replication chapters.
- Reliable HA/failover documentation for the chosen orchestration approach.

## Практические задания

1. Build primary and physical standby.
2. Measure lag during normal and burst workloads.
3. Compare asynchronous and synchronous acknowledgement latency.
4. Reproduce stale read after primary commit.
5. Pause replay/network and observe WAL retention/lag.
6. Perform planned switchover and unplanned failover in lab.
7. Rebuild/rejoin old primary safely.
8. Create logical publication/subscription for selected tables.

## Лабораторная работа

Создать `work/replication-ha-lab/`.

### Topology

```text
client/router
├── primary PostgreSQL
├── physical standby
└── logical subscriber for selected read model
```

### Requirements

- all nodes use isolated volumes/ports and marker files;
- replication identity and roles visible to client;
- replication lag metrics collected;
- async failover data-loss window measured with synthetic sequence IDs;
- sync mode behavior tested during standby unavailability;
- read routing has consistency policy;
- promotion verifies one writable primary;
- old primary cannot accept writes after fencing;
- timeline/rejoin procedure documented and automated where safe;
- slots monitored and removed only after consumer status verified;
- client reconnect/retry behavior bounded;
- no automatic failover introduced without testing false-positive risk.

### Failure scenarios

1. Replica connected but replay lag high.
2. Read-after-write sent to stale replica.
3. Replication slot retains unlimited WAL.
4. Standby disk fills and stops replay.
5. Long standby query conflicts with recovery.
6. Primary fails after local commit before replica receives WAL.
7. Synchronous policy blocks commits during standby failure.
8. Both old and new primary accept writes.
9. Client keeps writing to old endpoint after promotion.
10. Old primary rejoined without rewind/rebuild validation.
11. Logical subscriber schema differs.
12. Replica mistaken for backup.

## Самопроверка

1. Replication versus backup?
2. Physical versus logical replication?
3. Send/write/flush/replay lag?
4. Async versus sync RPO?
5. Why read replica can be stale?
6. What is replication slot risk?
7. Promotion versus complete failover?
8. Why fencing is mandatory?
9. How client discovers primary?
10. Why HA is not disaster recovery?

## Результат для базы знаний

- **Physical and logical replication**.
- **Synchronous and asynchronous replication**.
- **Replication lag and read consistency**.
- **Replication slots and WAL retention**.
- **Promotion, switchover and failover**.
- **Fencing and split-brain prevention**.
- **Replica rebuild and timeline lineage**.
- **HA versus backup and disaster recovery**.

## Когда переходить дальше

Можно переходить, когда lag and data-loss boundary are measured, failover leaves one writable primary, and clients recover without hiding ambiguous writes or stale-read constraints.