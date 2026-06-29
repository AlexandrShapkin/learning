# Спринт 19. Событийная архитектура и асинхронные границы

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Когда events reduce temporal/ownership coupling between components, а когда они лишь скрывают control flow, consistency and failure semantics?

## Результат спринта

После завершения необходимо уметь:

- различать notification event, event-carried state transfer and event sourcing conceptually;
- различать domain event and integration event;
- выбирать synchronous command/query versus asynchronous event;
- определять event ownership, schema and version;
- понимать temporal coupling and availability trade-off;
- проектировать at-least-once handling and idempotent consumers;
- учитывать ordering scope, duplicates and replay;
- применять transactional outbox;
- проектировать process manager for multi-step workflow;
- понимать eventual consistency and user-visible intermediate states;
- избегать hidden choreography and event spaghetti;
- выбирать orchestration versus choreography;
- проектировать dead-letter/reconciliation ownership;
- использовать correlation/causation IDs;
- оценивать event granularity and payload style;
- тестировать async architecture with deterministic failure cases.

## Основной маршрут

### Шаг 1. Async decision

For each interaction ask:

```text
is immediate result required
who owns next action
can temporary inconsistency be shown/handled
what happens on duplicate/reorder/loss delay
who retries and reconciles
what is authoritative state
```

### Шаг 2. Event contract

Define past-tense business fact, producer ownership, stable IDs, occurred time, schema version, aggregate/reference version and safe payload.

### Шаг 3. Delivery and processing

Use outbox, broker and idempotent consumer. Acknowledge only after durable processing state. Measure lag and expose process status.

### Шаг 4. Architecture comparison

Implement same workflow as synchronous in-process calls, orchestrated process manager and choreography. Compare coupling, observability, latency and failure handling.

## Ресурсы

- DDIA messaging/stream-processing chapters.
- Enterprise Integration Patterns.
- Transactional outbox/idempotent consumer material.
- Event-driven architecture case studies used critically.

## Практические задания

1. Convert one noncritical reaction to integration event.
2. Implement outbox and idempotent consumer.
3. Reproduce duplicate, delayed and out-of-order events.
4. Build process manager with timeout/manual intervention.
5. Compare orchestration and choreography for three steps.
6. Add replay-safe read-model rebuild.
7. Map event causal chain in traces/logs.

## Лабораторная работа

Создать `work/event-architecture/`.

### Workflow

`WorkOrderApproved → InventoryReservation → BillingAuthorization → FulfillmentStarted → Notification`.

### Requirements

- synchronous decisions remain synchronous where caller needs result;
- events are immutable facts owned by producer context;
- domain events translate to versioned integration events;
- outbox is committed with source state;
- consumer deduplicates by stable event/message ID;
- ordering assumptions are scoped by aggregate/partition;
- stale event cannot regress versioned state;
- process manager stores state, deadlines and correlation;
- user/API can see pending/failed/manual states;
- dead-letter/reconciliation has explicit owner;
- replay cannot repeat irreversible external effects;
- metrics/traces expose lag, attempts and causal chain;
- comparison documents when direct calls are simpler and safer.

### Failure scenarios

1. Event named as imperative command and ownership is unclear.
2. Event emitted before transaction commit.
3. Consumer side effect commits but acknowledgement fails and duplicates effect.
4. Global ordering is assumed.
5. Choreography has no component that knows workflow progress.
6. Event payload copies entire internal model and couples consumers.
7. Consumer depends on producer database to interpret event.
8. Replay sends notification/payment again.
9. Event bus hides synchronous request/response need.
10. Dead-letter queue has no owner or reconciliation path.
11. Eventual consistency is invisible to user/API.

## Самопроверка

1. Domain versus integration event?
2. Event notification versus event-carried state?
3. When async boundary is justified?
4. What does transactional outbox solve?
5. At-least-once requires what?
6. Ordering scope and aggregate version?
7. Orchestration versus choreography?
8. Process manager role?
9. Replay risks?
10. How expose eventual consistency?

## Результат для базы знаний

- **Synchronous and asynchronous component collaboration**.
- **Domain and integration events**.
- **Event notification and event-carried state transfer**.
- **Transactional outbox and idempotent consumers**.
- **Orchestration, choreography and process manager**.
- **Event ordering, replay and causal correlation**.
- **Eventual consistency as user-visible state**.
- **Event-driven architecture failure modes**.

## Когда переходить дальше

Можно переходить, когда async interactions have explicit ownership, outbox/idempotency/reconciliation, and a comparison proves where events improve coupling rather than merely hide control flow.