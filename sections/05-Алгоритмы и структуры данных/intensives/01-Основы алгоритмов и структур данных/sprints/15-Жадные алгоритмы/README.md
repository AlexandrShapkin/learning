# Спринт 15. Жадные алгоритмы

Ориентировочный объём: 14–20 часов.

## Центральный вопрос

Когда locally optimal choice can be committed without backtracking, и каким exchange/cut argument доказать global optimality?

## Результат спринта

После завершения необходимо уметь:

- recognize greedy-choice and optimal-substructure candidates;
- construct counterexamples to naive greedy rules;
- use exchange argument;
- use staying-ahead argument;
- connect cut property to MST algorithms;
- solve interval scheduling and related problems;
- understand fractional versus 0/1 knapsack distinction;
- implement Huffman coding;
- understand greedy graph/color/scheduling heuristics versus guaranteed algorithms;
- compare greedy with DP/backtracking;
- state tie-breaking and feasibility invariants;
- prove algorithm remains extendable;
- distinguish optimal guarantee from approximation/heuristic;
- test small cases against exhaustive oracle;
- avoid selecting greedy only because it is fast/simple.

## Основной маршрут

### Шаг 1. Greedy template

```text
maintain feasible partial solution
choose locally best candidate
commit choice
prove some optimal solution can include it
repeat
```

### Шаг 2. Proof techniques

Study interval scheduling exchange proof, MST cut property and Huffman sibling property.

### Шаг 3. Counterexamples

Construct failures for earliest start, shortest interval, highest value, largest coin and 0/1 ratio-only choices.

### Шаг 4. Greedy versus DP

Identify when local choice removes no essential future option; otherwise use DP/search.

## Ресурсы

### Обязательный маршрут

- CLRS greedy chapters.
- Kleinberg–Tardos greedy design.
- MIT greedy lectures.
- Skiena scheduling/greedy sections.

### Углубление

- matroids;
- approximation algorithms;
- online algorithms;
- primal-dual method;
- submodular optimization.

## Практические задания

1. Interval scheduling and interval partitioning.
2. Fractional knapsack and 0/1 counterexample.
3. Huffman tree/codes with deterministic ties.
4. Canonical coin systems versus arbitrary denominations.
5. Job scheduling variants with exhaustive small oracle.

## Лабораторная работа

Создать `work/greedy-lab/`.

### Solvers

- maximum non-overlapping intervals;
- room/resource interval partitioning;
- fractional knapsack;
- Huffman encoder model;
- Kruskal reuse;
- configurable greedy rules for counterexample search.

### Requirements

- feasibility validator;
- exhaustive optimal oracle for bounded n;
- automatic smallest counterexample search for bad rules;
- exchange/cut proof sketch beside each guaranteed algorithm;
- deterministic tie policy;
- generated random/adversarial tests;
- compare greedy/DP/exhaustive cost and solution quality;
- distinguish exact, approximate and heuristic output metadata.

### Failure scenarios

1. Wrong interval sort key.
2. Endpoint overlap convention undefined.
3. Huffman tie makes tests nondeterministic.
4. Greedy 0/1 knapsack assumed optimal.
5. Coin greedy fails arbitrary denomination.
6. Feasibility violated after local choice.
7. Proof assumes property not present.
8. Heuristic result labeled optimal.

## Самопроверка

1. What is greedy-choice property?
2. What is optimal substructure?
3. Exchange argument?
4. Staying-ahead argument?
5. Why interval earliest-finish works?
6. Fractional versus 0/1 knapsack?
7. Why Huffman is greedy?
8. How exhaustive small oracle helps?
9. Greedy versus heuristic?
10. When DP is safer?

## Результат для базы знаний

- **Greedy algorithm pattern**.
- **Greedy-choice property**.
- **Exchange and staying-ahead proofs**.
- **Interval scheduling**.
- **Fractional knapsack**.
- **Huffman coding**.
- **Greedy counterexamples and heuristics**.

## Когда переходить дальше

Можно переходить, когда each greedy solver is backed by a valid proof or explicitly classified heuristic, and bad rules have concrete counterexamples.