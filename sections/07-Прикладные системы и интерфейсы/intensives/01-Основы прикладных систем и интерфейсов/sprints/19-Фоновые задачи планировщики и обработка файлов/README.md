# Спринт 19. Фоновые задачи, планировщики и обработка файлов

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Когда работу нужно вынести из request lifecycle, и как сделать durable task execution observable, idempotent, cancellable and recoverable?

## Результат спринта

После завершения необходимо уметь:

- различать request work, deferred task, scheduled job and event consumer;
- проектировать job state machine;
- сохранять task intent durably before acknowledgement;
- использовать outbox/database queue/broker consciously;
- определять idempotency and deduplication boundary;
- применять leases/visibility timeouts and heartbeats;
- ограничивать retries with backoff and jitter;
- различать transient, permanent and poison failures;
- поддерживать cancellation and progress reporting;
- ограничивать worker concurrency and resource classes;
- выполнять scheduled jobs without duplicate assumptions;
- использовать leader/locking mechanism cautiously;
- обрабатывать file upload, validation, scanning and transformation;
- хранить large files outside process memory/database when appropriate;
- проектировать cleanup of temporary files and abandoned jobs;
- понимать at-least-once delivery and effect deduplication;
- наблюдать queue depth, age, attempts and duration;
- выполнять graceful worker shutdown.

## Основной маршрут

### Шаг 1. Decide async boundary

Move work to background when request cannot/should not wait, resource use must be controlled, external dependency is slow, or scheduled/retriable processing is needed. Do not make simple operations async only to hide poor latency.

### Шаг 2. Job state

```text
pending → leased/running → succeeded
                 ├→ retryable → pending
                 ├→ failed/dead
                 └→ canceled
```

Persist attempts, next-run time, lease owner/expiry, progress and result reference.

### Шаг 3. Execution protocol

Worker claims bounded jobs, renews lease, performs idempotent step, commits result, acknowledges/completes. Crash at any point must lead to retry or reconciliation, not silent loss.

### Шаг 4. File workflow

Use upload intent, object staging, validation, metadata commit, background transform and final activation. Enforce size/type/content checks and temporary-object retention.

## Ресурсы

- chosen broker/database queue official docs.
- data-storage outbox/idempotent consumer material.
- S3-compatible object workflow documentation.
- Go context, worker pool and file I/O docs.
- reliable scheduler/retry engineering references.

## Практические задания

1. Implement database-backed job queue, then compare broker-backed delivery.
2. Crash worker after side effect but before completion record.
3. Add lease expiry and recovery.
4. Implement retry taxonomy and dead-letter state.
5. Add scheduled cleanup with duplicate execution test.
6. Process uploaded CSV/image/document with progress.
7. Cancel a pending/running job safely.
8. Load test mixed CPU/I/O job classes.

## Лабораторная работа

Создать `work/background-processing/`.

### Jobs

- generate export;
- validate/import CSV;
- transform attachment preview;
- send webhook/notification intent;
- reconcile stale derived data;
- scheduled cleanup/retention.

### Requirements

- task record committed before API returns accepted status;
- stable job ID and idempotency key;
- claim uses atomic transition/lease;
- worker crash produces retry without duplicate final effect;
- attempts, next run and failure code stored;
- poison jobs stop after policy limit;
- cancellation state is explicit and checked between safe steps;
- progress is monotonic/meaningful and not treated as exact guarantee;
- concurrency bounded per job type/resource;
- uploaded files have size/type/checksum and isolated staging;
- temporary files/objects cleaned after success/failure/expiry;
- job status endpoint and SSE updates available;
- shutdown stops claims and drains/cancels owned work.

### Failure scenarios

1. API returns `202` before job intent is durable.
2. Worker crash loses in-memory queue.
3. Lease expires while worker still commits duplicate effect.
4. Retry loops permanent validation error.
5. Scheduled job runs twice and duplicates destructive action.
6. One large file/job starves all workers.
7. File type trusted from extension/content type only.
8. Temporary object remains after failed import.
9. Cancellation reports success while external effect continues.
10. Progress reaches 100 before transaction/result is durable.
11. Worker shutdown abandons claimed jobs indefinitely.

## Самопроверка

1. When should request become background job?
2. Durable intent means what?
3. Lease versus ownership guarantee?
4. Why at-least-once requires idempotency?
5. Transient versus permanent failure?
6. Retry backoff/jitter purpose?
7. Scheduled job duplicate risk?
8. How cancellation works between safe points?
9. File staging/finalization path?
10. Which queue metrics reveal health?
11. Graceful worker shutdown sequence?

## Результат для базы знаний

- **Request work versus background job**.
- **Durable job state machine**.
- **Leases, visibility and worker recovery**.
- **Background retry and poison-job handling**.
- **Idempotent job effects**.
- **Scheduled-job duplicate execution**.
- **File upload and processing lifecycle**.
- **Job progress, cancellation and observability**.

## Когда переходить дальше

Можно переходить, когда accepted work is durable, crash/retry/cancel paths converge to one valid result, and workers/files remain bounded and cleanable.