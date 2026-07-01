# Спринт 09. Окружения, parity и продвижение артефактов

Ориентировочный объём: 16–24 часа.

## Центральный вопрос

Как разделить development, staging and production-like environments without rebuilding artifacts or hiding important differences in data, identity, scale and failure behavior?

## Результат спринта

После завершения необходимо уметь:

- определять purpose and acceptance criteria of each environment;
- различать parity of mechanism from identical scale/data;
- продвигать one immutable artifact through environments;
- separate artifact, configuration and secret revisions;
- design environment ownership, credentials and state isolation;
- manage ephemeral preview environments;
- understand environment drift and reset/rebuild strategies;
- seed synthetic data safely;
- distinguish test environment confidence from production certainty;
- avoid environment-specific code branches;
- verify deployed artifact/config/migration identity;
- clean temporary environments without touching shared state.

## Основной маршрут

1. Define dev, staging and production-like contracts.
2. Deploy one digest with different external configuration.
3. Create and destroy a preview environment for a pull request.
4. Introduce environment drift and compare repair versus rebuild.

## Лабораторная работа

Создать `work/environments/`.

### Requirements

- environment manifest identifies artifact, config, secret and schema revisions;
- artifact digest is identical across promotion;
- credentials and state are isolated;
- staging uses same deployment mechanism and critical dependencies/contracts;
- scale differences and resulting confidence limits are documented;
- preview environment has owner, TTL and automatic cleanup;
- synthetic data reset is deterministic;
- manual drift is detected and reconciled;
- environment-specific behavior comes from validated config, not conditional builds;
- production-like verification checks exact running revision.

### Failure scenarios

1. Staging rebuilds image from source.
2. Production uses a hidden config value never tested elsewhere.
3. Preview environment shares database/credentials with staging.
4. Manual hotfix creates unreproducible environment drift.
5. Staging success is treated as proof under production scale/data.
6. Cleanup deletes shared namespace/database.
7. Environment name controls code path at compile time.
8. Deployment status does not expose artifact/config/schema revisions.

## Результат для базы знаний

- **Software delivery environments and parity**.
- **Immutable artifact promotion across environments**.
- **Environment configuration, identity and state isolation**.
- **Ephemeral preview environments and cleanup**.
- **Environment drift and rebuild strategies**.

## Когда переходить дальше

Можно переходить, когда the same digest moves through isolated environments and every meaningful difference is explicit in configuration, data, scale or dependency contract.