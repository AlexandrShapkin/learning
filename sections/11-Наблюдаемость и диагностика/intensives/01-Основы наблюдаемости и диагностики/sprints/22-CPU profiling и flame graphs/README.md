# Спринт 22. CPU profiling и flame graphs

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как определить, где CPU time реально расходуется под representative workload, и отличить hot code, scheduler/runtime overhead and measurement artifacts?

## Результат спринта

После завершения необходимо уметь:

- различать wall time, CPU time and on-CPU samples;
- использовать Go CPU profile and `pprof`;
- читать top, call graph and flame graph;
- понимать flat versus cumulative cost;
- выбирать representative load and profile duration;
- сравнивать baseline and candidate profiles;
- учитывать sampling and inlining effects;
- отличать application, runtime, syscall and kernel CPU;
- использовать labels/tags for profile segmentation;
- проверять optimization through benchmarks and system metrics;
- избегать premature micro-optimization;
- оценивать profiling overhead.

## Основной маршрут

1. Create CPU-heavy path with known algorithmic inefficiency.
2. Capture baseline Go CPU profile under stable load.
3. Interpret flat/cumulative call stacks and flame graph.
4. Optimize one hotspot and compare throughput/latency/CPU.
5. Use `perf` to distinguish user/runtime/kernel contribution.

## Ресурсы

- Go `pprof` documentation.
- Brendan Gregg flame graph and CPU profiling material.
- Linux `perf` documentation.

## Лабораторная работа

Создать `work/cpu-profiling/`.

### Requirements

- workload, data set, concurrency and environment are fixed;
- warm-up and profile windows are explicit;
- profile is captured without exposing public debug endpoint;
- top and flame graph identify flat/cumulative hotspots;
- runtime/GC/syscall/kernel contribution is discussed;
- baseline and candidate use comparable load and release metadata;
- optimization improves at least one target metric without worsening guardrails;
- benchmark and production-like profile conclusions are separated;
- profile overhead and sample uncertainty are measured;
- raw profile is excluded from Git; concise findings and regeneration commands are committed.

### Failure scenarios

1. Profile is captured during startup rather than steady load.
2. Flat cost is optimized while cumulative caller remains bottleneck.
3. One synthetic microbenchmark is generalized to service behavior.
4. CPU profile misses off-CPU waiting and is interpreted as total latency.
5. Inlining/symbolization makes stacks misleading.
6. Debug profile endpoint is publicly accessible.
7. Optimization reduces CPU but increases allocations/latency/errors.
8. Different load/release is used for comparison.

## Самопроверка

1. CPU versus wall time?
2. Sampling profiler?
3. Flat versus cumulative cost?
4. Flame graph interpretation?
5. Runtime/GC/kernel contribution?
6. Representative workload?
7. Baseline/candidate comparability?
8. Why CPU profile misses waiting?
9. Profiling overhead?
10. How verify optimization?

## Результат для базы знаний

- **CPU profiling and sampling**.
- **Go pprof top, call graphs and flame graphs**.
- **Flat and cumulative CPU cost**.
- **Application, runtime and kernel CPU attribution**.
- **Profile-based optimization experiments**.

## Когда переходить дальше

Можно переходить, когда one CPU hotspot is identified under representative load and an optimization is confirmed by both profiles and service-level metrics.