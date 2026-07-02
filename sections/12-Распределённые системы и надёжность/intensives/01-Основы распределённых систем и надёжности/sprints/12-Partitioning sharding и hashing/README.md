# Спринт 12. Partitioning, sharding и hashing

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как распределить данные и нагрузку между узлами так, чтобы routing remained deterministic and growth did not require moving everything?

## Результат спринта

После завершения необходимо уметь:

- различать horizontal partitioning and replication;
- выбирать range, hash and directory partitioning;
- проектировать partition key from access patterns;
- понимать composite keys and co-location;
- использовать consistent or rendezvous hashing conceptually;
- оценивать movement on membership change;
- учитывать skew and key cardinality;
- проектировать routing metadata and cache invalidation;
- distinguish logical partitions from physical shards;
- handle cross-shard queries/transactions explicitly;
- define ownership and placement history.

## Основной маршрут

1. Partition synthetic accounts/orders by range and hash.
2. Compare distribution and query locality.
3. Implement consistent or rendezvous hash ring.
4. Add/remove node and measure key movement.
5. Execute one cross-shard operation.

## Лабораторная работа

Создать `work/partitioning/`.

### Requirements

- key selection is justified by read/write/join patterns;
- routing is deterministic and versioned;
- physical node changes do not redefine logical key semantics;
- add/remove node movement is measured;
- skewed key distribution is detected;
- co-located operations and cross-shard operations are identified;
- routing metadata has stale-cache behavior;
- one range scan and one point lookup trade-off are measured;
- shard ownership history supports migration/recovery.

### Failure scenarios

1. Monotonic key creates hot range.
2. Low-cardinality tenant key creates uneven shards.
3. Node count modulo hashing remaps most keys.
4. Stale routing sends write to old owner.
5. Replication factor is confused with partition count.
6. Cross-shard query silently scans every node.
7. Partition key prevents required co-location.

## Результат для базы знаний

- **Data partitioning and sharding**.
- **Range, hash and directory partitioning**.
- **Consistent and rendezvous hashing**.
- **Partition-key selection and locality**.
- **Logical partitions and physical shard placement**.

## Когда переходить дальше

Можно переходить, когда membership changes move a bounded fraction of data and access patterns reveal explicit local versus cross-shard costs.