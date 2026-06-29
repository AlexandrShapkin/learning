# Спринт 24. Системная диагностика алгоритма

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Как from wrong result, timeout or memory growth locate the first invalid assumption in contract, invariant, complexity, data structure or implementation?

## Результат спринта

После завершения необходимо уметь:

- classify wrong answer, panic, timeout, memory limit and nondeterminism;
- minimize failing input and preserve seed/trace;
- distinguish contract misunderstanding from implementation bug;
- inspect invariant at first failing operation;
- compare optimized algorithm against reference oracle;
- identify complexity mismatch from scaling/counters;
- identify memory blow-up from state space/representation/retention;
- diagnose recursion depth and stack failure;
- distinguish algorithmic from runtime/OS bottleneck;
- use fuzz/property tests, benchmarks, profiles and traces by question;
- identify adversarial distribution;
- verify comparator/hash/order assumptions;
- detect overflow and sentinel errors;
- make minimal fix and add regression;
- avoid random rewrite/optimization before evidence;
- produce concise incident artifact.

## Diagnostic loop

```text
state exact symptom and constraints
→ reproduce with seed/input/version
→ minimize failing case
→ compare with oracle/invariant
→ classify correctness or resource issue
→ inspect first divergence
→ repair smallest invalid assumption
→ add regression and rerun scaling/adversarial suite
```

## Evidence sources

- failing input and operation trace;
- invariant validator;
- brute/reference output;
- property/fuzz seed;
- comparison/move/state counters;
- benchmark scaling curve;
- CPU/heap profile;
- recursion/goroutine stack;
- memory/RSS/I/O metrics;
- stdlib comparison.

## Лабораторная работа

Создать `work/algorithm-diagnostics/` containing faulty implementations and read-only `algotriage`:

```text
algotriage run CASE --seed S --size N
algotriage minimize FAILURE
algotriage scale ALGORITHM
algotriage profile ALGORITHM
algotriage compare ALGORITHM ORACLE
```

Collector/report must remain bounded and deterministic.

## Incident catalogue

Solve at least 18, including four combined cases:

1. Off-by-one binary search.
2. Invalid comparator.
3. Unstable sort violates contract.
4. Quicksort quadratic/deep recursion.
5. Hash table tombstone/resize corruption.
6. Hash collision degradation.
7. Linked-list lost link/cycle.
8. Balanced-tree stale metadata/rotation.
9. Heap stale index/order.
10. Graph directedness/visited timing.
11. Dijkstra negative edge.
12. Distance/weight overflow.
13. MST disconnected/parallel edge issue.
14. KMP/rolling-hash boundary/collision.
15. Greedy counterexample.
16. DP state/iteration-direction bug.
17. Backtracking restore/pruning bug.
18. Sliding-window invalid with negatives.
19. Bloom serialization/hash mismatch.
20. External sort fd/disk/memory issue.
21. Parallel race/order/non-associative reduction.
22. Benchmark optimized away/unfair setup.
23. Memory blow-up from representation/state dimension.
24. Standard-library misuse.
25. Multiple simultaneous faults.

### Combined examples

- hash degradation + allocation pressure;
- quicksort adversarial input + recursion stack;
- DP state explosion + integer overflow;
- external sort skew + fd limit;
- parallel reduction race + non-associative operation;
- wrong comparator + flaky map/order output.

## Incident artifact

```text
Symptom and constraints
Minimal failing input/seed
Expected invariant/oracle
First divergence
Root cause and trigger
Minimal fix
Regression case
Complexity/resource verification
```

One screen is sufficient; raw generated evidence is referenced.

## Self-check

1. How distinguish wrong contract from code bug?
2. Why minimize input?
3. What is first divergence?
4. When invariant validator is useful?
5. How scaling reveals complexity mismatch?
6. Timeout: algorithmic or implementation/OS?
7. Memory blow-up causes?
8. Why oracle may be slow but valuable?
9. How adversarial input differs from random?
10. When profile versus operation counter?
11. How prove pruning/greedy fix?
12. What makes regression complete?

## Критерии прохождения

- `algotriage` reproduces and minimizes bounded cases;
- at least 18 incidents and four combined cases solved;
- repairs add regression and preserve claimed complexity;
- no timeout fixed only by arbitrary larger limit;
- no rewrite accepted without first divergence;
- at least 10 of 12 answers are mechanism-based.

## Результат для базы знаний

- **Systematic algorithm diagnostics**.
- **Minimal failing input and first divergence**.
- **Oracle, invariant and property evidence**.
- **Complexity and scaling diagnosis**.
- **Algorithmic memory diagnosis**.
- **Adversarial input diagnosis**.
- **Regression after algorithm repair**.

## Когда переходить дальше

Можно переходить к итоговой работе, когда unknown correctness/performance failures are localized through minimized evidence and every repair has regression plus resource verification.