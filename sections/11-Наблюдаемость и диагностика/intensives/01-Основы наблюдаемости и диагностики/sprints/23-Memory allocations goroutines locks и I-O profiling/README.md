# Спринт 23. Memory, allocations, goroutines, locks и I-O profiling

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как определить whether latency or resource growth comes from allocations, retained heap, goroutine leaks, lock contention, blocking or I/O wait?

## Результат спринта

После завершения необходимо уметь:

- distinguish allocated bytes from retained/live heap;
- use heap, allocs, goroutine, mutex and block profiles;
- understand GC cycles and heap growth at practical level;
- identify goroutine leaks and blocked stacks;
- measure lock contention and blocking time;
- separate application waiting from kernel/storage/network I/O;
- use Go execution trace selectively;
- compare snapshots over time;
- understand profile sampling rates and overhead;
- correlate profiles with metrics/traces;
- verify leak/lock fixes under sustained load;
- avoid forcing GC/restart as diagnosis.

## Основной маршрут

1. Inject allocation-heavy code, retained-object leak and goroutine leak.
2. Capture heap/allocs/goroutine profiles at controlled times.
3. Add mutex/block contention and inspect profiles/trace.
4. Reproduce slow I/O and compare on-CPU/off-CPU evidence.
5. Fix one issue and run sustained verification.

## Ресурсы

- Go pprof and execution tracer docs.
- Go runtime memory/GC metrics docs.
- Linux I/O and blocking diagnostics references.

## Лабораторная работа

Создать `work/runtime-profiling/`.

### Requirements

- heap growth is separated into allocation rate and retained objects;
- snapshots use comparable load and lifecycle points;
- goroutine profiles identify owner and blocked state;
- mutex/block profiles use documented sampling settings;
- GC pause/CPU/heap metrics correlate with profiles;
- slow external I/O is not misclassified as CPU bottleneck;
- execution trace is bounded and collected only when needed;
- fix verification runs long enough to reveal leak recurrence;
- profile endpoints/files are access-controlled and excluded from Git;
- concise report records cause, evidence, fix and trade-offs.

### Failure scenarios

1. High allocation rate is called memory leak.
2. Heap snapshot is taken before/after different workloads.
3. Goroutine count rises from expected concurrency, not leak.
4. Mutex profile sampling is disabled/too low.
5. Block profile overhead distorts workload.
6. Restart appears to “fix” retained state without cause.
7. GC tuning hides allocation defect temporarily.
8. Network/storage wait is absent from CPU profile.
9. Heap dump leaks sensitive data.

## Самопроверка

1. Allocation rate versus retained heap?
2. Heap versus allocs profile?
3. Goroutine leak evidence?
4. Mutex versus block profile?
5. GC metrics and profiles?
6. Execution trace purpose?
7. On-CPU versus off-CPU wait?
8. Snapshot comparability?
9. Sampling/overhead?
10. How verify leak fix?

## Результат для базы знаний

- **Go heap and allocation profiling**.
- **Goroutine leak and blocked-stack diagnosis**.
- **Mutex and blocking profiles**.
- **Go execution traces and runtime behavior**.
- **On-CPU and off-CPU performance evidence**.

## Когда переходить дальше

Можно переходить, когда allocation, retention, goroutine, lock and I/O problems can be distinguished through independent profiles and sustained verification.