# Спринт 12. Secrets, keys, tokens, KMS и rotation

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как выдавать, использовать, обновлять и отзывать секреты и ключи так, чтобы компрометация имела ограниченный срок и область?

## Результат спринта

После завершения необходимо уметь:

- различать secret, key, token, certificate and identifier;
- inventory secret owners, consumers, scope and expiry;
- avoid secrets in source, image, logs and long-lived environment files;
- use secret manager and workload authentication;
- design generation, distribution, rotation and revocation;
- implement dual-read/single-write rotation patterns;
- handle token audiences, scopes and lifetimes;
- understand KMS/HSM/envelope-encryption roles;
- audit secret access without exposing values;
- respond to suspected compromise and historical leakage.

## Основной маршрут

1. Inventory all app/CI/platform secrets.
2. Move runtime secrets to local Vault/equivalent.
3. Replace one static credential with short-lived issuance.
4. Rotate DB, API and signing credentials without downtime.
5. Simulate repository/log leakage and revoke affected material.

## Лабораторная работа

Создать `work/secrets-lifecycle/`.

### Requirements

- inventory records owner, purpose, consumers, scope and expiry;
- workloads authenticate to secret store without shared root token;
- secret values never appear in Git, image history, process arguments or logs;
- rotation supports overlap where protocol requires;
- revocation invalidates active use within measured bounds;
- access events identify subject, secret path and result, not value;
- CI and runtime secrets are separated;
- backups/snapshots and old commits are included in compromise analysis;
- emergency rotation and dependency restart order are documented.

### Failure scenarios

1. Secret is removed from current file but remains in Git history.
2. Vault root/dev token is used by application.
3. Rotation breaks all replicas simultaneously.
4. Old credential remains valid after rollout.
5. Secret appears in command line or error log.
6. Token has broad audience/scope and long expiry.
7. Backup contains unrotated recoverable secret.

## Результат для базы знаний

- **Secret, key and token lifecycle**.
- **Secret managers and workload authentication**.
- **Credential rotation and revocation**.
- **KMS and envelope-encryption roles**.
- **Secret compromise response and historical leakage**.

## Когда переходить дальше

Можно переходить, когда every sensitive credential has bounded scope/lifetime and a tested rotation/revocation path.