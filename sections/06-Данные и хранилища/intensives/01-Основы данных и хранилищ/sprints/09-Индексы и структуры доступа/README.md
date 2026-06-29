# Спринт 09. Индексы и структуры доступа

Ориентировочный объём: 19–27 часов.

## Центральный вопрос

Как дополнительная structure accelerates specific predicates/orderings, и какие write, space and maintenance costs она создаёт?

## Результат спринта

После завершения необходимо уметь:

- объяснять index as redundant access structure;
- понимать B-tree ordering and logarithmic navigation;
- выбирать B-tree for equality/range/order/prefix-compatible predicates;
- понимать hash index use boundaries;
- выбирать GIN for multi-valued/document/full-text membership;
- понимать GiST/SP-GiST as framework for specialized operators;
- выбирать BRIN for large physically correlated data;
- проектировать multicolumn indexes and leftmost-prefix behavior;
- использовать expression and partial indexes;
- понимать included columns and index-only scans;
- различать covering potential and visibility-map requirement;
- оценивать selectivity and cardinality;
- понимать write amplification, page splits and index bloat;
- обнаруживать unused/redundant indexes cautiously;
- использовать `CREATE INDEX CONCURRENTLY` operationally;
- проверять index correctness through plans and workload, not naming intuition.

## Основной маршрут

### Шаг 1. B-tree and query shapes

Map predicates and order requirements to index key order. Equality prefixes, range column and ordering must be considered together.

### Шаг 2. Specialized access methods

Create one controlled example for hash, GIN, GiST and BRIN. Understand operator classes and supported operators.

### Шаг 3. Covering, partial and expression indexes

Use a partial predicate only when queries imply it. Expression index requires matching expression semantics and stable functions.

### Шаг 4. Cost and lifecycle

Measure index size, build time, DML overhead, vacuum behavior and plan use. More indexes can reduce write throughput and increase maintenance/recovery time.

## Ресурсы

### Обязательный маршрут

- PostgreSQL indexes, index types, multicolumn, partial, expression and index-only docs.
- Use The Index, Luke.
- CMU B-tree/index lectures.
- PostgreSQL access method/operator class documentation overview.

### Углубление

- B-tree page splits/deduplication;
- bloom indexes;
- LSM trees;
- covering index design in other engines;
- learned indexes;
- vector indexes.

## Практические задания

1. Design indexes for exact lookup, range, ordered pagination and top-N.
2. Compare `(tenant_id, status, created_at)` order variants.
3. Build partial index for active/unprocessed rows.
4. Build expression index for normalized lookup.
5. Use GIN for array/JSONB/full-text membership.
6. Use BRIN on append-ordered timestamp data.
7. Measure insert/update cost with increasing index count.

## Лабораторная работа

Создать `work/index-lab/`.

### Workloads

- tenant/order lookup;
- time-range scan;
- active-work queue;
- case-insensitive customer lookup;
- JSONB tags/attributes;
- spatial/range-like predicate if GiST available;
- append-only event table for BRIN;
- mixed read/write benchmark.

### Requirements

- baseline without custom indexes;
- each index tied to exact query contract;
- `EXPLAIN (ANALYZE, BUFFERS)` captured on synthetic data;
- table/index size and DML WAL/latency measured;
- warm/cold limitations stated;
- index-only scan verified rather than assumed;
- redundant-prefix and unused-index candidates reviewed;
- concurrent build/cancel/failure behavior tested on disposable schema;
- index validity checked after interrupted build where relevant.

### Failure scenarios

1. Index column order does not match predicate/order.
2. Function/cast prevents index use.
3. Partial-index predicate not implied by query.
4. Low-selectivity index is more expensive than scan.
5. Index-only scan still fetches heap pages.
6. GIN write/update cost ignored.
7. BRIN used on uncorrelated data.
8. Duplicate indexes consume write/storage budget.
9. Index build blocks or leaves invalid index unexpectedly.
10. Query speed improves but write/SLA regresses.

## Самопроверка

1. What does an index store/redundantly maintain?
2. B-tree supports which query shapes?
3. Why multicolumn order matters?
4. Partial versus expression index?
5. What is selectivity?
6. GIN versus GiST versus BRIN?
7. What enables index-only scan?
8. Why many indexes hurt writes?
9. How physical correlation affects BRIN?
10. How prove index is useful?

## Результат для базы знаний

- **Database index as access structure**.
- **B-tree index query shapes**.
- **Multicolumn index ordering**.
- **Partial and expression indexes**.
- **GIN, GiST, SP-GiST and BRIN**.
- **Index-only scan and visibility**.
- **Index selectivity, size and write amplification**.
- **Concurrent index lifecycle**.

## Когда переходить дальше

Можно переходить, когда every index has a demonstrated query benefit, write/storage costs are measured, and specialized index assumptions are validated against data distribution.