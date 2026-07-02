# Спринт 20. Проверка асинхронной обработки

Ориентировочный объём: 15–22 часа.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 15–19.

## Исходная задача

Создать `work/messaging-checkpoint/` — durable event-processing subsystem with queue/log semantics, consumer groups, idempotent effects, outbox/inbox, retries, DLQ, replay and schema evolution.

## Required capabilities

- transactional command plus outbox;
- relay to durable stream;
- partitioned consumer group;
- inbox/dedup and one external effect;
- bounded retry and DLQ;
- offset/replay tooling;
- versioned event contracts;
- lag/backlog/attempt observability.

## Mandatory fault cases

1. Producer commits state but publish fails.
2. Relay publishes then crashes before marking sent.
3. Consumer crashes before and after effect/ack.
4. Rebalance allows stale consumer to commit.
5. Duplicate message arrives after dedup expiry.
6. Poison event blocks partition.
7. Retry loop overloads dependency.
8. Replay duplicates external effect.
9. Old consumer receives new enum/required field.
10. New consumer replays historical old event.
11. Partition-key change breaks ordering.
12. Broker outage causes unbounded producer buffering.

## Defense

1. Queue, pub-sub and log semantics?
2. Delivery versus processing/effect guarantees?
3. Ack/offset commit boundary?
4. Operation/message/effect identity?
5. Outbox and inbox atomicity?
6. Dedup scope and retention?
7. Ordering scope and rebalance behavior?
8. Backpressure and backlog recovery?
9. Poison/DLQ/redrive policy?
10. Replay safety?
11. Schema compatibility policy?
12. Which state is authoritative?

## Критерии прохождения

- every crash boundary produces no silent loss and bounded duplication;
- one intended domain effect is preserved through idempotency/reconciliation;
- consumer rebalancing cannot commit stale ownership;
- overload and poison messages remain bounded;
- replay is rate-limited, isolated and safe;
- old/new schemas coexist through retained events;
- all twelve faults are reproduced and diagnosed;
- at least 10 of 12 defense answers cite offsets, ids, transactions or histories.

## Результат для базы знаний

Checkpoint-specific note не требуется. Update messaging notes where broker/product behavior differs from assumed guarantees.