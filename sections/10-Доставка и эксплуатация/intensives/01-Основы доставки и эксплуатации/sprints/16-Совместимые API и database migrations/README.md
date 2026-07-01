# Спринт 16. Совместимые API и database migrations

Ориентировочный объём: 20–29 часов.

## Центральный вопрос

Как release application, API/event contracts and database schema in compatible stages when old and new instances, clients and background jobs coexist?

## Результат спринта

После завершения необходимо уметь:

- apply expand-and-contract migration;
- distinguish backward, forward and mixed-version compatibility;
- design additive API/event/schema changes;
- handle field presence, defaults, enums and semantics;
- separate schema migration from data backfill and cleanup;
- make migrations idempotent/resumable where necessary;
- avoid long locks and unbounded transactions;
- use dual-read/write only with source of truth and reconciliation;
- coordinate old/new application versions;
- test migration on realistic data volume/state;
- define irreversible points and forward repair;
- retire old fields/endpoints only after usage evidence.

## Основной маршрут

1. Add a required domain field through nullable/additive schema and application compatibility.
2. Backfill in bounded batches while both versions run.
3. Switch reads/writes and compare data.
4. remove old field/contract after usage validation.
5. Repeat with API/event enum evolution.

## Лабораторная работа

Создать `work/compatible-migrations/`.

### Requirements

- compatibility matrix covers old/new app, schema and clients;
- schema expansion is safe before new code activation;
- backfill is restartable, bounded and observable;
- concurrent writes during backfill are captured/reconciled;
- indexes/constraints are introduced with lock/validation strategy;
- old application can run during compatibility window;
- API/event consumers handle unknown/additive fields per policy;
- contract cleanup uses usage evidence;
- rollback is refused after irreversible contract/data step where appropriate;
- forward-fix procedure restores invariants;
- migration version and status are visible in release evidence.

### Failure scenarios

1. Column/field becomes required before old writers are updated.
2. Migration locks a large table during peak.
3. Backfill misses concurrent changes.
4. Dual writes diverge without source of truth.
5. Enum addition crashes exhaustive old consumer.
6. Schema rollback drops data written by new version.
7. Old API endpoint is removed before clients migrate.
8. Migration succeeds on empty test DB but fails on realistic data.
9. Background worker with old code processes new data incorrectly.

## Результат для базы знаний

- **Expand-and-contract software migrations**.
- **Mixed-version application and schema compatibility**.
- **Restartable data backfills and reconciliation**.
- **Online index and constraint migration**.
- **API/event compatibility during releases**.
- **Irreversible migration points and forward repair**.

## Когда переходить дальше

Можно переходить, когда old/new application and clients coexist through a tested compatibility window and a realistic interrupted backfill resumes without data loss or long blocking.