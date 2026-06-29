# Спринт 23. Жизненный цикл, безопасность и удаление данных

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Как control who may access data, how long it exists and how it is deleted or archived without breaking integrity, audit or recovery obligations?

## Результат спринта

После завершения необходимо уметь:

- классифицировать data by sensitivity and lifecycle;
- применять least privilege through roles and grants;
- отделять application, migration, read-only and backup identities;
- использовать row-level security where justified;
- понимать authentication, TLS in transit and encryption-at-rest boundaries;
- управлять secrets outside source/config examples;
- проектировать audit trail without storing unnecessary sensitive payloads;
- применять data minimization and purpose limitation;
- определять retention and archival rules;
- различать soft delete, hard delete, tombstone and anonymization/pseudonymization;
- понимать deletion impact on replicas, caches, search, streams, objects and backups;
- проектировать subject/tenant deletion workflow;
- применять legal hold and deletion exceptions conceptually;
- использовать masking/tokenization for non-production data;
- избегать leaking data through logs, dumps, query plans and test fixtures;
- понимать backup retention conflict with immediate deletion promises;
- проверять access and deletion through end-to-end tests;
- документировать residual copies and recovery limitations.

## Основной маршрут

### Шаг 1. Data inventory and classification

For each field/dataset record owner, sensitivity, purpose, storage locations, derived copies, retention, access and deletion path.

### Шаг 2. Access control

Use separate database roles, schema/table/sequence/function privileges, default privileges and optional row-level security. Application authorization remains a separate layer.

### Шаг 3. Lifecycle

Model active, archived, deleted and held states. Define whether history remains, is anonymized or is physically removed.

### Шаг 4. Cross-store deletion

A deletion request becomes a tracked workflow across source database, cache, search, object storage, analytics and event-derived views. Verification must detect residual active copies.

## Ресурсы

- PostgreSQL authentication, roles, privileges and row-level security docs.
- PostgreSQL SSL/TLS and logging/auditing docs.
- OWASP database/data-protection guidance.
- NIST or recognized data-lifecycle and backup-security guidance.
- Official encryption, retention and access-control docs for auxiliary stores.

## Практические задания

1. Create separate runtime, migration, reporting and backup roles.
2. Test default privileges and accidental public access.
3. Implement tenant isolation with schema/key and optional RLS comparison.
4. Build sensitive-field inventory and retention matrix.
5. Implement delete/anonymize/archive workflow across stores.
6. Generate sanitized development dataset.
7. Audit logs for secret/PII leakage.
8. Test expired credentials and access revocation.

## Лабораторная работа

Создать `work/data-security-lifecycle/`.

### Components

- PostgreSQL roles and grants;
- tenant-aware Go service;
- optional row-level security policy;
- cache/search/object/event projections;
- deletion workflow and verifier;
- archive/retention worker;
- masked fixture generator;
- audit and access tests.

### Requirements

- no superuser credentials used by application;
- migration identity separated from runtime identity;
- secrets loaded from ignored/local mechanism;
- TLS enabled for networked lab services where practical;
- unauthorized tenant reads/writes rejected at multiple relevant boundaries;
- deletion command idempotent and restartable;
- derived stores receive deletion/tombstone updates;
- object versions and broker retention considered;
- backup residuals and restore re-deletion process documented;
- logs/plans/errors do not expose sensitive values;
- retention worker uses explicit policy and dry-run/report mode;
- legal hold or preservation flag prevents deletion where modeled.

### Failure scenarios

1. Application role can alter schema or read all tenants.
2. Default privileges expose new table.
3. RLS policy missing for one command/table.
4. Connection/log string leaks password or personal data.
5. Soft-deleted row remains in search/cache.
6. Object version remains accessible after logical delete.
7. Replay restores deleted projection.
8. Backup restore resurrects data without deletion reconciliation.
9. Retention job deletes wrong tenant/time range.
10. Test environment contains production dump.
11. Encryption claimed without key-management/recovery model.
12. Audit captures full sensitive payload unnecessarily.

## Самопроверка

1. Authentication versus authorization?
2. Least privilege for application/migration?
3. What does RLS protect and not protect?
4. Encryption in transit versus at rest?
5. Soft delete versus hard delete?
6. Anonymization versus pseudonymization?
7. Why deletion is cross-store workflow?
8. How backups complicate deletion?
9. What is data minimization?
10. How verify retention/deletion safely?

## Результат для базы знаний

- **Database roles and least privilege**.
- **Row-level security and tenant isolation**.
- **Encryption and secret boundaries**.
- **Data classification and lifecycle**.
- **Soft delete, hard delete and anonymization**.
- **Cross-store deletion and tombstones**.
- **Backup retention and deletion reconciliation**.
- **Sensitive-data logging and test-data masking**.

## Когда переходить дальше

Можно переходить, когда access tests prove least privilege, deletion is restartable across all derived stores, and residual backup/history behavior is stated honestly.