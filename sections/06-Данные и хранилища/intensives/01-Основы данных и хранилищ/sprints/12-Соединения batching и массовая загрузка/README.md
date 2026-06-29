# Спринт 12. Соединения, batching и массовая загрузка

Ориентировочный объём: 15–22 часа.

## Центральный вопрос

Как application uses limited database connections efficiently, controls overload and moves many rows without sacrificing transaction and error semantics?

## Результат спринта

После завершения необходимо уметь:

- объяснять connection, session, transaction and statement lifecycle;
- настраивать Go connection pool limits and lifetimes;
- понимать why database connection is an expensive stateful resource;
- различать application pool and external pooler modes;
- понимать session, transaction and statement pooling trade-offs;
- использовать context and statement/lock/idle timeouts;
- классифицировать connect, timeout, cancellation and server errors;
- применять prepared statements with plan/session awareness;
- использовать batching and multi-row operations;
- использовать PostgreSQL `COPY` for bulk load/export;
- сравнивать row-by-row, batched and COPY paths;
- проектировать idempotent bulk ingestion;
- применять backpressure and admission control;
- избегать max-connections exhaustion;
- понимать pool starvation and connection leaks;
- измерять acquisition, server and total latency;
- безопасно retry only eligible failures;
- выполнять graceful drain.

## Основной маршрут

### Шаг 1. Connection budget

Define database max connections, reserved/admin capacity, services, instances, workers and expected concurrent transactions. Pool size is a system budget.

### Шаг 2. Pool lifecycle

Configure max open/idle, lifetime and health checks. Observe wait count/time, acquisition latency and leaked rows/transactions.

### Шаг 3. Batch and COPY

Compare:

```text
one statement per row
multi-row INSERT
prepared/batched execution
COPY FROM
staging table + set-based merge
```

### Шаг 4. Overload and retries

Bound queue/concurrency. Distinguish transient connection loss from serialization/deadlock and application errors. Do not retry indefinitely.

## Ресурсы

- Go `database/sql` pool documentation or pgxpool docs.
- PostgreSQL connection, resource, timeout, prepared-statement and COPY docs.
- PgBouncer or equivalent pooling documentation as comparison.
- PostgreSQL protocol/network behavior overview.

## Практические задания

1. Measure pool acquisition under bounded/unbounded concurrency.
2. Reproduce connection leak by unclosed rows/transaction.
3. Compare row, batch and COPY ingestion.
4. Use staging table plus validation/merge.
5. Test statement, lock and transaction timeout differences.
6. Compare direct session pool and transaction pooler limitations.

## Лабораторная работа

Создать `work/db-client-lab/`.

### Components

- Go workload client;
- configurable pool and queue;
- row/batch/COPY loaders;
- transaction runner;
- metrics/report command;
- fault modes for delay, connection reset and server restart.

### Requirements

- max concurrent operations and queue bounded;
- pool statistics exported;
- every rows/result/transaction closes;
- acquisition, execution and total latency measured separately;
- context cancellation reaches database;
- COPY validates records through staging before final merge;
- partial batch failure has explicit atomicity/retry semantics;
- retries bounded and classified;
- graceful shutdown waits/cancels safely;
- benchmark includes correctness checksum and server load.

### Failure scenarios

1. Pool larger than database budget across instances.
2. Rows not closed, connection never returns.
3. Transaction left idle after error.
4. Queue unbounded while pool saturated.
5. Timeout cancels client but server work continues unexpectedly.
6. Transaction pooler breaks session state assumption.
7. COPY bad-row handling misunderstood.
8. Batch retry duplicates writes.
9. Connection reset leaves commit outcome ambiguous.
10. Health checks amplify outage load.

## Самопроверка

1. Connection versus transaction?
2. Why pool is bounded?
3. How calculate connection budget?
4. Session versus transaction pooling?
5. Prepared statement benefits and risks?
6. Batch versus COPY?
7. Why staging table helps?
8. Acquisition wait means what?
9. Which timeouts differ?
10. How handle ambiguous connection failure?

## Результат для базы знаний

- **Database connection and session lifecycle**.
- **Connection-pool sizing and starvation**.
- **Session and transaction pooling**.
- **Prepared statements and plan/session state**.
- **Batching and PostgreSQL COPY**.
- **Staging-table ingestion**.
- **Database admission control and backpressure**.
- **Client/database timeout and retry taxonomy**.

## Когда переходить дальше

Можно переходить, когда client load remains bounded, resources return to pool on every path, and ingestion/retry semantics are proven under partial failures.