# Спринт 25. Load testing, benchmarks и performance experiments

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как создать controlled performance experiment that reproduces workload shape, measures saturation and distinguishes benchmark artifacts from real service limits?

## Результат спринта

После завершения необходимо уметь:

- distinguish microbenchmark, component benchmark and load test;
- define workload model, arrival rate, concurrency and data set;
- understand open versus closed workload models;
- warm up caches/runtime and define steady state;
- measure throughput, latency distribution, errors and saturation together;
- identify coordinated omission and client bottlenecks;
- compare baseline/candidate statistically and operationally;
- vary one factor at a time;
- perform capacity/saturation and soak tests;
- preserve release/config/environment metadata;
- profile during representative load;
- bound tests to protect host and dependencies.

## Основной маршрут

1. Write Go benchmarks for one pure component and database path.
2. Build HTTP load test with fixed arrival-rate and closed-concurrency modes.
3. Find saturation knee through step/ramp load.
4. Run a bounded soak test for leak/backlog behavior.
5. Compare optimized and baseline releases with profiles.

## Ресурсы

- Go benchmark documentation.
- k6/Vegeta workload-model docs.
- systems performance and coordinated-omission references.

## Лабораторная работа

Создать `work/performance-experiments/`.

### Requirements

- hypothesis, workload/data/environment and success criteria are written before test;
- generator capacity is verified independently;
- open and closed workload behavior is compared;
- latency includes distribution/tail and error/timeout counts;
- server/dependency/resource saturation is collected concurrently;
- warm-up and measurement windows are explicit;
- coordinated omission is demonstrated or prevented;
- candidate/baseline use same inputs and stable environment;
- soak test includes memory, goroutines, queue age and storage growth;
- one result is rejected as benchmark artifact with evidence;
- all tests have request/concurrency/duration caps and cleanup.

### Failure scenarios

1. Load generator CPU/network becomes bottleneck.
2. Closed model hides overload by reducing arrivals.
3. Average latency hides tail/errors.
4. Benchmark runs on different data/cache state.
5. Warm-up/GC/startup dominates measurement.
6. Multiple code/config variables change together.
7. Coordinated omission reports unrealistically good latency.
8. Load test damages shared environment/data.
9. Throughput improves while error rate or resource cost worsens.

## Самопроверка

1. Benchmark versus load test?
2. Open versus closed model?
3. Coordinated omission?
4. Saturation knee?
5. Warm-up/steady state?
6. Generator bottleneck?
7. Baseline/candidate comparability?
8. Soak-test signals?
9. One-factor experiment?
10. Performance guardrails?

## Результат для базы знаний

- **Microbenchmarks, component benchmarks and load tests**.
- **Open and closed workload models**.
- **Coordinated omission in latency measurement**.
- **Saturation and soak testing**.
- **Performance experiment design and guardrails**.

## Когда переходить дальше

Можно переходить, когда the service saturation point is reproduced under a documented workload and the generator/measurement method is proven not to be the limiting factor.