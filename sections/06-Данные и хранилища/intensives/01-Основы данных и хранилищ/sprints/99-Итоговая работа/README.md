# Спринт 99. Итоговая работа

Ориентировочный объём: 45–70 часов.

## Задача

Создать `storage-lab-platform` — воспроизводимую Go application and operational laboratory, связывающую data contracts, PostgreSQL internals, transactions, indexes, migrations, specialized stores, replication, backup and diagnostics.

Проект не является production commerce platform или universal database benchmark. Его задача — позволить построить данные, изменить их, создать derived copies, внедрить bounded failures, доказать guarantees и восстановить систему по evidence.

## Архитектура

```text
clients / workload generator
            |
        storage-api
            |
 PostgreSQL primary ---- physical standby
      |       |
      |       +---- WAL archive / backups / PITR target
      |
      +---- transactional outbox ---- broker/log ---- consumers
      |                                      |          |
      |                                      |          +---- search index
      |                                      |          +---- cache invalidation
      |                                      |          +---- analytical projection
      |
      +---- object metadata ---- S3-compatible object storage
      |
      +---- Redis cache

optional laboratory modes:
- logical subscriber
- partitioned tables
- three-shard router
- columnar/time-series projection
```

## Domain

Synthetic multi-tenant commerce/content data:

- tenants and users;
- products and variable attributes;
- orders, lines, inventory and payments;
- shipments and status history;
- documents and object attachments;
- domain events and audit records;
- search/cache/analytical projections.

No production or personal data is used.

## Структура проекта

```text
work/storage-lab-platform/
├── cmd/
│   ├── storage-api/
│   ├── storagectl/
│   ├── outbox-relay/
│   ├── projector/
│   └── storagetriage/
├── internal/
│   ├── domain/
│   ├── config/
│   ├── postgres/
│   ├── migrations/
│   ├── cache/
│   ├── search/
│   ├── objects/
│   ├── events/
│   ├── replication/
│   ├── backup/
│   ├── observability/
│   └── faults/
├── schema/
├── migrations/
├── queries/
├── fixtures/
├── compose/
├── scripts/
├── reports/
├── docs/
├── Makefile
├── go.mod
└── README.md
```

## Документы итоговой работы

- [`IMPLEMENTATION.md`](IMPLEMENTATION.md) — обязательные components, guarantees and implementation stages.
- [`FAULTS.md`](FAULTS.md) — каталог из 50 bounded and reversible faults.
- [`ASSESSMENT.md`](ASSESSMENT.md) — blind incidents, final defense and delayed assessment.

## Основные результаты

Готовая лаборатория должна включать:

- versioned data contracts and exact types;
- normalized PostgreSQL source-of-truth schema;
- database constraints and tenant isolation;
- verified SQL query suite;
- transactions, isolation retries, outbox and idempotency;
- MVCC/lock/vacuum evidence;
- page, WAL, checkpoint and crash-recovery experiments;
- indexes and plan/statistics workload matrix;
- restartable expand-contract migration and backfill;
- bounded connection pool, batching and COPY ingestion;
- Redis cache with consistency/stampede controls;
- search projection with versioned idempotent indexing;
- S3-compatible object workflow with checksums and reconciliation;
- message log/queue with replay-safe consumers;
- analytical or time-series projection;
- physical replica, failover experiment and lag monitoring;
- partitioning and optional app-level sharding mode;
- logical and physical backup, WAL archive and PITR;
- roles, access tests, retention and cross-store deletion;
- capacity/cost report and observability baselines;
- read-only `storagetriage` and controlled fault injection.

## Порядок выполнения

1. Define domain, contracts, retention and failure boundaries.
2. Implement relational schema, constraints and query tests.
3. Add transactions, concurrency harness and outbox.
4. Establish physical/index/planner evidence.
5. Add client pool, batching and migrations.
6. Add cache, search, object and stream projections.
7. Add replication, partitioning and optional sharding.
8. Add backup/PITR, security and deletion workflow.
9. Add observability, capacity and cost reports.
10. Implement fault catalogue and blind incidents.
11. Run clean rebuild, recovery and delayed assessment.

## Обязательные артефакты

Коммитить:

- source and tests;
- SQL schema, migrations and queries;
- deterministic synthetic generators and small fixtures;
- Compose/config examples without secrets;
- verification, workload, backup and restore scripts;
- concise plans, scaling and capacity summaries;
- architecture, transaction and data-flow diagrams;
- fault definitions and incident cards;
- commands to regenerate large artifacts;
- links to `knowledge` notes.

Не коммитить:

- database volumes, dumps, WAL archives and base backups;
- object/search/broker data directories;
- credentials, private keys or actual `.env` files;
- production/personal datasets;
- large raw logs, profiles and plans;
- compiled binaries and caches;
- generated cost/pricing claims without assumptions/date;
- unbounded destructive fault scripts.

## Safety

- all stateful services use isolated local ports and volumes;
- destructive commands require lab marker, target identity and explicit flag;
- crash, disk, WAL, failover and corruption scenarios use disposable copies;
- backup restore targets a separate cluster;
- workloads cap rows, bytes, clients, duration and workers;
- public endpoints and default credentials are forbidden;
- fault/profile/admin endpoints are local and restricted;
- cleanup verifies sessions, listeners, volumes, temporary objects and processes.

## Результат для базы знаний

Итоговая работа должна завершить или исправить заметки по data modeling, SQL, normalization, transactions, MVCC, physical storage, indexes, plans, migrations, specialized stores, caching, streams, replication, sharding, backups, lifecycle, security, capacity and diagnostics.

Schemas, configs, synthetic data and incident evidence remain in `learning`; generalized mechanisms go to `knowledge`.