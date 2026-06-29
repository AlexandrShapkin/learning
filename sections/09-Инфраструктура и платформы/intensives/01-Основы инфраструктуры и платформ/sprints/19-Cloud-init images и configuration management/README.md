# Спринт 19. Cloud-init, images и configuration management

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Which configuration belongs in immutable image, first-boot bootstrap, ongoing configuration management or application deployment, and how to avoid snowflake hosts and endless boot scripts?

## Результат спринта

После завершения необходимо уметь:

- различать image baking, bootstrapping and configuration management;
- использовать cloud-init stages and instance data safely;
- создавать immutable/golden image pipeline conceptually/practically;
- применять Ansible idempotently;
- выбирать push/pull and agentless/agent approaches;
- отделять host baseline from application release;
- управлять package repositories and version pinning;
- понимать mutable host drift;
- проектировать rebuild instead of in-place repair where appropriate;
- хранить secrets outside images/user-data;
- учитывать first-boot retries and partial failure;
- тестировать image and configuration before promotion;
- выполнять rolling image replacement;
- избегать one giant cloud-init script as permanent management layer.

## Основной маршрут

1. Configure a VM using only cloud-init, observe limitations and rerun semantics.
2. Build a base image with OS packages/users/hardening baseline.
3. Apply Ansible role for runtime configuration and verify idempotence.
4. Compare mutable patching and immutable replacement.
5. Simulate failed first boot and image rollback.

## Ресурсы

- cloud-init docs;
- Ansible docs;
- optional Packer/image-builder docs;
- provider image lifecycle docs.

## Лабораторная работа

Создать `work/image-config-management/`.

### Requirements

- base image source/checksum/build definition is versioned;
- image contains no environment secrets or unique machine identity;
- cloud-init handles identity/network/bootstrap only and is bounded;
- Ansible roles are idempotent and report real changes;
- host baseline and application deployment are separate;
- package versions/repos are controlled;
- failed bootstrap is detectable and recoverable by replacement;
- image tests verify boot, SSH, storage/network/runtime prerequisites;
- rolling replacement preserves service and external state;
- drift detection compares expected host baseline;
- old images have retention/removal policy;
- configuration inventory contains no production data.

### Failure scenarios

1. User-data contains long-lived secret and is visible in metadata/logs.
2. cloud-init script partially succeeds and rerun duplicates actions.
3. Golden image contains machine ID/SSH host keys.
4. Ansible task always reports changed or is non-idempotent.
5. Manual SSH fixes create snowflake host.
6. Image replacement loses local application data.
7. Package update changes behavior without image/config revision.
8. Host baseline and app version cannot evolve independently.

## Самопроверка

1. Image bake versus bootstrap versus config management?
2. cloud-init lifecycle/idempotence limitations?
3. Immutable infrastructure meaning?
4. Ansible idempotence?
5. Host baseline versus application deployment?
6. Why no secrets in image/user-data?
7. Snowflake host?
8. Rebuild versus in-place repair?
9. Image promotion/testing?
10. Drift detection and retirement?

## Результат для базы знаний

- **Infrastructure image, bootstrap and configuration-management boundaries**.
- **cloud-init lifecycle and failure handling**.
- **Golden images and immutable replacement**.
- **Ansible idempotence and host configuration**.
- **Snowflake hosts and configuration drift**.
- **Host baseline versus application release**.

## Когда переходить дальше

Можно переходить, когда a host is reproduced from tested image plus bounded bootstrap/configuration, repeated automation converges, and manual repair is replaced by observable rebuild paths.