# Спринт 12. Секреты, выдача, ротация и отзыв

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как выдавать workload and delivery credentials just in time, rotate and revoke them without embedding secrets in code, images, logs or long-lived pipeline state?

## Результат спринта

После завершения необходимо уметь:

- distinguish secret value, reference, identity and policy;
- use short-lived credentials and workload identity;
- separate build, deploy and runtime secret scopes;
- understand secret-at-rest encryption limitations;
- design issuance, access, audit, rotation and revocation lifecycle;
- use overlapping versions for zero/low-downtime rotation;
- prevent secret exposure in logs, artifacts, cache and process arguments;
- handle certificate/token expiration;
- design break-glass access and recovery credentials;
- test consumer reload/restart semantics;
- revoke compromised credential and assess blast radius;
- avoid static shared secrets across environments.

## Основной маршрут

1. Inventory pipeline, registry, database and provider credentials.
2. Replace one static deploy credential with OIDC/short-lived token.
3. Fetch runtime secret by workload identity/reference.
4. Rotate database/provider credential with overlap.
5. Revoke and validate recovery path.

## Лабораторная работа

Создать `work/secret-delivery/`.

### Requirements

- PR/build jobs cannot access deploy/runtime secrets;
- deployment identity is environment-scoped and short-lived;
- runtime receives secret reference/value only at required boundary;
- secret values do not appear in Git, image, SBOM, logs or retained artifacts;
- rotation supports old/new overlap and consumer convergence;
- revocation is tested without relying on cache expiry alone;
- secret version identifier is observable, value is not;
- expiration monitoring and ownership are explicit;
- break-glass access is audited, time-limited and separate;
- leaked test secret triggers automated detection and replacement exercise.

### Failure scenarios

1. Secret is masked in UI but present in artifact/log/state.
2. PR can print inherited environment secret.
3. One static key is shared by CI, humans and runtime.
4. Rotation disables old credential before all consumers reload.
5. Revocation leaves cached sessions valid unexpectedly.
6. Secret mounted as command-line argument appears in process list.
7. Backup/restore cannot access encrypted data after key loss.
8. Break-glass credential becomes routine automation path.

## Результат для базы знаний

- **Secret references, identities and values**.
- **Short-lived delivery and workload credentials**.
- **Secret issuance, rotation and revocation**.
- **Secret exposure in pipelines, artifacts and runtime**.
- **Break-glass and recovery credentials**.

## Когда переходить дальше

Можно переходить, когда every credential has a distinct owner/scope/lifetime, rotation and revocation are exercised, and no secret value is required in source or immutable artifacts.