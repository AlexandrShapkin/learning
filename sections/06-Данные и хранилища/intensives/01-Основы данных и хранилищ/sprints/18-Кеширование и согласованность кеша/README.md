# Спринт 18. Кеширование и согласованность кеша

Ориентировочный объём: 17–24 часа.

## Центральный вопрос

Как ускорить reads and reduce backend load через cache, не превратив stale, missing or duplicated state в неконтролируемую correctness problem?

## Результат спринта

После завершения необходимо уметь:

- различать cache, source of truth and derived read model;
- применять cache-aside, read-through, write-through and write-behind patterns;
- понимать TTL, eviction and memory-pressure behavior;
- выбирать key design and versioning;
- проектировать negative caching;
- понимать stale data and consistency windows;
- применять explicit invalidation and event-driven invalidation;
- предотвращать cache stampede through request coalescing, jitter and bounded locking;
- использовать stale-while-revalidate style behavior where acceptable;
- понимать write-behind data-loss risk;
- выбирать local versus shared cache;
- понимать Redis expiration, eviction, persistence and replication only for tested configuration;
- избегать treating cache as transactional authority;
- проектировать idempotent cache refresh;
- измерять hit ratio, latency, backend load and memory;
- учитывать hot keys and large values;
- диагностировать stale, poisoned, missing and overloaded cache;
- избегать unsafe distributed-lock assumptions.

## Основной маршрут

### Шаг 1. Cache contract

For each cached value define:

```text
source of truth
key and version
freshness requirement
TTL and invalidation trigger
acceptable stale window
miss and backend failure behavior
repair/rebuild path
```

### Шаг 2. Read and write patterns

Compare cache-aside, read-through, write-through and write-behind under failures. Write-behind is not equivalent to durable commit.

### Шаг 3. Expiry and eviction

TTL controls freshness/lifecycle; eviction is capacity policy. They may occur independently. Random expiry alignment can create load spikes.

### Шаг 4. Stampede and invalidation

Use single-flight/coalescing, TTL jitter, bounded leases and stale serving only when semantics allow. Invalidation messages can be delayed or duplicated.

## Ресурсы

- Redis official docs on data types, expiration, eviction, persistence and transactions.
- DDIA caching and derived-data discussions.
- Reliable engineering references on cache-aside, stampede and invalidation.
- Go singleflight/context/concurrency docs for implementation.

## Практические задания

1. Implement local and Redis-backed cache-aside.
2. Compare TTL-only and event invalidation.
3. Reproduce cache stampede after synchronized expiry.
4. Add request coalescing and TTL jitter.
5. Implement negative caching with bounded TTL.
6. Simulate cache outage and backend overload.
7. Test hot key and oversized value behavior.
8. Compare write-through and write-behind failure semantics.

## Лабораторная работа

Создать `work/cache-consistency-lab/`.

### Domain

Cached product details, inventory availability, customer summary and search suggestions backed by PostgreSQL.

### Components

- Go service with cache policies;
- Redis and local-cache adapters;
- deterministic fake clock for tests;
- database change/outbox invalidator;
- workload and fault generator;
- consistency verifier;
- hit/load/latency report.

### Requirements

- cache keys include tenant and schema/version where needed;
- source database remains authoritative;
- every policy states stale window;
- invalidation is idempotent;
- cache miss concurrency bounded;
- request coalescing cannot block indefinitely;
- TTL jitter tested;
- negative cache distinguishes not-found from backend error;
- cache outage degrades with admission/backpressure;
- values have size limits;
- no secret or authorization decision cached without explicit safety model;
- metrics separate hit, miss, stale hit, refresh, error and eviction.

### Failure scenarios

1. Database updated but cache remains stale.
2. Invalidation arrives before transaction commit or out of order.
3. Cache stampede overloads database.
4. Negative cache hides newly created record too long.
5. Cache failure triggers retry storm.
6. Hot key saturates one shard/server.
7. Large value causes memory/network pressure.
8. Eviction mistaken for expiration policy.
9. Write-behind acknowledges before durable store and loses data.
10. Distributed lock expires while work continues.
11. Tenant/version omitted from cache key.
12. Cached authorization state outlives revocation.

## Самопроверка

1. Cache versus source of truth?
2. Cache-aside versus read-through?
3. Write-through versus write-behind?
4. TTL versus eviction?
5. What is cache stampede?
6. How request coalescing helps?
7. What is negative caching?
8. Why invalidation can be reordered/duplicated?
9. How cache outage affects backend?
10. Why distributed cache lock is a lease, not ownership proof?

## Результат для базы знаний

- **Cache as derived state**.
- **Cache-aside, read-through, write-through and write-behind**.
- **TTL, eviction and stale windows**.
- **Cache invalidation and ordering**.
- **Cache stampede and request coalescing**.
- **Negative caching**.
- **Hot keys and cache memory limits**.
- **Cache outage and backend protection**.
- **Distributed cache lock limitations**.

## Когда переходить дальше

Можно переходить, когда stale behavior and outage fallback are explicit, stampede is bounded, and database/cache consistency can be detected and repaired.