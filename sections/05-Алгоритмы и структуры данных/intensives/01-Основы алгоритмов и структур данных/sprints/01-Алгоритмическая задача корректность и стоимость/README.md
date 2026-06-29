# Спринт 01. Алгоритмическая задача, корректность и стоимость

Ориентировочный объём: 12–17 часов.

## Центральный вопрос

Как превратить неформальное условие в точный computational contract, доказать корректность решения и оценить его стоимость до измерений?

## Результат спринта

После завершения необходимо уметь:

- выделять input domain, output, constraints и size parameter;
- определять preconditions, postconditions и invalid inputs;
- строить loop/representation invariants;
- доказывать partial correctness и termination;
- использовать induction для recursive/iterative algorithms;
- применять O, Ω и Θ к конкретной функции стоимости;
- различать worst, average, expected, best и amortized analysis;
- оценивать time and auxiliary space;
- считать простые sums и recurrence relations;
- понимать lower bound как ограничение модели вычисления;
- отделять algorithm complexity от implementation constants;
- строить reference implementation and oracle;
- проверять scaling экспериментом;
- выявлять adversarial input distribution;
- объяснять trade-off между временем, памятью и простотой.

## Основной маршрут

### Шаг 1. Формализация задачи

Для каждой задачи фиксировать:

```text
Input and representation
Valid domain and constraints
Output relation
Size parameter n
Required guarantees
Allowed time/memory
Boundary and invalid cases
```

### Шаг 2. Correctness

Изучить CLRS/Kleinberg sections on loop invariants and induction. Для iterative algorithm использовать:

```text
Initialization
Maintenance
Termination
Postcondition
```

Для recursive algorithm определить decreasing measure and base case.

### Шаг 3. Complexity

Изучить asymptotic notation, logarithms, common sums and recurrences. Практические классы:

```text
1, log n, n, n log n, n², n³, 2ⁿ, n!
```

Всегда указывать операцию и input model.

### Шаг 4. Amortized and expected analysis

Разобрать dynamic array append, binary counter и randomized behavior. Expected complexity не равна гарантии для каждого запуска.

## Ресурсы

### Обязательный маршрут

- CLRS chapters 1–4 and amortized-analysis introduction selectively.
- MIT 6.006 introductory lectures.
- Mathematics for Computer Science: induction and asymptotics.
- Go benchmark documentation.

### Альтернативные объяснения

- Skiena, chapters on algorithm analysis.
- Sedgewick, analysis of algorithms.

### Углубление

- Master theorem proof;
- potential/accounting methods;
- probabilistic analysis;
- decision-tree lower bounds;
- formal verification.

## Практические задания

### 1. Contract extraction

Для пяти неформальных задач записать exact contract, size parameter and constraints. Найти минимум три ambiguous interpretations в каждой.

### 2. Invariant proof

Доказать корректность:

- maximum in array;
- stable partition by predicate;
- Euclidean GCD;
- prefix sum construction;
- insertion sort inner/outer loops.

### 3. Cost counting

Посчитать primitive-operation counts для linear scan, triangular nested loop, doubling loop and divide-by-two loop. Сопоставить exact count and asymptotic class.

### 4. Scaling

Реализовать O(n), O(n log n), O(n²) synthetic workloads. Измерить multiple n, normalize by predicted growth and explain deviations.

## Лабораторная работа

Создать `work/complexity-lab/`.

### Components

- deterministic dataset generator by size/distribution/seed;
- reference algorithms;
- operation counter independent of wall-clock time;
- Go benchmarks;
- CSV/JSON output;
- plot script;
- invariant/property tests.

### Algorithms

- linear search;
- binary search on sorted input;
- duplicate detection by nested loops and map;
- prefix sums;
- dynamic-array-like append simulation;
- one recursive divide-and-conquer routine.

### Requirements

- output validated before timing;
- setup excluded from measured region;
- sizes chosen to show growth without excessive runtime;
- wall time and operation count compared;
- best/worst distributions explicit;
- memory allocations recorded;
- report generated automatically from results;
- no manually maintained progress table.

### Failure scenarios

1. Wrong size parameter selected.
2. Benchmark includes input generation.
3. Compiler eliminates result.
4. Average-case claim without distribution.
5. O(n) implementation allocates O(n²) bytes accidentally.
6. Recursive algorithm lacks decreasing measure.
7. Invariant true initially but not maintained.
8. One timing used as proof.

## Самопроверка

1. What is an algorithmic contract?
2. O versus Θ versus Ω?
3. Worst versus expected complexity?
4. What is amortized analysis?
5. Why constants still matter?
6. What is auxiliary space?
7. How does loop invariant prove correctness?
8. How is termination proved?
9. What is a size parameter?
10. Why benchmark cannot replace analysis?

## Результат для базы знаний

- **Algorithmic problem and size parameter**.
- **Precondition, postcondition and invariant**.
- **Partial and total correctness**.
- **Big O, Theta and Omega**.
- **Worst, average, expected and amortized complexity**.
- **Time and auxiliary-space analysis**.
- **Recurrence and growth classes**.
- **Algorithm scaling experiment**.

## Когда переходить дальше

Можно переходить, когда complexity claims state the operation/input model, invariants are written for representative algorithms, and scaling results are reproduced from scripts.