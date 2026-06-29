# Спринт 14. SSE, WebSocket и интерфейсы реального времени

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Как доставлять evolving server state to connected clients, учитывая disconnects, ordering, replay, backpressure and authorization throughout a long-lived connection?

## Результат спринта

После завершения необходимо уметь:

- различать polling, long polling, SSE and WebSocket;
- выбирать one-way versus bidirectional channel;
- понимать connection handshake and lifetime;
- проектировать message/event envelope with ID, type and version;
- определять ordering scope and replay window;
- использовать SSE `Last-Event-ID` conceptually;
- проектировать WebSocket application protocol;
- использовать ping/pong/heartbeats and idle timeouts;
- ограничивать message size, rate and connection count;
- применять per-connection backpressure policy;
- понимать slow consumer and bounded queue handling;
- выполнять authentication at handshake and authorization per subscription/message;
- обрабатывать token/session expiry during connection;
- reconnect with jitter/backoff;
- reconcile snapshot plus incremental events;
- тестировать disconnect, duplicate, reorder and missed events;
- измерять connection and fan-out resource cost.

## Основной маршрут

### Шаг 1. Choose transport

Use normal HTTP request for commands. Polling is often sufficient. SSE fits server-to-client events over HTTP; WebSocket fits bidirectional low-latency messaging with custom protocol.

### Шаг 2. Event contract

Define stable event ID, stream/subscription scope, aggregate version, timestamp, schema version and payload. Event notification may trigger authoritative refetch rather than contain complete state.

### Шаг 3. Connection lifecycle

Handle open, authenticated, subscribed, active, slow, closing and reconnecting states. Client must detect loss and not assume continuous delivery.

### Шаг 4. Backpressure and replay

Bound per-client queue. Choose disconnect/drop/coalesce policy by event semantics. Restore through last ID or snapshot/refetch when replay window is unavailable.

## Ресурсы

- HTML/MDN Server-Sent Events documentation.
- WebSocket protocol and browser API docs.
- chosen Go WebSocket library documentation after protocol design.
- messaging/order/replay material from data-storage intensive.

## Практические задания

1. Compare polling and SSE for job progress.
2. Implement SSE reconnect with event IDs.
3. Implement WebSocket collaborative/status channel.
4. Reproduce slow consumer and bounded queue behavior.
5. Expire/revoke session during active connection.
6. Reconcile missed events with snapshot.
7. Load test connections and fan-out.

## Лабораторная работа

Создать `work/realtime-lab/`.

### Scenarios

- background job progress through SSE;
- item/order status notifications;
- optional bidirectional presence/comment demo through WebSocket;
- reconnect and replay;
- authorization scope change;
- slow client and network interruption.

### Requirements

- commands remain normal authenticated HTTP operations;
- event IDs and schema versions explicit;
- client deduplicates repeated event IDs;
- aggregate version prevents older update replacing newer state;
- replay window and snapshot fallback documented;
- connection, subscription and message limits;
- heartbeat/idle timeout;
- bounded send queues;
- slow-consumer policy is visible in metrics/logs;
- origin/authentication checked;
- authorization revalidated when resource/role changes require it;
- graceful server shutdown closes/reconnects clients predictably;
- no goroutine/connection leak after test.

### Failure scenarios

1. WebSocket chosen for ordinary request/response CRUD.
2. Client assumes connection means no events were missed.
3. Reconnect creates duplicate subscriptions.
4. Slow client grows unbounded queue.
5. Older event overwrites newer state.
6. Authentication checked once but access later revoked.
7. Proxy idle timeout closes connection silently.
8. Ping/pong goroutines leak.
9. Broadcast exposes tenant event to wrong subscriber.
10. Large client message exhausts memory.
11. Dropped event has no snapshot/refetch repair.

## Самопроверка

1. Polling versus SSE versus WebSocket?
2. One-way versus bidirectional need?
3. What does event ID provide?
4. Replay versus snapshot reconciliation?
5. Why connection does not prove complete delivery?
6. What is slow consumer?
7. Backpressure policies?
8. How authorization changes during connection?
9. Why commands may remain HTTP?
10. Which resources scale with connections?

## Результат для базы знаний

- **Polling, SSE and WebSocket selection**.
- **Long-lived connection lifecycle**.
- **Real-time event IDs, versions and replay**.
- **Snapshot plus incremental-event reconciliation**.
- **Slow consumers and per-connection backpressure**.
- **Authentication and authorization for real-time subscriptions**.
- **Reconnect, heartbeat and connection limits**.

## Когда переходить дальше

Можно переходить, когда disconnect/missed/duplicate/slow-client cases converge to authoritative state and every connection remains bounded and tenant-authorized.