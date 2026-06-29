# Спринт 09. Проверка структур данных

Ориентировочный объём: 10–16 часов.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 01–08.

## Исходная задача

Создать `work/collection-engine/` — единый command runner, выполняющий operation traces над несколькими structures:

```text
vector, deque, linked-list, hash-map, sorted-map,
balanced-tree, heap, trie
```

## Требования

- common trace format with seed and expected result;
- each structure exposes only meaningful operations;
- reference model for every implementation;
- invariants checked after mutations in debug/test mode;
- deterministic output;
- complexity counters separated from wall time;
- stdlib adapter included where available;
- generated workload distributions;
- memory/allocation benchmarks;
- one recommendation matrix generated from measured workload.

## Mandatory scenarios

1. Dynamic-array growth and shrink.
2. Linked-list head/tail/single-element deletion.
3. Ring/deque wraparound.
4. Hash collisions, tombstones and resize.
5. Binary-search duplicate boundaries.
6. Sorting all-equal/adversarial distributions.
7. BST degeneration.
8. Balanced-tree rotation/deletion.
9. B-tree split/merge.
10. Heap equal priorities/index updates.
11. Trie shared-prefix deletion and Unicode.
12. Aliasing/mutable output corruption.
13. Invalid comparator/hash contract.
14. Large input causing unexpected allocations.

## Blind selection

Randomly select six scenarios and diagnose from:

- failed invariant/property;
- minimal trace;
- operation counter;
- benchmark/profile evidence.

Do not patch by adding input-specific conditions before identifying broken invariant.

## Defense

1. How to choose array/list/deque?
2. Why hash table expected O(1)?
3. Sorted slice versus tree versus map?
4. How balance guarantees logarithmic height?
5. Heap versus sorted structure?
6. Trie versus hash map?
7. What is amortized cost?
8. How property/model tests differ from examples?
9. How locality changes equal Big-O implementations?
10. When stdlib should replace custom structure?

## Критерии прохождения

- all structures pass randomized differential traces;
- invariant failures minimize to reproducible trace;
- six blind cases are solved;
- benchmarks validate output and use same workload contract;
- no custom structure recommended without workload evidence;
- at least 8 of 10 defense answers are correct.

## Результат для базы знаний

Checkpoint-specific note не нужна. Исправить только notes where implementation disproved an assumption.