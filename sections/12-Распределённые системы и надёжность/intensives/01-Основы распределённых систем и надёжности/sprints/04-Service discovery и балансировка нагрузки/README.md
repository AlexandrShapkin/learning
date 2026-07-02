# Спринт 04. Service discovery и балансировка нагрузки

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Как клиенты находят живые экземпляры и распределяют запросы, если membership and health change continuously?

## Результат спринта

После завершения необходимо уметь:

- сравнивать DNS, registry and platform-native discovery;
- различать client-side, proxy and server-side load balancing;
- понимать endpoint freshness, TTL and stale membership;
- выбирать round-robin, least-loaded, random and consistent-hash strategies;
- учитывать connection reuse and uneven load;
- проектировать readiness and outlier handling;
- понимать health check bias and failure domains;
- выполнять graceful removal/draining;
- избегать thundering herd during endpoint recovery;
- измерять distribution and failover delay.

## Основной маршрут

1. Run four API replicas behind two balancing modes.
2. Reuse long-lived connections and observe skew.
3. Remove/restart endpoints with stale discovery entries.
4. Compare random/two-choice/least-loaded under uneven service times.

## Лабораторная работа

Создать `work/discovery-balancing/`.

### Requirements

- discovery source, TTL and refresh behavior are explicit;
- load-balancer policy matches connection/request model;
- readiness removes unsafe targets without killing them;
- graceful drain preserves active requests;
- stale endpoints are retried within a bounded budget;
- recovery uses jitter/ramp to prevent herd;
- zone/failure-domain preference does not eliminate fallback;
- distribution is measured by requests, concurrency and work time;
- one discovery outage is survived from bounded cached state.

### Failure scenarios

1. DNS cache retains dead endpoint.
2. HTTP keep-alive pins most load to one replica.
3. Least-connections favors slow/blocked requests incorrectly.
4. Health path succeeds while operation path fails.
5. All clients reconnect to recovered instance simultaneously.
6. Zone affinity prevents cross-zone fallback.
7. Endpoint is removed before draining.

## Результат для базы знаний

- **Service discovery and endpoint membership**.
- **Client-side and proxy load balancing**.
- **Connection reuse and load skew**.
- **Readiness, draining and stale endpoints**.
- **Failure-domain-aware load balancing**.

## Когда переходить дальше

Можно переходить, когда replica churn and discovery staleness do not create unbounded errors or severe load imbalance.