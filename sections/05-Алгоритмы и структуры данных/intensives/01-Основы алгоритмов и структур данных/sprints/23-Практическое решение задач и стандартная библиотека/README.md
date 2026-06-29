# Спринт 23. Практическое решение задач и стандартная библиотека

Ориентировочный объём: 16–23 часа.

## Центральный вопрос

Как reliably solve an unfamiliar problem by extracting structure and constraints, choosing the simplest sufficient algorithm and using proven library components where possible?

## Результат спринта

После завершения необходимо уметь:

- restate problem as exact contract;
- estimate feasible complexity from constraints;
- identify operation mix and candidate structures;
- create small examples/counterexamples;
- derive invariant/recurrence/greedy proof before coding;
- start with brute-force/reference solution;
- optimize one bottleneck while preserving oracle tests;
- choose standard library functions correctly;
- know when custom implementation is justified;
- handle boundary, malformed and adversarial inputs;
- create property/differential tests;
- estimate memory and stack depth;
- explain solution clearly without platform-specific memorization;
- recognize known patterns without forcing them;
- review code for hidden sort/allocation/conversion costs;
- verify complexity against implementation.

## Problem-solving loop

```text
clarify contract and constraints
→ derive feasible complexity
→ model data/operations
→ build brute/reference
→ find invariant/pattern
→ implement smallest correct solution
→ test boundaries/random cases
→ analyze actual complexity/resources
→ compare stdlib/alternative
→ simplify and document
```

## Standard library focus

Use and understand:

- `slices.Sort`, `SortFunc`, `BinarySearch`, `Compact`, `Delete`;
- `sort.Search`;
- `maps` helpers where appropriate;
- Go maps/sets-as-map;
- `container/heap`;
- `container/list` only with justified workload;
- `strings`/`bytes` search;
- `math/bits` for bit operations where relevant.

Custom structure is justified for missing operation/guarantee, learning experiment or measured constraint—not because interview solutions traditionally implement it.

## Practice set

Solve a curated set of approximately 30 representative problems, not hundreds of duplicates:

- 5 arrays/maps;
- 4 binary-search/sorting;
- 4 stack/queue/heap;
- 5 tree/graph;
- 3 strings;
- 3 greedy;
- 3 dynamic programming;
- 3 backtracking/window/prefix.

For each store only:

```text
problem contract/source link
constraints and chosen complexity
solution and tests
one alternative/counterexample
```

No progress spreadsheet.

## Лабораторная работа

Создать `work/problem-suite/`.

### Runner

```text
problems list
problems run ID --input FILE
problems verify ID --cases generated
problems compare ID VARIANTS
```

### Requirements

- each problem has parser/solver separated;
- brute/reference for small input where possible;
- randomized differential generation;
- examples and adversarial boundaries;
- complexity declaration checked against code review/counters;
- stdlib usage preferred and wrapped only if it adds contract;
- no copy of copyrighted problem statements beyond minimal contract/link;
- deterministic outputs;
- slow/exponential variants bounded;
- generated report shows patterns/failed assumptions, not completion percentage.

### Review checklist

1. Are constraints fully used?
2. Is size parameter correct?
3. Is selected structure aligned with operations?
4. Is invariant/proof valid?
5. Are overflow/index/empty/duplicate cases handled?
6. Does implementation match claimed complexity?
7. Can stdlib reduce risk?
8. Is there hidden mutation/aliasing?
9. Is optimized solution compared to oracle?
10. Is explanation simpler than code?

## Failure scenarios

- pattern forced despite violated precondition;
- sorting changes original-order requirement;
- recursion exceeds depth;
- integer overflow;
- map iteration causes flaky result;
- heap direction reversed;
- binary search predicate nonmonotonic;
- DP state incomplete;
- greedy lacks proof;
- complexity declaration ignores nested library call;
- custom implementation duplicates reliable stdlib badly.

## Самопроверка

1. How constraints imply feasible complexity?
2. Why start with brute force?
3. Pattern recognition versus proof?
4. How choose data structure from operations?
5. When stdlib preferable?
6. When custom structure justified?
7. How differential testing works?
8. How find hidden complexity?
9. Why adversarial cases matter?
10. What makes explanation complete?

## Результат для базы знаний

- **Practical algorithmic problem-solving loop**.
- **Constraint-driven complexity selection**.
- **Reference solution and differential testing**.
- **Pattern recognition with preconditions**.
- **Standard-library versus custom implementation**.
- **Algorithmic solution review checklist**.

## Когда переходить дальше

Можно переходить, когда representative suite is solved through consistent reasoning, every optimized solution has oracle evidence, and stdlib/custom choices are justified.