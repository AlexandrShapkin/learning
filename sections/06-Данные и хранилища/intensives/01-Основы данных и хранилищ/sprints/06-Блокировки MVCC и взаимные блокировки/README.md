# Спринт 06. Блокировки, MVCC и взаимные блокировки

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как database coordinates readers and writers through snapshots, row/table locks and version visibility, и почему blocking and bloat появляются даже при логически корректных запросах?

## Результат спринта

После завершения необходимо уметь:

- объяснять tuple versions and snapshots at practical level;
- понимать `xmin/xmax` only as diagnostic concepts;
- различать row-level, table-level, predicate and advisory locks;
- читать `pg_locks`, `pg_stat_activity` and blocking chains;
- понимать lock compatibility;
- воспроизводить blocking and deadlock;
- объяснять deadlock detection and victim abort;
- проектировать consistent lock ordering;
- понимать `NOWAIT` and `SKIP LOCKED`;
- объяснять why long transactions delay vacuum;
- понимать vacuum/autovacuum, visibility map and freeze overview;
- различать dead tuples, bloat and live data growth;
- использовать optimistic version columns;
- избегать advisory-lock namespace collisions;
- диагностировать idle-in-transaction and snapshot retention.

## Основной маршрут

### Шаг 1. MVCC visibility

Observe old/new row versions through concurrent snapshots. Use `pageinspect` only in disposable lab and avoid treating internal fields as stable API.

### Шаг 2. Locks

Study explicit lock modes and build blocking graph from activity/locks.

### Шаг 3. Deadlocks

Create two transactions locking resources in opposite order. Capture the cycle and fix through ordering or smaller lock scope.

### Шаг 4. Vacuum lifecycle

Generate churn, observe dead tuples/statistics, run vacuum/analyze and distinguish cleanup from file shrink.

## Ресурсы

### Обязательный маршрут

- PostgreSQL MVCC, explicit locking and vacuum docs.
- PostgreSQL monitoring views docs.
- DDIA concurrency-control sections.
- `pageinspect`, visibility and free-space-map docs.

## Практические задания

1. Observe row versions through concurrent snapshots.
2. Build lock compatibility experiments.
3. Reproduce deadlock and blocking graph.
4. Use `SKIP LOCKED` worker queue with recovery semantics.
5. Generate update/delete churn and inspect vacuum/bloat indicators.
6. Demonstrate idle transaction retaining snapshot.

## Лабораторная работа

Создать `work/mvcc-lock-lab/`.

### Components

- Go concurrent session harness;
- blocking/deadlock scenario catalogue;
- read-only lock/activity collector;
- work-queue implementation;
- churn generator;
- vacuum/bloat report.

### Requirements

- queries tagged with application/request ID;
- blocking root identified, not only blocked session;
- deadlock reproduction bounded and cleaned;
- lock ordering documented;
- queue workers handle crash/retry/idempotency;
- fairness limitations of `SKIP LOCKED` noted;
- long transaction proves vacuum impact;
- no destructive vacuum/rewrite on non-disposable data;
- table/index size evidence separated from tuple stats.

### Failure scenarios

1. Idle transaction holds locks/snapshot.
2. Two code paths lock rows in opposite order.
3. Broad update locks more rows than expected.
4. `SKIP LOCKED` task starves.
5. Worker commits task claim before durable result.
6. Advisory lock key collision.
7. Autovacuum disabled/misconfigured in lab.
8. Long snapshot prevents cleanup.
9. VACUUM expected to shrink file.
10. Lock timeout treated as root cause.

## Самопроверка

1. How MVCC lets readers/writers coexist?
2. What is snapshot visibility?
3. Row versus table lock?
4. How find blocking root?
5. What forms a deadlock?
6. How lock ordering prevents it?
7. What does `SKIP LOCKED` trade away?
8. Why long transaction harms vacuum?
9. Dead tuples versus bloat?
10. VACUUM versus rewrite/full vacuum?

## Результат для базы знаний

- **MVCC versions and snapshot visibility**.
- **PostgreSQL lock modes and blocking chains**.
- **Deadlock detection and lock ordering**.
- **NOWAIT and SKIP LOCKED**.
- **Vacuum, dead tuples and bloat**.
- **Long transactions and snapshot retention**.
- **Advisory and optimistic locking**.

## Когда переходить дальше

Можно переходить, когда blocking root and deadlock cycle are diagnosed from views, queue lifecycle survives worker failure, and vacuum impact is demonstrated safely.