# Спринт 17. Поиск с возвратом и branch and bound

Ориентировочный объём: 16–23 часа.

## Центральный вопрос

Как systematically enumerate candidate space, restore state exactly and prune branches without discarding valid or optimal solutions?

## Результат спринта

После завершения необходимо уметь:

- model decision/search tree;
- implement choose → explore → unchoose;
- maintain incremental state/invariants;
- distinguish permutation, combination and subset generation;
- avoid duplicate solutions;
- add feasibility pruning;
- add lower/upper-bound pruning for optimization;
- distinguish backtracking, DFS enumeration and branch-and-bound;
- choose recursion or explicit stack;
- order candidates to find good bounds early;
- define exponential complexity honestly;
- stop after first/all/k solutions;
- use memoization when subproblems repeat;
- parallelize only coarse independent branches;
- validate pruning against brute-force oracle;
- enforce node/time/memory limits.

## Основной маршрут

### Шаг 1. Search-space design

Define state, choices, goal, invalid prefix and restore operation. State mutation must be reversible.

### Шаг 2. Backtracking

Practice subsets, permutations, N-Queens, Sudoku-like constraints and graph coloring on bounded inputs.

### Шаг 3. Pruning

Use constraint propagation, remaining-capacity tests, symmetry breaking and candidate ordering.

### Шаг 4. Branch and bound

For optimization maintain incumbent and optimistic bound. Bound must never prune a potentially better solution.

## Ресурсы

### Обязательный маршрут

- Skiena backtracking chapters.
- CLRS branch-and-bound overview/exercises.
- Algorithm Design Manual search techniques.
- Constraint-solving introductory material.

### Углубление

- SAT/CSP solvers;
- exact cover/Dancing Links;
- alpha-beta pruning;
- integer programming;
- parallel search.

## Практические задания

1. Generate subsets/combinations/permutations without duplicates.
2. Solve N-Queens with column/diagonal incremental state.
3. Solve bounded Sudoku/exact-cover-like puzzle.
4. Graph coloring with ordering and pruning.
5. Branch-and-bound knapsack/TSP for small n.

## Лабораторная работа

Создать `work/search-lab/`.

### Framework

Generic-enough runner records:

- nodes expanded;
- branches pruned by reason;
- maximum depth;
- incumbent improvements;
- solutions found;
- timeout/node-limit status.

### Solvers

- permutations/combinations;
- N-Queens;
- graph coloring;
- bounded knapsack branch-and-bound;
- small TSP or scheduling optimization.

### Requirements

- deterministic candidate order with optional heuristic modes;
- exact state restoration tests;
- brute-force oracle for tiny cases;
- pruning-on/off result equivalence;
- symmetry/duplicate handling;
- explicit limits/cancellation;
- result distinguishes proven optimal, feasible, none and interrupted;
- optional parallel top-level branches with shared incumbent synchronization.

### Failure scenarios

1. State not restored after recursion.
2. Duplicate candidates produce duplicate solutions.
3. Pruning condition is not logically necessary.
4. Bound underestimates/overestimates wrong direction.
5. Global incumbent race.
6. Timeout reported as no solution.
7. Recursion depth/input unbounded.
8. Memoization key omits state.
9. Symmetry breaking removes distinct solutions.

## Самопроверка

1. What is search tree?
2. What does unchoose restore?
3. Feasibility pruning versus bound pruning?
4. Backtracking versus branch and bound?
5. How prove pruning safe?
6. Why candidate ordering matters?
7. How avoid duplicates?
8. What does interrupted result mean?
9. When memoization helps?
10. Why exponential complexity remains?

## Результат для базы знаний

- **Backtracking pattern**.
- **Search tree and reversible state**.
- **Constraint pruning and symmetry breaking**.
- **Branch-and-bound and incumbent**.
- **Safe optimistic bounds**.
- **Enumeration limits and interrupted results**.

## Когда переходить дальше

Можно переходить, когда pruning-on/off results agree on bounded cases, state restoration is proven, and interrupted search never masquerades as infeasibility/optimality.