# Итоговая проверка

## Blind incident exercise

Решить минимум 14 hidden incidents:

- two contract/analysis/testing cases;
- three structure/search/sort cases;
- three graph/string/design cases;
- two scale/probability/parallel cases;
- four combined incidents.

Combined examples:

- bad comparator + unstable sort symptom;
- collision degradation + allocation pressure;
- quicksort adversarial input + recursion stack;
- DP state explosion + overflow;
- external skew + file-descriptor limit;
- parallel race + non-associative reduction;
- invalid window precondition + wrong oracle;
- stale heap index + Dijkstra path corruption.

For each incident:

```text
Symptom and constraints
Seed/input/version
Initial safety/resource bound
Reference/invariant expectation
First divergence and evidence
Ranked hypotheses
Root cause and trigger
Minimal repair
Regression and scaling verification
```

## Clean rebuild and verification

From clean checkout:

1. fetch dependencies and verify module state;
2. run format, unit, property, race and fuzz-smoke suites;
3. build CLI;
4. generate deterministic datasets;
5. execute structure traces and classical algorithms;
6. run external sort under memory budget;
7. run parallel scaling with bounded workers;
8. produce benchmark/profile/scaling summaries;
9. inject and disable three faults;
10. cleanup and verify no large/temp resources remain.

## Final defense

Answer using project evidence:

1. How is an algorithmic problem formalized?
2. How are correctness and termination proved?
3. O, Θ, Ω and worst/expected/amortized differences?
4. How are structures chosen by operations and memory layout?
5. Why can hash tables degrade?
6. How do ordered/balanced/priority structures differ?
7. How are binary search and sorting guarantees verified?
8. How are graph representation and traversal chosen?
9. Which assumptions distinguish shortest-path algorithms?
10. How are MST and shortest paths different?
11. How do string matching algorithms avoid repeated work?
12. When do greedy, DP and backtracking apply?
13. How do prefix/window/two-pointer methods depend on monotonicity/order?
14. What guarantees do caches and probabilistic structures provide?
15. How do external algorithms change the cost model?
16. What limits parallel speedup?
17. How are algorithmic and implementation bottlenecks separated?
18. When is standard library preferable to custom implementation?
19. How is an unknown wrong/slow/memory-heavy algorithm diagnosed?
20. Which project evidence supports each complexity claim?

Every answer references tests, invariant, counter, scaling result, profile or incident.

## Completion criteria

Интенсив завершён, когда:

- clean checkout builds and verifies `algolab`;
- required structures and algorithms pass model/property/differential tests;
- complexity metadata agrees with implementation and scaling evidence;
- adversarial inputs are bounded and handled according to contract;
- external sort respects memory/temp/fd constraints;
- parallel variants are race-free and measured for speedup/efficiency;
- all 50 faults are safe/reproducible or an equivalent environmental substitute is documented;
- at least 14 blind incidents and four combined incidents are solved;
- standard-library comparisons are present;
- all main section questions are answered through evidence;
- generalized knowledge is transferred to `knowledge`.

## Delayed assessment

Через 7–14 дней без перечитывания:

1. derive complexity/invariant for one unfamiliar algorithm;
2. implement one structure from contract with property tests;
3. solve one graph and one DP/greedy problem;
4. diagnose four random faults, including a combined case;
5. interpret one scaling/profile report;
6. choose standard/custom structure for a given workload;
7. explain one external or parallel trade-off.

После delayed assessment уровень 3–4 можно считать закреплённым.