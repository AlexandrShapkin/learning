# Спринт 14. Рекурсия и разделяй и властвуй

Ориентировочный объём: 14–20 часов.

## Центральный вопрос

Когда self-similar decomposition simplifies correctness, и как recurrence, stack depth and combine cost determine total performance?

## Результат спринта

После завершения необходимо уметь:

- identify base case and decreasing measure;
- trace recursive call tree and stack depth;
- transform recursion into explicit stack/iteration;
- distinguish divide-and-conquer from simple recursion;
- derive recurrence for common algorithms;
- solve basic recurrences by substitution, recursion tree and Master theorem;
- analyze merge sort, binary search, exponentiation and quicksort;
- understand overlapping versus independent subproblems;
- apply tail-recursion concept without assuming Go optimization;
- choose threshold/hybrid algorithm;
- avoid repeated recomputation;
- handle recursive resource limits;
- prove correctness by induction;
- compare recursive/iterative implementations;
- parallelize independent subproblems cautiously.

## Основной маршрут

### Шаг 1. Recursive contract

For each function define:

```text
base cases
decreasing measure
inductive assumption
combination step
maximum depth
```

### Шаг 2. Divide and conquer

Study split → solve → combine. Analyze merge sort, closest simple examples and exponentiation by squaring.

### Шаг 3. Recurrences

Practice:

```text
T(n)=T(n-1)+O(1)
T(n)=T(n/2)+O(1)
T(n)=2T(n/2)+O(n)
T(n)=2T(n/2)+O(1)
```

### Шаг 4. Engineering

Consider input copying, allocations, recursion overhead, cutoff to insertion sort and parallel threshold.

## Ресурсы

### Обязательный маршрут

- CLRS recurrences/divide-and-conquer chapters.
- MIT 6.006/6.046 recurrence lectures.
- Mathematics for Computer Science induction material.
- Sedgewick divide-and-conquer examples.

### Углубление

- Akra–Bazzi;
- cache-oblivious divide-and-conquer;
- FFT;
- parallel fork-join algorithms;
- randomized recurrences.

## Практические задания

1. Implement recursive/iterative binary search and tree traversal.
2. Implement exponentiation by squaring with overflow policy.
3. Implement merge sort with reusable buffer and threshold variant.
4. Trace quicksort recursion depth by pivot distribution.
5. Convert flood-fill/DFS recursion to explicit stack.

## Лабораторная работа

Создать `work/divide-lab/`.

### Algorithms

- recursive/iterative binary search;
- merge sort variants;
- inversion count;
- exponentiation;
- maximum subarray divide-and-conquer versus linear;
- recursive matrix/block task optional.

### Requirements

- recurrence and depth documented per algorithm;
- counters for calls/combine operations;
- stack-depth guard;
- property tests versus reference;
- benchmark recursive/iterative/hybrid variants;
- avoid allocating full slices at every recursion;
- controlled parallel variant with threshold/work limit;
- cancellation/error propagation if parallel.

### Failure scenarios

1. Missing base case.
2. Measure does not decrease.
3. Midpoint split repeats same range.
4. Recursion depth O(n) unexpectedly.
5. Merge allocates O(n log n) total temporary memory.
6. Parallel recursion spawns unbounded goroutines.
7. Overlapping subproblems recomputed exponentially.
8. Recurrence ignores combine/copy cost.

## Самопроверка

1. What proves recursive termination?
2. Divide-and-conquer versus recursion?
3. What is recurrence?
4. How merge sort recurrence resolves?
5. Why quicksort depth may be O(n)?
6. Why Go tail recursion is not assumed optimized?
7. How explicit stack differs?
8. What are overlapping subproblems?
9. When hybrid threshold helps?
10. Why parallel recursion needs cutoff?

## Результат для базы знаний

- **Recursive base case and decreasing measure**.
- **Inductive correctness proof**.
- **Divide-and-conquer pattern**.
- **Recurrence relations and recursion trees**.
- **Master theorem practical use**.
- **Recursion depth and explicit stack**.
- **Hybrid and parallel divide-and-conquer**.

## Когда переходить дальше

Можно переходить, когда recurrences include all work, recursive depth is bounded/observed, and iterative/hybrid variants preserve correctness.