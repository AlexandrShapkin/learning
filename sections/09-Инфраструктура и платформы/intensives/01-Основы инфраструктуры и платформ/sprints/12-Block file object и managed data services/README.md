# Спринт 12. Block, file, object и managed data services

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как выбрать storage/data service by access semantics, durability, consistency, performance, lifecycle and recovery requirements rather than by product category alone?

## Результат спринта

После завершения необходимо уметь:

- различать block, file and object storage interfaces;
- понимать durability, availability and consistency as separate properties;
- выбирать local/ephemeral versus network/persistent storage;
- понимать attachment, mount and multi-writer constraints;
- учитывать IOPS, throughput, latency and queue depth;
- проектировать object key, metadata, versioning and lifecycle;
- понимать replication scope and failure domain;
- выбирать managed database/cache/queue by contract and operations transferred;
- оценивать backup, point-in-time recovery and restore ownership;
- учитывать encryption keys and access policies;
- проектировать data movement and egress cost;
- избегать treating snapshots/replicas as backups;
- проверять restore, not only backup creation.

## Основной маршрут

1. Run the same data patterns on virtual block disk, NFS-like file share and S3-compatible object store.
2. Measure small random, sequential and metadata-heavy workloads.
3. Map PostgreSQL, cache and object workloads to self-managed and managed options.
4. Test deletion, versioning, snapshot and independent restore paths.

## Ресурсы

- provider block/file/object storage docs;
- S3-compatible API concepts;
- managed database backup/restore docs;
- storage performance material from earlier intensives.

## Лабораторная работа

Создать `work/cloud-storage/`.

### Requirements

- access/consistency/performance matrix for block, file and object;
- benchmark parameters and cache conditions recorded;
- block resize and filesystem growth tested;
- file share concurrent access and locking semantics observed;
- object versioning/lifecycle and multipart upload cleanup tested;
- managed-service responsibility and limits documented;
- restore to separate target proves recovery;
- encryption and identity boundary stated;
- replica/snapshot/backup distinctions explicit;
- data transfer and retention cost model included;
- cleanup removes snapshots, versions and detached volumes safely.

### Failure scenarios

1. Shared block disk is attached read-write to unsupported multiple writers.
2. File storage latency/metadata bottleneck surprises application.
3. Object store is treated as POSIX filesystem.
4. Versioning retains deleted data and unexpected cost.
5. Replica follows accidental deletion/corruption.
6. Snapshot is in same account/region/failure boundary.
7. Backup exists but restore permissions/keys are unavailable.
8. Managed database reaches connection/storage/IO limit.

## Самопроверка

1. Block, file and object interfaces?
2. Durability versus availability?
3. IOPS versus throughput?
4. Object consistency/lifecycle questions?
5. Replica versus backup?
6. Snapshot versus point-in-time recovery?
7. Multi-writer constraints?
8. Managed database transfers which work?
9. Why restore testing is mandatory?
10. Data transfer/retention cost sources?

## Результат для базы знаний

- **Block, file and object storage semantics**.
- **Storage durability, availability and consistency**.
- **IOPS, throughput, latency and queueing**.
- **Object versioning and lifecycle**.
- **Managed data-service responsibility boundary**.
- **Replica, snapshot, backup and restore**.

## Когда переходить дальше

Можно переходить, когда storage choices are tied to measured access patterns and a separate restore target proves recovery across intended failure boundaries.