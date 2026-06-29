# Спринт 11. Изменение схемы и миграции данных

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Как изменить schema and existing data без длительной недоступности, потери совместимости и необратимого partial state?

## Результат спринта

После завершения необходимо уметь:

- различать schema migration, data migration and application rollout;
- оценивать DDL locks and table rewrites;
- применять expand-and-contract sequence;
- добавлять columns, constraints and indexes безопасными этапами;
- использовать `NOT VALID` and later validation where appropriate;
- понимать `CREATE INDEX CONCURRENTLY` lifecycle;
- выполнять chunked backfill;
- проектировать idempotent and restartable migrations;
- различать backward and forward compatibility;
- координировать old/new application versions;
- избегать uncontrolled dual writes;
- использовать triggers only with removal plan;
- проверять row counts, checksums and invariants;
- планировать rollback versus forward fix;
- понимать irreversible transformations;
- управлять schema version and migration ordering;
- тестировать migration on production-like scale;
- оценивать WAL, lock, disk and replication impact.

## Основной маршрут

### Шаг 1. Change classification

For each change state:

```text
metadata-only or rewrite
lock mode and duration
old/new app compatibility
backfill volume
additional disk/WAL
replica impact
rollback/forward path
verification
```

### Шаг 2. Expand and contract

Typical sequence:

```text
add compatible structure
→ deploy tolerant code
→ backfill and verify
→ switch reads/source of truth
→ stop old writes
→ remove obsolete structure later
```

### Шаг 3. Backfill

Use bounded batches, deterministic ranges, resumability and concurrency control. Avoid one giant transaction.

### Шаг 4. Constraint/index rollout

Build and validate in stages, monitor invalid indexes and lock wait, then enforce final invariant.

## Ресурсы

- PostgreSQL DDL, locking, constraints and concurrent index docs.
- Migration-tool docs only after SQL behavior is understood.
- Reliable expand-contract and online-migration references.
- DDIA schema-evolution sections.

## Практические задания

1. Add required field without breaking old clients.
2. Rename or split one column through expand-contract.
3. Add FK/check to dirty large table.
4. Build and cancel concurrent index.
5. Backfill derived data in resumable chunks.
6. Migrate identifier/type with old/new app versions.

## Лабораторная работа

Создать `work/migration-lab/`.

### Migration set

- add normalized address table;
- split current status and status history;
- introduce tenant-safe composite uniqueness;
- convert legacy text amount to exact numeric units;
- add search/read-model columns;
- remove deprecated field after compatibility window.

### Requirements

- versioned migrations;
- forward repair for irreversible changes;
- old and new application versions run during transition;
- lock timing and blocked-session evidence captured;
- backfill supports pause/resume/retry;
- batches do not rescan completed rows unnecessarily;
- validation checks counts, checksums and invariants;
- replica/WAL/disk impact measured in lab;
- failed concurrent index detected and cleaned;
- no migration depends on developer-local state.

### Failure scenarios

1. `ALTER` acquires long blocking lock.
2. Type/default change rewrites large table unexpectedly.
3. New app deployed before compatible schema.
4. Old app overwrites new value.
5. Giant backfill transaction creates bloat/WAL/lag.
6. Retry duplicates or skips rows.
7. Constraint validation fails after partial rollout.
8. Invalid concurrent index remains.
9. Rollback destroys data written by new version.
10. Dual writes diverge with no reconciliation.

## Самопроверка

1. Schema versus data migration?
2. What is expand-contract?
3. Why old/new compatibility matters?
4. What makes backfill resumable?
5. Why one giant transaction is risky?
6. What does `NOT VALID` change?
7. Concurrent index trade-offs?
8. Rollback versus forward fix?
9. How verify migration correctness?
10. How migration affects replicas/storage?

## Результат для базы знаний

- **Schema and data migrations**.
- **Expand-and-contract deployment**.
- **DDL locks and table rewrites**.
- **Restartable chunked backfill**.
- **Constraint validation and concurrent indexes**.
- **Backward/forward schema compatibility**.
- **Migration verification and forward repair**.
- **Migration WAL, disk and replication impact**.

## Когда переходить дальше

Можно переходить, когда migration survives interruption and mixed application versions, verification proves data invariants, and rollback/forward behavior is explicit.