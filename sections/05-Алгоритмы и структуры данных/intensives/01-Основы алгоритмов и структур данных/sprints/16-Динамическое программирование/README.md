# Спринт 16. Динамическое программирование

Ориентировочный объём: 19–27 часов.

## Центральный вопрос

Как identify overlapping subproblems and sufficient state so repeated computation becomes a bounded recurrence without losing correctness?

## Результат спринта

После завершения необходимо уметь:

- recognize optimal substructure and overlapping subproblems;
- define DP state with sufficient information;
- derive transition and base cases;
- choose top-down memoization versus bottom-up tabulation;
- determine evaluation order from dependency graph;
- reconstruct one optimal solution;
- distinguish value/count/feasibility DP;
- reduce memory with rolling arrays when dependencies allow;
- analyze state count × transition cost;
- handle impossible states/infinity/overflow;
- implement sequence, grid, knapsack and interval-style examples;
- understand DAG shortest path as DP;
- avoid adding irrelevant dimensions;
- test against exhaustive oracle;
- distinguish DP from greedy and backtracking;
- optimize only after correct recurrence.

## Основной маршрут

### Шаг 1. State design

For every DP write:

```text
state meaning
base cases
transition
computation order
answer location
proof by induction
state count and transition cost
```

### Шаг 2. Memoization/tabulation

Compare call overhead, reachable-state sparsity, stack depth and deterministic iteration.

### Шаг 3. Representative families

- Fibonacci/stairs only as introduction;
- 0/1 knapsack/subset sum;
- longest common subsequence/edit distance;
- grid paths;
- weighted interval scheduling;
- coin change;
- DAG paths.

### Шаг 4. Reconstruction and optimization

Store parent/choice or recompute. Apply rolling memory only when old states are not needed for reconstruction.

## Ресурсы

### Обязательный маршрут

- CLRS dynamic programming chapters.
- Kleinberg–Tardos DP design.
- MIT 6.006/6.046 DP lectures.
- Skiena DP chapters.

### Углубление

- bitset DP;
- digit/tree DP;
- divide-and-conquer/Knuth optimization;
- profile DP;
- probabilistic DP;
- approximate DP.

## Практические задания

1. Derive memo/tab versions for knapsack and LCS.
2. Implement edit distance with reconstruction.
3. Weighted interval scheduling with binary-search predecessor.
4. Memory-optimize grid/LCS variants and state limitations.
5. Find incorrect recurrence counterexamples.

## Лабораторная работа

Создать `work/dp-lab/`.

### Solvers

- 0/1 knapsack;
- subset sum/count;
- LCS and edit distance;
- weighted interval scheduling;
- grid path with obstacles/weights;
- coin change variants;
- DAG longest/shortest path.

### Requirements

- each solver includes state/transition metadata in README/tests;
- exhaustive brute-force oracle for small instances;
- memo and table variants where informative;
- reconstruction validated against objective;
- impossible/overflow states explicit;
- counters for states/transitions/cache hits;
- benchmarks by relevant dimensions, not only one n;
- memory-profile table/rolling variants;
- randomized differential tests.

### Failure scenarios

1. State lacks necessary context.
2. Base case wrong/overwrites impossible state.
3. In-place update direction turns 0/1 into unbounded knapsack.
4. Integer infinity overflows.
5. Reconstruction disagrees with optimal value.
6. Memo sentinel conflicts with valid zero.
7. Evaluation order reads uncomputed state.
8. Memory optimization destroys needed history.
9. Exponential recursion without memoization.
10. State dimension too large for constraints.

## Самопроверка

1. What makes problem suitable for DP?
2. State versus transition?
3. Memoization versus tabulation?
4. How prove recurrence?
5. Complexity formula?
6. Why update direction matters in knapsack?
7. How reconstruct solution?
8. When rolling array is valid?
9. DP versus greedy/backtracking?
10. How detect state explosion?

## Результат для базы знаний

- **Dynamic-programming state and transition**.
- **Optimal substructure and overlapping subproblems**.
- **Memoization and tabulation**.
- **DP dependency order and correctness**.
- **Solution reconstruction**.
- **Memory optimization in DP**.
- **Knapsack, LCS, edit distance and interval DP**.
- **State explosion and multidimensional complexity**.

## Когда переходить дальше

Можно переходить, когда recurrences pass exhaustive small oracles, reconstruction is validated, and complexity is derived from all state dimensions and transitions.