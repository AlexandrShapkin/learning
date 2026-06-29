# Реализация итоговой работы

## 1. Data contract and domain

- exact identity, money, time, tenant and lifecycle semantics;
- versioned API/event schemas;
- source-of-truth and derived fields identified;
- retention, audit and deletion rules;
- invalid/null/absent states explicit;
- synthetic data generator with seed, scale and skew controls.

## 2. Relational source of truth

PostgreSQL schema includes:

- tenants, users and roles;
- products, attributes and inventory;
- orders, lines, payments and shipments;
- status history and audit events;
- object metadata;
- transactional outbox and consumer inbox;
- schema migration state.

Requirements:

- candidate/business uniqueness preserved;
- tenant-safe composite references;
- exact constraints and state transitions;
- normalized authoritative facts;
- one explicitly derived read model with verifier;
- no application superuser.

## 3. SQL and query suite

At least 30 tested queries:

- point and range lookups;
- joins and anti-joins;
- aggregates and windows;
- current/history views;
- recursive relation;
- data-quality checks;
- keyset pagination;
- set-based updates/upserts;
- reporting queries.

Every query has deterministic fixtures, expected output and tenant authorization path.

## 4. Transactions and concurrency

- inventory/order/payment transitions;
- idempotent commands;
- row locks and optimistic versions;
- serializable transaction path with bounded retry;
- outbox record in source transaction;
- deterministic concurrency harness;
- lost-update/write-skew/deadlock fixtures;
- no external effect inside retryable transaction.

## 5. Physical storage and recovery evidence

- relation/index/TOAST size reports;
- page/tuple inspection on disposable data;
- update/delete/vacuum experiment;
- WAL bytes by operation;
- checkpoint and controlled crash restart;
- committed/uncommitted verification;
- integrity/checksum commands;
- SQLite journaling comparison optional.

## 6. Index and planner matrix

Mandatory query shapes:

- selective equality;
- multicolumn tenant/status/time;
- range/order/keyset pagination;
- partial active rows;
- expression/normalized lookup;
- JSON/tag membership;
- append-correlated BRIN case;
- broad aggregate and join;
- skew/correlated estimate error;
- temp spill.

Collect estimates, actual rows, loops, buffers, temp/WAL, index size and DML cost.

## 7. Client access and ingestion

- pgx or `database/sql` with bounded pool;
- acquisition/server/total latency separation;
- row, multi-row/batch and COPY paths;
- staging validation and set-based merge;
- timeouts and cancellation;
- connection ambiguity classification;
- graceful shutdown and resource cleanup;
- load limits and backpressure.

## 8. Schema and data migration

Implement one full expand-contract change:

```text
compatible expansion
→ mixed-version application support
→ resumable backfill
→ validation and new indexes/constraints
→ read/write switch
→ old-path disablement
→ delayed cleanup
```

Capture locks, WAL, disk and replica impact. Provide forward repair for irreversible step.

## 9. Cache

- Redis and optional local cache;
- versioned tenant-safe keys;
- cache-aside baseline;
- TTL, jitter and negative caching;
- request coalescing;
- outbox/event invalidation;
- stale-window policy;
- consistency checker and rebuild;
- cache-outage backend protection;
- hit/miss/stale/refresh/error metrics.

## 10. Search

- explicit mappings/analyzers;
- exact identifier fields and analyzed text;
- tenant/authorization filters;
- stable document ID and source version;
- idempotent projector;
- deleted-document handling;
- source/index reconciliation;
- relevance corpus;
- reindex into new generation and alias switch;
- stable pagination.

## 11. Object storage

- S3-compatible private bucket;
- database metadata and upload state machine;
- content size/type/checksum validation;
- multipart upload with resume/abort;
- idempotent finalization;
- narrow presigned URLs;
- versioning/retention experiment;
- orphan object/metadata reconciliation;
- delete workflow across versions.

## 12. Event queue and log

- PostgreSQL transactional outbox;
- relay with idempotent publication;
- partition/subject key and ordering scope;
- durable consumer with inbox/dedup;
- retry/backoff/dead-letter path;
- replay-safe projections;
- schema version compatibility;
- consumer lag and poison-message metrics;
- broker outage backpressure.

## 13. Analytical and time-series projection

Implement at least one:

- columnar analytical store with fact/dimension projection; or
- time-series store/extension with retention and rollups.

Requirements:

- exact event grain;
- idempotent ingestion;
- late-data correction;
- measured load/query/storage behavior;
- high-cardinality test;
- source remains reconstructable.

## 14. Replication and availability

- PostgreSQL physical standby;
- async baseline and optional sync mode;
- send/write/flush/replay lag metrics;
- read-consistency routing policy;
- replication-slot monitoring;
- controlled promotion/failover;
- fencing of old primary;
- client reconnect behavior;
- old-primary rebuild/rejoin;
- optional logical subscriber.

## 15. Partitioning and sharding

Mandatory:

- PostgreSQL declarative partitioning;
- partition pruning and retention lifecycle;
- skew/hot-partition evidence.

Optional but recommended:

- three PostgreSQL shards;
- versioned shard map and Go router;
- one tenant/range migration;
- fan-out query and cross-shard limitation evidence.

## 16. Backup and disaster recovery

- logical dump and selective restore;
- physical base backup;
- WAL archiving;
- point-in-time recovery to isolated cluster;
- schema/count/checksum/application validation;
- encrypted backup handling without committed secrets;
- retention preserving recovery chain;
- cache/search projections rebuilt;
- measured RPO/RTO and restore time;
- failed/missing backup-chain scenario.

## 17. Security and lifecycle

- separate runtime, migration, reporting and backup roles;
- explicit grants/default privileges;
- optional RLS comparison;
- local TLS for networked services where feasible;
- redacted logs and configs;
- sensitive-field inventory;
- retention/archive worker;
- restartable cross-store delete/anonymize workflow;
- backup-restore re-deletion reconciliation;
- synthetic masked fixtures only.

## 18. Observability and capacity

Collect:

- client pool and queue;
- PostgreSQL connections, waits, transactions, query stats and errors;
- locks, transaction age, vacuum and bloat indicators;
- table/index/TOAST/WAL/temp/archive/backup growth;
- replica and consumer lag;
- cache/search/object/broker metrics;
- CPU, memory, disk capacity and I/O;
- per-tenant/workload attribution;
- capacity forecast and cost assumptions.

## 19. Diagnostics

`storagetriage` supports read-only bounded collection for:

```text
slow query
blocking/deadlock
storage/vacuum
replication/WAL
cache/search/stream/object divergence
migration
backup/PITR/restore
version/config identity
```

It redacts values, records timestamps/versions and never applies fixes.

## 20. Verification commands

```text
make fmt
make test
make test-race
make test-integration
make migrate-up
make seed
make verify-data
make workload
make plans
make backup
make restore-test
make fault-smoke
make cleanup
```

## 21. Implementation stages

### Stage 1. Contracts and relational correctness

Build domain, schema, constraints, SQL tests and application access.

### Stage 2. Concurrency and internals

Add transactions, locks, outbox, pages/WAL/index/planner experiments.

### Stage 3. Client and migration lifecycle

Add pool/load paths and complete expand-contract migration.

### Stage 4. Derived stores

Add cache, search, objects, broker and analytical projection with reconciliation.

### Stage 5. Scale and recovery

Add replication, partitioning/sharding, backups, PITR and recovery drills.

### Stage 6. Security and operations

Add roles, lifecycle/deletion, observability, capacity and cost reports.

### Stage 7. Faults and assessment

Implement `FAULTS.md`, blind incidents, clean rebuild and delayed assessment.