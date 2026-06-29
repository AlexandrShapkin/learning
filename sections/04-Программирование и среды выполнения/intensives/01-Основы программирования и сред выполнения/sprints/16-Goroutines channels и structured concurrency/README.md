# Спринт 16. Goroutines, channels и structured concurrency

Ориентировочный объём: 15–22 часа.

## Центральный вопрос

Как выполнять multiple activities concurrently, связывать их lifecycle и обеспечивать завершение без leaks, lost errors and uncontrolled fan-out?

## Результат спринта

После завершения необходимо уметь:

- distinguish concurrency and parallelism;
- explain goroutine versus OS thread/task/process;
- create goroutines with explicit ownership/lifetime;
- use unbuffered and buffered channels;
- understand send/receive/close semantics and zero values after close;
- use `select`, timers and cancellation;
- design fan-out/fan-in, pipeline and worker pool;
- propagate context, errors and shutdown;
- apply structured concurrency principle even without language keyword;
- bound goroutine counts, queues and work;
- avoid channel close ownership confusion;
- distinguish synchronization via communication from shared memory;
- handle early consumer cancellation;
- diagnose blocked goroutine and goroutine leak;
- test concurrent code deterministically where possible;
- understand scheduler behavior only as non-guaranteed implementation detail.

## Основной маршрут

### Шаг 1. Concurrency model

Study Go Tour concurrency and Go blog pipeline/context materials. Define goroutine parent/owner and completion condition.

### Шаг 2. Channels

Practice:

- unbuffered rendezvous;
- bounded buffer;
- close by sender/owner;
- range over channel;
- nil channel disabling select case;
- select fairness not assumed as strict guarantee.

### Шаг 3. Cancellation/error propagation

Use `context.Context`, `errgroup` concept or own minimal group. Every blocking operation must respond to cancellation where practical.

### Шаг 4. Patterns and limits

Implement worker pool, fan-in, pipeline with backpressure. Avoid goroutine-per-item without bound.

## Ресурсы

### Обязательный маршрут

- A Tour of Go concurrency.
- Go blog: pipelines and cancellation, context.
- `context`, `sync`, `time` docs.
- Go scheduler overview only for context.

### Альтернативные объяснения

- CSP paper/concepts.
- *Concurrency in Go* selected chapters.

### Углубление

- work stealing scheduler;
- structured concurrency libraries;
- actor model;
- async runtimes;
- cancellation semantics across distributed systems;
- channel implementation internals.

## Практические задания

### 1. Channel semantics

Predict/test blocking, buffer capacity, close, receive-after-close, send-after-close panic and nil channel behavior.

### 2. Leak reproduction

Create generator whose consumer stops early. Observe goroutine count/stack, then add cancellation/drain design.

### 3. Worker pool

Process tasks with fixed workers, per-task errors, ordered/unordered results and cancellation. Measure queue/backpressure.

### 4. Fan-in failure

Multiple producers, one fails. Ensure all producers stop, channels close once and error preserves cause.

## Лабораторная работа

Создать `work/taskflow/` — concurrent processing engine.

### Model

```text
Source → Decode → Validate → Transform workers → Ordered sink
```

### Requirements

- configurable bounded workers and queue;
- context cancellation from CLI/signal/error;
- first-error and collect-errors policies explicit;
- optional output order preservation;
- no goroutine per item without bound;
- stage ownership and channel close documented in code structure;
- progress/metrics without blocking pipeline;
- shutdown waits for owned goroutines;
- deterministic tests with fake stages/clocks;
- goroutine leak check;
- benchmarks for workers/queue sizes;
- no shared mutable map without synchronization.

### Failure scenarios

1. Source blocks forever until cancellation.
2. Consumer stops early.
3. Worker panics.
4. One worker returns error while others blocked on send.
5. Output sink slow.
6. Channel closed by wrong participant.
7. Queue unbounded/memory growth.
8. Lost error from background goroutine.
9. Timer/ticker leak.
10. CLI exits before goroutines finish.
11. Order-preserving buffer grows excessively.
12. Cancellation arrives during partial output.

### Panic policy

Worker panic may be recovered only at task boundary if shared engine invariants remain valid. Record stack and return job failure; otherwise fail process.

## Дополнительный эксперимент

Compare channel-based worker pool with mutex/condition/shared queue implementation. Evaluate ownership, throughput, cancellation and complexity.

## Самопроверка

1. Concurrency versus parallelism?
2. Goroutine versus thread?
3. What does unbuffered send synchronize?
4. Who should close channel?
5. What happens receiving from closed channel?
6. Why nil channel may be useful/dangerous?
7. What is backpressure?
8. How does cancellation prevent leaks?
9. What is structured concurrency principle?
10. Why can early consumer leak producer?
11. How to bound fan-out?
12. When should panic cross goroutine boundary?

Практическая проверка: inspect goroutine dump from stuck pipeline and identify ownership/blocking/cancellation defect.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Concurrency and parallelism**.
- **Goroutine and OS thread**.
- **Channel semantics**.
- **Buffered channel and backpressure**.
- **select and cancellation**.
- **Worker pool, fan-out and fan-in**.
- **Structured concurrency in Go**.
- **Goroutine lifecycle and leak**.
- **Concurrent pipeline error propagation**.

## Когда переходить дальше

Можно переходить, когда taskflow stops cleanly for every failure/cancellation path, goroutine count returns to baseline, and queue/work concurrency are bounded.