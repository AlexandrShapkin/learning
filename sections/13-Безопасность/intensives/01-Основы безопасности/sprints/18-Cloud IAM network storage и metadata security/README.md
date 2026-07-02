# Спринт 18. Cloud IAM, network, storage и metadata security

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как проектировать cloud-like access so that identities, metadata services, storage and network controls remain least-privilege and auditable?

## Результат спринта

После завершения необходимо уметь:

- distinguish human, workload and control-plane identities;
- design role assumption and short-lived credentials;
- avoid static cloud access keys;
- scope resource policies and trust policies;
- protect metadata/instance identity endpoints;
- configure public/private network and storage exposure;
- apply encryption and key-policy separation;
- log control-plane and data-access events;
- understand organization/account/project boundaries;
- manage break-glass and cross-account access;
- evaluate common-mode cloud dependencies.

## Основной маршрут

1. Simulate cloud accounts/projects and workload roles locally or in provider sandbox.
2. Replace static keys with short-lived role/workload credentials.
3. Restrict object storage and metadata access.
4. Add control-plane and data-access logging.
5. Test cross-account/project and public-exposure failures.

## Лабораторная работа

Создать `work/cloud-security/`.

### Requirements

- no long-lived root/owner credentials are used by workloads;
- trust and permission policies are separate and least-privilege;
- storage is private by default and public access requires explicit review;
- metadata credentials are inaccessible from untrusted request paths;
- network paths use private endpoints where justified;
- encryption keys have separate administration/use permissions;
- control-plane changes and sensitive data reads are auditable;
- cross-account/project roles have external conditions and expiry;
- break-glass actions are logged and reviewed;
- one cloud dependency/failure-domain risk is documented.

### Failure scenarios

1. Static access key is stored in CI or image.
2. Trust policy allows arbitrary principal assumption.
3. Object storage becomes public through ACL/policy interaction.
4. SSRF-like path reaches metadata credentials.
5. Encryption key administrators can silently read all data.
6. Control-plane logs omit data-access events.
7. Organization-wide role is overly broad.

## Результат для базы знаний

- **Cloud IAM roles and short-lived credentials**.
- **Cloud trust policies and resource policies**.
- **Cloud metadata-service protection**.
- **Cloud storage exposure and encryption-key separation**.
- **Cloud audit logging and account boundaries**.

## Когда переходить дальше

Можно переходить, когда static credentials/public exposure/metadata access are eliminated or explicitly bounded and cloud actions are attributable.