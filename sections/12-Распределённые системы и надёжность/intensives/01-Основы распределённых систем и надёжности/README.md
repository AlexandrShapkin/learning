# Основы распределённых систем и надёжности

Основной интенсив раздела «Распределённые системы и надёжность». Его цель — научиться проектировать systems of communicating components under delay, duplication, reordering, overload and partial failure, while making consistency, availability, recovery and coordination trade-offs explicit.

Практика выполняется на synthetic Go-системе:

- API gateway and stateless service replicas;
- replicated key-value/account state service;
- partitioned worker and event-log subsystem;
- coordinator/lease service;
- PostgreSQL for local transactional state;
- fault proxy for latency, loss, duplication, reordering and network partitions;
- observability and deterministic test harness.

## Результат прохождения

После завершения необходимо уметь самостоятельно:

- model nodes, processes, messages, state and failure domains;
- distinguish crash, omission, timing, partition and Byzantine assumptions;
- explain why remote failure cannot be known immediately;
- design deadlines, cancellation, retries and retry budgets;
- make APIs idempotent under duplicate/late requests;
- select client-side/server-side load balancing and discovery;
- scale stateless paths while controlling overload and state affinity;
- compare leader-follower, multi-leader and leaderless replication;
- define linearizable, sequential, causal, snapshot and eventual consistency requirements;
- reason about read/write quorums and stale data;
- apply CAP/PACELC without using them as slogans;
- represent versions with logical clocks/vector clocks and resolve conflicts;
- understand CRDT join/merge properties;
- choose partition keys and consistent/rendezvous hashing;
- plan rebalancing, locality and hot-shard mitigation;
- distinguish work queues, pub/sub and durable logs;
- define at-most-once, at-least-once and effectively-once behavior;
- design ordering, consumer groups, offsets, replay and retention;
- implement idempotency keys, deduplication, inbox/outbox and reconciliation;
- control poison messages, retry topics, dead-letter queues and backpressure;
- evolve asynchronous contracts and schemas;
- use locks, leases and fencing tokens safely;
- explain leader election, majority quorum and Raft log replication;
- distinguish consensus from replication, discovery or distributed locks;
- choose local transactions, two-phase commit, sagas and compensations;
- apply timeout, retry, hedging, circuit breaker, bulkhead and rate limiting patterns;
- design load shedding and graceful degradation;
- prevent retry storms, cascading failures and split brain;
- design multi-zone/multi-region failover and failback;
- connect architecture to SLI/SLO, RTO/RPO and recovery evidence;
- test safety/liveness under crashes, pauses, partitions, clock skew and overload;
- use deterministic simulation, model-based testing and fault injection;
- diagnose first divergence across requests, messages, replicas and coordinators;
- document invariants, assumptions and unacceptable failure modes.

Целевой уровень: 3 по всему разделу и 4 по consistency/replication reasoning, messaging semantics, coordination, resilience under overload, fault testing and multi-region recovery.

## Границы

Интенсив не заменяет:

- implementation course for production consensus/storage engines;
- deep distributed database internals specialization;
- formal methods course in TLA+/PlusCal/Coq;
- Kafka/Pulsar/RabbitMQ vendor administration certification;
- cloud-provider-specific multi-region architecture course;
- security course covering Byzantine/adversarial systems;
- full SRE/on-call apprenticeship;
- mathematical queueing-theory specialization.

Storage engine details belong to «Данные и хранилища»; platform placement to «Инфраструктура и платформы»; incident command and recovery procedures to «Доставка и эксплуатация».

## Предварительные знания

Рекомендуется завершить основные интенсивы по networks, programming runtimes, data stores, application design, infrastructure, delivery and observability.

Минимально необходимы:

- Go concurrency, contexts, channels and networking;
- HTTP/gRPC or equivalent RPC concepts;
- TCP, DNS, TLS and load balancing basics;
- SQL transactions and isolation basics;
- queues/logs at introductory level;
- Docker/Compose and Kubernetes basics;
- Prometheus/log/trace diagnostics;
- understanding of SLO, RTO and RPO;
- technical English.

## Лабораторное окружение

Default laboratory:

