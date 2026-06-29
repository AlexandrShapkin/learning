# Спринт 24. Системная диагностика программы

Ориентировочный объём: 18–26 часов.

Новая теория минимальна. Спринт объединяет language, runtime, OS, I/O, concurrency, network, testing and profiling into one diagnostic method.

## Центральный вопрос

Как от user-visible symptom перейти к first causal defect in source, build, configuration, runtime, resources or environment, не разрушив evidence случайными изменениями?

## Результат спринта

После завершения необходимо уметь:

- define exact symptom, scope, timeline and expected behavior;
- reproduce failure with minimal controlled input;
- distinguish source defect, build artifact, dependency, configuration and environment;
- classify compile, link, startup, panic, deadlock, race, leak, I/O, network and overload failures;
- collect bounded evidence before restart/rebuild/cache cleanup;
- choose debugger/profile/trace/race detector/OS tools by question;
- compare running process with source/build/module/version expectations;
- reconstruct goroutine/process/resource lifecycle;
- rank falsifiable hypotheses and choose discriminating test;
- repair minimally and add regression test/benchmark;
- distinguish trigger, root cause and secondary symptoms;
- recognize when issue belongs to OS/network/dependency rather than application logic;
- create concise incident evidence without maintaining a bureaucracy-heavy log;
- leave diagnostic hooks safe and disabled/restricted by default.

## Diagnostic loop

```text
stabilize and bound impact
→ state exact symptom/expected behavior
→ identify version/config/input/environment
→ reproduce and preserve evidence
→ classify likely layer
→ rank hypotheses
→ run one discriminating observation
→ apply minimal reversible fix
→ verify behavior, resources and regressions
→ add test/detection improvement
```

Do not start with restart, dependency upgrade, cache deletion, broad timeout increase or random optimization.

## Evidence map

### Source/build

- commit/build/module info;
- compiler/linker output;
- binary architecture/dependencies/symbols;
- dependency graph and config schema.

### Process/runtime

- exit status/signal/panic stack;
- goroutine/thread/process tree;
- heap/GC/runtime metrics;
- open files/sockets;
- current config and readiness.

### Correctness/concurrency

- failing input/request ID;
- race detector;
- goroutine dump;
- state invariants;
- deterministic test/fuzz corpus.

### Performance

- workload and latency/throughput;
- CPU/heap/alloc/block/mutex profiles;
- queue depth and saturation;
- OS CPU/memory/I/O/network evidence.

## Лабораторная работа

Create `work/program-diagnostics/` containing:

### `progtriage`

Read-only collector:

```text
progtriage PID --question crash|memory|cpu|hang|io|network|version
```

Collects only relevant bounded evidence:

- process/build/version summary;
- command/cwd sanitized;
- status/limits/cgroup;
- threads/goroutines/stacks where permitted;
- fd/socket summary;
- runtime profiles from authenticated loopback endpoint or signal-triggered file;
- selected `/proc`, `lsof`, `strace`/`perf` short samples;
- config checksum and dependency/build info;
- manifest with timestamps/tool versions/hashes.

It must not dump full environment, secrets, request bodies or unlimited profiles.

### `faulty-runtime-app`

Application combines CLI, HTTP, worker queue, file journal, subprocess and serialization. It supports named bounded faults.

## Incident catalogue

Solve at least 18, including four combined incidents:

1. Syntax/type build failure.
2. Dependency version/API mismatch.
3. Accidental local replace/build tag.
4. Wrong architecture/shared library loader failure.
5. Startup config validation failure.
6. Partial startup resource leak.
7. Panic with useful stack.
8. Panic recovered at wrong boundary and corrupt state continues.
9. Typed nil or shadowed error.
10. Truncated/partial I/O.
11. File descriptor leak.
12. Child process/pipeline deadlock.
13. Child/grandchild remains after timeout.
14. Data race.
15. Lost update/logical race.
16. Mutex deadlock.
17. Goroutine/channel/ticker leak.
18. Queue/backpressure growth.
19. Cancellation ignored.
20. CPU hot loop.
21. Excessive allocation/GC pressure.
22. Retained heap/cache/backing array.
23. Slow I/O/downstream dependency.
24. HTTP connection/body leak.
25. Timeout/retry duplicate work.
26. TLS/network phase misclassified as app error.
27. Readiness true before dependency ready.
28. Graceful shutdown hangs/loses work.
29. Test flake masks product bug.
30. Benchmark/profile taken on wrong workload.
31. Version/config mismatch between source and running binary.
32. Multiple simultaneous failures.

### Combined examples

- queue growth + GC pressure;
- network timeout + unsafe retry duplication;
- stale binary + incompatible config;
- deadlock + signal shutdown timeout;
- fd leak + readiness remains green;
- CPU saturation + misleading downstream timeout.

## Incident artifact

One screen per incident:

```text
Symptom and impact
Version/config/input
Preserved evidence
Ranked hypotheses
Discriminating test
Root cause and trigger
Minimal fix
Regression verification
```

Raw profile/trace/log paths replace long narrative.

## Blind exercise

Another person/tool selects hidden fault and gives only user-visible symptom. First response must:

1. state safety action;
2. request/collect baseline identity;
3. choose maximum three evidence sources;
4. state ranked hypotheses before editing code/config.

## Самопроверка

1. How distinguish source, build and running artifact?
2. What evidence should be collected before restart?
3. Panic versus process signal versus returned error?
4. Race versus deadlock versus starvation?
5. Allocation churn versus retained heap?
6. Goroutine leak versus normal waiting workers?
7. Endpoint CPU versus network/downstream latency?
8. Why can readiness be misleading?
9. How can retry create correctness failure?
10. When use debugger, profile, trace, race detector or strace?
11. Root cause versus trigger/secondary symptom?
12. What makes fix verified?
13. Why can benchmark/profile mislead?
14. When should issue move to OS/network/dependency investigation?

Практическая проверка: diagnose one unknown combined fault, repair it, add regression and prove resources return to baseline.

## Критерии прохождения

- `progtriage` is read-only, bounded and sanitized;
- at least 18 incidents and four combined cases are solved;
- no broad restart/timeout/upgrade is accepted as unexplained final fix;
- every repair has test, benchmark or state verification;
- running artifact/version/config are verified explicitly;
- cleanup leaves no process/fd/goroutine/profile endpoint exposure;
- at least 12 of 14 self-check answers are mechanism-based.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Systematic program diagnostics**.
- **Source, build artifact and running process identity**.
- **Failure-stage classification**.
- **Runtime evidence collection**.
- **Crash, race, deadlock and leak diagnosis**.
- **Application resource lifecycle diagnosis**.
- **Performance and overload diagnosis**.
- **Regression verification after incident**.

## Когда переходить дальше

Можно переходить к итоговой работе, когда unknown failures are diagnosed from bounded evidence and fixes are proven by regression plus resource baseline.