# Спринт 14. Проверка репликации и распределения данных

Ориентировочный объём: 15–22 часа.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 07–13.

## Исходная задача

Создать `work/replication-sharding-checkpoint/` — replicated and partitioned state service with explicit consistency modes, quorum behavior, conflict handling and online rebalancing.

## Required capabilities

- configurable leader-follower or leaderless mode;
- replica positions, terms/epochs and lag;
- at least two consistency/session modes;
- quorum reads/writes;
- versioned updates and conflict resolution;
- logical partitions with deterministic routing;
- live rebalance and hot-key mitigation;
- history/invariant checker.

## Mandatory fault cases

1. Follower pauses and serves stale data.
2. Old leader resumes after promotion.
3. Minority partition accepts conflicting update.
4. Clock-skewed last-write-wins loses data.
5. Tombstone expires before stale replica returns.
6. Sloppy quorum does not overlap as assumed.
7. Stale router writes to old shard owner.
8. Rebalance snapshot misses concurrent change.
9. Rebalance causes network/disk saturation.
10. Hot key overloads one partition.
11. Cross-shard operation violates invariant.
12. Replica checksum/history diverges silently.

## Defense

1. Which acknowledgement/durability semantics are provided?
2. Which consistency model applies to each operation?
3. How are session guarantees implemented?
4. What quorum assumptions are required?
5. What happens in majority and minority partitions?
6. How are concurrent versions detected/resolved?
7. How are deletes protected from resurrection?
8. Why was the partition key chosen?
9. How is ownership versioned?
10. How does rebalance preserve writes?
11. How is hot-key mitigation selected?
12. Which invariants remain cross-shard?

## Критерии прохождения

- client histories match documented consistency modes;
- stale writers and old shard owners are fenced;
- partition behavior is measured for majority/minority clients;
- conflicts/deletes converge without silent lost updates;
- live rebalancing survives interruption;
- hot-key mitigation preserves documented semantics;
- all twelve faults are reproduced and diagnosed;
- at least 10 of 12 defense answers cite histories, epochs, versions or checksums.

## Результат для базы знаний

Checkpoint-specific note не требуется. Update replication/consistency/partitioning notes where experiments changed assumptions.