# Спринт 04. Сложные запросы и реляционные операции

Ориентировочный объём: 17–24 часа.

## Центральный вопрос

Как выразить multi-step analytical and transformation logic декларативным SQL, сохранив корректные NULL, duplicate, ordering and cardinality semantics?

## Результат спринта

После завершения необходимо уметь:

- использовать correlated and uncorrelated subqueries;
- применять `EXISTS`, `IN`, `ANY`, `ALL` safely;
- использовать `UNION`, `INTERSECT`, `EXCEPT`;
- писать common table expressions;
- строить recursive CTE with termination/cycle protection;
- применять window functions and explicit frames;
- использовать conditional aggregation and `FILTER`;
- выполнять upsert and set-based modifications;
- применять `LATERAL` where justified;
- работать с JSONB only where model requires it;
- понимать grouping sets overview;
- декомпозировать query without changing semantics;
- устранять N+1 application access;
- создавать oracle for complex reports;
- обеспечивать deterministic keyset pagination;
- отделять query correctness from performance.

## Основной маршрут

### Шаг 1. Subqueries and semijoins

Compare joins, `EXISTS`, anti-joins and scalar subqueries. Track cardinality and NULL behavior.

### Шаг 2. CTE and recursion

Use CTE for logical stages, not as an assumed optimization rule. Recursive CTE requires anchor, recursive term, decreasing/reachability condition and cycle handling.

### Шаг 3. Windows

Define partition, order and frame explicitly. Compare ranking, running totals, lag/lead and top-N-per-group.

### Шаг 4. Modification and pagination

Use `RETURNING`, conflict handling and set-based updates. Implement keyset pagination with a stable unique tie-breaker.

## Ресурсы

### Обязательный маршрут

- PostgreSQL subquery, CTE, window and DML documentation.
- Database course material on relational operations.
- Generated local SQL exercise set.

## Практические задания

1. Build customer/order/payment/fulfillment reports.
2. Implement top-N per group and running balances.
3. Compare `NOT EXISTS`, anti-join and `NOT IN` with NULL.
4. Traverse category/referral hierarchy with cycle protection.
5. Remove N+1 access through set-based queries.
6. Implement keyset pagination.

## Лабораторная работа

Создать `work/query-suite/`.

### Query catalogue

At least 30 named queries covering operational lookups, aggregates, missing relationships, current/history views, rankings, recursion, data-quality checks, upserts and pagination.

### Requirements

- each query has input/output contract;
- expected results come from fixtures or reference code;
- duplicates and NULL are explicit;
- window frame is explicit where order-sensitive;
- no unstable offset pagination in final design;
- Go layer avoids N+1;
- JSON output preserves numeric/time semantics;
- obvious unbounded outputs and accidental cross joins are prevented.

### Failure scenarios

1. Scalar subquery returns multiple rows.
2. `NOT IN` with NULL returns unexpected result.
3. Default window frame changes peer behavior.
4. Recursive CTE cycles or repeats.
5. Join multiplies aggregates.
6. `DISTINCT` hides a query/model bug.
7. Offset pagination skips/duplicates under writes.
8. Upsert overwrites newer data.
9. N+1 scales with result rows.

## Самопроверка

1. Subquery versus join?
2. Semijoin and antijoin?
3. Recursive CTE parts?
4. Window partition/order/frame?
5. Rank versus row_number?
6. Why aggregates inflate after one-to-many join?
7. What does `LATERAL` enable?
8. Keyset versus offset pagination?
9. Why `DISTINCT` may hide a bug?
10. How set-based access removes N+1?

## Результат для базы знаний

- **SQL subqueries and semijoins**.
- **Set operations**.
- **Common table expressions and recursion**.
- **Window functions and frames**.
- **Set-based data modification**.
- **N+1 query problem**.
- **Deterministic keyset pagination**.
- **Complex-query correctness testing**.

## Когда переходить дальше

Можно переходить, когда query suite matches reference results, duplicates and NULL are deliberate, and application access does not execute row-count-proportional queries.