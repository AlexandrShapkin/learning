# Спринт 05. Stateless scaling, affinity и backpressure

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как горизонтально масштабировать обработку запросов без скрытого локального состояния, неограниченных очередей и потери контроля над перегрузкой?

## Результат спринта

После завершения необходимо уметь:

- различать stateless compute and externally stored state;
- выявлять hidden session/cache/local-file affinity;
- выбирать sticky sessions only with explicit failure behavior;
- масштабировать workers by throughput and queue age;
- применять bounded queues and admission control;
- понимать backpressure propagation;
- различать concurrency and arrival rate;
- предотвращать load amplification by retries/fan-out;
- проектировать graceful scale-down and draining;
- учитывать cold start and cache warm-up;
- измерять saturation knee and per-instance capacity.

## Основной маршрут

1. Scale API from one to six replicas.
2. Break it through local session and local file state.
3. Move authoritative state out and compare affinity strategies.
4. Overload bounded and unbounded worker queues.

## Лабораторная работа

Создать `work/stateless-scaling/`.

### Requirements

- replica replacement does not lose authoritative user state;
- local cache is disposable and versioned/invalidated;
- affinity need and failure behavior are documented;
- request and worker concurrency limits are explicit;
- queues are bounded by size and age;
- producer receives slowdown/rejection signal under overload;
- scale-out is tested with cold instances;
- scale-down drains active work and releases leases;
- retries do not increase effective arrival rate without bound;
- capacity report identifies first bottleneck.

### Failure scenarios

1. Session stored only in one process.
2. Shared file volume becomes serialization bottleneck.
3. Unbounded queue causes memory exhaustion.
4. Autoscaling reacts after backlog violates latency target.
5. Sticky sessions pin hot customer to one instance.
6. Scale-down kills leased/in-flight work.
7. Cold cache causes synchronized dependency overload.

## Результат для базы знаний

- **Stateless horizontal scaling**.
- **Session affinity and hidden local state**.
- **Bounded queues and backpressure**.
- **Scaling workers by throughput and queue age**.
- **Cold-start and scale-down behavior**.

## Когда переходить дальше

Можно переходить, когда replica churn and overload preserve state correctness and produce bounded slowdown/rejection rather than hidden queue growth.