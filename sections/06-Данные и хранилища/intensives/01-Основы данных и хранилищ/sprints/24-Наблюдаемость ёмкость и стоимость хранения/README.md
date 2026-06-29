# Спринт 24. Наблюдаемость, ёмкость и стоимость хранения

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как observe workload and resource behavior early enough to detect saturation, plan capacity and understand the full cost of data growth?

## Результат спринта

После завершения необходимо уметь:

- define storage SLI/SLO candidates;
- collect connection, transaction, query, lock and error metrics;
- использовать `pg_stat_activity`, `pg_stat_database`, `pg_stat_statements` and related views;
- наблюдать buffer/cache hit context without treating one ratio as universal goal;
- измерять table/index/TOAST/WAL/temp growth;
- наблюдать checkpoint, vacuum, bloat and transaction-age indicators;
- измерять replication lag and slot retention;
- отслеживать cache hit/miss/eviction and broker lag;
- различать latency, throughput, concurrency, queueing and saturation;
- создавать workload baselines and per-tenant breakdowns;
- прогнозировать storage growth and headroom;
- учитывать backup, replicas, indexes, WAL, temp and derived stores in capacity;
- оценивать compute, storage, IOPS, network, request and egress costs;
- понимать cost impact of retention and replication factor;
- создавать safe query/log sampling and redaction;
- связывать application traces with database query identities;
- проектировать alerts on symptoms and exhaustion trends;
- проводить bounded load/capacity tests;
- distinguish capacity issue from query/design issue.

## Основной маршрут

### Шаг 1. Workload identity

Tag application name, request/job ID and operation name. Aggregate by normalized query and workload class rather than raw SQL with sensitive values.

### Шаг 2. Resource model

Track:

```text
connections and pool wait
CPU and runnable work
memory and cache
storage capacity and growth
IOPS/throughput/latency
temp files and WAL
locks and transaction age
replication and consumer lag
```

### Шаг 3. Capacity planning

Estimate current footprint, daily growth, retention, index/replica/backup multipliers, migration headroom and restore workspace. Validate with measured data.

### Шаг 4. Cost model

Calculate total cost per data class and workload: primary, replicas, backups, object versions, search index, message retention, network transfer and operational labor.

## Ресурсы

- PostgreSQL monitoring statistics and logging docs.
- `pg_stat_statements`, `auto_explain` and progress-view docs.
- Systems Performance methodology.
- Official metrics/operations docs for Redis, search, object and broker systems.
- Cloud/vendor pricing docs only when performing a current concrete estimate.

## Практические задания

1. Build database workload dashboard/report from system views.
2. Establish idle and representative baselines.
3. Generate connection, CPU, I/O, lock, temp and WAL pressure separately.
4. Forecast 3/6/12-month storage with uncertainty/headroom.
5. Calculate full replication/backup/index multiplier.
6. Attribute workload and storage by tenant/table/query class.
7. Design alerts for disk exhaustion, lag, blocked transactions and failed backups.
8. Compare cost of shorter retention, compression and tiering.

## Лабораторная работа

Создать `work/storage-observability/`.

### Components

- Go workload generator with operation labels;
- read-only metrics collector;
- PostgreSQL statistics snapshots;
- OS/container resource collector;
- Redis/search/broker/object metrics adapters;
- capacity forecast and cost calculator;
- alert rule examples;
- synthetic incident baselines.

### Requirements

- collector uses least-privileged read access;
- reports include version, time window and workload metadata;
- raw SQL parameters and personal data redacted;
- baselines cover idle, normal, burst and degradation;
- connection pool and server sessions correlated;
- table/index/TOAST/WAL/temp/backup sizes separated;
- replication and consumer lag tracked;
- growth forecast includes uncertainty and operational headroom;
- cost model states pricing/assumptions/date externally when used;
- alerts distinguish symptom, saturation and trend;
- load tests bounded and cleanup verified.

### Failure scenarios

1. Average latency hides tail/blocked requests.
2. High cache-hit ratio hides slow scans or writes.
3. Database connections counted without application pool wait.
4. Table size ignores indexes/TOAST/backups/replicas.
5. WAL archive or replication slot fills disk.
6. Autovacuum/transaction age warning ignored.
7. Search/broker/object derived copies omitted from capacity.
8. Alert fires on normal batch without workload context.
9. Metric labels create excessive cardinality.
10. Query logging exposes sensitive data.
11. Forecast extrapolates short abnormal window blindly.
12. Cost estimate ignores egress/requests/restore workspace.

## Самопроверка

1. Latency, throughput and saturation?
2. Pool wait versus query execution?
3. What should `pg_stat_statements` answer?
4. Why one cache-hit ratio is insufficient?
5. Which components multiply stored bytes?
6. How transaction age relates to vacuum risk?
7. What is capacity headroom?
8. Why monitor lag and WAL retention?
9. How avoid metric/log data leakage?
10. What belongs in total storage cost?

## Результат для базы знаний

- **Database workload observability**.
- **PostgreSQL statistics views and query identity**.
- **Latency, throughput, queueing and saturation**.
- **Storage and WAL growth accounting**.
- **Replication, cache and stream lag metrics**.
- **Capacity forecasting and headroom**.
- **Data-storage total cost model**.
- **Safe database logging and metric cardinality**.

## Когда переходить дальше

Можно переходить, когда workload/resource evidence is correlated, capacity includes every copy and recovery workspace, and alerts/cost estimates state explicit assumptions.