# Спринт 17. Idempotency, deduplication, outbox и inbox

Ориентировочный объём: 20–29 часов.

## Центральный вопрос

Как сделать повторное выполнение безопасным, если producer, broker, consumer and external effects могут повторить одну логическую операцию?

## Результат спринта

После завершения необходимо уметь:

- определять scope and lifetime of idempotency key;
- distinguish duplicate request, message and effect;
- implement atomic idempotency record with result reuse;
- handle concurrent duplicate attempts;
- choose dedup retention and storage model;
- implement transactional outbox;
- implement inbox/dedup at consumer boundary;
- understand relay crash and repeated publication;
- reconcile outbox/inbox and business state;
- protect external side effects through provider idempotency or local state machine;
- distinguish natural idempotence from enforced deduplication;
- avoid global unbounded dedup sets.

## Основной маршрут

1. Add idempotency keys to command API.
2. Crash before/after DB commit and response.
3. Write business state plus outbox in one transaction.
4. Relay events with duplicate publication and consumer inbox.
5. Add one external provider effect.

## Лабораторная работа

Создать `work/idempotency-outbox/`.

### Requirements

- idempotency key is scoped by operation/tenant and request semantics;
- concurrent duplicates produce one authoritative result;
- key reuse with different payload is rejected;
- outbox and business state commit atomically;
- relay is restartable and may publish duplicates safely;
- inbox/dedup and business effect commit atomically where possible;
- external effect has provider key or explicit reconciliation state;
- dedup retention exceeds possible redelivery/replay window;
- cleanup/expiry does not re-enable unsafe duplicates prematurely;
- metrics expose duplicate, conflict and reconciliation counts.

### Failure scenarios

1. Same idempotency key is reused with different request body.
2. Two concurrent requests both pass a non-atomic check.
3. Business commit succeeds but event publish fails.
4. Relay publishes then crashes before marking sent.
5. Consumer marks message before effect and loses work.
6. Dedup record expires before delayed replay.
7. External provider accepts duplicate effect.

## Результат для базы знаний

- **Idempotency keys and result reuse**.
- **Distributed deduplication scope and retention**.
- **Transactional outbox pattern**.
- **Consumer inbox and atomic effect processing**.
- **External-effect idempotency and reconciliation**.

## Когда переходить дальше

Можно переходить, когда crash/retry/replay at every boundary produces one intended domain effect or an explicit reconcilable state.