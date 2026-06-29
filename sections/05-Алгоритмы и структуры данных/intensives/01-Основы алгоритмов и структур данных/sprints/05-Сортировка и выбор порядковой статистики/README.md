# Спринт 05. Сортировка и выбор порядковой статистики

Ориентировочный объём: 17–24 часа.

## Центральный вопрос

Как переставить elements into order, какие guarantees различают sorting algorithms и когда full sort is unnecessary?

## Результат спринта

После завершения необходимо уметь:

- define total/strict weak order and comparator requirements;
- distinguish stable, in-place, adaptive and comparison sorting;
- implement insertion, selection, merge, quick and heap sort;
- understand partition invariants;
- analyze best/average/worst and auxiliary space;
- explain Ω(n log n) comparison lower bound;
- use counting/radix sort under valid key assumptions;
- select kth element via heap/quickselect;
- understand introspective/stdlib hybrid strategies conceptually;
- handle duplicates and equal keys;
- compare sort algorithms by distribution and memory;
- use Go `sort`/`slices` correctly;
- detect comparator inconsistency;
- verify permutation, order and stability properties;
- measure locality/allocations and recursion depth.

## Основной маршрут

### Шаг 1. Simple sorts

Implement insertion and selection sort. Use them to practice invariants and adaptive behavior.

### Шаг 2. Merge and quicksort

Study divide-and-conquer, merge correctness, partition schemes and randomized pivot. Never claim quicksort worst O(n log n).

### Шаг 3. Heap and non-comparison sorts

Implement heap sort and counting/radix for bounded integer/string-like keys.

### Шаг 4. Selection

Implement heap-based top-k and randomized quickselect. Full sorting may be unnecessary.

## Ресурсы

### Обязательный маршрут

- CLRS sorting/selection chapters.
- Sedgewick sorting chapters.
- Go `sort` and `slices` docs/source overview.
- MIT 6.006 sorting lectures.

### Альтернативные объяснения

- Princeton Algorithms sorting visualizations.
- Programming Pearls sorting/selection examples.

### Углубление

- TimSort/PDQsort/introsort;
- sample sort;
- sorting networks;
- parallel/external sorting;
- cache-aware radix sort.

## Практические задания

### 1. Property suite

For every sort verify:

- output ordered;
- output is permutation;
- stable variant preserves original equal-key order;
- input mutation contract;
- comparator behavior.

### 2. Distributions

Test random, sorted, reverse, all-equal, few-unique, organ-pipe and adversarial pivot distributions.

### 3. Top-k

Compare full sort, min/max heap and quickselect for various k/n.

### 4. Comparator bug

Create non-transitive or overflow-prone comparator and observe incorrect behavior. Replace subtraction comparator with safe comparison.

## Лабораторная работа

Создать `work/sortlab/`.

### Implementations

- insertion/selection;
- stable merge sort;
- randomized three-way quicksort;
- heap sort;
- counting/radix sort for explicit domains;
- quickselect/top-k;
- stdlib adapter.

### Requirements

- generic comparable/ordered or comparator API;
- randomized and exhaustive small tests;
- stability test records key+original position;
- operation counters: comparisons, swaps/moves, allocations;
- benchmarks by n/distribution;
- recursion depth bounded or fallback;
- stdlib included as production baseline;
- charts generated from result data;
- conclusions separate algorithm from implementation effects.

### Failure scenarios

1. Empty/one element.
2. Many duplicates break partition progress.
3. Already sorted input causes quadratic quicksort.
4. Comparator inconsistent/non-transitive.
5. Merge loses stability.
6. Counting array too large for key range.
7. Integer comparator overflow.
8. Quickselect wrong duplicate partition.
9. Benchmark includes data generation/copy inconsistently.
10. Recursive quicksort stack depth excessive.

## Самопроверка

1. Stable versus in-place?
2. Insertion sort best case?
3. Merge sort time/space?
4. Quicksort average/worst?
5. What does partition invariant state?
6. Why comparison sorts have n log n lower bound?
7. When counting/radix sorting applies?
8. Why full sort unnecessary for kth/top-k?
9. How stdlib hybrid protects worst cases?
10. What makes comparator valid?

## Результат для базы знаний

- **Sorting properties: stability, in-place and adaptivity**.
- **Insertion, selection, merge, quick and heap sort**.
- **Quicksort partition and pivot selection**.
- **Comparison-sort lower bound**.
- **Counting and radix sort**.
- **Quickselect and top-k**.
- **Comparator contract**.
- **Sorting workload distributions**.

## Когда переходить дальше

Можно переходить, когда all variants pass permutation/order/stability properties and algorithm choice is supported by distribution-aware measurements.