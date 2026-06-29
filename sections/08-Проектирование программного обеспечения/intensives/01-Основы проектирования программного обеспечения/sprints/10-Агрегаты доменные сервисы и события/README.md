# Спринт 10. Агрегаты, доменные сервисы и события

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как определить consistency boundary and collaboration between domain objects without turning every relation into one giant aggregate or every rule into a stateless service?

## Результат спринта

После завершения необходимо уметь:

- понимать aggregate as consistency and transaction boundary;
- выбирать aggregate root and internal ownership;
- ссылаться на other aggregates by identity where appropriate;
- сохранять invariants within one atomic boundary;
- различать aggregate invariant and cross-aggregate process;
- проектировать aggregate size from concurrency/change constraints;
- использовать domain service for policy not naturally owned by one value/entity;
- отличать domain service from application orchestration;
- создавать domain events as facts after state transition;
- различать domain event, integration event and command;
- сохранять event meaning and schema deliberately;
- не использовать events to hide synchronous dependency without semantics;
- понимать eventual consistency as explicit trade-off;
- проектировать repositories around aggregate lifecycle;
- тестировать aggregate transitions and emitted facts;
- связывать persistence transaction and event publication safely.

## Основной маршрут

### Шаг 1. Aggregate candidates

Для `WorkOrder`, `Inventory`, `BillingAccount`, `Attachment` определить:

```text
invariants requiring atomicity
concurrent writers
size and loading cost
references to other concepts
lifecycle ownership
failure/consistency tolerance
```

### Шаг 2. Root and repository

Only aggregate root is loaded/saved through repository. Internal entities/values cannot be independently mutated by arbitrary callers.

### Шаг 3. Domain service

Move only a rule that genuinely combines concepts without natural owner. Application service still coordinates transaction, repository and external effects.

### Шаг 4. Events

After successful transition, record facts such as `WorkOrderApproved`. Translate to integration event/outbox outside the pure model or through explicit application boundary.

## Ресурсы

- *Domain-Driven Design* and *Implementing Domain-Driven Design*, aggregates/services/events.
- Transaction and outbox material from data-storage intensive.
- Go modeling and event handling examples used critically.

## Практические задания

1. Draw aggregate candidates and reject at least one oversized design.
2. Enforce one invariant inside aggregate root.
3. Split one cross-aggregate rule into process/application coordination.
4. Implement a domain service with no infrastructure dependency.
5. Record and publish domain/integration events through outbox.
6. Test concurrent update behavior and aggregate version.

## Лабораторная работа

Создать `work/aggregates-events/`.

### Requirements

- every aggregate has named invariants and root;
- transaction boundary matches aggregate consistency need;
- other aggregates are referenced by stable IDs, not mutable object graph;
- repositories operate on aggregate lifecycle rather than arbitrary tables;
- domain services contain domain policy, not I/O orchestration;
- application service coordinates persistence/external work;
- domain events are past-tense facts and immutable;
- integration events have explicit translation/versioning;
- event publication is coordinated through transaction/outbox;
- aggregate version or locking prevents silent lost updates;
- tests cover invalid transitions and event emission;
- eventual consistency is documented where cross-aggregate actions are deferred.

### Failure scenarios

1. Entire system becomes one aggregate for global consistency.
2. Every table/entity gets its own aggregate by default.
3. Aggregate contains large unbounded collection loaded for every command.
4. Caller mutates child entity independently of root.
5. Domain service is a procedural god service with repositories and HTTP clients.
6. Domain event is named as command (`SendEmail`).
7. Event is emitted before transaction commits and cannot be reconciled.
8. Integration DTO leaks into domain event and couples provider/client.
9. Cross-aggregate invariant is assumed atomic without protocol.
10. Repository exposes query/update methods for every internal field.

## Самопроверка

1. Aggregate means what?
2. What defines aggregate boundary?
3. Why reference other aggregate by ID?
4. Aggregate invariant versus cross-aggregate process?
5. Domain service versus application service?
6. Domain event versus integration event?
7. Event fact versus command?
8. How event publication relates to transaction?
9. Why aggregate size affects concurrency/performance?
10. What repository should load/save?

## Результат для базы знаний

- **Aggregate as consistency boundary**.
- **Aggregate root and internal ownership**.
- **Cross-aggregate process and eventual consistency**.
- **Domain service versus application service**.
- **Domain, integration events and commands**.
- **Aggregate repository and lifecycle**.
- **Transaction and outbox for event publication**.
- **Aggregate size, concurrency and versioning**.

## Когда переходить дальше

Можно переходить, когда aggregate boundaries are justified by named invariants/concurrency, events are facts coordinated with persistence, and cross-aggregate consistency is explicit rather than assumed.