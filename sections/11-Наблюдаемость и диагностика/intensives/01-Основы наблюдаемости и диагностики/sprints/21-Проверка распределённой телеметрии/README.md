# Спринт 21. Проверка распределённой телеметрии

Ориентировочный объём: 14–21 час.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 16–20.

## Исходная задача

Создать `work/distributed-telemetry-checkpoint/` — OpenTelemetry-instrumented API, worker, PostgreSQL and external-provider path with Collector, trace store and cross-signal correlation.

## Required capabilities

- synchronous and asynchronous traces;
- resource and semantic attributes;
- logs with trace/span context;
- histogram exemplars;
- head and tail sampling comparison;
- Collector queues, batching and memory limits;
- trace/log/metric drill-down;
- explicit telemetry loss and correlation tests.

## Mandatory fault cases

1. HTTP propagation breaks at one service.
2. Queue producer/consumer relationship is lost.
3. Retry attempts collapse into one span.
4. Parallel child durations are summed incorrectly.
5. Connection-pool/queue wait is hidden.
6. Independent sampling creates partial trace.
7. Tail sampler exhausts capacity.
8. Baggage leaks sensitive/high-volume data.
9. Semantic attribute differs between services.
10. Collector exporter rejects/drops data.
11. Exemplar points to missing/expired trace.
12. Cross-store release/time identity is inconsistent.

## Defense

1. Trace/span/link and operation/attempt semantics?
2. How is context propagated across HTTP and queue?
3. How is critical path found?
4. Head versus tail sampling trade-offs?
5. What belongs in baggage?
6. How are semantic conventions enforced?
7. Collector backpressure and loss behavior?
8. How are errors and retries represented?
9. How are metrics/logs/traces correlated?
10. What does an exemplar prove?
11. How are partial/missing traces detected?
12. What uncertainty remains from sampling/clock skew?

## Критерии прохождения

- synchronous and asynchronous operations produce coherent traces;
- retries, fan-out, queue wait and critical path are visible;
- known rare/error/slow traces survive selected sampling policy;
- Collector outage/overload behavior is measured and bounded;
- logs, metrics and traces share canonical resource/release identity;
- exemplars and links preserve diagnostic context;
- all twelve faults are reproduced and diagnosed;
- absence of trace is never treated as absence of operation without sampling/pipeline evidence;
- at least 10 of 12 defense answers reference trace/collector/query evidence.

## Результат для базы знаний

Checkpoint-specific note не требуется. Update tracing notes where propagation, sampling or Collector behavior changed assumptions.