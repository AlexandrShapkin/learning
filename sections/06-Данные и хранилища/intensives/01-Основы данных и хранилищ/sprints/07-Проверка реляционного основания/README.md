# Спринт 07. Проверка реляционного основания

Ориентировочный объём: 12–18 часов.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 01–06.

## Исходная задача

Создать `work/order-ledger/` — relational service and SQL suite for multi-tenant orders, inventory, payments and status history.

## Требования к модели

- exact money/time/identity semantics;
- normalized source-of-truth schema;
- alternate and composite tenant-safe keys;
- database constraints for persisted invariants;
- explicit delete/retention policy;
- versioned payload compatibility;
- one denormalized read model with verifier/repair;
- migration from flawed v1 dataset.

## Query requirements

At least 25 verified queries covering lookups, joins, aggregates, anti-relationships, rankings, running totals, recursive history, data-quality checks, set-based updates and keyset pagination.

No N+1 application path.

## Transaction scenarios

- inventory reservation;
- account/payment command;
- order status transition;
- idempotent request handling;
- write-skew invariant;
- serialization retry;
- outbox event record.

Run under relevant isolation levels and verify invariants.

## Lock/MVCC scenarios

1. Blocking row update.
2. Deadlock through opposite lock order.
3. Idle transaction.
4. `SKIP LOCKED` worker claim.
5. Long snapshot plus churn/vacuum.
6. Optimistic version conflict.

## Tests

- schema/migration tests;
- SQL query reference tests;
- concurrent deterministic harness;
- SQLSTATE classification;
- property tests for totals/state transitions;
- old/new payload compatibility;
- cleanup from fresh schema.

## Blind cases

Randomly select at least six:

- missing business uniqueness;
- cross-tenant FK leak;
- join aggregate multiplication;
- NULL anti-query bug;
- lost update;
- write skew;
- duplicate side effect on retry;
- deadlock;
- idle transaction/vacuum issue;
- stale denormalized total.

## Defense

1. Logical versus physical model?
2. Which invariants belong in constraints?
3. Why normalize, and when denormalize?
4. SQL NULL/duplicate/order semantics?
5. How isolation protects invariants?
6. Lost update versus write skew?
7. How MVCC affects visibility?
8. How diagnose blocking/deadlock?
9. Why external effect needs outbox/idempotency?
10. How long transactions affect vacuum?

## Критерии прохождения

- clean schema build/migration succeeds;
- invalid states and cross-tenant references are rejected;
- all queries match reference results;
- transaction invariants hold under concurrency;
- retry is bounded and side-effect safe;
- six blind cases are solved from evidence;
- no lingering sessions/locks/data after cleanup;
- at least 8 of 10 defense answers are correct.

## Результат для базы знаний

Checkpoint-specific note не требуется. Исправить existing notes where experiment contradicted the prior model.