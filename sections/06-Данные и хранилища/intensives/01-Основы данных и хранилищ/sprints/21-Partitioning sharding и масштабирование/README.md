# Спринт 21. Partitioning, sharding и масштабирование

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как divide growing data and workload across partitions or nodes, сохраняя query locality, invariants, rebalancing and operational control?

## Результат спринта

После завершения необходимо уметь:

- различать table partitioning and sharding;
- выбирать range, list and hash partitioning;
- понимать partition key and pruning;
- проектировать partition lifecycle, attach/detach and retention;
- понимать local indexes/constraints limitations;
- выбирать shard key by locality, distribution and growth;
- выявлять hot partitions/shards;
- понимать scatter-gather query cost;
- проектировать routing and shard map;
- использовать consistent hashing conceptually where suitable;
- понимать resharding and online data movement;
- проектировать tenant placement and large-tenant isolation;
- учитывать cross-shard joins, aggregations and transactions;
- понимать global uniqueness difficulty;
- применять IDs with shard/routing information cautiously;
- сравнивать scale-up, read replicas, partitioning and sharding;
- измерять skew, per-shard capacity and rebalancing impact;
- проектировать fallback/reconciliation for partial migration;
- диагностировать pruning failures, skew and routing errors.

## Основной маршрут

### Шаг 1. Native partitioning

Use PostgreSQL declarative partitioning for time and tenant examples. Verify pruning through plans and operations.

### Шаг 2. Shard-key selection

Evaluate candidates by:

```text
cardinality and distribution
query locality
write concentration
future growth
cross-shard invariants
rebalancing cost
operational ownership
```

### Шаг 3. Application-level sharding

Build a small router over multiple PostgreSQL instances. Keep shard map explicit and versioned. Do not hide cross-shard transactions.

### Шаг 4. Rebalancing

Move a bounded tenant/range using copy, catch-up, verify, routing switch and cleanup. Every stage is resumable and reversible until final cutover.

## Ресурсы

- PostgreSQL partitioning documentation.
- DDIA partitioning chapters.
- Distributed database/sharding design references.
- Consistent hashing and rebalancing papers as optional background.

## Практические задания

1. Partition events by month and tenant class.
2. Verify partition pruning and retention detach/drop.
3. Compare range, list and hash distribution.
4. Build three-shard Go router.
5. Generate skewed tenants and detect hot shard.
6. Execute tenant migration between shards.
7. Implement global aggregation through fan-out and compare cost.
8. Design global ID/uniqueness strategy.

## Лабораторная работа

Создать `work/partition-shard-lab/`.

### Topology

- one PostgreSQL instance with partitioned tables;
- three independent PostgreSQL shards;
- Go router and shard-map store;
- data generator with normal and oversized tenants;
- rebalance/migration controller;
- verification and capacity report.

### Requirements

- partition/shard key documented with rejected alternatives;
- every request routes deterministically;
- tenant isolation cannot cross shard accidentally;
- query API states local versus fan-out operations;
- shard map updates are versioned and atomic for clients;
- migration has copy, dual-read/verification or change-catch-up strategy;
- no uncontrolled dual write;
- counts/checksums/invariants verified before cutover;
- old shard retained until rollback window closes;
- skew and capacity metrics per shard;
- cross-shard operation failures are explicit, not presented as one ACID transaction.

### Failure scenarios

1. Partition key absent from query, no pruning.
2. Too many tiny partitions.
3. Unique constraint assumption crosses partitions/shards.
4. Sequential/range key creates hot shard.
5. One large tenant dominates capacity.
6. Scatter-gather query overloads all shards.
7. Routing map changes while clients use stale version.
8. Tenant copied but concurrent changes missed.
9. Dual writes diverge.
10. Cutover occurs before verification.
11. Cross-shard transaction partially commits.
12. Rebalancing increases WAL/network/disk beyond capacity.

## Самопроверка

1. Partitioning versus sharding?
2. Range, list and hash partitioning?
3. What enables partition pruning?
4. What makes a good shard key?
5. What is hot shard?
6. Why scatter-gather is costly?
7. How global uniqueness changes?
8. Why cross-shard transactions are difficult?
9. What stages make rebalancing safe?
10. Scale-up/read replica versus sharding?

## Результат для базы знаний

- **Table partitioning and partition pruning**.
- **Range, list and hash partitioning**.
- **Shard-key selection**.
- **Routing, shard maps and hot shards**.
- **Scatter-gather and cross-shard operations**.
- **Global uniqueness and distributed IDs**.
- **Online resharding and tenant migration**.
- **Partitioning versus replication and vertical scaling**.

## Когда переходить дальше

Можно переходить, когда pruning and routing are demonstrated, skew is measurable, and tenant migration preserves verified data without pretending cross-shard atomicity.