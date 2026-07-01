# Спринт 11. Конфигурация и параметры окружений

Ориентировочный объём: 16–24 часа.

## Центральный вопрос

Как управлять configuration independently from artifact while preserving schema, ownership, validation, rollout and rollback semantics?

## Результат спринта

После завершения необходимо уметь:

- distinguish code, configuration, secret and operational state;
- define typed configuration schema and defaults;
- validate required, optional and mutually dependent fields;
- understand startup-only versus dynamic configuration;
- version configuration independently and correlate with deployment;
- design layered configuration without precedence ambiguity;
- avoid environment-name conditionals and hidden mutable values;
- test invalid/missing config before rollout;
- roll out config changes with health criteria;
- handle config rollback when state/behavior changed;
- detect configuration drift;
- expose nonsecret effective configuration safely.

## Основной маршрут

1. Inventory all current constants/env/files/flags.
2. Create one schema with validation and documented ownership.
3. Separate startup and reloadable parameters.
4. Deploy same artifact with different config revisions.
5. Introduce invalid and semantically dangerous changes.

## Лабораторная работа

Создать `work/configuration-delivery/`.

### Requirements

- configuration schema is versioned and machine-validated;
- precedence between defaults, files, environment and flags is explicit;
- unknown/deprecated fields follow documented policy;
- startup fails fast for invalid critical config;
- dynamic reload is atomic or safely rejected;
- nonsecret config revision is visible in runtime metadata;
- config changes have review, promotion and rollback path;
- configuration and artifact can be changed independently but correlated;
- drift detector compares desired and effective state;
- tests cover old artifact/new config and new artifact/old config where supported.

### Failure scenarios

1. Typo silently falls back to unsafe default.
2. Multiple config layers override each other unexpectedly.
3. Dynamic reload leaves half-applied state.
4. Config rollback is incompatible with migrated data/new artifact.
5. Environment name changes behavior through hidden code branch.
6. Manual runtime edit creates drift.
7. Effective config endpoint leaks secret.
8. Deprecated option remains indefinitely with conflicting meaning.

## Результат для базы знаний

- **Application configuration lifecycle and schema**.
- **Configuration precedence and validation**.
- **Startup and dynamic configuration**.
- **Configuration revision, rollout and drift**.
- **Artifact/configuration compatibility**.

## Когда переходить дальше

Можно переходить, когда configuration changes are validated, versioned, observable and independently promotable without hidden precedence or secret leakage.