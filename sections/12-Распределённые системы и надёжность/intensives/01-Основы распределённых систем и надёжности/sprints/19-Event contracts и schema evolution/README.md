# Спринт 19. Event contracts и schema evolution

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как изменять event payload and semantics, если старые producers, consumers and retained events coexist for long periods?

## Результат спринта

После завершения необходимо уметь:

- различать event type, schema and semantic contract;
- применять backward, forward and full compatibility;
- выбирать additive evolution and defaults carefully;
- понимать enum, required-field and semantic-change hazards;
- version event envelope and payload deliberately;
- use schema registry or contract tests;
- handle unknown fields and event types;
- design upcasters/translators only with ownership and retirement plan;
- replay old events through new consumers;
- deprecate fields/events using usage evidence;
- distinguish notification, fact and command semantics;
- protect partition key and ordering compatibility.

## Основной маршрут

1. Define event envelope and two payload versions.
2. Run old/new producers and consumers together.
3. Replay retained v1 events through v2 consumer.
4. Change enum and semantic meaning to reproduce breakage.
5. Retire an old field after usage evidence.

## Лабораторная работа

Создать `work/event-contracts/`.

### Requirements

- envelope includes event ID, type, version, time, producer and correlation context;
- compatibility policy is machine-tested where possible;
- old consumers ignore additive fields safely;
- new consumers handle old retained events;
- unknown enum/type behavior is explicit;
- semantic changes use new event/type/version rather than silent field reuse;
- partition key changes require migration/order plan;
- schema registry availability is not on critical data path without fallback;
- deprecation uses consumer inventory and replay tests;
- sensitive fields have retention/privacy review.

### Failure scenarios

1. Required field is added without default/migration.
2. Old consumer crashes on new enum.
3. Field keeps same name but changes units/meaning.
4. New partition key breaks per-entity ordering.
5. Schema registry outage blocks all producers.
6. Retained old event cannot be processed by new consumer.
7. Upcaster chain becomes permanent hidden business logic.

## Результат для базы знаний

- **Event envelopes and semantic contracts**.
- **Backward and forward event-schema compatibility**.
- **Event enum, required-field and semantic evolution**.
- **Schema registries and contract tests**.
- **Event deprecation, replay and upcasting**.

## Когда переходить дальше

Можно переходить, когда old/new producers and consumers coexist through retained-event replay and semantic changes cannot silently reinterpret historical data.