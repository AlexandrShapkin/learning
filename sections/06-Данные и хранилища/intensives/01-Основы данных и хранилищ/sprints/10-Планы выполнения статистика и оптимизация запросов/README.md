# Спринт 10. Планы выполнения, статистика и оптимизация запросов

Ориентировочный объём: 20–29 часов.

## Центральный вопрос

Как optimizer estimates alternatives, почему chosen plan can be wrong, и как improve workload without random configuration changes?

## Результат спринта

После завершения необходимо уметь:

- читать plan tree bottom-up and by actual data flow;
- различать estimated and actual rows/cost/time;
- понимать sequential, index, index-only and bitmap scans;
- объяснять nested-loop, hash and merge joins;
- понимать sort, aggregate, materialize and parallel nodes;
- использовать `EXPLAIN`, `ANALYZE`, `BUFFERS`, `WAL`, timing options safely;
- понимать statistics: null fraction, distinct count, MCV, histogram and correlation;
- создавать extended statistics for correlated columns;
- распознавать cardinality-estimation errors;
- понимать selectivity and join-order impact;
- выявлять spills to temporary files;
- различать planning and execution time;
- понимать prepared generic/custom plan issue overview;
- корректировать schema/query/index/statistics before cost knobs;
- использовать `pg_stat_statements` for workload-level view;
- сравнивать p50/p95 and throughput under representative concurrency;
- отличать database bottleneck from application/network wait.

## Основной маршрут

### Шаг 1. Plan operators

For each node identify input, output rows, loops, memory/disk behavior and blocking/streaming nature.

### Шаг 2. Estimates and statistics

Compare estimated versus actual cardinalities. Create skew/correlation examples and run `ANALYZE`/extended statistics.

### Шаг 3. Join and sort behavior

Control table sizes/selectivity to observe nested loop, hash join, merge join, in-memory sort and spill.

### Шаг 4. Optimization method

```text
representative slow query
→ exact plan with buffers
→ locate largest misestimate/work
→ form hypothesis
→ change query/schema/index/statistics
→ rerun correctness and workload
```

Do not disable planner methods globally as a final fix.

## Ресурсы

### Обязательный маршрут

- PostgreSQL `EXPLAIN`, planner statistics and performance tips docs.
- CMU query execution and optimization lectures.
- SQL Performance Explained.
- `pg_stat_statements` documentation.

### Углубление

- dynamic programming join enumeration;
- cost model internals;
- JIT and parallel query;
- adaptive query processing;
- plan cache internals.

## Практические задания

1. Observe scan choice across selectivity/size.
2. Force data skew and estimate error.
3. Compare join algorithms with controlled inputs.
4. Trigger sort/hash spill through bounded memory setting.
5. Repair correlated-column estimate using extended stats.
6. Compare prepared generic/custom plan for skewed parameter values.
7. Rank top workload queries through `pg_stat_statements`.

## Лабораторная работа

Создать `work/query-planner-lab/`.

### Query set

- selective lookup;
- broad range;
- multi-table joins;
- skewed tenant/status query;
- aggregation and top-N;
- window query;
- pagination;
- JSON/tag membership;
- reporting query with spill risk.

### Requirements

- deterministic scale/skew generator;
- correctness result checksum;
- estimated/actual row ratios extracted;
- buffers/temp/WAL metrics captured where applicable;
- before/after plans linked to one change;
- connection/application timing separated from server execution;
- statistics target/extended stats experiments reverted/documented;
- no permanent disabling of scan/join methods;
- optimization report states trade-off and affected workload.

### Failure scenarios

1. `EXPLAIN ANALYZE` changes production data through DML.
2. Actual time read as exclusive rather than cumulative/loops.
3. Large estimate error ignored.
4. Query optimized for one tenant and regresses others.
5. Cost units interpreted as milliseconds.
6. Cold/warm cache conditions mixed.
7. Sort/hash spill overlooked.
8. Missing `ANALYZE` after load.
9. Planner GUC disabled as unexplained fix.
10. Database blamed for application pool/network wait.

## Самопроверка

1. Estimated cost versus actual time?
2. How read loops and rows?
3. Seq/index/bitmap scan differences?
4. Nested loop/hash/merge joins?
5. What statistics drive selectivity?
6. What is cardinality-estimation error?
7. What are extended statistics?
8. How detect spill?
9. Planning versus execution time?
10. What is workload-level optimization?

## Результат для базы знаний

- **Query execution plan and plan nodes**.
- **Estimated versus actual cardinality**.
- **Scan and join algorithms**.
- **Planner statistics and selectivity**.
- **Extended statistics and correlated columns**.
- **Sort/hash spill and work memory**.
- **Prepared generic and custom plans**.
- **Evidence-driven SQL optimization**.
- **pg_stat_statements workload analysis**.

## Когда переходить дальше

Можно переходить, когда plan trees are interpreted correctly, cardinality errors are reproduced/repaired, and optimization improves a representative workload without breaking correctness.