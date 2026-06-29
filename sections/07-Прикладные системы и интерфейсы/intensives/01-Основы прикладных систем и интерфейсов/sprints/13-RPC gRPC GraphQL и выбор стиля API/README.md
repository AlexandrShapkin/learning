# Спринт 13. RPC, gRPC, GraphQL и выбор стиля API

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как выбрать interface style by interaction and client constraints, а не по популярности protocol or framework?

## Результат спринта

После завершения необходимо уметь:

- различать resource-oriented HTTP, operation-oriented RPC and query-oriented GraphQL;
- понимать synchronous request/response constraints;
- проектировать Protocol Buffers messages and services;
- учитывать field numbers, presence, defaults and compatibility;
- использовать unary and streaming gRPC conceptually;
- понимать deadlines, cancellation and status codes in RPC;
- проектировать GraphQL schema, types, queries and mutations;
- понимать resolver execution and N+1 risk;
- применять selection depth/complexity limits;
- различать transport-level and domain errors;
- сравнивать browser, internal service and public API clients;
- понимать generated clients and schema ownership;
- планировать versioning/evolution for each style;
- сравнивать observability, caching, proxies and tooling;
- избегать creating multiple styles without a use case;
- write an architecture decision supported by working prototypes.

## Основной маршрут

### Шаг 1. Decision matrix

Compare:

```text
client diversity and browser support
operation/query shape
latency and payload control
streaming needs
caching and intermediaries
schema evolution
debugging/tooling
organizational ownership
```

### Шаг 2. gRPC

Implement one internal service. Define protobuf package, messages, field presence, errors, deadline and retry policy. Generated code is transport adapter, not business logic.

### Шаг 3. GraphQL

Implement one read-heavy client-driven view. Use data loader/batching or set-based backend to avoid resolver N+1. Mutations still require transaction/idempotency rules.

### Шаг 4. Compare

Run equivalent use case through REST, gRPC and GraphQL, measure request count/payload/latency and analyze operational complexity.

## Ресурсы

- gRPC and Protocol Buffers official documentation.
- GraphQL specification and official learning material.
- OpenAPI/HTTP material from previous sprints.
- browser support/proxy/load-balancer documentation for tested stack.

## Практические задания

1. Implement protobuf schema evolution examples.
2. Build unary gRPC create/get and one server-streaming operation.
3. Propagate deadline/cancellation to use case.
4. Build GraphQL list/detail aggregation.
5. Reproduce resolver N+1 and fix it.
6. Add query depth/complexity/result limits.
7. Write decision records for public browser API and internal service API.

## Лабораторная работа

Создать `work/api-style-lab/`.

### Implementations

- REST API from sprint 11;
- gRPC service and Go client;
- GraphQL gateway/server and TypeScript client;
- shared application core and PostgreSQL adapter;
- workload/contract comparison report.

### Requirements

- business logic shared, transport adapters separate;
- protobuf field numbers never reused;
- old/new protobuf compatibility tests;
- gRPC deadlines and cancellation propagate;
- retry policy excludes non-idempotent ambiguous calls without protocol;
- GraphQL authorization occurs per resource/field path as required;
- N+1 query count measured and bounded;
- query depth, aliases, result sizes and time bounded;
- GraphQL errors do not leak internals;
- REST caching/intermediary benefits included in comparison;
- browser access implications documented;
- final recommendation is workload-specific.

### Failure scenarios

1. Protobuf field number reused with different meaning.
2. Generated transport type becomes domain model everywhere.
3. gRPC deadline ignored by database call.
4. automatic retry duplicates non-idempotent command.
5. GraphQL resolver executes one SQL query per row.
6. authorization checked only at top-level query.
7. deeply nested query exhausts resources.
8. GraphQL mutation reports partial domain success ambiguously.
9. REST, gRPC and GraphQL semantics diverge.
10. extra protocol added without client/operational benefit.

## Самопроверка

1. REST versus RPC versus GraphQL?
2. What makes protobuf evolution compatible?
3. Why field numbers matter?
4. Deadline versus timeout/cancellation?
5. What is gRPC streaming?
6. How GraphQL resolver N+1 appears?
7. Why query complexity needs limits?
8. Where authorization belongs in GraphQL?
9. What do generated clients solve and not solve?
10. Which constraints decide API style?

## Результат для базы знаний

- **Resource, operation and query-oriented APIs**.
- **Protocol Buffers schema evolution**.
- **gRPC deadlines, status and streaming**.
- **GraphQL schema and resolver execution**.
- **GraphQL N+1 and query complexity controls**.
- **Transport adapters versus application core**.
- **API-style decision matrix**.

## Когда переходить дальше

Можно переходить, когда all styles execute the same application rules, compatibility and resource limits are tested, and the chosen style is justified by concrete clients and operations.