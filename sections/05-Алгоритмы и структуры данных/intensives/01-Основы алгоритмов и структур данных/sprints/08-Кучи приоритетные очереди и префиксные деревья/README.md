# Спринт 08. Кучи, приоритетные очереди и префиксные деревья

Ориентировочный объём: 15–21 час.

## Центральный вопрос

Как специализированные tree-like structures optimize repeated extremum extraction and prefix-based lookup without maintaining full global order?

## Результат спринта

После завершения необходимо уметь:

- define priority queue operations;
- implement binary min/max heap in array;
- map parent/child indices and heap invariant;
- implement sift-up, sift-down, heapify, push, pop, replace and fix;
- explain O(n) bottom-up heap construction;
- use heap for top-k, scheduling and heap sort;
- understand indexed priority queue/decrease-key;
- use Go `container/heap` correctly;
- define trie and prefix lookup;
- implement rune/byte-aware trie policy;
- support insert, exact search, prefix enumeration and delete;
- compare trie with hash map/sorted strings;
- understand memory overhead/compression options;
- test duplicate priorities and stable tie-breaking;
- diagnose stale index and structural corruption.

## Основной маршрут

### Шаг 1. Binary heap

Study complete-tree array layout and heap invariant. Prove sift operations.

### Шаг 2. Priority queue applications

Implement scheduler/top-k/k-way merge and indexed heap for graph algorithms.

### Шаг 3. Trie

Study prefix sharing and branching by bytes/runes. Define normalization/case policy explicitly.

### Шаг 4. Representation comparison

Heap is partially ordered, trie is prefix ordered; neither replaces a general balanced map in all workloads.

## Ресурсы

### Обязательный маршрут

- CLRS heaps/priority queues.
- Sedgewick priority queues/tries.
- Go `container/heap` docs.
- Open Data Structures heaps/tries.

### Углубление

- d-ary, Fibonacci and pairing heaps;
- radix/Patricia tries;
- DAWG/FST;
- succinct tries;
- cache-efficient heaps.

## Практические задания

1. Implement generic heap and compare incremental build with bottom-up heapify.
2. Implement indexed heap supporting priority update/removal.
3. Solve top-k and k-way merge without full sorting.
4. Implement trie with exact/prefix/delete.
5. Compare byte and rune trie for Unicode datasets.

## Лабораторная работа

Создать `work/priority-prefix-lab/`.

### Components

- binary heap and indexed priority queue;
- stdlib heap adapter;
- event scheduler simulation;
- k-way sorted-stream merger;
- trie autocomplete service;
- generators for priorities/words/prefix distributions.

### Requirements

- invariant checks after every operation in tests;
- differential tests against sorted reference;
- stable tie-breaking through sequence IDs where required;
- update/remove indexes remain correct after swaps;
- trie normalization policy explicit;
- autocomplete ranking separated from prefix lookup;
- memory/node-count report;
- benchmarks by k, heap size, prefix sharing;
- no full sort hidden in top-k implementation.

### Failure scenarios

1. Empty pop.
2. One-child sift-down.
3. Equal priorities reorder unexpectedly.
4. Indexed item stores stale index.
5. Heapify loop boundary wrong.
6. Trie deletion removes shared prefix.
7. Unicode byte/rune mismatch.
8. Prefix result ordering nondeterministic.
9. Unbounded trie memory from hostile keys.

## Самопроверка

1. What is heap invariant?
2. Why root is extremum but array not sorted?
3. Why heapify is O(n)?
4. Priority queue versus sorted array?
5. What is decrease-key?
6. How top-k uses heap?
7. What does trie share?
8. Trie versus hash map for prefix search?
9. Why Unicode policy matters?
10. How stable tie-breaking is added?

## Результат для базы знаний

- **Binary heap and heap invariant**.
- **Priority queue operations**.
- **Bottom-up heap construction**.
- **Indexed priority queue and decrease-key**.
- **Top-k and k-way merge**.
- **Trie and prefix search**.
- **Trie memory/normalization trade-offs**.

## Когда переходить дальше

Можно переходить, когда heap/index invariants survive randomized updates and trie operations preserve shared prefixes under deletion.