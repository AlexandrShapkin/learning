# Спринт 17. Locks, atomics и memory model

Ориентировочный объём: 16–23 часа.

## Центральный вопрос

Как несколько concurrent executions safely share memory, какие ordering guarantees создаёт synchronization и почему «редко ломается» не означает отсутствия race?

## Результат спринта

После завершения необходимо уметь:

- define data race precisely;
- understand happens-before at practical level;
- use Go memory model to reason about visibility/order;
- choose mutex, RWMutex, channel, atomic or ownership confinement;
- protect invariants, not individual fields mechanically;
- use `sync.Once`, `WaitGroup`, `Cond`, `Pool` appropriately;
- use typed atomics for counters/state only with explicit invariant;
- understand compare-and-swap loops and ABA overview;
- distinguish race, logical race, deadlock, livelock and starvation;
- detect races with `go test -race` and understand limitations;
- collect mutex/block profiles;
- avoid copying locks and lock-order inversion;
- design lock hierarchy or reduce shared state;
- benchmark contention without invalid conclusions;
- reason about publication and immutable snapshots.

## Основной маршрут

### Шаг 1. Memory model

Read Go memory model. Focus on synchronization events:

- goroutine initialization;
- channel send/receive/close;
- mutex unlock/lock;
- atomics;
- once;
- program initialization.

Without synchronization, observed ordering cannot be inferred from source order across goroutines.

### Шаг 2. Mutexes and invariants

Protect coherent state transition under one lock. Avoid exposing references that mutate state outside lock.

### Шаг 3. Atomics

Use atomic operations only for independent state or carefully designed state machine. Atomic fields do not make compound invariant atomic automatically.

### Шаг 4. Deadlocks/contention

Study lock order, blocking while holding lock, callbacks under lock, RWMutex trade-offs and profiling.

## Ресурсы

### Обязательный маршрут

- Go memory model.
- `sync` and `sync/atomic` docs.
- Go race detector documentation.
- Go block/mutex profiling docs.

### Альтернативные объяснения

- *The Art of Multiprocessor Programming* selected chapters.
- Java memory model/happens-before comparison.

### Углубление

- lock-free algorithms;
- linearizability;
- RCU;
- false sharing;
- memory barriers;
- transactional memory;
- formal concurrency testing.

## Практические задания

### 1. Race catalogue

Reproduce and fix:

- map read/write;
- loop variable/shared counter;
- publication without synchronization;
- slice append shared backing array;
- configuration reload pointer swap;
- test parallel subtest capture.

Run race detector and explain one race it cannot prove absent.

### 2. Invariant locking

Implement account transfer/store update where total/invariants require multi-field atomicity. Show why separate field locks/atomics fail.

### 3. Deadlock

Create two-lock inversion with timeout/goroutine dump, then enforce ordering or redesign single owner.

### 4. Contention

Compare Mutex, RWMutex, atomic snapshot and channel owner under read/write ratios. Include correctness and profiles; no universal winner.

## Лабораторная работа

Create `work/concurrent-store/` extending typed store.

### API

- concurrent Get/List/Put/Delete/CompareAndSwap;
- snapshot export;
- subscription/change stream optional;
- atomic config/version publication;
- bounded watchers.

### Implementations

At least two:

1. mutex-protected map;
2. single-owner goroutine or immutable snapshot/atomic pointer model.

### Requirements

- linearizable operations where promised;
- invariants/property tests under concurrency;
- race detector clean;
- no callback invoked while internal lock held;
- lock copying prevented;
- cancellation for watchers;
- benchmarks with realistic read/write ratios;
- mutex/block profiles;
- deterministic deadlock tests use timeout and subprocess if needed;
- documentation states consistency semantics.

### Failure scenarios

1. Data race on map/slice.
2. Lost update.
3. Check-then-act logical race.
4. Deadlock by lock inversion.
5. Callback re-enters store while lock held.
6. RWMutex writer starvation/contention scenario.
7. Atomic pointer publishes mutable object then changes it.
8. Watcher blocks writer.
9. WaitGroup Add/Wait misuse.
10. `sync.Once` initialization failure cannot retry.
11. Copied mutex.
12. False sharing optional benchmark.

## Дополнительный эксперимент

Implement small lock-free stack/queue only from a trusted algorithm, then test with stress/property tools. Document memory reclamation/ABA limitations; not used as production solution.

## Самопроверка

1. What is data race?
2. What is happens-before?
3. Why source order is insufficient across goroutines?
4. Mutex versus channel ownership?
5. RWMutex when can hurt?
6. Why atomics do not protect compound invariant automatically?
7. Race versus logical race?
8. Deadlock versus livelock/starvation?
9. What does race detector observe/miss?
10. Why not call external callback under lock?
11. How can immutable snapshot simplify reads?
12. What makes operation linearizable?

Практическая проверка: given race report/goroutine dump/profile, identify shared variable, synchronization gap or lock cycle and prove fix under test.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Data race and happens-before**.
- **Go memory model**.
- **Mutex and protected invariant**.
- **RWMutex trade-offs**.
- **Atomic operations and CAS**.
- **Logical race**.
- **Deadlock, livelock and starvation**.
- **Race detector limitations**.
- **Mutex and block profiling**.
- **Immutable snapshot publication**.

## Когда переходить дальше

Можно переходить, когда both store implementations pass stress/property/race tests, semantics are explicit, and profiles support synchronization choices.