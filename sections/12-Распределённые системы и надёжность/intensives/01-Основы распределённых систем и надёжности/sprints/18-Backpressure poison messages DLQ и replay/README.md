# Спринт 18. Backpressure, poison messages, DLQ и replay

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как остановить рост backlog and repeated failure when consumers are slow, one message is permanently bad or replay exceeds downstream capacity?

## Результат спринта

После завершения необходимо уметь:

- измерять arrival, service and completion rates;
- использовать queue depth and oldest-message age;
- применять bounded concurrency and prefetch;
- propagate backpressure to producers;
- classify transient versus permanent processing failures;
- design retry delay/topics and attempt limits;
- use dead-letter queue as investigation/recovery path, not trash;
- handle poison messages without blocking partition forever;
- plan replay rate, ordering and side-effect safety;
- drain backlog while preserving live traffic;
- understand retention versus recovery window;
- audit manual redrive.

## Основной маршрут

1. Overload consumers and measure backlog age.
2. Introduce permanent poison event.
3. Add bounded delayed retries and DLQ.
4. Repair schema/handler and redrive selected events.
5. Replay historical stream under rate limit.

## Лабораторная работа

Создать `work/backpressure-dlq/`.

### Requirements

- consumer concurrency/prefetch/queue are bounded;
- producer receives explicit slowdown/rejection where possible;
- retry policy records class, attempt and next time;
- poison message cannot block unrelated partitions indefinitely;
- DLQ preserves original metadata, reason and history;
- redrive is filtered, reviewed, rate-limited and idempotent;
- replay is isolated from live offsets unless intentionally combined;
- backlog recovery accounts for new arrival rate;
- oldest age and completion lag drive scaling/admission decisions;
- retention cannot expire unresolved DLQ/replay evidence silently.

### Failure scenarios

1. Immediate retry loop saturates broker/dependency.
2. One poison message blocks ordered partition forever.
3. DLQ drops original headers/schema/trace context.
4. Redrive duplicates external effects.
5. Replay overwhelms database/provider.
6. Scaling workers increases downstream saturation.
7. Queue depth is stable while age grows.
8. Retention removes backlog before processing.

## Результат для базы знаний

- **Messaging backpressure and backlog age**.
- **Poison messages and bounded retries**.
- **Dead-letter queues and redrive**.
- **Event replay and rate limiting**.
- **Backlog recovery capacity**.

## Когда переходить дальше

Можно переходить, когда overload, poison messages and replay produce bounded backlog and deliberate recovery rather than uncontrolled retry amplification.