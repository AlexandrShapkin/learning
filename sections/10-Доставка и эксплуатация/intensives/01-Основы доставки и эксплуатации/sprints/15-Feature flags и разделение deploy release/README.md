# Спринт 15. Feature flags и разделение deploy/release

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Как use feature flags to integrate and deploy incomplete or risky behavior separately from user exposure without creating permanent conditional architecture and inconsistent states?

## Результат спринта

После завершения необходимо уметь:

- distinguish release, experiment, operational and permission flags;
- define flag owner, default, scope, expiry and removal;
- separate code deployment from feature activation;
- target cohorts consistently;
- understand server/client evaluation and cache/offline behavior;
- design safe defaults under flag-service failure;
- avoid flag combinations and state-space explosion;
- migrate data before activation;
- audit changes and emergency kill switches;
- test both states and transition behavior;
- remove flag and dead code after rollout;
- avoid using flags as authorization boundary.

## Основной маршрут

1. Hide a multi-commit feature behind a release flag.
2. Activate for internal cohort, then percentage/tenant cohort.
3. Simulate flag provider outage/stale cache.
4. Use an operational kill switch for a noncritical integration.
5. Remove the flag after full release.

## Лабораторная работа

Создать `work/feature-flags/`.

### Requirements

- flag registry includes type, owner, default, creation and expiry/removal trigger;
- targeting is deterministic and privacy-safe;
- old/new behavior can coexist with compatible data/contracts;
- missing/stale provider follows documented fail-open/fail-closed behavior;
- flag changes are audited and environment-scoped;
- tests cover disabled, enabled, transition and provider-failure states;
- kill switch reduces harm without corrupting state;
- metrics separate flag cohorts;
- removal deletes configuration, branches, tests and dead code;
- permission/security checks do not rely solely on feature flag.

### Failure scenarios

1. Flag defaults enabled in production unexpectedly.
2. Different service instances evaluate cohort inconsistently.
3. Flag service outage disables critical path without plan.
4. Old and new code write incompatible data.
5. Multiple flags create untested combinations.
6. Kill switch stops processing but leaves queue/backlog unmanaged.
7. Flag becomes permanent architecture/config debt.
8. Client-side flag exposes secret or enforces authorization.

## Результат для базы знаний

- **Feature flag types and lifecycle**.
- **Deployment versus release activation**.
- **Feature-flag targeting and evaluation consistency**.
- **Feature-flag failure defaults and kill switches**.
- **Feature-flag debt and removal**.

## Когда переходить дальше

Можно переходить, когда feature exposure can change independently from artifact deployment, failure/default behavior is tested, and a completed flag is removed entirely.