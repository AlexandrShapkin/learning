# Спринт 17. Балансировка нагрузки и отказоустойчивость

Ориентировочный объём: 14–20 часов.

## Центральный вопрос

How can multiple backend instances serve one logical endpoint while intermediaries make routing, health and retry decisions without violating application semantics?

## Результат спринта

После завершения необходимо уметь:

- distinguish DNS, L4 and L7 load balancing;
- explain connection versus request distribution;
- compare round-robin, least-connections, hash and weighted algorithms;
- explain active/passive health checks;
- distinguish process alive, port open, ready and functionally healthy;
- understand connection reuse and uneven request distribution;
- explain source IP preservation through proxy protocol/forwarded headers;
- configure HAProxy or nginx L4/L7 balancing;
- explain session affinity and its trade-offs;
- understand retry, timeout and circuit-breaking boundaries;
- distinguish load balancing from high availability;
- explain failover VIP concept and keepalived/VRRP overview;
- measure distribution, latency and failure behavior;
- diagnose unhealthy backend, stale DNS, proxy saturation and retry storms;
- reason about idempotency before retrying requests.

## Место в интенсиве

A proxy can route requests to one backend. This sprint expands to multiple instances and examines availability/performance trade-offs.

## Основной маршрут

### Шаг 1. Balancing layers

Study:

- DNS round-robin and caching limitations;
- L4 connection forwarding;
- L7 request-aware proxying;
- client-side balancing overview.

### Шаг 2. Algorithms and connection behavior

Understand that HTTP keep-alive/HTTP2 may send many requests over one connection, so per-connection balancing differs from per-request balancing.

### Шаг 3. Health and failure

Study:

- startup/readiness/liveness;
- passive failure observation;
- rise/fall thresholds;
- draining;
- retry budgets and timeouts;
- partial failure.

### Шаг 4. HA

Review VIP/VRRP/anycast concepts. Mandatory lab uses one load balancer; optional part adds keepalived pair in namespaces.

## Ресурсы

### Обязательный маршрут

- HAProxy configuration documentation.
- nginx upstream/load balancing docs.
- HTTP retry/idempotency semantics from RFC 9110.
- DNS caching limitations from sprint 11.

### Альтернативные объяснения

- Google SRE chapters on load balancing and overload.
- HAProxy architecture articles.
- Envoy load balancing docs for conceptual comparison.

### Углубление

- consistent hashing;
- Maglev;
- anycast;
- global server load balancing;
- service mesh;
- outlier detection and circuit breaking;
- connection draining during deploy;
- QUIC load balancing.

## Практические задания

### 1. Distribution

Run three backends returning instance ID. Compare:

- one request per TCP connection;
- many requests over keep-alive;
- multiple parallel clients;
- HTTP/2 if supported.

Explain observed distribution.

### 2. Algorithms

Create backends with different response delays/capacities. Compare round-robin, least-connections and weights using same workload.

### 3. Health semantics

Backends support `/live`, `/ready`, `/work`. Create states:

- process alive but not ready;
- port open but dependency unavailable;
- slow but correct;
- returning errors for subset.

Design health check that avoids both false positive and cascading load.

### 4. Retry ambiguity

Proxy times out after backend applied POST. Demonstrate duplicate without idempotency key. Configure retries only for safe/eligible cases and compare.

## Лабораторная работа

Create `work/load-balancing-lab/`.

### Topology

```text
clients -- DNS name -- HAProxy
                        ├── app-a
                        ├── app-b
                        └── app-c
```

Optional second HAProxy with VIP/VRRP.

### Backends

Go application exposes:

- instance ID/version;
- readiness state;
- configurable delay/error/crash;
- stateful counter/order endpoint with idempotency keys;
- connection/request IDs;
- graceful shutdown/drain mode.

### Load balancer modes

- TCP L4;
- HTTP L7;
- round-robin;
- least-connections;
- weighted;
- source/consistent hash where supported;
- active health checks;
- backend TLS optional;
- proxy protocol or forwarded headers with trust validation.

### Experiments

1. Distribution by connection/request.
2. Backend slow/unhealthy.
3. One backend removed/drained.
4. Rolling version change.
5. Health-check flapping.
6. All backends unavailable.
7. Queue/backlog saturation.
8. Client timeout versus proxy/backend timeouts.
9. Retry safe GET.
10. Retry unsafe POST with/without idempotency key.
11. Sticky session and lost backend.
12. Source IP/header spoofing.
13. TLS termination then backend plaintext/TLS comparison.
14. DNS TTL change to second load balancer.

### Evidence

- HAProxy stats/logs;
- backend request logs;
- connection captures;
- request distribution table;
- latency/error percentiles;
- health state transitions;
- client-visible status/body;
- no manual progress table beyond generated test results.

### Optional HA experiment

Run two load balancers with keepalived VRRP on isolated segment. Move VIP after primary failure and measure:

- convergence;
- ARP/NA update;
- existing versus new connection behavior;
- split-brain prevention assumptions.

## Дополнительный эксперимент

Implement simple client-side balancer in Go using DNS records and health observations. Compare stale endpoint/cache behavior with central proxy.

Alternative: consistent hashing of keys and remapping percentage when backend added/removed.

## Самопроверка

1. How do L4 and L7 balancing differ?
2. What is balanced: connection or request?
3. Why can keep-alive skew distribution?
4. How do liveness and readiness differ?
5. Why can aggressive health checks cause load?
6. What is session affinity cost?
7. Why can retry duplicate work?
8. How do timeout layers interact?
9. Why is one load balancer not high availability?
10. How can client identity be preserved safely?
11. What happens to existing connections during failover?

Практическая проверка: given client errors, HAProxy state and backend logs, distinguish DNS, listener, health, algorithm, capacity, timeout, retry and application failure.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Load balancing layers** — DNS, L4, L7 and client-side.
- **Balancing algorithms** — round-robin, least connections, weights and hashing.
- **Health checks** — liveness, readiness and functional health.
- **Connection reuse and distribution** — keep-alive/HTTP2 effects.
- **Retries and timeout budgets** — idempotency and amplification.
- **Session affinity** — state coupling and failure.
- **Load balancer high availability** — VIP/VRRP/anycast overview.
- **Source identity through proxy** — PROXY protocol and trusted headers.

## Когда переходить дальше

Можно переходить, когда L4/L7 modes and health/failure scenarios are measured, retries preserve semantics, and distribution is explained through connection behavior rather than expected round-robin alone.