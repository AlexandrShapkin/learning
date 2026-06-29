# Спринт 04. Бинарный поиск и упорядоченные данные

Ориентировочный объём: 12–18 часов.

## Центральный вопрос

Когда monotonic/order property allows logarithmic search, и как избежать boundary errors in half-open intervals and predicates?

## Результат спринта

После завершения необходимо уметь:

- state binary-search precondition;
- implement exact search, lower bound and upper bound;
- use half-open intervals `[lo, hi)`;
- prove invariant and termination;
- handle duplicates and absent target;
- perform binary search on monotonic predicate/answer;
- understand comparison model and O(log n);
- compare sorted slice lookup with map/tree;
- maintain sorted data with insertion cost;
- use Go `sort.Search`, `slices.BinarySearch` correctly;
- detect overflow in midpoint in general languages;
- design comparator/order contract;
- test all small arrays exhaustively;
- distinguish binary search from two-pointer/window methods.

## Основной маршрут

### Шаг 1. Exact and boundary searches

Implement exact membership, first `>= x`, first `> x`, last `<= x`. Prefer one generalized lower-bound primitive.

### Шаг 2. Invariant

For predicate search use:

```text
all indices < lo are false
all indices >= hi are true
answer remains in [lo, hi)
```

Adapt exact invariant explicitly.

### Шаг 3. Search on answer

Use monotonic feasibility function for minimal capacity/time/value. Prove monotonicity before searching.

### Шаг 4. Ordered representation

Compare lookup-heavy/read-mostly sorted slices with hash maps and trees, including insertion/rebuild cost and memory locality.

## Ресурсы

### Обязательный маршрут

- CLRS binary search exercises/analysis.
- Go `sort.Search` and `slices.BinarySearch` docs.
- Programming Pearls binary search discussion.
- MIT 6.006 ordered search material.

### Альтернативные объяснения

- CP-Algorithms binary search as secondary reference.
- Sedgewick ordered symbol tables.

### Углубление

- interpolation/exponential search;
- fractional cascading;
- branchless/vectorized search;
- learned indexes.

## Практические задания

### 1. Exhaustive correctness

Generate all sorted integer arrays up to small length with duplicates and compare lower/upper bound to linear oracle.

### 2. Predicate search

Solve minimal feasible capacity, earliest timestamp and square-root floor using monotonic predicates. State domains/overflow rules.

### 3. Sorted dictionary

Implement immutable sorted key/value table with binary search and batch rebuild. Compare with map for read-heavy workload.

### 4. Broken variants

Create off-by-one/infinite-loop examples and use invariant to identify defect, not trial fixes.

## Лабораторная работа

Создать `work/searchlab/`.

### Algorithms

- linear search;
- exact binary search;
- lower/upper bound;
- exponential search plus binary range;
- search on monotonic answer;
- sorted-table lookup.

### Requirements

- generic comparator/order support where appropriate;
- exhaustive tests for small domains;
- differential tests against stdlib/linear oracle;
- integer boundary tests;
- duplicate semantics explicit;
- benchmarks by size and hit distribution;
- comparison with map including build/update cost;
- optional branch/cache counters;
- report on when sorted slice wins in complete workload.

### Failure scenarios

1. Empty/single-element input.
2. Target before/after range.
3. All elements equal.
4. Duplicate first/last confusion.
5. Predicate not monotonic.
6. Midpoint/interval fails to shrink.
7. Comparator violates order.
8. Search benchmark excludes expensive sorted-data maintenance unfairly.

## Самопроверка

1. What precondition enables binary search?
2. Why half-open interval useful?
3. Exact versus lower bound?
4. How prove termination?
5. How handle duplicates?
6. What is search on answer?
7. Why predicate must be monotonic?
8. Binary search versus map lookup trade-off?
9. Why sorted insert is O(n) in slice?
10. What does exhaustive small-domain testing find?

## Результат для базы знаний

- **Binary-search precondition**.
- **Half-open interval invariant**.
- **Exact search, lower bound and upper bound**.
- **Binary search on monotonic predicate**.
- **Ordered slice as dictionary**.
- **Binary-search boundary failures**.

## Когда переходить дальше

Можно переходить, когда generalized search passes exhaustive tests and every variant has a written invariant and monotonicity proof.