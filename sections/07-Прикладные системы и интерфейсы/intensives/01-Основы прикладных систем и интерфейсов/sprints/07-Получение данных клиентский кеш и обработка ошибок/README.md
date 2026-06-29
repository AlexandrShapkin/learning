# Спринт 07. Получение данных, клиентский кеш и обработка ошибок

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как browser client получает server state, сохраняет responsive UI and handles stale, partial, failed or repeated requests without hiding uncertainty from the user?

## Результат спринта

После завершения необходимо уметь:

- различать server state and client UI state;
- проектировать query keys and cache identity;
- понимать freshness, staleness and invalidation;
- использовать cancellation and request deduplication;
- предотвращать stale-response overwrite;
- различать retryable transport error and business rejection;
- сохранять user input and operation context after failure;
- проектировать optimistic update with rollback/reconciliation;
- использовать pessimistic flow when uncertainty is unacceptable;
- понимать duplicate submit and idempotency dependency;
- создавать loading, empty, partial, stale and offline states;
- применять pagination/infinite loading without duplicate/missing items;
- учитывать authentication refresh/retry boundaries;
- использовать error boundaries only for rendering failures, not all errors;
- измерять client-perceived latency;
- тестировать slow, offline and malformed response cases.

## Основной маршрут

### Шаг 1. Query lifecycle

Define query identity, parameters, loading state, success data, staleness, refetch trigger, cancellation and error display.

### Шаг 2. Mutations

For every mutation state:

```text
user intent
pending representation
server acceptance/commit boundary
retry/idempotency behavior
optimistic rollback or reconciliation
success confirmation
unknown outcome handling
```

### Шаг 3. Error taxonomy

Separate validation, authorization, conflict, rate limit, server, network, timeout, abort and malformed-response errors. Preserve machine code and human context.

### Шаг 4. Degraded UX

Use throttling/offline simulation. Keep previous data when safe, label staleness, allow retry and avoid replacing complete page with generic spinner.

## Ресурсы

- Fetch API and AbortController docs.
- chosen client-query/cache library official docs after manual implementation.
- HTTP caching/error semantics.
- browser Network Information/offline docs only as optional hints.

## Практические задания

1. Implement query cache manually for one resource, then compare library behavior.
2. Cancel and deduplicate repeated search requests.
3. Add optimistic item update with forced conflict.
4. Preserve form values and map server field errors.
5. Build cursor pagination with duplicate protection.
6. Test offline, timeout, malformed JSON and delayed old response.

## Лабораторная работа

Создать `work/data-aware-client/` extending sprint 06.

### Requirements

- query keys include all parameters affecting result;
- concurrent identical requests are deduplicated where intended;
- canceled/stale response cannot overwrite current view;
- old data may remain visible only with explicit stale/pending indication;
- mutation uses idempotency key when repeat may reach server;
- optimistic update has rollback or authoritative refetch;
- validation errors map to fields and summary;
- permission/conflict/rate-limit errors have distinct UX;
- pagination preserves stable order and avoids duplicates;
- retry count/backoff is bounded;
- no automatic retry for unsafe/invalid operations without protocol;
- user timing markers record action-to-feedback and action-to-confirmed-result.

### Failure scenarios

1. Cache key omits tenant/filter and shows wrong data.
2. Old request completes last and overwrites new result.
3. Automatic retry duplicates create operation.
4. Optimistic item remains after server rejection.
5. Auth refresh loop retries forever.
6. Generic toast loses field/action context.
7. Spinner replaces useful stale data unnecessarily.
8. Pagination duplicates item after concurrent insertion.
9. Offline state reports “not found”.
10. Malformed success payload crashes renderer.
11. Error boundary catches network state incorrectly.

## Самопроверка

1. Server state versus UI state?
2. What makes a query key complete?
3. Fresh versus stale data?
4. Cancellation versus timeout?
5. When optimistic update is safe?
6. Why mutation retry needs idempotency?
7. Validation versus conflict error?
8. What is unknown outcome?
9. How cursor pagination can still duplicate?
10. Which latency does user perceive?

## Результат для базы знаний

- **Client server-state lifecycle**.
- **Query keys, freshness and invalidation**.
- **Request cancellation and deduplication**.
- **Optimistic updates and reconciliation**.
- **Application error taxonomy and contextual UX**.
- **Loading, stale, partial and offline states**.
- **Client pagination consistency**.
- **User-perceived latency measurement**.

## Когда переходить дальше

Можно переходить, когда client remains understandable under slow/offline/conflict conditions, mutations cannot duplicate silently, and stale/optimistic state always has an authoritative reconciliation path.