# Спринт 22. Debugging, profiling и performance

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как найти cause of incorrect behavior, crash, leak or slowness through controlled reproduction and runtime evidence rather than speculative code changes?

## Результат спринта

После завершения необходимо уметь:

- apply diagnostic loop: symptom → reproduction → evidence → hypothesis → discriminating test → fix → regression;
- use Delve/GDB breakpoints, stack, frames, variables and conditional breakpoints;
- understand optimized-code debugging limitations;
- read panic stack traces and goroutine dumps;
- collect/analyze CPU, heap, alloc, goroutine, block and mutex profiles;
- use Go execution trace for scheduler/GC/blocking events;
- write valid benchmarks and compare statistically/cautiously;
- use `perf`, `strace`, `lsof`, `/proc` to separate runtime/OS causes;
- identify CPU hot path, allocation hot path, retained heap, goroutine/fd leak and contention;
- distinguish latency, throughput, saturation and queueing;
- establish baseline before optimization;
- preserve correctness and use profile-guided changes;
- understand compiler optimizations/inlining effects;
- avoid micro-optimizing cold code;
- create performance budget and regression benchmark;
- diagnose high CPU, high memory, slow I/O and deadlock systematically.

## Основной маршрут

### Шаг 1. Debugger

Use Delve on normal/failed tests and binaries:

- break/continue/next/step;
- goroutines/threads;
- stack/frame/locals;
- conditional breakpoint;
- core/minidump where supported.

### Шаг 2. Profiles

Study `runtime/pprof`, `net/http/pprof`, `go tool pprof`:

- samples versus exact accounting;
- cumulative versus flat;
- alloc versus in-use;
- goroutine/block/mutex profiles;
- profile duration and workload representativeness.

### Шаг 3. Trace and OS evidence

Use `go tool trace`, `perf stat/record`, `strace -c/-f`, `/proc/PID`, `lsof`. Correlate timelines and avoid collecting every tool simultaneously without question.

### Шаг 4. Optimization method

```text
correctness tests → representative workload → baseline
→ profile → hypothesis → smallest change
→ correctness regression → repeated measurement
```

## Ресурсы

### Обязательный маршрут

- Go diagnostics and pprof docs.
- Go trace and benchmark docs.
- Delve documentation.
- Brendan Gregg performance methodology/USE overview.
- perf/strace documentation.

### Альтернативные объяснения

- *Systems Performance* methodology chapters.
- Go performance case studies verified locally.

### Углубление

- PGO;
- hardware counters/cache analysis;
- continuous profiling;
- eBPF uprobes;
- core dump postmortem;
- allocation/GC internals;
- tail latency analysis.

## Практические задания

### 1. Crash debugging

Debug nil panic and index panic from failing test. Set breakpoint before failure, inspect state and create minimal regression.

### 2. CPU profile

Create intentional inefficient parser/hash loop. Profile under representative workload, optimize one measured hotspot and compare repeated benchmark.

### 3. Memory profile

Distinguish high allocation rate from retained heap with alloc/inuse profiles. Fix one retention and one allocation issue separately.

### 4. Blocking/contention

Create mutex contention and channel blocking. Use mutex/block profile, trace and goroutine dump; redesign/bound work.

## Лабораторная работа

Create `work/diagnostics-lab/` with `faultyapp` and fault modes.

### Fault modes

```text
panic-nil
panic-index
cpu-spin
alloc-churn
heap-retain
goroutine-leak
fd-leak
mutex-contention
deadlock
slow-io
queue-growth
gc-pressure
```

### Commands

```text
faultyapp run MODE --duration --limit
faultyapp verify MODE
scripts/collect.sh PID QUESTION
scripts/analyze.sh BUNDLE
```

### Requirements

- every mode bounded/safe and opt-in;
- one user-visible symptom statement;
- collector selects relevant evidence, not full machine dump;
- profiles tagged with workload/version/time;
- debugger reproduction instructions;
- fixed variant and regression test/benchmark;
- CPU/memory/resource limits;
- no pprof endpoint exposed beyond loopback;
- raw large profiles ignored, regeneration commands committed;
- race/deadlock modes in subprocess timeout;
- optimization report states baseline, change, result and trade-off in one page max.

### Diagnostic scenarios

1. High CPU in user code.
2. High CPU from GC/allocation.
3. Memory RSS high but live heap bounded.
4. Live heap grows due retained map/cache.
5. Goroutine count grows.
6. File descriptors grow.
7. Requests slow due lock contention.
8. Requests slow due downstream I/O.
9. Deadlock with all goroutines blocked.
10. Queue grows because arrival exceeds service.
11. Benchmark improves but production-like workload regresses.
12. Debugger variable unavailable due optimization.
13. Profile points to wrapper/cumulative caller, misinterpreted.
14. Race detector changes timing but reveals real race.

## Дополнительный эксперимент

Apply Go PGO to measured workload, inspect changed build/performance and explain representativeness/versioning risks.

Alternative: use `perf` hardware counters/flame graph to investigate cache/branch behavior in one CPU-bound function.

## Самопроверка

1. What is minimal reproducible symptom?
2. Breakpoint versus profile?
3. Flat versus cumulative profile?
4. alloc versus in-use profile?
5. What does execution trace add?
6. Why can RSS differ from Go heap?
7. Leak versus retention versus allocation churn?
8. How identify goroutine/fd leak?
9. Contention versus CPU saturation?
10. Why benchmark may lie?
11. Why optimize after profile?
12. What verifies performance fix?
13. How does optimized build affect debugging?
14. What evidence separates app and OS I/O wait?

Практическая проверка: receive one unknown fault mode, choose maximum three initial evidence sources, identify root cause and prove corrected behavior/performance.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Program diagnostic method**.
- **Debugger and stack/frame inspection**.
- **CPU and heap profiling**.
- **Allocation versus retained memory**.
- **Goroutine, block and mutex profiles**.
- **Go execution trace**.
- **Benchmark methodology**.
- **CPU, memory, I/O and contention bottlenecks**.
- **Performance optimization loop**.
- **Application versus OS evidence**.

## Когда переходить дальше

Можно переходить, когда all fault modes are diagnosed from targeted evidence, fixes have regression tests/benchmarks, and no optimization is justified only by intuition.