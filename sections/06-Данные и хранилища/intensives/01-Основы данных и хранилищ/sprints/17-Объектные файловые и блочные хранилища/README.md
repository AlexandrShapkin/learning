# Спринт 17. Объектные, файловые и блочные хранилища

Ориентировочный объём: 15–22 часа.

## Центральный вопрос

Как выбрать storage abstraction for bytes and files, понимая differences in naming, consistency, mutation, metadata, failure recovery and access protocol?

## Результат спринта

После завершения необходимо уметь:

- различать block, file and object storage abstractions;
- объяснять filesystem path/inode semantics versus object key;
- понимать object immutability/replacement model;
- проектировать bucket/key namespace and tenant isolation;
- использовать metadata, content type, checksums and ETags cautiously;
- выполнять multipart upload and resume/abort;
- понимать object versioning and lifecycle rules;
- использовать presigned URLs with scope and expiry;
- понимать consistency guarantees of tested S3-compatible system;
- проектировать idempotent upload and deduplication;
- distinguish object existence from database metadata transaction;
- избегать orphaned object/database records;
- применять staging/finalization and garbage collection;
- понимать random/block access versus whole-object access;
- оценивать request, storage, replication and egress costs;
- проектировать backup/restore differently from primary object data;
- диагностировать partial upload, checksum mismatch and stale metadata.

## Основной маршрут

### Шаг 1. Storage abstractions

Compare:

```text
block: addressed sectors/volumes, filesystem/database builds structure
file: hierarchical namespace and byte-stream operations
object: key + whole object + metadata over API
```

### Шаг 2. Object lifecycle

Define key generation, ownership, upload state, checksum, finalization, versioning, retention and deletion.

### Шаг 3. Cross-system consistency

Database and object store do not share one local ACID transaction. Use pending states, idempotent operations, outbox/workflow and reconciliation.

### Шаг 4. Security and cost

Keep buckets private, issue narrow presigned URLs, validate content and size, encrypt as required and estimate request/egress/storage classes.

## Ресурсы

- Amazon S3 API and consistency documentation.
- MinIO or another S3-compatible official documentation.
- Linux filesystem/block material from the OS intensive.
- DDIA storage and distributed-systems sections.
- Cloud/object lifecycle and security documentation for tested platform.

## Практические задания

1. Compare local file, block-backed filesystem and object API semantics.
2. Implement upload/download/head/delete/list with checksums.
3. Implement multipart upload with interruption/resume/abort.
4. Design database metadata plus object finalization workflow.
5. Reconcile orphan metadata and orphan objects.
6. Test versioning, retention and lifecycle expiration.
7. Estimate cost for several object-size/access distributions.

## Лабораторная работа

Создать `work/object-storage-lab/`.

### Components

- local S3-compatible service;
- PostgreSQL object metadata table;
- Go upload/download service;
- multipart worker;
- checksum verifier;
- reconciliation and garbage-collection command;
- presigned URL endpoint;
- lifecycle/cost report.

### Requirements

- buckets private by default;
- keys generated independently from user filenames;
- tenant ownership verified through database;
- max size/type and checksum policy;
- upload state machine: pending, uploaded, verified, active, deleting, deleted/failed;
- object and metadata operations idempotent;
- interrupted multipart uploads discoverable and abortable;
- no database row claims active object before verification;
- deletion handles retries and retention constraints;
- versioning behavior tested;
- fixtures synthetic and small.

### Failure scenarios

1. User-controlled key overwrites another tenant.
2. Database commits metadata but upload fails.
3. Object exists but metadata transaction fails.
4. Multipart upload leaves abandoned parts.
5. Checksum/size differs from declared metadata.
6. Presigned URL grants excessive duration/action.
7. Delete marker/versioning semantics misunderstood.
8. Listing used as authoritative transactional index.
9. Retention rule deletes needed data.
10. Object storage treated as low-latency random-access filesystem.
11. Egress/request cost omitted.

## Самопроверка

1. Block versus file versus object storage?
2. Object key versus filesystem path?
3. Why object/database update is not one ACID transaction?
4. What does multipart upload solve?
5. How checksum/ETag should be interpreted?
6. Why versioning changes deletion?
7. What is presigned URL risk?
8. How reconcile orphans?
9. Why listing is not a relational query/index?
10. Which costs dominate small versus large objects?

## Результат для базы знаний

- **Block, file and object storage abstractions**.
- **Object keys, metadata and checksums**.
- **Multipart upload lifecycle**.
- **Object versioning and retention**.
- **Presigned URLs and access scope**.
- **Database and object-store consistency workflow**.
- **Orphan reconciliation and garbage collection**.
- **Object-storage cost model**.

## Когда переходить дальше

Можно переходить, когда interrupted/cross-system failures are recoverable, object ownership cannot cross tenants, and lifecycle/cost semantics are verified against the tested service.