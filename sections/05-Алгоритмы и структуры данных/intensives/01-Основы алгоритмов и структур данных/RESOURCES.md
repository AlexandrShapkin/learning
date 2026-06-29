# Ресурсы интенсива

Это общая библиография. В каждом спринте указан минимальный маршрут; читать всё подряд не требуется.

## Основные книги

- *Introduction to Algorithms* (CLRS) — analysis, data structures and classical algorithms.
- *Algorithms*, Robert Sedgewick and Kevin Wayne — implementations, visual models and experiments.
- *The Algorithm Design Manual*, Steven Skiena — design patterns and problem modeling.
- *Open Data Structures*, Pat Morin — freely available implementations and analysis.
- *Algorithm Design*, Kleinberg and Tardos — correctness and design paradigms.
- *Data Structures and Algorithm Analysis*, Mark Allen Weiss.
- *Programming Pearls*, Jon Bentley — algorithm engineering and problem formulation.

## Курсы

- MIT 6.006 Introduction to Algorithms.
- MIT 6.046/6.1220 Design and Analysis of Algorithms.
- Princeton Algorithms I/II.
- Stanford algorithms courses by Tim Roughgarden.
- UC Berkeley CS61B materials for data structures.

## Analysis and correctness

- CLRS chapters on growth, recurrences, probabilistic and amortized analysis.
- Mathematics for Computer Science selected chapters on induction, invariants, graphs and probability.
- Concrete Mathematics selected sums/recurrences chapters.
- Go benchmarking and pprof documentation.

## Data structures

- Go standard library docs: `slices`, `sort`, `container/heap`, `container/list`.
- Open Data Structures chapters on arrays, lists, hashing, trees, heaps and graphs.
- Sedgewick chapters on union-find, searching and priority queues.

## Graphs

- CLRS graph chapters.
- Sedgewick Algorithms, graph sections.
- Stanford/Princeton graph lectures.
- NetworkX documentation only for small reference/visualization, not as primary implementation.

## String algorithms

- CLRS string matching chapter.
- *Algorithms on Strings, Trees, and Sequences*, Dan Gusfield, as advanced reference.
- Unicode/UTF-8 references from programming intensive.

## External and parallel algorithms

- *Algorithms and Data Structures for Massive Datasets*, Dzejla Medjedovic et al.
- Database system external sorting/hash join chapters as cross-reference.
- *Introduction to Parallel Algorithms and Architectures* selected concepts.
- Go scheduler/concurrency and profiling docs for implementation evidence.

## Practical references

- CP-Algorithms as secondary implementation/navigation reference; verify proofs and constraints independently.
- LeetCode/Codeforces/other platforms only as sources of representative tasks, not as curriculum backbone.
- Go Wiki and official blog for benchmark/testing patterns.

## Rules for sources

1. Start with the mandatory sections in the sprint.
2. Use textbook/lecture for model and proof; use implementation reference after attempting design.
3. Treat code snippets as hypotheses until tested against boundaries.
4. Do not copy platform solutions into the repository.
5. Compare at least one alternative algorithm or representation.
6. Complexity claim must state input model and operation being measured.
7. Current standard-library behavior is checked against installed Go documentation/source when relevant.