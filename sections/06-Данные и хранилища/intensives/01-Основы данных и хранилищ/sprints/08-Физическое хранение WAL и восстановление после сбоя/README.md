# Спринт 08. Физическое хранение, WAL и восстановление после сбоя

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как logical rows become pages and files, и какие mechanisms позволяют подтвердить committed data after process or machine failure?

## Результат спринта

После завершения необходимо уметь:

- различать logical row/table from heap file/page/tuple;
- понимать page header, line pointers and tuple storage conceptually;
- объяснять TOAST and oversized values;
- различать database buffer cache and OS page cache;
- понимать dirty pages, checkpoints and background writing;
- объяснять write-ahead logging rule;
- понимать WAL records, LSN and full-page images at operational level;
- различать commit acknowledgement, WAL flush and data-page write;
- объяснять crash recovery redo concept;
- понимать durability risks of `fsync`, storage caches and unsafe settings;
- использовать checksums and integrity tools cautiously;
- различать logical data corruption, page corruption and lost writes;
- наблюдать table/index/WAL size growth;
- понимать why update may create new tuple version;
- сравнивать PostgreSQL WAL with SQLite rollback journal/WAL conceptually;
- выполнять controlled crash/restart only in disposable cluster.

## Основной маршрут

### Шаг 1. Pages and tuples

Use `pageinspect`, relation size functions and small tables to observe page allocation, tuple versions, free space and TOAST. Internal layout is version-specific and not application API.

### Шаг 2. Buffering and writes

Trace:

```text
SQL change → shared buffers → WAL generation
→ WAL flush at commit → later data-page write/checkpoint
```

Separate process memory, database cache, kernel cache and physical persistence.

### Шаг 3. Crash recovery

Create committed/uncommitted changes, stop the disposable server abruptly, restart and verify committed state plus rollback of incomplete transaction.

### Шаг 4. Durability boundaries

Compare safe defaults with laboratory-only unsafe settings. Do not use performance results from unsafe mode as production recommendation.

## Ресурсы

### Обязательный маршрут

- PostgreSQL database physical storage, WAL, checkpoints and reliability docs.
- CMU storage/buffer/recovery lectures.
- Database Internals storage and WAL chapters.
- PostgreSQL `pageinspect`, `pg_visibility`, checksums and `amcheck` docs.

### Углубление

- ARIES;
- WAL record internals;
- torn pages and full-page writes;
- direct I/O;
- storage barriers and controller caches;
- page compression.

## Практические задания

1. Map relation sizes and page counts as rows grow.
2. Observe inline versus TOASTed values.
3. Compare insert/update/delete physical effects.
4. Measure WAL bytes for different operations.
5. Trigger checkpoint and observe dirty-buffer/WAL behavior.
6. Run controlled crash with committed/uncommitted transactions.
7. Compare PostgreSQL and SQLite journal modes on a tiny workload.

## Лабораторная работа

Создать `work/storage-internals/`.

### Components

- disposable PostgreSQL cluster/container;
- schema and deterministic data generator;
- relation/page inspection scripts;
- WAL-volume collector;
- crash/restart verifier;
- integrity check script;
- SQLite comparison fixture.

### Requirements

- all destructive actions verify lab marker and target;
- page/tuple observations record tested PostgreSQL version;
- committed checksum survives crash;
- uncommitted rows are absent after recovery;
- relation, index, TOAST and WAL sizes reported separately;
- `fsync`/durability settings restored after experiment;
- large binary/WAL artifacts ignored by Git;
- integrity command output summarized, not overinterpreted;
- recovery time and WAL distance recorded for bounded cases.

### Failure scenarios

1. Dirty data page assumed durable before WAL flush.
2. Unsafe `fsync` setting left enabled.
3. Kill test targets wrong cluster.
4. TOAST/index size omitted from capacity estimate.
5. Checkpoint expected to truncate all WAL immediately.
6. OS page cache confused with durable media.
7. Corrupted page test performed without backup/disposable copy.
8. Uncommitted transaction mistakenly expected after crash.
9. Internal tuple fields treated as stable business metadata.

## Самопроверка

1. Logical row versus heap tuple/page?
2. What does TOAST solve?
3. What is database buffer cache?
4. What does write-ahead mean?
5. Why can commit happen before data page write?
6. What is checkpoint?
7. What does crash recovery redo?
8. Why `fsync` and storage cache matter?
9. Relation size includes which components?
10. PostgreSQL WAL versus SQLite journal conceptually?

## Результат для базы знаний

- **Database pages, tuples and relation files**.
- **TOAST and oversized values**.
- **Database buffer cache and dirty pages**.
- **Write-ahead logging and LSN**.
- **Checkpoint and crash recovery**.
- **Commit durability boundary**.
- **Checksums and storage corruption**.
- **PostgreSQL and SQLite journaling comparison**.

## Когда переходить дальше

Можно переходить, когда committed/uncommitted crash behavior is proven, WAL/page roles are distinct, and all destructive experiments are reproducible and scoped.