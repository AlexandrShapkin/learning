# Спринт 11. REST и проектирование HTTP API

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как выразить application resources and operations через HTTP semantics так, чтобы clients could understand behavior, caching, safety and failures without implementation knowledge?

## Результат спринта

После завершения необходимо уметь:

- определять resources and representations;
- выбирать URI structure without encoding actions everywhere;
- использовать GET, POST, PUT, PATCH and DELETE semantics;
- различать safe and idempotent methods;
- выбирать status codes by observable outcome;
- использовать request/response headers deliberately;
- проектировать content negotiation and media types at practical level;
- понимать conditional requests and ETag overview;
- применять caching headers for public/private responses;
- отличать resource state from command/action resource;
- создавать OpenAPI contract;
- генерировать docs/client only as contract derivative;
- проектировать links/location and asynchronous acceptance;
- избегать leaking database schema into public API;
- обеспечивать stable naming and identifiers;
- тестировать API semantics against contract.

## Основной маршрут

### Шаг 1. Resources

Model items, orders, attachments, jobs and webhook subscriptions. An operation that does not map cleanly to CRUD may be represented as command/subresource with explicit lifecycle.

### Шаг 2. HTTP methods/statuses

For each endpoint define safety, idempotency, preconditions, success codes, empty behavior, conflict and asynchronous result.

### Шаг 3. Representations

Define JSON field semantics, exact time/money/ID types, optional/null behavior, links and version compatibility. Avoid exposing internal table names or unbounded nested graphs.

### Шаг 4. Executable contract

Write OpenAPI, validate examples and run contract tests against server and TypeScript client.

## Ресурсы

- HTTP Semantics and Caching RFCs.
- OpenAPI Specification.
- JSON Schema.
- REST architectural style/background.
- MDN HTTP method/status/header references.

## Практические задания

1. Convert RPC-like endpoints into resource-oriented API.
2. Design create/read/update/delete and action subresources.
3. Add conditional update with ETag/If-Match or version field.
4. Define async job resource with `202 Accepted` and status location.
5. Write OpenAPI examples and negative cases.
6. Generate client, then verify it does not replace semantic review.

## Лабораторная работа

Создать `work/http-api/` over application core.

### API surface

```text
/v1/items
/v1/items/{id}
/v1/items/{id}/status-transitions
/v1/items/{id}/attachments
/v1/jobs/{id}
/v1/webhook-subscriptions
```

### Requirements

- URI/method/status semantics documented;
- GET/HEAD do not mutate business state;
- PUT/PATCH behavior and missing fields are explicit;
- delete semantics distinguish immediate, accepted and already absent;
- `Location` used for created/accepted resources where appropriate;
- representations use stable external names/IDs;
- list responses bounded;
- cacheability/private data headers explicit;
- conditional update prevents lost overwrite where required;
- OpenAPI passes validation;
- examples are executable tests;
- server and generated/manual client conform to same contract.

### Failure scenarios

1. GET endpoint triggers state change.
2. POST retried and duplicates resource with no idempotency protocol.
3. `200` returned for every outcome.
4. `204` response includes body or client expects one.
5. PATCH null/absent semantics are ambiguous.
6. Database row/schema exposed directly.
7. Async operation returns success before result without job resource.
8. Cache header allows shared caching of private response.
9. ETag/version ignored during concurrent update.
10. OpenAPI differs from running server.

## Самопроверка

1. Resource versus representation?
2. Safe versus idempotent method?
3. PUT versus PATCH?
4. `201`, `202`, `204` meanings?
5. When command subresource is justified?
6. What does `Location` represent?
7. Conditional request solves what?
8. HTTP cacheability belongs where?
9. Why API should not mirror database schema?
10. What makes OpenAPI executable contract?

## Результат для базы знаний

- **HTTP resources and representations**.
- **HTTP method safety and idempotency**.
- **REST API URI and operation design**.
- **HTTP status and header semantics**.
- **Conditional requests and optimistic concurrency**.
- **Asynchronous job resources**.
- **OpenAPI as executable interface contract**.
- **API representation versus database model**.

## Когда переходить дальше

Можно переходить, когда every endpoint has justified HTTP semantics, contract examples execute against the server, and concurrent/asynchronous outcomes are represented explicitly.