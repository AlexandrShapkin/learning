# Спринт 13. Проверка внутреннего устройства хранилища

Ориентировочный объём: 13–19 часов.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 08–12.

## Исходная задача

Расширить `order-ledger` до `work/storage-checkpoint/` и доказать behavior от client connection до plan, index, pages, WAL, migration and recovery.

## Part 1. Physical evidence

For representative tables:

- relation, index and TOAST sizes;
- page and tuple samples on disposable data;
- update, delete and vacuum effects;
- WAL volume per workload;
- checkpoint and crash-recovery experiment;
- committed and uncommitted state verification.

## Part 2. Index and plan matrix

Create workloads for:

- selective lookup;
- time range and keyset pagination;
- partial active-row query;
- multicolumn tenant query;
- JSON or tag membership;
- broad scan and aggregation;
- skewed correlated columns;
- join with estimate error;
- sort or hash spill.

For each record correctness checksum, estimated and actual rows, buffers, runtime, index size and write effect.

## Part 3. Migration

Perform mixed-version expand-contract migration with compatible schema expansion, resumable backfill, staged validation, read switch, cleanup, interruption and forward repair.

## Part 4. Client and ingestion

Compare row, batch and COPY paths with pool limits. Reproduce pool saturation, cancellation, connection reset and graceful drain.

## Mandatory fault cases

1. Wrong multicolumn index order.
2. Function or cast prevents index use.
3. Stale or missing statistics.
4. Correlated-column estimate error.
5. Sort or hash spill.
6. Unsafe durability setting.
7. Crash during committed and uncommitted work.
8. Migration lock blocks workload.
9. Backfill interruption.
10. Invalid concurrent index.
11. Connection or rows leak.
12. Pool or queue overload.
13. Ambiguous commit after connection loss.
14. COPY bad-record or partial-load case.

## Defense

1. How row maps to page and tuple?
2. WAL and checkpoint roles?
3. Commit durability boundary?
4. How choose index type and order?
5. How read estimates, actual loops and buffers?
6. What causes cardinality error?
7. Why migration needs compatibility stages?
8. How verify restartable backfill?
9. How pool size relates to database capacity?
10. Batch versus COPY trade-off?
11. How distinguish query time and pool wait?
12. Which evidence proves recovery?

## Критерии прохождения

- crash recovery preserves committed data and removes uncommitted effects;
- index and plans are supported by workload evidence;
- estimate errors and spills are diagnosed;
- migration survives interruption and mixed clients;
- client resources and pool return to baseline;
- all 14 faults are reproduced and repaired;
- at least 10 of 12 defense answers are correct;
- destructive artifacts remain isolated and cleanup passes.

## Результат для базы знаний

Checkpoint-specific note не требуется. Update only mechanisms where evidence changed the model.