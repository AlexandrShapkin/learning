# Спринт 22. Конфигурация, локализация, кеширование и аудит

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как управлять environment-dependent behavior, languages, derived responses and business evidence without creating hidden mutable state or leaking sensitive context?

## Результат спринта

После завершения необходимо уметь:

- различать build-time, startup and runtime configuration;
- валидировать configuration and fail fast safely;
- управлять secrets separately from ordinary config;
- понимать feature flags and rollout state;
- избегать configuration drift and undocumented defaults;
- моделировать locale, language, time zone and formatting preferences;
- использовать stable translation keys/messages;
- обрабатывать pluralization, dates, numbers and currencies;
- проектировать server/client localization ownership;
- применять HTTP/application cache only with explicit key/freshness/invalidation;
- учитывать user/tenant/locale/auth variation in cache keys;
- различать audit event, application log and analytics event;
- создавать append-oriented audit records for important actions;
- сохранять actor, action, resource, outcome and correlation context;
- избегать sensitive payloads in logs/audit/cache;
- проектировать feature/config change audit;
- тестировать configuration/locale/cache variations;
- диагностировать stale config, wrong locale and cross-user cache leaks.

## Основной маршрут

### Шаг 1. Configuration lifecycle

Define source precedence, required values, defaults, secret references and reload policy. Most core config is immutable after startup unless safe dynamic behavior is deliberately designed.

### Шаг 2. Localization

Separate message identity from rendered text. Resolve locale through explicit user preference and supported fallback. Persist instants/semantic data, render in user context.

### Шаг 3. Caching

For each cached response/value define:

```text
source of truth
complete cache key
freshness and TTL
invalidation/version
private/public scope
failure and bypass behavior
```

### Шаг 4. Audit

Audit records answer who/what/which resource/when/result/source, not full request dumps. They must survive normal log rotation and be access-controlled.

## Ресурсы

- Go configuration and environment patterns.
- Unicode CLDR/ICU message formatting references.
- HTTP caching and `Vary` semantics.
- Redis/cache material from data-storage intensive.
- OWASP logging guidance and audit references.

## Практические задания

1. Build typed startup config with validation and safe diagnostics.
2. Add local secret references and rotation/reload scenario.
3. Localize UI/API presentation for two locales and time zones.
4. Test pluralization, currency and daylight-saving boundaries.
5. Cache a tenant/user/locale-sensitive response and reproduce a leak.
6. Add feature flag with explicit owner/expiry/default.
7. Implement audit events for privileged and state-changing operations.

## Лабораторная работа

Создать `work/application-crosscutting/`.

### Requirements

- config schema documents source, default and sensitivity;
- application refuses invalid/missing critical config;
- logs display names/status, never secret values;
- runtime config changes have version and audit where supported;
- feature flags include owner, purpose, default and removal condition;
- unsupported locale has deterministic fallback;
- API machine codes remain stable while human text can localize;
- dates/numbers/currency formatted at presentation boundary;
- cache keys include every user/tenant/locale/authorization dimension affecting output;
- private response cannot enter shared public cache;
- cache invalidation/versioning tested;
- audit records include actor, effective actor, tenant, action, resource, outcome and correlation ID;
- sensitive before/after values are minimized/redacted;
- audit access is restricted and retention defined.

### Failure scenarios

1. Secret has default committed in source.
2. Config reload partially updates related settings.
3. Feature flag becomes permanent undocumented branch.
4. Server/client translation keys diverge.
5. Timestamp stored/rendered as ambiguous local time.
6. Currency amount formatted with wrong currency/precision.
7. Cache key omits tenant/user/locale/permission.
8. `Vary`/authorization scope omitted from HTTP cache.
9. Audit and debug log are treated as same retention/access stream.
10. Audit records full tokens/personal payloads.
11. Admin impersonation audit lacks effective/original actor.

## Самопроверка

1. Build/startup/runtime config?
2. Why fail fast on invalid config?
3. Secret versus ordinary config?
4. Feature flag lifecycle?
5. Locale versus language/time zone?
6. Why persist semantic values, not formatted text?
7. What makes cache key complete?
8. Public versus private cache?
9. Audit event versus application log?
10. Which fields make privileged action auditable?

## Результат для базы знаний

- **Application configuration lifecycle and validation**.
- **Secrets and feature-flag lifecycle**.
- **Localization, locale, time zone and formatting**.
- **Application/HTTP cache key and invalidation contract**.
- **Private response caching and Vary semantics**.
- **Audit events versus logs and analytics**.
- **Actor, action, resource and outcome audit context**.

## Когда переходить дальше

Можно переходить, когда invalid configuration fails safely, localized behavior is deterministic, cache cannot cross identity/context boundaries, and important actions are auditable without sensitive payload leakage.