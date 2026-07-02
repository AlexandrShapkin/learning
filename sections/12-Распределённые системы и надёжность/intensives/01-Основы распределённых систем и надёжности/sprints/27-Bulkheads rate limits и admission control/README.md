# Спринт 27. Bulkheads, rate limits и admission control

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как изолировать tenants, workloads and dependencies so that one overloaded path cannot consume all shared capacity?

## Результат спринта

После завершения необходимо уметь:

- apply bulkheads to threads/goroutines/connections/queues/pools;
- distinguish concurrency limit, rate limit and quota;
- implement token bucket and leaky-bucket concepts;
- use global, per-tenant and per-route limits;
- design admission control before expensive work;
- return retry-after/backoff signals;
- reserve capacity for critical operations;
- prevent noisy-neighbor effects;
- coordinate distributed limits approximately or strongly as needed;
- understand fairness and starvation;
- monitor rejected, queued and admitted work;
- choose fail-open/fail-closed limit-service behavior.

## Основной маршрут

1. Separate API pools for critical and batch routes.
2. Add per-tenant concurrency and rate limits.
3. Overload one tenant and preserve others.
4. Compare local approximate and centralized global limiting.

## Лабораторная работа

Создать `work/bulkheads-admission/`.

### Requirements

- critical and noncritical workloads have separate bounded pools;
- admission occurs before DB/provider/large allocation;
- rate/concurrency/quota semantics and windows are explicit;
- tenant identity cannot bypass limits through unstable key;
- rejection response includes safe retry guidance where appropriate;
- reserved capacity is tested under batch overload;
- fairness/starvation are measured;
- centralized limiter outage behavior is documented;
- limit configuration changes do not create synchronized bursts;
- scaling replicas does not accidentally multiply intended global capacity without accounting.

### Failure scenarios

1. One tenant consumes all DB connections.
2. Rate limit is checked after expensive work.
3. Per-instance limits multiply after scale-out.
4. Retry-after causes synchronized retries.
5. Reserved pool is unused but critical traffic still starves due another bottleneck.
6. Central limiter outage either blocks all traffic or removes every protection unexpectedly.
7. Low-volume tenant is starved by fairness algorithm.

## Результат для базы знаний

- **Bulkhead isolation in distributed services**.
- **Rate, concurrency and quota limits**.
- **Admission control before expensive work**.
- **Tenant fairness and noisy-neighbor control**.
- **Local and distributed rate limiting**.

## Когда переходить дальше

Можно переходить, когда one tenant or workload can saturate its allocated capacity without exhausting critical paths or unrelated tenants.