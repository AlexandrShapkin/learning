# Спринт 18. Префиксные суммы, два указателя и скользящее окно

Ориентировочный объём: 13–19 часов.

## Центральный вопрос

Как exploit sequence order and incremental range changes to replace repeated O(n) recomputation with one-pass or logarithmic queries?

## Результат спринта

После завершения необходимо уметь:

- build one/two-dimensional prefix sums;
- answer static range queries;
- use difference arrays for batch range updates;
- apply two pointers on sorted/monotonic structures;
- design fixed and variable sliding windows;
- maintain counts/sums/deques incrementally;
- recognize monotonic-window preconditions;
- use monotonic queue for window extrema;
- distinguish contiguous subsequence from subset/subsequence;
- handle negatives where sum-window monotonicity fails;
- combine binary search/prefix sums;
- prove pointer movement is linear total;
- avoid off-by-one range conventions;
- choose map/window frequency structures;
- test all small arrays exhaustively;
- generalize patterns without memorizing problem templates blindly.

## Основной маршрут

### Шаг 1. Prefix/difference arrays

Use half-open range sums:

```text
prefix[0]=0
prefix[i+1]=prefix[i]+a[i]
sum(l,r)=prefix[r]-prefix[l]
```

### Шаг 2. Two pointers

Prove each pointer moves at most n under monotonic condition. Examples: pair sum sorted array, dedup, merge, partition.

### Шаг 3. Sliding window

Fixed window maintains aggregate; variable window requires property allowing left movement without missing solutions.

### Шаг 4. Monotonic deque

Maintain candidates for min/max while expiring old indices.

## Ресурсы

### Обязательный маршрут

- Skiena/Programming Pearls sequence techniques.
- CP-Algorithms prefix/two-pointer references as secondary.
- Go slice/deque implementation review.
- selected contest/course problems only as representative examples.

### Углубление

- Fenwick/segment trees;
- Mo's algorithm;
- streaming sketches;
- multidimensional integral images;
- convex hull trick.

## Практические задания

1. Prefix sums/range queries and difference updates.
2. Pair/three-sum variants on sorted data.
3. Longest/shortest window satisfying monotonic constraints.
4. Minimum-window frequency matching.
5. Window max with monotonic deque.
6. Counterexample: positive-number sum window applied to negative values.

## Лабораторная работа

Создать `work/range-pattern-lab/`.

### Solvers

- static range sum 1D/2D;
- batch range increments;
- sorted pair sum;
- dedup/merge;
- longest distinct window;
- minimum covering window;
- minimum length sum ≥ target for nonnegative values;
- sliding min/max.

### Requirements

- range convention explicit;
- exhaustive comparison with O(n²/O(n³)) oracle on small arrays;
- negative-value preconditions enforced;
- Unicode policy for text window;
- operation counters proving total pointer movement;
- streaming fixed-window mode;
- benchmarks by alphabet/value distribution/window behavior;
- no hidden sorting when original-order semantics matter.

### Failure scenarios

1. Prefix off-by-one.
2. Empty range/window.
3. Left pointer advances before condition recorded.
4. Negative values invalidate monotonic sum logic.
5. Duplicate frequency decrement wrong.
6. Deque expires wrong index or loses equal extrema.
7. Integer prefix overflow.
8. Sorted copy changes required original indices.

## Самопроверка

1. Why prefix sum answers range in O(1)?
2. Difference array use?
3. Why two pointers total O(n)?
4. What property enables variable window?
5. Why negative values break some windows?
6. Fixed versus variable window?
7. How monotonic deque finds extrema?
8. Subarray versus subsequence/subset?
9. How preserve original indices after sorting?
10. What oracle checks pattern correctness?

## Результат для базы знаний

- **Prefix sums and range queries**.
- **Difference arrays**.
- **Two-pointer technique**.
- **Sliding-window invariant**.
- **Monotonic deque for window extrema**.
- **Pattern preconditions and counterexamples**.

## Когда переходить дальше

Можно переходить, когда optimized solvers agree exhaustively with brute-force oracles and every pattern states the monotonic/order precondition that makes it valid.