# Спринт 16. Delivery semantics, ordering и consumer groups

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Какие гарантии доставки и порядка реально предоставляет broker/consumer protocol, и что application должна делать при crash, redelivery and rebalance?

## Результат спринта

После завершения необходимо уметь:

- различать at-most-once, at-least-once and effectively-once processing;
- объяснять why transport “exactly once” does not guarantee one external effect;
- выбирать acknowledgement/commit point;
- понимать visibility timeout, lease and redelivery;
- определять ordering scope by stream/partition/key;
- проектировать consumer groups and rebalancing;
- handle duplicate, delayed and out-of-order messages;
- preserve progress through offsets/checkpoints;
- understand producer idempotence and transactions conceptually;
- handle crash between effect and acknowledgement.

## Основной маршрут

1. Consume events with ack before and after effect.
2. Crash at each boundary and observe loss/duplicates.
3. Add two consumers and trigger rebalance.
4. Compare global, partition and key ordering.

## Лабораторная работа

Создать `work/delivery-ordering/`.

### Requirements

- delivery and processing guarantees are stated separately;
- ack/offset point is tied to durable local/effect state;
- duplicate delivery is expected and observable;
- ordering guarantee names exact partition/key scope;
- consumer rebalance drains/revokes partitions safely;
- in-flight work cannot commit after ownership loss without validation;
- offset reset/replay procedure is explicit;
- producer sequence/idempotence behavior is tested where available;
- external effects are protected independently from broker semantics.

### Failure scenarios

1. Ack before processing loses work.
2. Ack after side effect duplicates it on crash.
3. Rebalance lets old consumer commit after new owner starts.
4. Multiple partitions violate assumed global order.
5. Retry topic changes ordering unexpectedly.
6. Offset is committed beyond unfinished batch item.
7. “Exactly once” broker transaction excludes external API effect.

## Результат для базы знаний

- **At-most-once and at-least-once delivery**.
- **Effectively-once processing and external effects**.
- **Message acknowledgement and offset commit points**.
- **Consumer groups and partition rebalancing**.
- **Message ordering scopes**.

## Когда переходить дальше

Можно переходить, когда crash/rebalance tests show the exact boundaries where loss or duplication can occur and application invariants survive both.