- Linux host or VM;
- Go, Git, Bash, Make, jq and yq;
- Docker/Podman and Compose;
- kind/k3d/k3s and `kubectl`;
- PostgreSQL;
- NATS JetStream, Redpanda/Kafka-compatible broker or another local durable log;
- Redis/Valkey optional for lease/cache experiments;
- Toxiproxy or custom Go network proxy;
- Prometheus, Grafana and OpenTelemetry for evidence;
- k6/Vegeta for bounded load;
- `tc netem`, `iptables`/`nftables`, `ss`, `tcpdump`;
- optional Jepsen-style or model-checking harness;
- optional TLA+/PlusCal for specification exercises.

Подробности: [`LAB_ENVIRONMENT.md`](LAB_ENVIRONMENT.md).

Проверка:

```bash
bash scripts/check-environment.sh
```

## Принципы прохождения

1. Every remote call can delay, duplicate, reorder, fail or complete after the caller gives up.
2. Safety and liveness properties are written before implementation claims.
3. “Exactly once” is decomposed into delivery, execution, effects and observation.
4. Timeouts bound waiting; retries create additional work and must have budgets.
5. Idempotency and deduplication have explicit scope, key, retention and concurrency semantics.
6. Replication does not by itself define consistency or availability.
7. Quorum equations are checked against failure and topology assumptions.
8. Coordination is minimized and protected with epochs or fencing tokens.
9. Backpressure and admission control are part of correctness under overload.
10. Failover is incomplete until stale writers and failback are handled.
11. Chaos experiments verify named hypotheses; they do not substitute for design.
12. Diagnosis preserves node/message/epoch/version evidence before restart or repair.
13. General mechanisms move to `knowledge`; implementations, traces and fault evidence remain in `learning`.

## Основной стек

- Go and contexts;
- HTTP/gRPC-style RPC;
- PostgreSQL;
- NATS JetStream or Kafka-compatible log;
- Docker/Compose and Kubernetes;
- Toxiproxy and `tc netem`;
- Prometheus/OpenTelemetry/Grafana;
- k6 or Vegeta;
- optional Redis/Valkey, etcd and TLA+;
- Bash, Make, jq and yq.

## Порядок спринтов

