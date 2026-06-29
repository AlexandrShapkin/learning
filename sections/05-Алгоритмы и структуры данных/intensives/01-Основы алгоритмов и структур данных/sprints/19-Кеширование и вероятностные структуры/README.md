# Спринт 19. Кеширование и вероятностные структуры

Ориентировочный объём: 15–21 час.

## Центральный вопрос

Как ограниченная память может ускорять repeated access или отвечать приблизительно, и какие guarantees теряются из-за eviction policy, stale state и probabilistic error?

## Результат спринта

После завершения необходимо уметь:

- различать cache, memoization и persistent storage;
- объяснять hit, miss, eviction, capacity and working set;
- реализовывать FIFO, LRU and LFU policies;
- понимать hash map + doubly linked list design for LRU;
- определять TTL and expiration semantics;
- различать admission и eviction;
- понимать cache stampede and stale values conceptually;
- объяснять Bloom filter construction and false positives;
- рассчитывать approximate bit count/hash count/error rate;
- понимать absence of false negatives under valid operations;
- реализовывать Bloom filter and counting variant overview;
- понимать Count-Min Sketch or HyperLogLog at overview level;
- сравнивать exact set with probabilistic structure;
- тестировать deterministic policy and probabilistic bounds;
- учитывать hashing/adversarial keys;
- не использовать cache correctness-critical source of truth.

## Основной маршрут

### Шаг 1. Cache semantics

Define key/value identity, capacity metric, replacement policy, update behavior, TTL clock and concurrency boundary. LRU means recency of a specified operation, not vague “popular”.

### Шаг 2. Eviction policies

Implement FIFO, LRU and LFU. For LFU define tie-breaking and frequency aging limitations.

### Шаг 3. Bloom filter

Study bit array and k independent/derived hashes. False positive probability depends on inserted count, m and k; deletion is unsafe in ordinary Bloom filter.

### Шаг 4. Approximate structures

Review Count-Min Sketch and HyperLogLog to understand one-sided frequency error and cardinality estimation. Full implementation optional; one must be implemented as extension or capstone component.

## Ресурсы

### Обязательный маршрут

- CLRS/standard cache replacement background where applicable.
- *Algorithms and Data Structures for Massive Datasets* Bloom/filter chapters.
- Original Bloom filter concepts and reliable tutorials.
- Go hash/list/heap primitives from earlier sprints.

### Углубление

- ARC/TinyLFU;
- cache admission policies;
- stable/counting/scalable Bloom filters;
- Count-Min Sketch;
- HyperLogLog;
- distributed caching and consistent hashing.

## Практические задания

1. Implement FIFO/LRU/LFU caches with explicit capacity policy.
2. Generate access traces: scan, hot set, Zipf-like and phase change.
3. Measure hit ratio and operation cost by policy.
4. Implement Bloom filter with configurable expected n and false-positive rate.
5. Empirically measure false positives; assert no false negatives before unsupported deletion.
6. Compare exact set memory with Bloom filter.

## Лабораторная работа

Создать `work/cache-sketch-lab/`.

### Components

- cache interface and FIFO/LRU/LFU implementations;
- deterministic fake clock and TTL support;
- trace generator;
- Bloom filter;
- optional Count-Min Sketch;
- exact reference models;
- report generator.

### Requirements

- LRU operations maintain map/list invariants;
- LFU frequency/tie semantics explicit;
- capacity zero and oversize item policy tested;
- TTL expiration does not depend on wall-clock sleeps;
- randomized operation tests against slow reference;
- Bloom hash derivation/version persisted if serialized;
- false-positive experiment uses fixed seeds and confidence caveat;
- memory/hit-ratio comparisons by workload;
- no probabilistic result presented as exact membership.

### Failure scenarios

1. LRU updates map but not list.
2. Eviction leaves stale node/key.
3. LFU counters grow forever or ties nondeterministic.
4. TTL read promotes already expired entry.
5. Capacity measured by items when bytes required.
6. Cache stampede under concurrent miss optional.
7. Bloom parameters calculated for wrong n.
8. Hash modulo/serialization mismatch causes false negatives.
9. Ordinary Bloom deletion clears bits shared by other keys.

## Самопроверка

1. Cache versus memoization?
2. FIFO versus LRU versus LFU?
3. What is working set?
4. Why LRU uses map plus list?
5. What is admission versus eviction?
6. Bloom false positive/false negative guarantees?
7. How choose m and k?
8. Why ordinary Bloom cannot delete?
9. Exact set versus probabilistic filter?
10. Why cache cannot be source of truth?

## Результат для базы знаний

- **Cache hit, miss, capacity and eviction**.
- **FIFO, LRU and LFU policies**.
- **TTL and cache lifecycle**.
- **Bloom filter and false-positive probability**.
- **Counting Bloom/approximate structures overview**.
- **Exact versus probabilistic membership**.
- **Cache workload and hit-ratio analysis**.

## Когда переходить дальше

Можно переходить, когда cache policies match reference traces and Bloom behavior is explained through measured parameters rather than assumed accuracy.