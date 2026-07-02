# Спринт 06. Проверка основ распределённых систем

Ориентировочный объём: 14–21 час.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 01–05.

## Исходная задача

Создать `work/distributed-foundations-checkpoint/` — small multi-process Go system with discovery, load balancing, propagated deadlines, safe retries and bounded overload behavior.

## Required flow

- three API/service replicas;
- dynamic membership and endpoint churn;
- one stateful dependency and one provider simulator;
- operation/attempt identity;
- propagated end-to-end deadline;
- bounded retries with jitter;
- stateless request processing;
- bounded queue and admission control;
- fault proxy and observability.

## Mandatory fault cases

1. Request is delivered but response is lost.
2. Process is paused rather than crashed.
3. One-way/asymmetric network delay or partition.
4. Clock skew reverses apparent event order.
5. Nested retries amplify traffic.
6. Dead endpoint remains in discovery cache.
7. Keep-alive creates severe load skew.
8. Health check differs from real operation path.
9. Local session state is lost after rescheduling.
10. Unbounded queue exhausts memory or latency.
11. Scale-down interrupts work.
12. Cold replicas overload a dependency.

## Defense

1. What are explicit failure/timing assumptions?
2. Safety and liveness properties?
3. How are operation and attempts identified?
4. What is unknown after timeout?
5. How is deadline budget allocated?
6. Why are retries bounded and jittered?
7. How does discovery expire stale membership?
8. How is load distribution measured?
9. What local state is disposable?
10. Where is backpressure applied?
11. What is the first saturation point?
12. Which evidence distinguishes delay from crash?

## Критерии прохождения

- all remote operations have explicit deadline and identity;
- duplicate/lost/late responses preserve invariants;
- membership churn and stale endpoints recover within measured bounds;
- replicas are replaceable without authoritative-state loss;
- queues/retries/concurrency are bounded;
- all twelve faults are reproduced and diagnosed;
- at least 10 of 12 defense answers reference traces, counters or fault history;
- cleanup removes all proxies, qdiscs, processes and test state.

## Результат для базы знаний

Checkpoint-specific note не требуется. Update existing notes where measured network, retry or scaling behavior changed assumptions.