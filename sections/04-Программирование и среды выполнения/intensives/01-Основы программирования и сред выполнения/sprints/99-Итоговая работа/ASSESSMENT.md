# Итоговая проверка

## Blind incident exercise

Решить минимум 14 hidden incidents:

- two language/API/error cases;
- two build/module/runtime-startup cases;
- two I/O/storage/process cases;
- three concurrency/memory cases;
- two network/lifecycle cases;
- three combined incidents.

Combined examples:

- stale binary + incompatible configuration;
- queue growth + allocation/GC pressure;
- timeout + retry duplicate;
- mutex deadlock + shutdown hang;
- fd leak + readiness remains green;
- partial write + failed compaction rollback;
- data race + flaky test;
- dependency change + reflection schema mismatch.

For each keep compact record:

```text
Symptom and impact
Version/config/input
Initial safety action
Evidence and timeline
Ranked hypotheses
Discriminating test
Root cause, trigger and secondary effects
Minimal repair
Regression/resource verification
Rollback
```

## Clean rebuild and recovery

From clean checkout/environment:

1. fetch dependencies through documented process;
2. run all format/test/race/integration/fuzz-smoke checks;
3. build and inspect executable;
4. start daemon and verify readiness;
5. submit/process/compact/restart and validate journal;
6. run one subprocess and one network workflow;
7. collect profile/triage bundle;
8. inject and roll back three faults;
9. stop/cleanup and prove no processes/fds/listeners/resources remain.

## Final defense

Answer using project evidence:

1. How does source become executable and process?
2. Compilation versus interpretation/VM/JIT?
3. What services does runtime provide?
4. How do types/interfaces/generics constrain behavior?
5. How are errors and panic boundaries designed?
6. Where do values live and why do they escape?
7. How does GC differ from ownership/manual memory?
8. How does program interact with files/processes/syscalls/network?
9. Process/thread/goroutine/task differences?
10. How do race and deadlock arise and get proven?
11. Async versus concurrent versus parallel?
12. How do cancellation and backpressure control lifecycle?
13. How are modules/dependencies/build versions controlled?
14. How do tests/fuzzing/race detector verify different risks?
15. How are panic, CPU, memory, goroutine, fd and contention failures diagnosed?
16. How do CLI/configuration/readiness/shutdown form application contract?
17. How should language/runtime be selected for a task?
18. Which project properties improve reliability, performance and maintainability?

Every answer references source/tests/compiler output/profile/trace/incident evidence.

## Completion criteria

Интенсив завершён, когда:

- clean checkout builds and verifies full project;
- module/API/type/error contracts are explicit and tested;
- codecs/journal survive corruption and partial failure;
- concurrency is bounded and race-detector clean;
- cancellation/shutdown return resources to baseline;
- network/process adapters classify failures correctly;
- profiles/trace/triage reproduce diagnostic findings;
- all 50 faults are safe/reversible or an environmental substitute is documented;
- at least 14 blind incidents and three combined incidents are solved;
- comparison workload across runtimes is reproducible;
- all main section questions are answered through evidence;
- reusable knowledge is transferred to `knowledge`.

## Delayed assessment

Через 7–14 дней без перечитывания:

1. draw source → build → runtime → OS → I/O/network path;
2. answer 18 defense questions;
3. rebuild and run project from README;
4. diagnose four random faults, including combined;
5. inspect one binary/stack/profile and explain it;
6. implement one small change with tests and no lifecycle regression;
7. revisit one technology-choice assumption from evidence.

После delayed assessment уровень 3–4 можно считать закреплённым.