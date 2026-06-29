# Реализация итоговой работы

## 1. Common algorithm contract

Every runnable algorithm declares:

```text
name and version
input/output schema
valid domain and preconditions
size parameters
correctness properties
claimed time/space complexity
mutability/stability/order guarantees
resource limits
```

CLI rejects incompatible modes instead of silently changing assumptions.

## 2. Dataset and trace framework

- deterministic generators with seed;
- distributions: uniform, sorted, reverse, duplicates, skewed, adversarial and graph-specific;
- operation traces for mutable structures;
- small fixtures committed, large generated on demand;
- manifest records generator/version/parameters/checksum;
- parsers enforce size and format limits.

## 3. Verification framework

- reference/oracle implementations;
- invariant validators;
- model-based random operation testing;
- differential comparison;
- exhaustive enumeration for small domains;
- property tests for order/permutation/connectivity/path cost;
- fuzz parsers/decoders/selected structures;
- failing seed/trace persistence and minimization.

## 4. Required structures

Implement educational versions:

- dynamic vector;
- deque/ring buffer;
- linked list;
- chained or open-address hash map;
- ordered balanced tree;
- heap/indexed priority queue;
- trie;
- disjoint-set union.

Each includes mutation invariant checks and a standard/reference adapter.

## 5. Search, sort and selection

- linear and binary search;
- lower/upper bound;
- insertion, merge, quick, heap and one non-comparison sort;
- quickselect/top-k;
- comparator contract tests;
- stdlib baseline;
- distribution-aware benchmarks and adversarial fallback.

## 6. Trees and graphs

- tree traversals and BST operations;
- balanced tree and range queries;
- BFS, DFS, components, cycle detection, topological order and SCC;
- Dijkstra, Bellman–Ford and DAG shortest paths;
- Kruskal/Prim and DSU;
- path/forest verification;
- deterministic behavior only where contract promises it.

## 7. Strings

- naive and KMP exact search;
- rolling-hash/Rabin–Karp with collision verification;
- prefix or Z function;
- multi-pattern or streaming matcher;
- explicit byte/rune policy;
- fuzz agreement and chunk-boundary tests.

## 8. Design paradigms

Representative solvers:

- divide-and-conquer;
- one proven greedy algorithm plus counterexample finder;
- dynamic programming with reconstruction;
- backtracking/branch-and-bound with limits;
- prefix/two-pointer/window algorithm.

Each solver includes proof sketch/invariant and small exhaustive oracle.

## 9. Cache and probabilistic structures

- LRU cache with deterministic trace testing;
- Bloom filter with parameter calculation and empirical false-positive report;
- optional LFU or Count-Min Sketch;
- exact reference and serialization/version policy.

## 10. External algorithms

- external merge sort under configurable memory/fan-in;
- k-way heap merge;
- stable record ordering;
- dedicated temp directory and manifest;
- resume/cleanup policy;
- order/permutation/checksum verification;
- I/O volume, pass count, RSS and wall-time report.

## 11. Parallel algorithms

- sequential and bounded parallel map/reduce;
- parallel merge sort or equivalent divide-and-conquer;
- configurable workers/grain threshold;
- cancellation/error propagation;
- race-detector clean;
- speedup/efficiency report for 1..P workers;
- non-associative/order-sensitive cases rejected or explicit.

## 12. Benchmark and profiling

Mandatory commands:

```text
make test
make test-race
make fuzz-smoke
make benchmark
make scale
make profile
make verify
make cleanup
```

Measurements include:

- operation counts;
- comparisons/swaps/moves/probes/states/relaxations;
- wall time and allocations;
- optional CPU/cache/branch metrics;
- scaling over multiple sizes/distributions;
- stdlib/reference/custom comparison;
- result checksum and workload metadata.

## 13. Diagnostics

`algotriage` supports:

```text
run
compare
minimize
check-invariant
scale
profile
inspect-trace
```

It is read-only with respect to user data and never claims root cause automatically. Bundles contain seed, parameters, first divergence, counters and selected profile summary.

## 14. Fault system

Faults from `FAULTS.md` are opt-in, bounded and isolated. Each defines:

- precondition;
- exact defect/fault mode;
- expected symptom/evidence;
- rollback/disable path;
- regression proving repair.

## 15. Implementation stages

### Stage 1. Contracts and verification

Build schemas, generators, reference models, invariant and minimization framework.

### Stage 2. Structures

Implement basic/ordered/priority structures and pass operation traces.

### Stage 3. Classical algorithms

Add search/sort/tree/graph/string implementations with proof/property tests.

### Stage 4. Design paradigms

Add greedy/DP/backtracking/range solvers with exhaustive oracles.

### Stage 5. Scale-oriented components

Add LRU/Bloom, external sort and parallel implementations.

### Stage 6. Engineering evidence

Add scaling, benchmarks, profiles and stdlib comparisons.

### Stage 7. Faults and diagnostics

Implement fault modes, minimization and blind incidents.

### Stage 8. Assessment

Clean rebuild, final defense and delayed assessment.