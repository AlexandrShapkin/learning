# Спринт 21. Интеграционные контракты и anti-corruption layer

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как сохранять local model and independent evolution when applications, contexts and external systems exchange data through changing APIs and messages?

## Результат спринта

После завершения необходимо уметь:

- различать internal model, published contract and provider model;
- проектировать explicit contract ownership;
- выбирать schema-first/code-first deliberately;
- определять compatibility rules for request, response and event contracts;
- использовать adapters/assemblers/translators;
- понимать anti-corruption layer as semantic protection;
- избегать shared library/model as default integration;
- проектировать consumer and provider contract tests;
- учитывать tolerant reader and Postel-law limits;
- управлять field/enum/default/null/presence evolution;
- проектировать version negotiation and deprecation;
- использовать expand-and-contract for integrations;
- учитывать data backfill/replay and dual-read/write risks;
- различать API gateway/facade and ACL responsibilities;
- сохранять correlation, idempotency and error semantics;
- оценивать semantic coupling beyond syntax compatibility.

## Основной маршрут

### Шаг 1. Contract inventory

For every boundary state:

```text
owner and consumers
operation/event meaning
schema and semantics
compatibility commitment
errors/order/idempotency
version/deprecation path
source of truth
```

### Шаг 2. Semantic translation

Create local types and mapping. ACL may combine calls, normalize units/statuses, protect local language and absorb provider quirks.

### Шаг 3. Evolution

Perform additive change, enum evolution, field replacement and semantic change through compatibility window. Test old/new consumers and stored messages.

### Шаг 4. Migration/reconciliation

Use dual-read/write only with source-of-truth and comparison/repair plan. Prefer adapters and staged cutover over permanent parallel models.

## Ресурсы

- DDD anti-corruption layer and published language.
- OpenAPI, JSON Schema and Protocol Buffers compatibility references.
- Consumer-driven contract testing references.
- Schema/data migration material from previous intensives.

## Практические задания

1. Translate external provider statuses/amounts into local model.
2. Evolve REST/protobuf/event contract with old-client tests.
3. Handle unknown enum/optional field safely.
4. Replace shared DTO library with published schema and generated/local adapters.
5. Run expand-contract migration across two modules/services.
6. Add reconciliation for dual-read/cutover period.
7. Model semantic breaking change despite syntactic compatibility.

## Лабораторная работа

Создать `work/integration-contracts/`.

### Boundaries

- Work Orders → Fulfillment event;
- Billing provider API;
- Reporting/read-model feed;
- legacy system adapter;
- public HTTP and internal protobuf contracts.

### Requirements

- contracts are versioned and owned;
- internal domain types are not exported as shared integration library;
- ACL translates names, units, statuses and failure semantics;
- old/new provider and consumer fixtures run in CI;
- unknown fields/enum values follow documented policy;
- field presence/null/default semantics are explicit;
- message ordering/idempotency/correlation remain compatible;
- deprecated fields/endpoints have usage evidence and removal condition;
- dual paths have authoritative source and comparison metrics;
- replay/backfill handles stored historical schemas;
- semantic contract changes require explicit migration even if schema validates;
- errors do not expose provider internals directly.

### Failure scenarios

1. Shared DTO/model package couples every participant release.
2. ACL only renames fields and leaks provider lifecycle/status semantics.
3. Enum addition crashes exhaustive consumer.
4. Optional/zero/default semantics change silently.
5. Field type remains same but business meaning changes.
6. Provider removes field after documentation-only deprecation.
7. Dual writes diverge with no comparison or source of truth.
8. Stored old events cannot be replayed by new consumer.
9. Consumer-driven contract passes but provider runtime guarantee differs.
10. API gateway is mistaken for semantic anti-corruption layer.
11. Error/status translation loses retry/idempotency meaning.

## Самопроверка

1. Internal model versus published contract?
2. ACL protects which semantics?
3. Schema compatibility versus semantic compatibility?
4. Additive change can still break how?
5. Unknown enum/presence/default policy?
6. Shared model library trade-off?
7. Consumer/provider contract tests prove what?
8. Expand-contract at integration boundary?
9. Dual-read/write needs which controls?
10. Gateway/facade versus ACL?

## Результат для базы знаний

- **Internal model and published integration contract**.
- **Anti-corruption layer and semantic translation**.
- **Schema and semantic compatibility**.
- **Contract ownership, versioning and deprecation**.
- **Consumer/provider contract testing**.
- **Integration expand-and-contract migration**.
- **Dual-path reconciliation and source of truth**.
- **Stored-message schema evolution**.

## Когда переходить дальше

Можно переходить, когда old/new consumers and providers coexist under tested contracts, local models remain independent, and semantic changes have explicit translation or migration rather than silent schema compatibility.