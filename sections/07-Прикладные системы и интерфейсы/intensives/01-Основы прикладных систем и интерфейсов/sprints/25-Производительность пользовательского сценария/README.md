# Спринт 25. Производительность пользовательского сценария

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как измерить и улучшить complete user journey, разделив browser rendering, network, server queueing, application work, database and external dependency costs?

## Результат спринта

После завершения необходимо уметь:

- определять user-centric performance budget;
- различать navigation, interaction and confirmed-result latency;
- использовать Navigation, Resource and User Timing APIs;
- понимать browser main-thread work and rendering phases;
- измерять JavaScript bundle and resource waterfalls;
- находить layout shift and long-task causes;
- применять code/resource loading optimization only from evidence;
- измерять server latency segments and queue wait;
- различать throughput, concurrency, latency and saturation;
- измерять database/external calls inside journey;
- использовать caching/compression/batching cautiously;
- понимать N+1 from client and server;
- проектировать load model from user behavior;
- измерять cold/warm/authenticated/background paths;
- сравнивать p50/p95/p99 and failure rates;
- проводить capacity/load tests with correctness checks;
- отличать microbenchmark from end-to-end result;
- задавать regression budgets without overfitting noisy CI.

## Основной маршрут

### Шаг 1. Journey budget

For one critical scenario define:

```text
input-to-first feedback
input-to-useful content
input-to-confirmed durable result
background completion
error/retry feedback
resource/bundle/request budgets
```

### Шаг 2. Browser evidence

Capture network waterfall, performance trace, main-thread tasks, rendering/layout and user timing. Avoid optimizing synthetic score alone.

### Шаг 3. Server/dependency evidence

Use trace spans and metrics to split load balancer/queue, handler, authorization, database, cache, external call and serialization time.

### Шаг 4. Load and optimization

Generate representative users/think time/data distribution. Change one factor, preserve correctness checksum and compare tail latency/resource saturation.

## Ресурсы

- Browser Performance, Navigation/Resource/User Timing APIs.
- browser DevTools performance/network docs.
- Go benchmarks, pprof and trace docs.
- OpenTelemetry trace/metrics docs.
- systems performance and load-testing methodology.

## Практические задания

1. Instrument action-to-feedback and action-to-confirmed-result.
2. Analyze bundle/resource waterfall and lazy-loading trade-off.
3. Reproduce long task and layout shift.
4. Trace one request through browser, API, DB and external mock.
5. Build user-behavior load model with bounded concurrency.
6. Compare N+1, batch and cached paths.
7. Establish one rejected optimization that improves microbenchmark but hurts journey.

## Лабораторная работа

Создать `work/application-performance/`.

### Journeys

- initial authenticated load;
- search and detail navigation;
- create/edit submit;
- file upload plus background progress;
- external integration confirmation;
- notification/webhook-driven update.

### Requirements

- explicit performance budgets and representative environment;
- browser and server clocks/spans correlated where possible;
- request ID/trace ID linked in test report;
- user timing markers around real feedback/result;
- network throttling and cache conditions recorded;
- bundle/resource sizes reported;
- long tasks/layout shifts tied to source;
- server queue, handler, DB and external times separated;
- load test includes think time, data skew and auth sessions;
- correctness and error-rate checks under load;
- p50/p95/p99 plus throughput/resources;
- one-variable before/after experiments;
- no universal conclusions from one laptop;
- regression thresholds account for noise and protect meaningful budgets.

### Failure scenarios

1. API handler is fast but pool/queue wait dominates journey.
2. Initial bundle reduction increases repeated request/chunk latency unexpectedly.
3. Client fetches one request per list item.
4. Server renders/serializes huge unused payload.
5. Cache improves average but serves stale unauthorized data.
6. Load test has zero think time and unrealistic hot dataset.
7. p50 improves while p99/errors regress.
8. Browser trace taken with extensions/dev mode and treated as production.
9. Background completion excluded from user expectation.
10. Optimization breaks accessibility or correctness.
11. CI timing noise causes meaningless failure threshold.

## Самопроверка

1. User-perceived versus server latency?
2. First feedback versus confirmed result?
3. Navigation/Resource/User Timing roles?
4. What is long task/layout shift?
5. Throughput, concurrency and saturation?
6. Why tail percentiles matter?
7. What is representative user load?
8. How trace separates dependency costs?
9. Microbenchmark versus journey?
10. Why cache/batch/lazy load can trade costs?
11. What makes performance regression test useful?

## Результат для базы знаний

- **User-centric application performance budgets**.
- **Browser navigation, resource and user timing**.
- **Main-thread long tasks and layout stability**.
- **End-to-end trace decomposition**.
- **Application throughput, latency, concurrency and saturation**.
- **Representative user-journey load models**.
- **Tail latency and correctness under load**.
- **Performance regression and optimization evidence**.

## Когда переходить дальше

Можно переходить, когда one critical journey is decomposed end-to-end, tail/error/resource behavior is measured under representative load, and optimizations preserve accessibility and correctness.