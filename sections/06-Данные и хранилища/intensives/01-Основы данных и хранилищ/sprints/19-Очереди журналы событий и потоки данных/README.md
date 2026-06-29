# Спринт 19. Очереди, журналы событий и потоки данных

Ориентировочный объём: 19–27 часов.

## Центральный вопрос

Как передавать и повторно обрабатывать asynchronous work/events, понимая ordering, retention, acknowledgement, redelivery and duplicate effects?

## Результат спринта

После завершения необходимо уметь:

- различать queue, publish-subscribe and append-only log;
- понимать producer, broker, partition/subject, consumer and consumer group;
- объяснять ordering scope and partition-key effect;
- различать at-most-once, at-least-once and effectively-once application behavior;
- понимать why “exactly once” is scoped and not universal;
- проектировать idempotent consumers and deduplication records;
- использовать acknowledgement, retry, backoff and dead-letter handling;
- различать retention by time/size/acknowledgement;
- понимать replay and consumer offsets;
- проектировать transactional outbox and relay;
- понимать change data capture overview;
- применять inbox pattern where duplicate side effects matter;
- проектировать event schema/versioning and compatibility;
- различать command, event and state snapshot;
- boundedly handle poison messages and hot partitions;
- применять backpressure and admission control;
- диагностировать lag, redelivery, reorder, loss and duplicate effects;
- выбирать queue/log versus direct database workflow.

## Основной маршрут

### Шаг 1. Queue versus log

Queue distributes work and may remove acknowledged messages. Log retains ordered records and tracks consumer position. Concrete products can expose both models.

### Шаг 2. Delivery semantics

Broker delivery guarantee is not the same as business side-effect guarantee. Consumer may fail after side effect but before acknowledgement.

### Шаг 3. Outbox and CDC

Write domain state and outbox row in one database transaction. Relay publishes idempotently; consumers deduplicate by stable event ID/version.

### Шаг 4. Replay and evolution

Events must be versioned and replay-safe. Rebuilding a read model requires deterministic handlers or explicit migration logic.

## Ресурсы

- DDIA messaging, event logs and stream-processing chapters.
- NATS JetStream official docs or Kafka/Redpanda official docs for the chosen laboratory.
- PostgreSQL logical decoding/outbox references as advanced comparison.
- Enterprise Integration Patterns selected messaging concepts.

## Практические задания

1. Implement work queue with ack, retry and dead-letter path.
2. Implement partitioned event log and consumer offsets.
3. Reproduce failure after side effect before ack.
4. Add idempotency/inbox record.
5. Implement PostgreSQL transactional outbox relay.
6. Rebuild one read model through replay.
7. Test schema v1/v2 consumers.
8. Reproduce hot partition and lag.

## Лабораторная работа

Создать `work/event-stream-lab/`.

### Domain events

- order created;
- inventory reserved/rejected;
- payment accepted/failed;
- shipment created;
- product updated;
- cache/search projection update.

### Components

- PostgreSQL source and outbox;
- Go relay;
- selected broker/log;
- idempotent consumers;
- inbox/dedup table;
- retry/dead-letter worker;
- projection rebuild command;
- lag/redelivery verifier.

### Requirements

- event ID, aggregate ID/version and schema version;
- ordering scope explicitly tied to partition/subject key;
- outbox write shares transaction with source change;
- relay crash/restart safe;
- consumer side effects idempotent;
- ack occurs only after durable processing state;
- poison messages bounded and inspectable;
- retries have backoff and limits;
- replay uses separate consumer state and does not duplicate irreversible effects;
- lag/throughput metrics exported;
- broker outage cannot exhaust application memory or database connections.

### Failure scenarios

1. Database commits but direct publish fails.
2. Publish succeeds but producer retries duplicate event.
3. Consumer side effect commits but ack fails.
4. Ack occurs before durable side effect.
5. Event ordering assumed across partitions.
6. Poison message loops forever.
7. Schema change breaks old consumer.
8. Replay sends email/payment again.
9. Hot partition creates lag.
10. Retention deletes data before slow consumer reads it.
11. Dead-letter queue becomes unowned storage.
12. Relay marks published before broker confirmation ambiguously.

## Самопроверка

1. Queue versus append-only log?
2. What is consumer group?
3. Where is ordering guaranteed?
4. At-most versus at-least once?
5. Why business exactly-once is difficult?
6. What is idempotent consumer?
7. How transactional outbox closes database/publish gap?
8. Inbox/dedup purpose?
9. Replay risks?
10. Retention versus acknowledgement?
11. How backpressure protects system?
12. What causes consumer lag?

## Результат для базы знаний

- **Queue, publish-subscribe and append-only log**.
- **Delivery and acknowledgement semantics**.
- **Idempotent consumer and inbox deduplication**.
- **Transactional outbox and relay**.
- **Consumer groups, offsets and ordering scope**.
- **Retry, dead-letter handling and poison messages**.
- **Event schema evolution and replay**.
- **Lag, hot partitions and backpressure**.

## Когда переходить дальше

Можно переходить, когда source-to-event gap is closed by outbox, duplicate/redelivery paths preserve business invariants, and replay cannot repeat irreversible effects.