# Спринт 25. Системная диагностика данных и хранилищ

Ориентировочный объём: 20–30 часов.

## Центральный вопрос

Как from wrong or stale data, slow queries, blocking, lag, disk pressure or failed recovery locate the first causal defect across model, application, database, storage and derived systems?

## Результат спринта

После завершения необходимо уметь:

- state exact data symptom, affected scope and timeline;
- verify source-of-truth and application/database versions;
- classify correctness, latency, availability, capacity and recovery incidents;
- collect bounded evidence before restart, failover or cleanup;
- distinguish query issue, lock wait, pool starvation and storage I/O;
- reconstruct transaction and replication timelines;
- identify blocking root and deadlock cycle;
- diagnose cardinality estimates, index choice and spills;
- distinguish live growth, dead tuples, bloat and retained WAL;
- detect replica/search/cache/stream divergence;
- distinguish duplicate event from duplicate business side effect;
- diagnose failed/partial migration and backfill;
- verify backup chain and recovery point;
- rank falsifiable hypotheses;
- perform one discriminating test at a time;
- apply minimal reversible repair;
- verify data invariants and resource baseline afterward;
- add a regression, reconciliation or alert improvement;
- produce concise incident evidence without operational diary bureaucracy.

## Diagnostic loop

```text
stabilize writes and preserve evidence
→ identify data/version/config/workload
→ define expected invariant or service level
→ find source of truth and first divergence
→ classify model/query/transaction/storage/replication/derived layer
→ rank hypotheses
→ run discriminating observation
→ repair minimally
→ verify correctness, lag, locks, capacity and recovery
→ add prevention or detection
```

Do not begin with restart, failover, vacuum full, reindex, cache flush, increased timeout or restored backup without a hypothesis and recovery plan.

## Evidence map

### Data correctness

- primary keys, versions and audit/event sequence;
- constraint and invariant queries;
- source versus cache/search/object/projection checks;
- transaction/outbox/inbox records;
- migration version and backfill checkpoint derived from data.

### Query and concurrency

- normalized query and plan;
- estimates, actual rows, loops, buffers and temp files;
- active sessions, wait events and blocking graph;
- transaction age, isolation and retry evidence;
- pool acquisition and server execution timing.

### Storage and recovery

- relation/index/TOAST/WAL/archive/backup sizes;
- checkpoint/vacuum/bloat indicators;
- disk/IOPS/latency and filesystem space;
- replication send/write/flush/replay positions;
- backup manifest, WAL chain and restore validation.

### Derived systems

- cache version/TTL/invalidation event;
- search document version and index generation;
- broker offset, lag, redelivery and dead letter;
- object metadata, version and checksum.

## Лабораторная работа

Создать `work/storage-diagnostics/`.

### `storagetriage`

Read-only collector:

```text
storagetriage database --question slow|blocked|storage|vacuum|version
storagetriage replication --question lag|failover|wal
storagetriage derived --question cache|search|stream|object
storagetriage recovery --question backup|pitr|restore
storagetriage compare --entity TYPE --id ID
```

It collects only relevant bounded evidence, redacts values and records versions/timestamps.

### Faulty platform

A synthetic service combines PostgreSQL, Redis, search, object storage and event broker with named opt-in faults.

## Incident catalogue

Solve at least 20 incidents, including five combined cases:

1. Missing/incorrect database constraint.
2. Cross-tenant query or key leak.
3. Join multiplication or NULL query bug.
4. Lost update.
5. Write skew.
6. Serialization retry duplicates side effect.
7. Idle transaction.
8. Blocking chain.
9. Deadlock.
10. Long snapshot and vacuum pressure.
11. Wrong/missing index.
12. Cardinality estimate error.
13. Sort/hash spill.
14. Pool starvation or connection leak.
15. Migration lock or partial backfill.
16. Invalid concurrent index.
17. Replica lag or stale read.
18. Split-brain/routing after failover.
19. Replication slot/WAL disk growth.
20. Cache stale/stampede/hot key.
21. Search stale document or wrong analyzer/mapping.
22. Event redelivery or out-of-order projection.
23. Object/database orphan or checksum mismatch.
24. Partition pruning or shard routing failure.
25. Backup missing WAL or failed restore.
26. Capacity forecast misses derived copies.
27. Retention/deletion leaves active residual copy.
28. Multiple simultaneous failures.

### Combined examples

- connection pool saturation plus slow query;
- long transaction plus autovacuum/bloat;
- replica lag plus read-after-write routing;
- cache stampede plus database connection exhaustion;
- outbox backlog plus stale search/cache;
- migration backfill plus WAL/replica lag;
- disk pressure plus retained replication slot;
- restore plus replay resurrects deleted data.

## Incident artifact

```text
Symptom and impact
Scope, versions and timeline
Initial safety action
Expected invariant/path
Preserved evidence
Ranked hypotheses
Discriminating test
Root cause, trigger and secondary effects
Minimal repair
Correctness/resource/recovery verification
Prevention or detection improvement
```

One screen plus linked raw evidence is sufficient.

## Blind exercise

Another person/tool selects hidden fault and provides only a user-visible symptom. Before changing state:

1. identify authoritative data and write-safety action;
2. capture version/config/workload identity;
3. select maximum four initial evidence sources;
4. state ranked hypotheses.

## Самопроверка

1. How find source of truth and first divergence?
2. Query execution versus lock/pool wait?
3. Dead tuples versus bloat versus live growth?
4. Replica lag versus lost data?
5. Cache/search stale state versus source corruption?
6. Duplicate delivery versus duplicate side effect?
7. Migration partial state versus normal compatibility window?
8. Which evidence proves backup/PITR recoverability?
9. Root cause versus trigger/secondary symptom?
10. Why broad restart/reindex/cache flush can destroy evidence?
11. How verify repair across derived stores?
12. What makes capacity incident preventable?

## Критерии прохождения

- `storagetriage` is read-only, bounded and redacted;
- at least 20 incidents and five combined cases are solved;
- every repair has invariant query, regression, reconciliation or restore verification;
- no broad restart/timeout/failover/reindex is accepted as unexplained final fix;
- source/derived versions and transaction/event sequence are checked explicitly;
- cleanup returns sessions, locks, lag, temp data and services to baseline;
- at least 10 of 12 self-check answers are mechanism-based.

## Результат для базы знаний

- **Systematic storage diagnostics**.
- **Source of truth and first divergence**.
- **Database wait, plan and pool diagnosis**.
- **MVCC, vacuum and storage-growth diagnosis**.
- **Replication and derived-data divergence diagnosis**.
- **Migration and data-correctness incident diagnosis**.
- **Backup and recovery-chain diagnosis**.
- **Cross-store repair and verification**.

## Когда переходить дальше

Можно переходить к итоговой работе, когда unknown correctness, latency, lag, capacity and recovery failures are localized from bounded evidence and repaired with cross-store verification.