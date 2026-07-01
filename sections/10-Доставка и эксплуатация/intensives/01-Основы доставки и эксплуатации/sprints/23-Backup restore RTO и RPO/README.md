# Спринт 23. Backup, restore, RTO и RPO

Ориентировочный объём: 20–29 часов.

## Центральный вопрос

Как определить what must be backed up, how often, where, and how to prove that restoration meets business-relevant data-loss and recovery-time requirements?

## Результат спринта

После завершения необходимо уметь:

- identify authoritative persistent state and derived/rebuildable state;
- distinguish backup, snapshot, replica, archive and export;
- define RPO and RTO for specific failure scenarios;
- design full/incremental/logical/physical backup approaches;
- protect backup identity, encryption and retention;
- account for application consistency and quiescing/checkpoints;
- restore into isolated target;
- validate schema, configuration, keys and external dependencies;
- test point-in-time recovery and accidental deletion;
- measure real recovery time and data loss;
- define backup ownership, monitoring and failure response;
- avoid declaring success from backup job completion alone.

## Основной маршрут

1. Inventory PostgreSQL, object data, configuration, secrets references and deployment metadata.
2. Set RPO/RTO for deletion, corruption and full environment loss.
3. Implement logical/physical or snapshot/log backup combinations.
4. Restore to separate database/environment and verify application invariants.
5. Perform point-in-time recovery around a known destructive event.

## Лабораторная работа

Создать `work/backup-restore/`.

### Requirements

- backup scope states authoritative, derived and externally owned data;
- schedule/retention follows RPO and legal/lifecycle assumptions;
- backup is encrypted and access separated from production credentials;
- at least one copy crosses intended account/cluster/failure boundary;
- application-consistent point and transaction/log position are known;
- restore uses isolated target and documented dependencies;
- data counts/checksums plus business invariants are verified;
- measured RTO includes provisioning, keys, config, DNS/traffic and validation;
- measured RPO compares latest recoverable state with incident time;
- failed/corrupt/incomplete backup is detected;
- restore drill produces evidence and corrective action.

### Failure scenarios

1. Replica follows accidental deletion/corruption.
2. Snapshot is inaccessible after account/key failure.
3. Database restores but object files/config/secrets do not.
4. Backup job succeeds with truncated/unusable archive.
5. Restore overwrites active production-like environment.
6. Point-in-time recovery selects wrong timestamp/time zone.
7. RTO excludes approval, provisioning or traffic cutover.
8. Encryption key/permission is unavailable during restore.
9. Retention deletes last known-good recovery point.

## Результат для базы знаний

- **Backup, snapshot, replica, archive and restore**.
- **Recovery point and recovery time objectives**.
- **Application-consistent backups**.
- **Point-in-time recovery**.
- **Isolated restore verification**.
- **Backup retention, encryption and failure domains**.

## Когда переходить дальше

Можно переходить, когда an isolated restore reconstructs the service and verifies business invariants within measured RTO/RPO, including keys, configuration and traffic recovery.