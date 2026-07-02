# Спринт 13. Rebalancing, locality и hot shards

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как безопасно перемещать partition ownership and replicas while traffic continues, and how detect/mitigate hot keys or hot shards?

## Результат спринта

После завершения необходимо уметь:

- планировать online rebalancing stages;
- различать control-plane ownership and data-plane serving;
- использовать epochs/generations during migration;
- copy, catch up, cut over and retire old owner;
- prevent dual writers and stale routing;
- измерять transfer impact and throttling;
- distinguish hot key, hot partition and hot node;
- apply key salting, splitting, replication or caching appropriately;
- preserve locality and failure-domain placement;
- handle interrupted/restarted rebalance;
- verify completeness through checksums/offsets.

## Основной маршрут

1. Move one partition between nodes under live writes.
2. Add generation-aware routing and dual-read/catch-up phase.
3. Interrupt migration and resume.
4. Generate one hot key and compare mitigation strategies.

## Лабораторная работа

Создать `work/rebalancing/`.

### Requirements

- migration state machine is explicit and resumable;
- only current epoch owner accepts authoritative writes;
- copied snapshot and change stream reach a known cutover position;
- stale router receives redirect/version error;
- data completeness is checked before old owner retirement;
- transfer rate is throttled to preserve service SLO;
- hot key/partition/node are separately observable;
- mitigation keeps ordering/consistency semantics documented;
- placement respects zone/failure-domain rules;
- rollback before and after cutover is defined.

### Failure scenarios

1. Old and new owners accept writes simultaneously.
2. Snapshot misses concurrent writes.
3. Router uses stale partition map.
4. Rebalance saturates network/disk and causes outage.
5. Interrupted migration restarts from scratch and duplicates state.
6. Salting hot key breaks required ordering/query semantics.
7. Replicas are placed in one failure domain.

## Результат для базы знаний

- **Online shard rebalancing**.
- **Partition ownership epochs and cutover**.
- **Snapshot plus change-stream migration**.
- **Hot keys, hot partitions and hot nodes**.
- **Shard locality and failure-domain placement**.

## Когда переходить дальше

Можно переходить, когда a live partition migration survives interruption without dual writers or missing updates, and hot-key mitigation preserves the required semantics.