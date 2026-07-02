# Распределённые системы и надёжность

Практическое изучение частичных отказов, масштабирования, репликации, согласованности, partitioning, обмена сообщениями, координации, отказоустойчивости и восстановления распределённых систем.

Раздел соответствует области [«Распределённые системы и надёжность»](https://github.com/AlexandrShapkin/knowledge/tree/main/content/Распределённые%20системы%20и%20надёжность) базы знаний.

## Основной интенсив

### [01. Основы распределённых систем и надёжности](intensives/01-Основы%20распределённых%20систем%20и%20надёжности/)

Маршрут строится вокруг одного распределённого Go-приложения: API, replicated state service, partitioned worker system, event log, coordinator and failure injector. Практика включает задержки, потери сообщений, сетевые разделения, crash/restart, clock skew, overload, stale replicas, split-brain risks and regional recovery.

После прохождения необходимо уметь:

- объяснять неопределённость сети и частичные отказы;
- проектировать RPC deadlines, cancellation and retry budgets;
- выбирать service discovery and load-balancing model;
- масштабировать stateless and stateful components;
- выбирать replication topology and consistency guarantees;
- применять quorum reasoning, CAP and PACELC;
- разрешать concurrent updates with versions, clocks and CRDT concepts;
- выбирать partition key, consistent hashing and rebalancing strategy;
- отличать queues from durable logs;
- проектировать delivery, ordering, replay and consumer-group semantics;
- реализовывать idempotency, deduplication, outbox and inbox;
- управлять backpressure, poison messages and dead-letter flows;
- применять leases, fencing tokens and leader election;
- понимать consensus and Raft mechanisms;
- выбирать between local transaction, 2PC, saga and compensation;
- ограничивать failure propagation through timeouts, retries, circuit breakers, bulkheads and rate limits;
- проектировать graceful degradation and load shedding;
- строить multi-zone and multi-region failover;
- связывать SLO, availability, RTO and RPO with architecture;
- проверять системы через deterministic simulation, fault injection and chaos experiments;
- локализовать first divergence across nodes, messages, replicas and coordinators;
- документировать safety, liveness and operational trade-offs.

Ориентировочный объём: 370–520 часов.

## Планируемые тематические углубления

- **Consensus algorithms and replicated state machines**;
- **Distributed databases and consistency models**;
- **Streaming platforms and event processing**;
- **CRDTs and conflict-free collaboration**;
- **Distributed transactions and workflow orchestration**;
- **Multi-region architecture and disaster tolerance**;
- **Resilience engineering and overload control**;
- **Deterministic simulation and distributed-systems testing**;
- **Queueing, capacity and performance of distributed systems**;
- **Formal specification of safety and liveness properties**.

Каждое углубление будет самостоятельным маршрутом.

## Связи с другими разделами

- Network behavior and protocols — [«Сети и протоколы»](../03-Сети%20и%20протоколы/).
- Concurrency and runtime mechanisms — [«Программирование и среды выполнения»](../04-Программирование%20и%20среды%20выполнения/).
- Storage engines, transactions and database internals — [«Данные и хранилища»](../06-Данные%20и%20хранилища/).
- Service boundaries and application contracts — [«Проектирование программного обеспечения»](../08-Проектирование%20программного%20обеспечения/).
- Cloud, Kubernetes and placement — [«Инфраструктура и платформы»](../09-Инфраструктура%20и%20платформы/).
- Recovery procedures and incident response — [«Доставка и эксплуатация»](../10-Доставка%20и%20эксплуатация/).
- Telemetry and cross-layer diagnosis — [«Наблюдаемость и диагностика»](../11-Наблюдаемость%20и%20диагностика/).
- Authentication, trust and distributed security — [«Безопасность»](../13-Безопасность/).
