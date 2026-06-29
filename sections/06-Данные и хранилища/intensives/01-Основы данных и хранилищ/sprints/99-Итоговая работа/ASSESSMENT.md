# Итоговая проверка

## Blind incident exercise

Решить минимум 16 hidden incidents:

- three data-model/SQL/transaction cases;
- three physical/index/planner/client cases;
- three cache/search/object/stream cases;
- three replication/sharding/recovery/lifecycle cases;
- four combined incidents.

Combined examples:

- long transaction + vacuum pressure + disk growth;
- pool saturation + slow query + lock wait;
- migration backfill + WAL growth + replica lag;
- cache stampede + database connection exhaustion;
- outbox backlog + stale search and cache;
- failover + stale router + ambiguous client retries;
- PITR restore + event replay resurrects deleted data;
- shard migration + duplicate delivery + stale search version.

For each incident:

```text
Symptom and impact
Scope, versions and timeline
Initial write-safety action
Expected invariant and source of truth
Preserved evidence
Ranked hypotheses
Discriminating test
Root cause, trigger and secondary effects
Minimal repair
Data, resource and recovery verification
Prevention or detection improvement
```

## Clean build and environment reconstruction

From clean checkout and empty laboratory volumes:

1. start required services with non-default local credentials;
2. apply schema migrations;
3. generate deterministic synthetic dataset;
4. run unit, integration, concurrency and query suites;
5. verify constraints and source-of-truth checksums;
6. run representative workload and capture baseline;
7. build derived cache/search/object/event/analytical state;
8. establish replica and record lag;
9. create logical and physical backups plus WAL archive;
10. stop and cleanly rebuild application clients.

## Recovery exercise

Perform one full recovery scenario:

1. record exact destructive event and target recovery point;
2. stop/redirect writes safely;
3. restore base backup into isolated cluster;
4. replay WAL to chosen point;
5. verify schema, counts, checksums and domain workflows;
6. rebuild/reconcile cache, search and analytical projections;
7. inspect outbox/inbox/event offsets before replay;
8. verify deleted/retained data policy;
9. measure achieved RPO/RTO;
10. keep original failed environment untouched until validation completes.

## Final defense

Answer using project evidence:

1. How are conceptual, logical and physical data models different?
2. How are identity, keys, constraints and normalization chosen?
3. How do SQL NULL, duplicates, joins and windows affect correctness?
4. How is a transaction boundary derived from an invariant?
5. Which anomalies do isolation levels permit or prevent?
6. How do MVCC, locks, deadlocks and vacuum interact?
7. How do pages, WAL, checkpoints and crash recovery preserve data?
8. How are index type/order and query shape connected?
9. How are execution plans, statistics and estimates interpreted?
10. How is a schema/data migration made compatible and restartable?
11. How do pool sizing, batching and COPY affect throughput and safety?
12. When should relational, KV, document, graph, columnar, time-series or search storage be used?
13. How are cache staleness and stampede controlled?
14. How do outbox, acknowledgements, idempotency and replay interact?
15. How are database and object-store states reconciled?
16. What guarantees and failure modes come from replication/failover?
17. How do partitioning and sharding change queries and transactions?
18. How are RPO, RTO, backup type and PITR connected?
19. How are least privilege, retention and deletion enforced across stores?
20. How are capacity, lag, bloat, WAL, cost and slow queries observed?
21. How is first divergence found in a multi-store incident?
22. Which evidence proves every major guarantee in the project?

Every answer references at least one schema/query, concurrent experiment, plan, metric, restore, reconciliation result or incident.

## Completion criteria

Интенсив завершён, когда:

- clean checkout recreates the laboratory and all migrations apply;
- relational schema and query suite preserve stated invariants;
- transaction/isolation/lock scenarios are reproduced and repaired;
- crash recovery proves committed and uncommitted behavior;
- indexes/plans/statistics are tied to representative workloads;
- migration survives interruption and mixed-version clients;
- connection/ingestion paths are bounded and idempotent;
- cache, search, object and event projections are rebuildable and reconcilable;
- physical replication, lag monitoring and fenced failover work;
- partitioning and optional sharding paths preserve verified data;
- logical backup, physical backup and PITR restore succeed in isolation;
- least privilege and cross-store deletion tests pass;
- capacity/cost report includes primary, indexes, replicas, WAL, backups and derived stores;
- `storagetriage` is read-only, bounded and redacted;
- all 50 faults are safe and reproducible or have a documented equivalent laboratory substitute;
- at least 16 blind incidents and four combined incidents are solved;
- all 22 defense answers are supported by evidence;
- generalized knowledge is transferred to `knowledge`.

## Delayed assessment

Через 7–14 дней без перечитывания:

1. reconstruct the data path from API request to PostgreSQL, WAL, outbox and derived stores;
2. answer the 22 defense questions;
3. rebuild schema and representative data from scripts;
4. diagnose four random faults, including one combined case;
5. interpret one query plan and one lock/replication incident;
6. perform a bounded restore or validate a fresh restore drill;
7. design one schema migration and one storage choice from new constraints;
8. identify one capacity or lifecycle risk not covered by the initial design.

После delayed assessment уровень 3–4 можно считать закреплённым.