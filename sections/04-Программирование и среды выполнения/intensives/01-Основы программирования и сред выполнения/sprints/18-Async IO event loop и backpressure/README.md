# Спринт 18. Async I/O, event loop и backpressure

Ориентировочный объём: 14–21 час.

## Центральный вопрос

Как runtime handles many waiting I/O operations without one dedicated blocking thread per operation, и чем asynchronous execution отличается от concurrency and parallelism?

## Результат спринта

После завершения необходимо уметь:

- distinguish synchronous, blocking, nonblocking and asynchronous operations;
- explain readiness/completion models conceptually;
- understand event loop, task queue, microtask and callback execution at overview level;
- compare Go blocking-style goroutines/network poller with Node.js event loop and Python asyncio;
- explain futures/promises/async-await as control-flow abstractions;
- propagate cancellation/deadlines across async work;
- design bounded queues and backpressure;
- avoid blocking event loop with CPU work;
- understand callback ordering and reentrancy hazards;
- distinguish I/O concurrency from CPU parallelism;
- handle overload, queue timeout and dropped work intentionally;
- diagnose event-loop lag, goroutine buildup, queue growth and slow consumer;
- compare thread-per-connection, goroutine-per-connection and event-loop models without caricature;
- test async timing without fragile sleeps.

## Основной маршрут

### Шаг 1. I/O models

Review blocking/nonblocking descriptors, readiness (`select/poll/epoll`) and async completion overview. Map to Go netpoll concept without depending on internals.

### Шаг 2. Event loop

Study Node.js event loop and Python asyncio docs:

- callbacks/tasks;
- timers;
- I/O readiness;
- promise/microtask queues;
- blocking CPU work.

### Шаг 3. Go model

Go exposes blocking-looking APIs while runtime parks goroutines and uses network poller where possible. Compare API ergonomics, cancellation and scheduler costs.

### Шаг 4. Backpressure and overload

Bound:

- accepted connections;
- in-flight requests;
- queue length;
- per-client rate;
- timeout/deadline;
- memory per item.

Reject/degrade intentionally instead of infinite buffering.

## Ресурсы

### Обязательный маршрут

- Node.js event loop documentation.
- Python asyncio task/event loop docs.
- Go net/http/net/context/runtime diagnostics docs.
- Linux epoll overview.

### Альтернативные объяснения

- *High Performance Browser Networking* event-driven sections.
- libuv design overview.

### Углубление

- io_uring;
- async Rust executors;
- reactor/proactor patterns;
- work stealing;
- cooperative scheduling;
- structured async cancellation;
- backpressure in reactive streams.

## Практические задания

### 1. Ordering

Create Node/Python examples with timers, resolved promises/tasks, I/O callback and sync code. Predict then observe ordering. Record version-specific behavior cautiously.

### 2. Event-loop blocking

Run CPU-heavy handler and measure lag/other request latency. Move CPU work to worker/process and compare.

### 3. Go waiting workload

Run thousands of idle connections/goroutines under limits. Observe goroutines, threads, FDs and memory. Avoid external load.

### 4. Backpressure

Implement bounded producer/consumer with reject, block and drop-oldest policies. Compare correctness and latency under overload.

## Лабораторная работа

Create `work/async-lab/` with equivalent bounded job service in:

- Go;
- Node.js or TypeScript;
- Python asyncio.

### Protocol

Local TCP/HTTP endpoint accepts jobs:

```text
id, kind=io|cpu, duration, payload_size, deadline
```

### Requirements

- same observable semantics;
- max connections/in-flight/queue sizes;
- request deadline/cancellation;
- I/O job simulates async wait/local file/socket;
- CPU job bounded and optionally offloaded;
- overload returns explicit error/status;
- metrics: queue depth, active, rejected, completed, latency;
- no unbounded promise/task/goroutine creation;
- tests use controlled clocks/events where feasible;
- clean shutdown drains or cancels according to policy.

### Failure scenarios

1. Event loop blocked by CPU task.
2. Unhandled promise/task exception.
3. Forgotten await/task leak.
4. Queue grows unbounded.
5. Producer ignores cancellation.
6. Slow client holds resources.
7. Timeout fires but underlying work continues.
8. Callback reentrancy changes shared state.
9. Go goroutine-per-request lacks admission bound.
10. Worker pool saturated, retries amplify load.
11. Shutdown loses queued work.
12. Async test flakes due sleeps.

### Comparison report

Compare:

- code structure;
- waiting-task memory;
- OS thread count;
- CPU task behavior;
- cancellation;
- backpressure;
- diagnostics;
- failure semantics.

Do not convert one local benchmark into universal language ranking.

## Дополнительный эксперимент

Implement same server in Rust async runtime or use io_uring-based library overview. Focus on executor/future polling and ownership constraints.

## Самопроверка

1. Blocking versus synchronous?
2. Nonblocking versus asynchronous?
3. What does event loop schedule?
4. Promise/future versus thread?
5. Why CPU work blocks event loop?
6. How can Go expose blocking APIs at scale?
7. What is backpressure?
8. Why unbounded queue is dangerous?
9. How do cancellation and timeout differ?
10. Async versus parallelism?
11. How to test timing without sleep?
12. What evidence shows event-loop/goroutine overload?

Практическая проверка: given latency/queue/task/thread metrics, determine event-loop block, admission failure, slow consumer or CPU saturation.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Synchronous, blocking, nonblocking and asynchronous I/O**.
- **Event loop and task queues**.
- **Promise, future and async/await**.
- **Go network poller execution model overview**.
- **Async versus concurrent versus parallel execution**.
- **Backpressure and bounded queues**.
- **Event-loop blocking and lag**.
- **Cancellation and deadlines in async systems**.

## Когда переходить дальше

Можно переходить, когда three implementations enforce the same bounds, overload behavior is explicit, and waiting/CPU/cancellation differences are demonstrated by evidence.