1. [Модель распределённой системы и частичные отказы](sprints/01-Модель%20распределённой%20системы%20и%20частичные%20отказы/)
2. [Время, порядок, идентичность и неопределённость](sprints/02-Время%20порядок%20идентичность%20и%20неопределённость/)
3. [RPC, deadlines, cancellation и retry budgets](sprints/03-RPC%20deadlines%20cancellation%20и%20retry%20budgets/)
4. [Service discovery и балансировка нагрузки](sprints/04-Service%20discovery%20и%20балансировка%20нагрузки/)
5. [Stateless scaling, affinity и backpressure](sprints/05-Stateless%20scaling%20affinity%20и%20backpressure/)
6. [Проверка основ распределённых систем](sprints/06-Проверка%20основ%20распределённых%20систем/)
7. [Топологии репликации и lag](sprints/07-Топологии%20репликации%20и%20lag/)
8. [Модели согласованности](sprints/08-Модели%20согласованности/)
9. [Quorums, CAP и PACELC](sprints/09-Quorums%20CAP%20и%20PACELC/)
10. [Версии, logical clocks и разрешение конфликтов](sprints/10-Версии%20logical%20clocks%20и%20разрешение%20конфликтов/)
11. [CRDT и монотонное слияние состояния](sprints/11-CRDT%20и%20монотонное%20слияние%20состояния/)
12. [Partitioning, sharding и hashing](sprints/12-Partitioning%20sharding%20и%20hashing/)
13. [Rebalancing, locality и hot shards](sprints/13-Rebalancing%20locality%20и%20hot%20shards/)
14. [Проверка репликации и распределения данных](sprints/14-Проверка%20репликации%20и%20распределения%20данных/)
15. [Очереди, pub-sub и журналы событий](sprints/15-Очереди%20pub-sub%20и%20журналы%20событий/)
16. [Delivery semantics, ordering и consumer groups](sprints/16-Delivery%20semantics%20ordering%20и%20consumer%20groups/)
17. [Idempotency, deduplication, outbox и inbox](sprints/17-Idempotency%20deduplication%20outbox%20и%20inbox/)
18. [Backpressure, poison messages, DLQ и replay](sprints/18-Backpressure%20poison%20messages%20DLQ%20и%20replay/)
19. [Event contracts и schema evolution](sprints/19-Event%20contracts%20и%20schema%20evolution/)
20. [Проверка асинхронной обработки](sprints/20-Проверка%20асинхронной%20обработки/)
21. [Distributed locks, leases и fencing tokens](sprints/21-Distributed%20locks%20leases%20и%20fencing%20tokens/)
22. [Leader election, consensus и Raft](sprints/22-Leader%20election%20consensus%20и%20Raft/)
23. [Two-phase commit и атомарное решение](sprints/23-Two-phase%20commit%20и%20атомарное%20решение/)
24. [Sagas, compensations и workflow state](sprints/24-Sagas%20compensations%20и%20workflow%20state/)
25. [Проверка координации и распределённых операций](sprints/25-Проверка%20координации%20и%20распределённых%20операций/)
26. [Timeouts, retries, hedging и circuit breakers](sprints/26-Timeouts%20retries%20hedging%20и%20circuit%20breakers/)
27. [Bulkheads, rate limits и admission control](sprints/27-Bulkheads%20rate%20limits%20и%20admission%20control/)
28. [Load shedding и graceful degradation](sprints/28-Load%20shedding%20и%20graceful%20degradation/)
29. [Failover, multi-zone и multi-region](sprints/29-Failover%20multi-zone%20и%20multi-region/)
30. [Availability, SLO, RTO, RPO и recovery architecture](sprints/30-Availability%20SLO%20RTO%20RPO%20и%20recovery%20architecture/)
31. [Fault injection, deterministic testing и chaos engineering](sprints/31-Fault%20injection%20deterministic%20testing%20и%20chaos%20engineering/)
32. [Capacity, queueing и reliability economics](sprints/32-Capacity%20queueing%20и%20reliability%20economics/)
33. [Системная диагностика и reliability review](sprints/33-Системная%20диагностика%20и%20reliability%20review/)
99. [Итоговая работа](sprints/99-Итоговая%20работа/)

## Покрытие основных вопросов

| Вопрос | Спринты |
|---|---|
| Почему удалённый отказ трудно отличить от задержки? | 01–03, 26, 31 |
| Как масштабировать и распределять нагрузку? | 04–06, 12–13, 27–28, 32 |
| Как выбрать replication and consistency? | 07–14 |
| Что practically mean CAP/PACELC? | 08–10 |
| Как выбрать partition key and avoid hot shard? | 12–14, 32 |
| Queue versus event log? | 15–20 |
| Какие delivery and ordering guarantees нужны? | 16–20 |
| Как сделать повторы безопасными? | 03, 16–18, 24, 26 |
| Когда нужна coordination/consensus/transaction? | 21–25 |
| Как ограничить failure propagation? | 26–28, 32–33 |
| Как проектировать failover and controlled degradation? | 28–31 |
| Как проверять partial failures and overload? | 06, 14, 20, 25, 31–33 |

## Итоговая работа

Финальный проект — `distributed-reliability-lab`: synthetic multi-service system with replicated and partitioned state, durable event processing, coordination, resilience controls, multi-zone recovery, deterministic fault testing and read-only `disttriage` diagnostics.

Система должна позволять:

- reproduce partial failures, delayed/duplicated messages and network partitions;
- compare consistency and availability under multiple replication modes;
- rebalance partitions and handle hot keys;
- process events safely under retries, crashes and replay;
- demonstrate locks with fencing, leader election and consensus;
- run saga and 2PC failure cases;
- contain retry storms and overload;
- fail over between zones/regions without stale writers;
- measure SLO, capacity, recovery and data loss;
- diagnose first divergence across requests, messages, replicas, epochs and offsets.

## Вклад в базу знаний

Each sprint names exact recommended notes. General mechanisms move to `knowledge`; source, fault scenarios, traces, models and experimental reports remain in `learning`.

## Общая библиография

Official specifications, documentation, papers and selected books are listed in [`RESOURCES.md`](RESOURCES.md). Each sprint identifies the required minimum route.
