# Спринт 20. Webhooks и внешние интеграции

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как взаимодействовать с independent external system, предполагая timeouts, retries, duplicates, reordering, partial outages and incompatible data?

## Результат спринта

После завершения необходимо уметь:

- различать synchronous API call, webhook and asynchronous event integration;
- создавать adapter/anti-corruption mapping between models;
- задавать connect, TLS, response and total deadlines;
- применять retry only to eligible operations;
- использовать exponential backoff and jitter;
- понимать ambiguous outcome after connection loss;
- применять idempotency keys and provider request IDs;
- проектировать circuit breaker and concurrency/bulkhead limits conceptually;
- ограничивать queues and in-flight calls;
- валидировать external responses as untrusted data;
- реализовывать inbound webhook signature verification;
- проверять timestamp/replay window and raw request body;
- deduplicate webhook event IDs;
- учитывать out-of-order events and authoritative fetch/reconciliation;
- отвечать webhook sender quickly and process durably;
- проектировать subscription lifecycle and secret rotation;
- сохранять integration audit without sensitive payload leakage;
- использовать sandbox/mock server and fault injection;
- диагностировать provider, network and local adapter failures separately.

## Основной маршрут

### Шаг 1. Integration contract

For every dependency define operations, timeout budget, idempotency, rate limits, retry guidance, authentication, versioning, data ownership and reconciliation endpoint.

### Шаг 2. Outbound call

```text
validate local preconditions
→ create durable operation/request ID
→ bounded call with deadline
→ classify response/ambiguous failure
→ persist result or schedule reconciliation
```

### Шаг 3. Inbound webhook

Read bounded raw body, verify signature/timestamp/endpoint secret, parse as unknown, store/deduplicate event, return promptly, process in background and reconcile order/version.

### Шаг 4. Failure control

Bound retries, queue and concurrency. Circuit breaker may reduce useless calls but cannot prove provider state; recovery still needs probe/reconciliation.

## Ресурсы

- HTTP client and TLS docs in Go.
- provider webhook signing documentation for sandbox example.
- OWASP webhook/API security guidance.
- Amazon Builders’ Library timeout/retry/backoff articles.
- Enterprise Integration Patterns and DDIA selected sections.

## Практические задания

1. Build fake provider with delay, reset, 429, 5xx and malformed responses.
2. Implement timeout budget and retry classifier.
3. Reproduce ambiguous create outcome and reconcile by idempotency key.
4. Implement signed inbound webhook with key rotation.
5. Deliver duplicate and out-of-order events.
6. Add bounded circuit/concurrency control.
7. Compare webhook, polling and direct synchronous call.

## Лабораторная работа

Создать `work/integration-lab/`.

### Integration

Synthetic payment/shipping/document-analysis provider:

- create external operation;
- query operation status;
- receive signed status webhook;
- cancel where supported;
- rotate credentials/webhook secret;
- enforce rate limits.

### Requirements

- dedicated adapter translates external/internal models;
- all calls have explicit total/dependency deadlines;
- request body and response size bounded;
- retry policy based on operation and status, not “all errors”;
- idempotency key reused for retry of same logical request;
- ambiguous outcome enters reconciliation state;
- webhook verification uses exact raw body and constant-time signature comparison where appropriate;
- timestamp tolerance/replay protection;
- old/new secrets overlap for bounded rotation window;
- event ID deduplicated;
- aggregate/provider version handles reordering;
- webhook handler durably records before acknowledgement;
- queue/concurrency/rate-limit behavior bounded;
- logs redact secrets and sensitive payloads;
- provider outage does not exhaust application pool/workers.

### Failure scenarios

1. HTTP client has no timeout.
2. Automatic retry duplicates provider operation.
3. Connection reset after provider commit is treated as definite failure.
4. Retry storm follows 429/5xx outage.
5. Circuit opens but queued work grows without bound.
6. Webhook signature verified after JSON reserialization.
7. Replay uses old valid signed event.
8. Event delivered twice repeats business effect.
9. Older status arrives after newer and regresses state.
10. Webhook returns 200 before durable receipt.
11. Provider model leaks into core business model everywhere.
12. Secret rotation causes gap or accepts old secret forever.

## Самопроверка

1. Sync call versus webhook versus event?
2. Timeout budget components?
3. Which operations are retryable?
4. What is ambiguous outcome?
5. Idempotency key role with provider?
6. Backoff and jitter?
7. Circuit breaker solves what and not what?
8. Why verify raw webhook body?
9. How prevent replay/duplicate effects?
10. How handle out-of-order events?
11. What is reconciliation?

## Результат для базы знаний

- **Synchronous and webhook integration styles**.
- **External API timeout and retry budgets**.
- **Ambiguous outcome and reconciliation**.
- **Integration adapters and model translation**.
- **Webhook signature, timestamp and replay protection**.
- **Webhook deduplication and event ordering**.
- **Circuit breaker, bulkhead and bounded retry**.
- **External integration audit and secret rotation**.

## Когда переходить дальше

Можно переходить, когда duplicate/reordered/ambiguous/outage cases preserve local invariants and every external operation has a bounded retry or reconciliation path.