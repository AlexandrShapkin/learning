# Спринт 99. Итоговая работа

Ориентировочный объём: 38–58 часов.

## Задача

Создать `algolab` — воспроизводимую Go library and CLI platform для реализации, проверки, генерации workload, сравнения и диагностики алгоритмов и структур данных.

Проект не является соревновательной платформой или production database. Его цель — связать analysis, correctness, structures, graph/string algorithms, design paradigms, external/parallel processing and performance evidence в одной системе.

## Архитектура

```text
algolab CLI
├── generate datasets and operation traces
├── run reference/optimized algorithms
├── verify invariants and results
├── benchmark/profile/scale
├── inject bounded faults
└── minimize failing cases

library
├── structures
├── searching and sorting
├── trees/heaps/tries
├── graph and string algorithms
├── greedy/DP/backtracking patterns
├── cache/sketches
├── external and parallel algorithms
└── verification/diagnostics
```

## Структура проекта

```text
work/algolab/
├── cmd/algolab/
├── internal/
│   ├── model/
│   ├── datasets/
│   ├── structures/
│   ├── search/
│   ├── sorting/
│   ├── trees/
│   ├── graphs/
│   ├── strings/
│   ├── paradigms/
│   ├── external/
│   ├── parallel/
│   ├── verify/
│   ├── benchmark/
│   ├── diagnostics/
│   └── faults/
├── testdata/
├── scripts/
├── reports/
├── docs/
├── Makefile
├── go.mod
└── README.md
```

## Документы итоговой работы

- [`IMPLEMENTATION.md`](IMPLEMENTATION.md) — mandatory components and stages.
- [`FAULTS.md`](FAULTS.md) — catalogue of 50 bounded/reversible faults.
- [`ASSESSMENT.md`](ASSESSMENT.md) — blind incidents, final defense and delayed assessment.

## Основные требования

Готовая система должна включать:

- exact contracts and complexity metadata;
- reference and optimized implementations;
- arrays/lists/deques/hash tables/trees/heaps/tries/DSU;
- sorting, binary search and selection;
- graph traversal, SCC, shortest paths and MST;
- string matching;
- greedy, DP, backtracking and range-pattern examples;
- LRU/Bloom or similar cache/sketch components;
- external merge sort;
- bounded parallel algorithms;
- deterministic generators with seeds;
- example, exhaustive-small, randomized, property, differential and fuzz tests;
- invariant validators;
- operation counters and scaling experiments;
- benchmark/profile tooling;
- read-only `algotriage` and failure minimization;
- controlled adversarial inputs;
- standard-library comparison.

## Порядок выполнения

1. Define common contracts, dataset formats and result metadata.
2. Implement verification/reference framework.
3. Add basic structures/search/sort.
4. Add trees/heaps/tries/graphs/strings.
5. Add design paradigms and representative solvers.
6. Add cache/probabilistic structures.
7. Add external and parallel modes.
8. Add benchmark/profile/scaling reports.
9. Add fault injection and minimization.
10. Run blind incidents and delayed assessment.

## Обязательные артефакты

Коммитить:

- source and tests;
- small deterministic datasets/seeds;
- generator and benchmark scripts;
- invariant/property/fuzz corpus;
- concise generated scaling/profile summaries;
- diagrams for small structures/graphs;
- incident cards;
- commands to regenerate large datasets/results;
- links to `knowledge` notes.

Не коммитить:

- binaries and caches;
- large generated datasets;
- copied platform problem statements/solutions;
- raw huge profiles/charts without source;
- external/private data;
- uncontrolled exponential workloads;
- environment-specific temporary files.

## Safety

- every exponential algorithm has size/node/time limits;
- every generator has explicit seed and size;
- external processing uses dedicated temp directory and disk limit;
- parallel mode caps workers and nested parallelism;
- adversarial cases remain local and synthetic;
- fault modes are opt-in and bounded;
- cleanup verifies files/processes/resources;
- benchmark output is not treated as universal ranking.

## Результат для базы знаний

Итоговая работа должна завершить или уточнить заметки по complexity, correctness, structures, searching/sorting, trees, graphs, strings, design paradigms, caching/probabilistic/external/parallel algorithms and diagnostics.

Implementations, datasets and benchmark evidence remain in `learning`; generalized mechanisms go to `knowledge`.