# Спринт 15. Колоночные, аналитические и временные хранилища

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Как storage layout and execution model change when workload scans and aggregates many rows but touches few columns, or continuously appends time-ordered measurements?

## Результат спринта

После завершения необходимо уметь:

- различать OLTP and OLAP workloads;
- объяснять row-oriented and column-oriented layouts;
- понимать compression, encoding and vectorized execution conceptually;
- выбирать fact, dimension and event schemas;
- использовать star-schema concepts without copying warehouse dogma blindly;
- понимать partition pruning and data skipping;
- объяснять immutable parts/segments and background merges overview;
- моделировать append-heavy time-series data;
- выбирать timestamp, series identity and tag dimensions;
- проектировать retention, downsampling and rollups;
- понимать high-cardinality label/tag cost;
- различать event time and ingestion time;
- handle late and out-of-order data;
- сравнивать PostgreSQL row store, columnar analytical store and time-series extension;
- измерять scan bytes, compression, latency and load cost;
- понимать why analytical store is not automatic replacement for transactional source;
- выбирать pre-aggregation/materialized views cautiously.

## Основной маршрут

### Шаг 1. Workload distinction

Characterize:

```text
point lookup versus scan
short update transaction versus append batch
few rows/many columns versus many rows/few columns
freshness versus compression
concurrency versus throughput
```

### Шаг 2. Columnar execution

Study column storage, compression, vectorized operations, min/max metadata and partition pruning.

### Шаг 3. Analytical modeling

Build fact and dimension tables. Define grain before adding dimensions and measures.

### Шаг 4. Time series

Define series cardinality, timestamp semantics, retention/downsampling, late data and query windows.

## Ресурсы

- DDIA analytics and storage-engine discussions.
- ClickHouse or equivalent analytical-store official docs.
- PostgreSQL partitioning/materialized-view docs.
- TimescaleDB or another time-series system official docs.
- Prometheus storage/data-model docs for label-cardinality comparison.
- Database textbook/data-warehouse selected chapters.

## Практические задания

1. Convert order events into analytical fact/dimension model.
2. Compare row and column stores for selected aggregations.
3. Measure compression and scanned bytes for narrow/wide queries.
4. Build time-series model for service/request metrics.
5. Test high-cardinality tag explosion.
6. Handle late-arriving event and recompute aggregate.
7. Add retention and downsampling jobs with verification.

## Лабораторная работа

Создать `work/analytical-timeseries-lab/`.

### Datasets

- order/payment/shipment events;
- synthetic request metrics;
- device/sensor measurements;
- skewed tenants and high-cardinality labels.

### Implementations

- PostgreSQL transactional schema;
- PostgreSQL analytical/read-model variant;
- one columnar/analytical store;
- one time-series extension/store where feasible.

### Requirements

- logical grain documented;
- deterministic generator and checksum;
- bulk load process measured;
- queries cover point lookup, range scan, group aggregate and top-N;
- partition/data-skipping evidence captured;
- compressed/uncompressed storage reported;
- late data and correction policy tested;
- retention/downsampling preserves stated aggregates;
- high-cardinality scenario bounded;
- no claim that one store wins all workloads.

### Failure scenarios

1. Fact-table grain is ambiguous.
2. Duplicate event double-counts metric.
3. Partition key prevents pruning.
4. Too many tiny partitions/parts.
5. High-cardinality labels explode memory/index size.
6. Event time and ingestion time mixed.
7. Late data never updates rollup.
8. Materialized aggregate becomes stale.
9. OLTP update workload sent to append-optimized analytical store.
10. Compression comparison ignores load/CPU/query differences.

## Самопроверка

1. OLTP versus OLAP?
2. Row versus column layout?
3. Why column stores compress well?
4. What is vectorized execution?
5. What is fact-table grain?
6. Partition pruning versus index lookup?
7. Event time versus ingestion time?
8. Why label cardinality matters?
9. Retention versus downsampling?
10. Why source of truth may remain relational?

## Результат для базы знаний

- **OLTP and OLAP workloads**.
- **Row-oriented and column-oriented storage**.
- **Compression, vectorized execution and data skipping**.
- **Fact, dimension and analytical grain**.
- **Time-series identity and timestamp semantics**.
- **High-cardinality labels**.
- **Retention, rollups and late data**.
- **Transactional versus analytical source of truth**.

## Когда переходить дальше

Можно переходить, когда layout and model choices are tied to measured query/load patterns, late data is handled explicitly, and retention/rollups are verifiable.