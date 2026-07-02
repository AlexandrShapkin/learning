# Спринт 13. Data classification, encryption, retention и privacy

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Какие данные действительно нужны системе, где они находятся, кому доступны и когда должны быть удалены?

## Результат спринта

После завершения необходимо уметь:

- classify public, internal, confidential and restricted data;
- inventory data stores, flows, copies and processors;
- apply minimization and purpose limitation;
- choose field, record, volume and transport encryption appropriately;
- distinguish encryption from access control and deletion;
- design retention and deletion schedules;
- handle backups, logs, analytics and derived data;
- apply pseudonymization/tokenization where useful;
- define data-subject or business deletion semantics;
- measure data exposure and residual metadata risk;
- document privacy and lawful-use assumptions for synthetic organization.

## Основной маршрут

1. Create data inventory and flow map.
2. Classify fields and determine collection purpose.
3. Remove or tokenize unnecessary identifiers.
4. Encrypt selected fields through envelope encryption.
5. Implement retention and deletion across primary, logs and backups simulation.

## Лабораторная работа

Создать `work/data-protection/`.

### Requirements

- each sensitive field has purpose, owner, access and retention;
- unnecessary collection is removed before adding encryption;
- encryption keys are separated from encrypted data;
- search/index/reporting trade-offs are documented;
- logs/traces exclude or redact restricted fields;
- deletion covers replicas, caches, queues and derived records where applicable;
- backup retention and restore re-deletion procedure are defined;
- access to restricted data is audited;
- metadata and correlation risks remain explicit;
- one data breach scenario quantifies affected records and controls.

### Failure scenarios

1. Encryption is used while every service retains decryption access.
2. Sensitive field is copied into logs/analytics indefinitely.
3. Deletion affects primary DB only.
4. Backup restore resurrects deleted records.
5. Pseudonymous identifier is easily re-linked.
6. Retention policy has no enforcement/test.
7. Application collects data with no purpose.

## Результат для базы знаний

- **Data classification and inventories**.
- **Data minimization and purpose limitation**.
- **Field, storage and transport encryption**.
- **Data retention, deletion and backup restoration**.
- **Pseudonymization and metadata privacy risks**.

## Когда переходить дальше

Можно переходить, когда sensitive data locations, purposes, access, encryption and deletion can be demonstrated end to end.