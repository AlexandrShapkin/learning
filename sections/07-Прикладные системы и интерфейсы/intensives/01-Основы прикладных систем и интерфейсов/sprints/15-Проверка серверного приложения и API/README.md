# Спринт 15. Проверка серверного приложения и API

Ориентировочный объём: 14–20 часов.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 09–14.

## Исходная задача

Создать `work/server-api-checkpoint/` — Go application exposing one shared application core through REST, gRPC and a bounded GraphQL/read interface, plus SSE status events.

## Domain scenarios

- create item/order with idempotency key;
- read/list with cursor pagination;
- update with optimistic concurrency;
- status transition;
- accepted background job resource;
- server-to-client progress/status stream;
- authorization placeholder subject/tenant context;
- graceful shutdown during active requests/connections.

## Architecture requirements

```text
transport adapters
├── HTTP/REST + OpenAPI
├── gRPC + protobuf
├── GraphQL bounded read gateway
└── SSE stream
        |
application use cases
        |
PostgreSQL adapter + task/outbox adapter
```

Business rules and transaction boundaries are shared and transport-independent.

## HTTP/API requirements

- explicit server timeouts/body/concurrency limits;
- request ID and context cancellation;
- resource-oriented methods/statuses;
- stable Problem Details-style errors;
- runtime request validation;
- cursor pagination with unique order;
- idempotency-key concurrency behavior;
- optimistic concurrency conflict;
- OpenAPI examples executed;
- private/cache headers explicit.

## gRPC/GraphQL requirements

- protobuf field compatibility tests;
- deadlines and cancellation propagate;
- status/domain error mapping documented;
- GraphQL query depth/result limits;
- resolver query count bounded;
- per-resource authorization path preserved;
- all transports produce equivalent business outcomes.

## Real-time requirements

- SSE event IDs and reconnect;
- duplicate event deduplication;
- snapshot/refetch fallback;
- bounded connection/send queues;
- slow client policy;
- tenant subscription isolation;
- graceful shutdown/reconnect behavior.

## Tests

- application-core unit tests;
- PostgreSQL integration tests;
- OpenAPI/REST contract tests;
- protobuf compatibility tests;
- gRPC integration tests;
- GraphQL N+1 and limit tests;
- real connection cancellation tests;
- SSE reconnect/slow-client tests;
- race and leak checks.

## Blind cases

Randomly select at least ten:

1. handler ignores canceled context;
2. body/connection queue unbounded;
3. business rule duplicated in transport;
4. cursor missing tenant/filter scope;
5. concurrent idempotency race;
6. same key used with different payload;
7. protobuf field reused;
8. gRPC retry duplicates command;
9. GraphQL resolver N+1;
10. GraphQL authorization missing at nested resource;
11. stale SSE event overwrites current state;
12. slow client leaks queue/goroutine;
13. shutdown closes dependency too early;
14. OpenAPI and server drift.

## Defense

1. Handler versus use-case responsibility?
2. How context cancellation propagates?
3. Where transaction boundary is defined?
4. Resource API versus RPC method?
5. Why cursor needs stable unique ordering?
6. How idempotency result is coordinated transactionally?
7. Protobuf compatibility rules?
8. GraphQL N+1 and complexity controls?
9. SSE replay/snapshot model?
10. What graceful shutdown must drain?
11. How equivalent outcomes are checked across transports?
12. Which evidence proves resource bounds?

## Критерии прохождения

- clean build and all test layers pass;
- no business rule depends on transport;
- cancellation and shutdown release every owned resource;
- REST, gRPC and GraphQL outcomes agree on shared cases;
- idempotency and concurrency conflicts behave deterministically;
- GraphQL and SSE remain bounded;
- ten blind cases are diagnosed and repaired;
- race/leak checks return to baseline;
- at least 10 of 12 defense answers are correct.

## Результат для базы знаний

Checkpoint-specific note не требуется. Update existing notes where implementation evidence changed the prior contract or mechanism.