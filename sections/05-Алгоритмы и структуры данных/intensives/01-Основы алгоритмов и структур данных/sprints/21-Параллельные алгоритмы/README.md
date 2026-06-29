# Спринт 21. Параллельные алгоритмы

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Как divide work across processors while preserving correctness, bounding coordination and understanding why more workers do not imply proportional speedup?

## Результат спринта

После завершения необходимо уметь:

- distinguish concurrency from parallel algorithmism;
- define work T1 and span T∞;
- reason about theoretical parallelism T1/T∞;
- apply Amdahl and overhead limits;
- identify data/task parallelism;
- implement bounded parallel map/reduce;
- implement parallel divide-and-conquer with thresholds;
- understand parallel scan/prefix sum concept;
- avoid races and false sharing overview;
- choose partition/grain size;
- balance uneven work;
- propagate cancellation/errors;
- validate deterministic/non-deterministic result contracts;
- measure speedup, efficiency and scalability;
- distinguish CPU, memory-bandwidth and synchronization limits;
- understand when sequential algorithm is preferable;
- avoid parallelizing inherently sequential dependency chains.

## Основной маршрут

### Шаг 1. Work/span model

Study DAG of dependencies. Work is all operations; span is longest dependent chain. Lower bound on P processors is max(T1/P, T∞).

### Шаг 2. Parallel patterns

- partitioned map;
- reduction tree;
- fork-join divide-and-conquer;
- pipeline versus parallel computation;
- prefix scan overview.

### Шаг 3. Costs

Task creation, synchronization, copying, cache coherence and memory bandwidth can dominate small tasks.

### Шаг 4. Go implementation

Use bounded goroutines/worker pools and thresholds. Race detector and deterministic correctness tests remain mandatory.

## Ресурсы

### Обязательный маршрут

- CLRS parallel algorithms chapter where available.
- MIT parallel algorithms/work-span lectures.
- Go concurrency, race detector and profiling docs.
- Amdahl's law and parallel efficiency references.

### Углубление

- work stealing;
- parallel sorting/graphs;
- SIMD/vectorization;
- GPU algorithms;
- NUMA;
- lock-free structures.

## Практические задания

1. Parallel sum/reduction with deterministic overflow policy.
2. Parallel merge sort with size threshold.
3. Parallel file/chunk processing with bounded memory.
4. Prefix scan implementation or detailed experiment.
5. Irregular task workload with static partition versus work queue.
6. False-sharing/contended counter comparison optional.

## Лабораторная работа

Создать `work/parallel-lab/`.

### Workloads

- CPU-heavy map/reduce;
- merge sort;
- histogram;
- graph frontier processing or batch BFS layer;
- variable-cost tasks;
- external run sorting integration.

### Requirements

- sequential reference for every workload;
- workers capped by flag and environment;
- grain/threshold configurable;
- error/cancellation stops owned work;
- no data races;
- deterministic output where promised;
- speedup measured for 1..P workers and multiple sizes;
- report T1, wall time, speedup, efficiency, allocations and CPU utilization;
- separate setup/I/O from CPU comparison;
- avoid oversubscription in nested parallelism.

### Failure scenarios

1. Shared accumulator race.
2. Reduction operation not associative/order-sensitive.
3. Too-small tasks slower than sequential.
4. Unbounded recursive goroutines.
5. Uneven static partitions leave cores idle.
6. Cancellation leaks workers.
7. Nested parallelism oversubscribes.
8. Memory bandwidth saturates.
9. Parallel output order unexpectedly changes semantics.
10. Benchmark compares different algorithms/inputs.

## Самопроверка

1. Work versus span?
2. What limits parallel speedup?
3. Amdahl's law?
4. Task versus data parallelism?
5. Why grain size matters?
6. What is load balancing?
7. When reduction is safe?
8. Why memory bandwidth can dominate?
9. Parallelism versus concurrency?
10. When sequential wins?

## Результат для базы знаний

- **Work and span model**.
- **Parallelism and Amdahl's law**.
- **Parallel map, reduce and divide-and-conquer**.
- **Grain size and scheduling overhead**.
- **Load balancing and work queues**.
- **Parallel speedup and efficiency**.
- **Memory bandwidth and synchronization limits**.

## Когда переходить дальше

Можно переходить, когда parallel variants match sequential results, race/cancellation tests pass, and speedup curves are explained by work, span and hardware limits.