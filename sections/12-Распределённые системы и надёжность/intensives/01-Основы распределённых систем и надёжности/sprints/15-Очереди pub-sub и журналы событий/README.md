# Спринт 15. Очереди, pub-sub и журналы событий

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Чем отличаются work queue, pub-sub and durable event log, и какую модель выбирать для распределения работы, fan-out and replay?

## Результат спринта

После завершения необходимо уметь:

- различать task queue, pub-sub and append-only log;
- понимать broker, topic/stream, partition, consumer and subscription;
- выбирать push versus pull consumption;
- проектировать retention and replay;
- различать transient and durable subscription state;
- понимать competing consumers and fan-out;
- связывать partitioning with ordering and parallelism;
- проектировать acknowledgement and visibility/lease semantics;
- учитывать broker unavailability and producer buffering;
- отделять event notification from authoritative state.

## Основной маршрут

1. Implement one work queue and one durable event stream.
2. Add two competing workers and two independent subscribers.
3. Stop consumers, retain events and replay from offset.
4. Compare queue redelivery with log replay.

## Лабораторная работа

Создать `work/queues-logs/`.

### Requirements

- workload names queue/log/pub-sub semantics explicitly;
- durable retention and subscriber position are observable;
- competing consumers process each work item according to contract;
- independent subscribers receive their own event history;
- replay does not mutate production-like state without explicit mode;
- partition count and key define ordering/parallelism;
- producer behavior during broker outage is bounded;
- event log is not treated as authoritative domain state without reconstruction rules.

### Failure scenarios

1. Pub-sub is used for work that must be processed once by one worker.
2. Queue is expected to support arbitrary historical replay.
3. Consumer state is lost and entire stream reprocesses unexpectedly.
4. One partition limits throughput.
5. Producer buffers indefinitely during broker outage.
6. Event notification is assumed to contain full authoritative state.

## Результат для базы знаний

- **Task queues, pub-sub and durable event logs**.
- **Competing consumers and fan-out subscriptions**.
- **Message retention, offsets and replay**.
- **Push and pull consumption**.
- **Partitioning, ordering and messaging parallelism**.

## Когда переходить дальше

Можно переходить, когда each asynchronous path has explicit queue/log semantics, retention, ownership and replay behavior under consumer/broker outage.