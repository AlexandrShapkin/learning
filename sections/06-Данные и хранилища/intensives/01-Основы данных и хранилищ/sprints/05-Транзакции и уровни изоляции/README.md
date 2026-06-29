# Спринт 05. Транзакции и уровни изоляции

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как объединить changes into an atomic state transition и выбрать isolation sufficient for invariants under concurrent access?

## Результат спринта

После завершения необходимо уметь:

- объяснять atomicity, consistency, isolation and durability;
- определять transaction boundary from business invariant;
- использовать begin/commit/rollback and savepoints;
- различать PostgreSQL read committed, repeatable read and serializable;
- воспроизводить nonrepeatable reads, lost updates and write skew;
- понимать statement snapshot versus transaction snapshot;
- применять optimistic/pessimistic techniques;
- использовать `SELECT ... FOR UPDATE/SHARE` deliberately;
- понимать serialization failures and transaction retry;
- проектировать idempotent retry boundary;
- избегать external side effects inside retryable transaction;
- сокращать transaction duration;
- тестировать concurrency with deterministic barriers;
- различать database consistency and business correctness.

## Основной маршрут

### Шаг 1. Transaction contract

Identify all rows/facts participating in invariant and all external effects.

### Шаг 2. Isolation experiments

Use multiple sessions and record initial state, statements, expected snapshot/locks, result and invariant outcome.

### Шаг 3. Serializable and retry

Serializable execution may abort transactions to preserve a serial order. Retry the complete transaction with bounded attempts and safe idempotency.

### Шаг 4. Application integration

Go helper must propagate context, rollback correctly and never retry arbitrary non-repeatable side effects.

## Ресурсы

### Обязательный маршрут

- PostgreSQL transaction isolation and control docs.
- DDIA transactions chapter.
- Berenson isolation paper as advanced context.
- pgx or `database/sql` transaction docs.

## Практические задания

1. Transfer funds and reserve inventory.
2. Reproduce lost update through read-modify-write.
3. Reproduce cross-row write skew.
4. Compare locking and serializable solutions.
5. Implement bounded transaction retry in Go.
6. Demonstrate duplicate external effect under naive retry.

## Лабораторная работа

Создать `work/transaction-lab/`.

### Scenarios

- account transfer;
- inventory reservation;
- unique active subscription;
- capacity/on-call write skew;
- order status transition;
- idempotent payment command.

### Requirements

- deterministic concurrent harness;
- scenarios run under relevant isolation levels;
- invariants checked after every run;
- serialization/deadlock SQLSTATE classified;
- retry wraps complete transaction only;
- external effects represented by outbox records;
- bounded timeout and attempts;
- no transaction waits for user/network input;
- report distinguishes prevented anomaly from abort/retry.

### Failure scenarios

1. Lost update under read committed.
2. Write skew violates cross-row invariant.
3. Retry reuses stale transaction/data.
4. External effect duplicates on retry.
5. Transaction commits partial transition.
6. Long transaction holds snapshot/locks.
7. Rollback error masks primary error.
8. Isolation semantics assumed portable.
9. Decision reads data outside transaction.

## Самопроверка

1. ACID meanings?
2. Transaction boundary chosen by what?
3. Statement versus transaction snapshot?
4. Lost update versus write skew?
5. Repeatable read versus serializable?
6. Why serializable can abort?
7. When row lock helps?
8. Why retry whole transaction?
9. Why external effect cannot be naively retried?
10. What does consistency in ACID mean?

## Результат для базы знаний

- **ACID and transaction boundary**.
- **Isolation levels and snapshots**.
- **Lost update and write skew**.
- **Serializable transaction and retry**.
- **Pessimistic and optimistic concurrency control**.
- **External side effects and transactional outbox**.
- **Deterministic concurrency testing**.

## Когда переходить дальше

Можно переходить, когда anomalies are reproduced, invariants are preserved by a justified strategy, and retries cannot duplicate external effects.