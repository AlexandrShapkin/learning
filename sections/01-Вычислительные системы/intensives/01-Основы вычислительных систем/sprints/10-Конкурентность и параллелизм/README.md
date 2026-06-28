# Спринт 10. Конкурентность и параллелизм

Ориентировочный объём: 12–16 часов.

## Центральный вопрос

Почему корректные по отдельности операции становятся некорректными при совместном выполнении и как установить допустимый порядок доступа к shared state?

## Результат спринта

После завершения необходимо уметь:

- различать concurrency и parallelism;
- объяснять race condition, data race и atomicity;
- находить interleaving, нарушающий invariant;
- использовать mutex, atomic operations, channels, condition variables и semaphores по назначению;
- объяснять happens-before в Go memory model;
- воспроизводить и диагностировать deadlock;
- отличать deadlock, livelock и starvation;
- использовать race detector и goroutine dump;
- измерять contention и scalability;
- объяснять false sharing и cache coherence на практическом уровне;
- выбирать synchronization strategy по ownership и invariants, а не по привычке.

## Место в интенсиве

Threads и goroutines из спринта 08 разделяют state и выполняются в непредсказуемом interleaving. Этот спринт добавляет правила корректности и механизмы coordination.

## Основной маршрут

### Шаг 1. Основы concurrency

Прочитать OSTEP:

- глава 26 «Concurrency: An Introduction»;
- глава 27 «Thread API»;
- глава 28 «Locks»;
- глава 29 «Lock-based Concurrent Data Structures».

### Шаг 2. Coordination primitives

Прочитать OSTEP:

- глава 30 «Condition Variables»;
- глава 31 «Semaphores»;
- глава 32 «Common Concurrency Problems».

### Шаг 3. Go memory model

Прочитать полностью:

- https://go.dev/ref/mem
- package `sync`: https://pkg.go.dev/sync
- package `sync/atomic`: https://pkg.go.dev/sync/atomic
- race detector: https://go.dev/doc/articles/race_detector

Не использовать фразу «операции выполняются по порядку source code» как memory-order guarantee между goroutines.

### Шаг 4. Practical debugging

Освоить:

```bash
go test -race ./...
go test -run TestName -count 1000
go test -bench . -benchmem -count 7
gotestsum --format testname   # необязательно
kill -QUIT <pid>              # goroutine dump
```

## Ресурсы

### Обязательный маршрут

- OSTEP chapters 26–32.
- Go Memory Model.
- `sync`, `sync/atomic` и race detector documentation.

### Альтернативные объяснения

- *The Go Programming Language*, chapter 9 Concurrency with Shared Variables.
- Bryan Mills, «Rethinking Classical Concurrency Patterns».
- Dmitry Vyukov, материалы о Go scheduler/race detector.

### Углубление

- C/C++ memory model и hardware memory ordering;
- lock-free algorithms и ABA problem;
- Linux futex;
- cache coherence protocols;
- structured concurrency.

### Справочные материалы

- `futex(2)`.
- Go execution tracer.
- `runtime.SetMutexProfileFraction` и mutex profile.

## Практические задания

### 1. Interleaving

Для операции `counter++` разложить read/modify/write и построить interleaving двух goroutines, который теряет increment. Затем проверить программой с большим числом iterations.

### 2. Invariant

Реализовать account transfer между двумя balances. Invariant: total balance constant, ни один balance не отрицателен.

Создать unsafe variant и test, который с высокой вероятностью обнаруживает нарушение. Затем исправить lock ordering и объяснить, почему один mutex на account может создать deadlock при противоположных transfers.

### 3. Producer/consumer

Реализовать bounded queue двумя способами:

- mutex + condition variables;
- buffered channel.

Обе версии должны поддерживать close/cancellation и не терять elements. Сравнить complexity и ownership model, а не только speed.

### 4. Deadlock

Создать минимальный deterministic deadlock с двумя locks. Диагностика должна содержать goroutine dump и wait graph. После этого исправить единым global lock order.

## Лабораторная работа

Создать `work/counterlab/` с единым interface:

```go
type Counter interface {
    Add(delta int64)
    Value() int64
}
```

Реализовать:

1. `UnsafeCounter`;
2. `MutexCounter`;
3. `AtomicCounter`;
4. `OwnerCounter`, где state принадлежит одной goroutine и operations идут через channel;
5. `ShardedCounter` с фиксированным количеством shards.

### Correctness tests

- sequential semantics;
- N goroutines × M increments;
- mixed positive/negative deltas;
- repeated test under `-race`;
- final Value after coordinated shutdown;
- no goroutine leak через timeout/WaitGroup.

`UnsafeCounter` должен находиться в отдельном package/test case, где failure ожидаема и не ломает обычный `go test`.

### Benchmarks

Измерить implementations при:

- 1, 2, 4, 8, 16, 32 workers;
- read/write ratios 0/100, 50/50, 90/10;
- `GOMAXPROCS=1` и `GOMAXPROCS=<logical CPUs>`;
- low contention и high contention.

Сохранять ns/op, allocations/op, throughput и CPU count. Нельзя сравнивать implementations с разной semantics: eventual aggregation sharded counter должна быть явно отмечена, если Value не мгновенно exact.

### Contention profile

Для mutex variant снять:

```bash
go test -bench BenchmarkMutex -mutexprofile mutex.out
go tool pprof -top mutex.out
```

Для channel/owner variant снять CPU profile и execution trace.

### False sharing

Создать два counters, которые обновляются разными goroutines:

- соседние fields одной structure;
- fields, разделённые padding минимум в cache line.

Повторить benchmark с pinning/несколькими CPUs. Если эффект не наблюдается, сохранить result и указать возможные причины вместо выдуманного conclusion.

## Дополнительный эксперимент

Реализовать publish/subscribe одного immutable snapshot через `atomic.Pointer[T]`. Writer создаёт новый snapshot и публикует pointer, readers только загружают.

Сравнить с вариантом `RWMutex`. Объяснить, почему atomic pointer не делает mutable object автоматически безопасным.

## Самопроверка

1. Чем data race отличается от более общего race condition?
2. Какой invariant защищает mutex?
3. Почему atomic operation не решает compound invariant автоматически?
4. Что означает happens-before?
5. Почему buffered channel не является «быстрым mutex»?
6. Какие четыре условия необходимы для deadlock?
7. Как false sharing связан с cache coherence?
8. Почему больше goroutines может уменьшить throughput?
9. Когда ownership model проще shared-memory model?

Практическая проверка: получить failing concurrent test, сначала доказать interleaving или wait cycle, затем исправить минимальным synchronization change и проверить `-race`/repetition.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Конкурентность и параллелизм** — различия и связь с hardware execution.
- **Состояние гонки и data race** — invariants, interleavings и detection.
- **Атомарность** — atomic operation, linearization point и ограничения.
- **Mutex и condition variable** — ownership protected state и waiting protocol.
- **Semaphores и channels** — coordination и resource counting/message passing.
- **Happens-before и модель памяти** — visibility и ordering guarantees.
- **Deadlock, livelock и starvation** — условия, диагностика и prevention.
- **False sharing** — cache lines, coherence traffic и padding.

## Когда переходить дальше

Можно переходить, когда race detector находит намеренную гонку, safe variants проходят repeated tests, deadlock диагностируется по wait graph, benchmark сравнивает одинаковую semantics, а выбранный primitive объясняется через invariant и ownership.