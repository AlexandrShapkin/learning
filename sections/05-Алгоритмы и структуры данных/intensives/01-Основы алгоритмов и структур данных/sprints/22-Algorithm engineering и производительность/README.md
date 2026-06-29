# Спринт 22. Algorithm engineering и производительность

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Почему two implementations with same asymptotic complexity can differ radically, и как choose/optimize using representative workloads and system evidence?

## Результат спринта

После завершения необходимо уметь:

- connect asymptotic model with constants and input distribution;
- establish representative workload and correctness checksum;
- use Go benchmarks, benchstat, pprof and trace;
- inspect allocations, CPU hotspots and contention;
- reason about locality, cache misses and pointer chasing;
- understand branch predictability/vectorization overview;
- compare contiguous and linked structures empirically;
- choose AoS versus SoA conceptually;
- reduce allocation/copying only where measured;
- distinguish algorithmic from implementation bottleneck;
- understand latency percentiles versus throughput;
- avoid benchmark pitfalls and overfitting;
- use stdlib optimized algorithms as baseline;
- design fallback for adversarial/worst-case input;
- document performance budget and regression test;
- stop optimizing when constraint is met.

## Основной маршрут

### Шаг 1. Measurement contract

```text
question
representative dataset/distribution
correctness validation
baseline
metrics
noise controls
comparison method
```

### Шаг 2. CPU/memory behavior

Compare operation counts with CPU time, allocations and optional cache/branch counters. Big O remains necessary but incomplete.

### Шаг 3. Algorithm selection

Examples:

- hash map versus sorted slice/tree;
- list versus slice;
- comparison versus radix sort;
- heap top-k versus full sort;
- dense matrix versus adjacency list;
- DP memory layouts.

### Шаг 4. Robustness

Add thresholds, hybrid algorithms, randomized pivots, capacity bounds and worst-case fallback.

## Ресурсы

### Обязательный маршрут

- Programming Pearls selected chapters.
- Go benchmarking/pprof/trace docs.
- Brendan Gregg performance methodology.
- Sedgewick empirical algorithm analysis.

### Углубление

- PGO;
- cache-oblivious algorithms;
- SIMD/intrinsics;
- NUMA;
- branchless algorithms;
- succinct structures;
- autotuning.

## Практические задания

1. Compare slice/list traversal and random updates.
2. Compare map/sorted slice/balanced tree under mixed workloads.
3. Compare stdlib sort with educational variants by distribution.
4. Profile DP implementations with row/column traversal/layout.
5. Find break-even n for brute/simple versus asymptotically better algorithm.
6. Add adversarial fallback to quicksort/hash-like experiment.

## Лабораторная работа

Создать `work/engineering-lab/`.

### Benchmark matrix

- sizes on logarithmic scale;
- multiple distributions;
- warm/cold/read/write mixes;
- memory budgets;
- worker counts where relevant;
- stdlib/reference/custom variants.

### Requirements

- output checksum/invariants validated;
- generation outside measured region or consistently included by question;
- repeated runs and benchstat;
- Go/CPU/OS metadata;
- CPU and memory profiles for selected anomalies;
- optional `perf stat` counters;
- break-even and scaling charts generated;
- conclusions limited to tested context;
- one optimization rejected because evidence shows no benefit;
- regression benchmark threshold broad enough for normal noise.

### Failure scenarios

1. Benchmark optimized away.
2. Different algorithms receive different data/copy cost.
3. Setup dominates tiny benchmark.
4. One run/noise interpreted as gain.
5. Big-O claim ignores input distribution.
6. Profile workload unrepresentative.
7. Fewer allocations but slower CPU/greater retention.
8. Cache effect confused with algorithm complexity.
9. Optimization breaks worst-case or correctness.
10. Microbenchmark improvement harms end-to-end behavior.

## Самопроверка

1. Why same Big O differs?
2. What is representative workload?
3. Operation count versus wall time?
4. What does allocation profile show?
5. How locality affects list/slice?
6. What is break-even point?
7. Why stdlib is baseline?
8. How protect adversarial worst case?
9. Why one benchmark insufficient?
10. When stop optimizing?

## Результат для базы знаний

- **Algorithm engineering**.
- **Constants, distributions and asymptotic complexity**.
- **Data locality and pointer chasing**.
- **Benchmark methodology for algorithms**.
- **Break-even analysis**.
- **Hybrid algorithms and worst-case fallback**.
- **Algorithmic versus implementation bottleneck**.
- **Performance budget and regression**.

## Когда переходить дальше

Можно переходить, когда benchmark matrix is reproducible, profiles explain deviations from operation counts, and recommendations are constrained to explicit workloads.