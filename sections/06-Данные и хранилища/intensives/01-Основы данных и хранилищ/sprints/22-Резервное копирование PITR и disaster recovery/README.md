# Спринт 22. Резервное копирование, PITR и disaster recovery

Ориентировочный объём: 20–30 часов.

## Центральный вопрос

Какие copies and recovery procedures are required to meet an explicit RPO/RTO, и как доказать восстановимость instead of assuming backup exists?

## Результат спринта

После завершения необходимо уметь:

- определять RPO, RTO and recovery scope;
- различать logical dump, physical base backup, snapshot and replica;
- понимать why replication is not backup;
- создавать `pg_dump`/`pg_restore` workflows;
- создавать physical base backup;
- настраивать WAL archiving and point-in-time recovery;
- понимать timeline and recovery target concepts;
- выбирать full, incremental/differential concepts where supported;
- проектировать backup retention and rotation;
- шифровать backups and separate credentials;
- хранить copies in independent failure domain;
- проверять integrity, completeness and restore time;
- выполнять restore to isolated target;
- восстанавливать related services and object/search/broker state deliberately;
- понимать application consistency across multiple stores;
- проектировать restore order and reconciliation;
- документировать disaster scenarios and decision points;
- проводить scheduled restore drills;
- оценивать backup storage, transfer and operational cost;
- диагностировать missing WAL, corrupt dump, incompatible version and insufficient capacity.

## Основной маршрут

### Шаг 1. Recovery objectives

For each data class define:

```text
maximum acceptable loss (RPO)
maximum acceptable downtime (RTO)
retention and historical points
scope: row/table/database/cluster/site
security and legal requirements
verification frequency
```

### Шаг 2. Logical and physical backups

Compare portability, granularity, speed, size, version constraints and recovery procedure.

### Шаг 3. PITR

Create base backup, archive WAL, generate changes, choose target time/LSN/transaction and restore to a new cluster. Verify timeline and application state.

### Шаг 4. Full-system recovery

Recover database first or according to dependency plan, then rebuild/reconcile cache, search and derived projections. Object store and broker require their own backup/lifecycle strategy.

## Ресурсы

- PostgreSQL backup, restore, continuous archiving and PITR docs.
- PostgreSQL `pg_dump`, `pg_restore`, `pg_basebackup` docs.
- DDIA durability/recovery sections.
- Reliable disaster-recovery and backup-security guidance.
- Official backup/snapshot docs for auxiliary stores used in lab.

## Практические задания

1. Create logical dump in custom/directory format and selective restore.
2. Create physical base backup and new cluster restore.
3. Configure WAL archive with verification.
4. Restore to point before accidental deletion.
5. Measure backup/restore duration and size.
6. Encrypt and rotate backups.
7. Rebuild cache/search projections after restore.
8. Test missing/corrupt WAL and insufficient disk cases.

## Лабораторная работа

Создать `work/backup-recovery-lab/`.

### Scenarios

- accidental row/table deletion;
- bad migration;
- database volume loss;
- primary and replica unavailable;
- object metadata/database mismatch;
- corrupted or incomplete latest backup;
- recovery to alternate infrastructure/version-compatible target.

### Requirements

- synthetic dataset with independent checksums and sequence history;
- documented RPO/RTO target per scenario;
- logical and physical backup paths;
- PITR with archived WAL;
- backups stored outside active database volume;
- encryption keys/secrets not committed with backup;
- restore always goes to isolated target first;
- validation checks schema, counts, checksums and application workflows;
- derived caches/search indexes rebuilt and reconciled;
- restore timing captured from clean start;
- retention cleanup cannot delete all usable recovery chains;
- drill can be rerun from scripts.

### Failure scenarios

1. Replica is treated as backup and corruption replicates.
2. Dump command succeeds but file is truncated/unreadable.
3. Base backup exists but required WAL segment is missing.
4. Backup and encryption key share one failure domain.
5. Restore target lacks disk or compatible extensions.
6. Latest backup contains bad migration/data.
7. PITR target chosen after destructive transaction.
8. Search/cache restored independently and contradict source.
9. Retention removes base backup needed by WAL chain.
10. Backup includes secrets or broad personal data.
11. RTO estimate excludes transfer/rebuild/verification.
12. Restore procedure only exists as undocumented manual memory.

## Самопроверка

1. RPO versus RTO?
2. Logical versus physical backup?
3. Why replica is not backup?
4. What is base backup plus WAL archive?
5. What can PITR target?
6. Why restore to isolated environment?
7. How verify backup completeness?
8. How auxiliary derived stores recover?
9. Why retention must preserve recovery chain?
10. What determines restore time?

## Результат для базы знаний

- **RPO, RTO and recovery scope**.
- **Logical and physical database backups**.
- **Base backup, WAL archive and PITR**.
- **Backup retention and recovery chains**.
- **Encrypted and isolated backup storage**.
- **Restore validation and drills**.
- **Recovery of multi-store systems**.
- **Replication versus backup**.

## Когда переходить дальше

Можно переходить, когда a clean isolated restore meets measured RPO/RTO assumptions, PITR survives a destructive scenario, and every required artifact/key/dependency is verified.