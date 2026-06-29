# Спринт 12. Валидация, ошибки, пагинация, идемпотентность и версии

Ориентировочный объём: 19–27 часов.

## Центральный вопрос

Как определить повторяемые cross-endpoint contracts for invalid input, conflicts, list traversal, repeated requests and compatible evolution?

## Результат спринта

После завершения необходимо уметь:

- различать syntax, shape, domain and authorization validation;
- возвращать machine-readable error categories;
- использовать Problem Details or equivalent error envelope;
- связывать field errors with client form paths;
- сохранять safe diagnostic/correlation identifiers;
- не раскрывать internal stack/SQL/provider details;
- выбирать offset and cursor pagination;
- проектировать stable sort and cursor encoding;
- определять filtering/search/sort grammar;
- использовать idempotency keys for unsafe retried operations;
- хранить request identity, fingerprint and result lifecycle;
- различать duplicate request and conflicting key reuse;
- проектировать optimistic concurrency conflicts;
- развивать schema additively;
- определять deprecation and compatibility window;
- использовать consumer/contract tests;
- понимать that URL versioning alone does not solve compatibility.

## Основной маршрут

### Шаг 1. Validation pipeline

```text
transport syntax/content type/body size
→ schema/type validation
→ authentication and authorization context
→ domain invariant/use-case validation
→ persistence/external constraints
```

Return errors at the layer that can explain and repair them safely.

### Шаг 2. Error contract

Define stable code/type, title/message, field issues, retryability, correlation ID and optional safe metadata. Localization of human text remains client/presentation concern unless server contract requires otherwise.

### Шаг 3. Lists

Offset is simple but unstable/expensive at scale. Cursor encodes stable ordering position; it must bind to relevant sort/filter/tenant context or be validated.

### Шаг 4. Idempotency and evolution

For create/payment/webhook-like requests, record key plus request fingerprint and completed/in-progress result. Compatible evolution requires old clients and stored payloads in tests.

## Ресурсы

- Problem Details for HTTP APIs specification.
- OpenAPI and JSON Schema validation rules.
- HTTP retry/idempotency semantics.
- database unique constraints/transactions from previous intensive.
- API compatibility and consumer-driven contract references.

## Практические задания

1. Create one error taxonomy shared across endpoints.
2. Map nested validation failures to accessible form fields.
3. Implement offset and cursor pagination, then mutate data between pages.
4. Add idempotency keys to create operation with concurrent duplicate requests.
5. Detect key reuse with different payload.
6. Evolve response/request through three compatible versions.
7. Create old-client contract suite.

## Лабораторная работа

Создать `work/api-contract-rules/`.

### Requirements

- malformed JSON, wrong content type and oversized body differ;
- field/domain/auth/conflict/rate-limit/internal errors have stable codes;
- errors include correlation ID and no sensitive internals;
- pagination order includes unique tie-breaker;
- cursor is opaque to clients and validated for scope;
- filtering/sorting allowlist prevents arbitrary internal-field exposure;
- idempotency record is transactionally coordinated with operation result;
- concurrent same-key requests return one logical result;
- same key/different payload returns conflict;
- in-progress/failed/expired key semantics are explicit;
- additive response changes do not break old client fixtures;
- field removal/semantic change has deprecation and migration plan;
- OpenAPI, server and clients share tested examples.

### Failure scenarios

1. Validation returns only “bad request”.
2. Internal database/provider message reaches client.
3. Pagination sort lacks unique tie key.
4. Cursor reused across tenant/filter and leaks/misorders data.
5. Offset page skips/duplicates after insert/delete.
6. Idempotency key stored after side effect and race duplicates work.
7. Same key silently accepts different body.
8. Retry receives cached success for wrong authenticated subject.
9. New required field breaks old client immediately.
10. Enum adds value and client exhaustive switch crashes.
11. Deprecated endpoint has no usage/retirement evidence.

## Самопроверка

1. Syntax versus domain validation?
2. What makes an error machine-readable?
3. Why keep correlation ID?
4. Offset versus cursor pagination?
5. Why stable unique order matters?
6. What does idempotency key identify?
7. Why store request fingerprint?
8. Duplicate in-progress request behavior?
9. Additive versus breaking API change?
10. Why URL version is insufficient?
11. How old-client fixtures prove compatibility?

## Результат для базы знаний

- **Application validation layers**.
- **Machine-readable API error contract**.
- **Problem Details and contextual field errors**.
- **Offset and cursor pagination**.
- **Stable ordering and cursor scope**.
- **Idempotency-key lifecycle and request fingerprint**.
- **API compatibility, deprecation and contract tests**.

## Когда переходить дальше

Можно переходить, когда clients can classify and display every failure, repeated requests produce one logical result under concurrency, and old-client tests survive compatible API evolution.