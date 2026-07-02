# Спринт 99. Итоговая работа

Ориентировочный объём: 75–110 часов.

## Задача

Создать `distributed-reliability-lab` — synthetic multi-service system demonstrating partial failures, replication, consistency, partitioning, durable messaging, coordination, overload controls, multi-zone recovery and reproducible fault testing.

Проект не является production database or messaging platform. Его задача — доказать через histories, invariants and measured fault experiments, что заявленные safety, liveness, consistency, availability and recovery properties сохраняются в обозначенных границах.

## Reference domain

Synthetic reservation and fulfillment system:

- stateless API gateway and service replicas;
- replicated inventory/account state;
- partitioned order/work ownership;
- durable event log and worker groups;
- PostgreSQL local transactional state;
- external payment/fulfillment simulators;
- coordinator/lease service;
- multi-zone and multi-region simulation;
- observability and fault-control plane.

## Target topology

```text
clients/load generator
        |
load balancer / discovery
        |
API and domain-service replicas
├── replicated state group
├── partitioned ownership/shards
├── PostgreSQL local state + outbox
├── durable event log
├── consumer groups + inbox/DLQ
├── lease/consensus coordinator
├── workflow/saga engine
└── provider simulators

resilience and recovery
├── deadlines/retry budgets/circuit breakers
├── bulkheads/rate limits/load shedding
├── zone/region placement and failover
├── deterministic model/fault runner
└── read-only disttriage
```

## Repository structure

```text
work/distributed-reliability-lab/
├── services/
├── protocols/
├── replication/
├── partitions/
├── messaging/
├── coordination/
├── workflows/
├── resilience/
├── topology/
├── models/
├── faults/
├── load/
├── observability/
├── reports/
├── scripts/
├── Makefile
└── README.md
```

## Документы итоговой работы

- [`IMPLEMENTATION.md`](IMPLEMENTATION.md) — mandatory subsystems, stages and evidence.
- [`FAULTS.md`](FAULTS.md) — catalogue of 64 bounded distributed faults.
- [`ASSESSMENT.md`](ASSESSMENT.md) — blind histories, clean reconstruction and final defense.

## Mandatory capabilities

1. Explicit system/timing/failure model and critical invariants.
2. Canonical operation, attempt, message, replica, partition, term and epoch identities.
3. End-to-end deadlines, cancellation, retry budgets and idempotency.
4. Dynamic service discovery, balancing, draining and stateless scaling.
5. Replicated state with measurable lag, terms/epochs and stale-writer fencing.
6. At least two consistency modes and client-history tests.
7. Quorum/partition behavior and convergence mechanisms.
8. Version/conflict handling and one CRDT experiment.
9. Partition routing, online rebalancing and hot-key mitigation.
10. Durable queue/log, consumer groups, ordering and replay.
11. Transactional outbox, inbox/dedup and external-effect reconciliation.
12. Poison/DLQ/backpressure/schema-evolution handling.
13. Lease/fencing and educational consensus state machine.
14. One 2PC case and one durable saga case.
15. Circuit breaker, bulkhead, admission and load-shedding controls.
16. Multi-zone and multi-region failover with one authoritative writer.
17. SLO, capacity, RTO and RPO evidence.
18. Deterministic simulation, invariant checks and bounded chaos tests.
19. Read-only `disttriage` diagnostics and reliability review.

## Mandatory scenarios

1. Lost response after successful effect with safe retry.
2. Paused process indistinguishable from failed process until policy timeout.
3. Discovery staleness and connection load skew.
4. Replica lag and stale read after user write.
5. Old leader resumes after promotion and is fenced.
6. Majority/minority partition with documented availability/consistency behavior.
7. Concurrent updates detected and resolved without wall-clock LWW loss.
8. CRDT replicas converge under reorder/duplication.
9. Live shard rebalance survives interruption.
10. Hot key is mitigated without breaking required ordering.
11. Producer/outbox and consumer/inbox crash boundaries preserve one intended effect.
12. Rebalance/replay/DLQ remain idempotent and bounded.
13. Expired lease holder resumes and is rejected by fencing token.
14. Consensus group preserves committed-log safety through partition/crash.
15. 2PC demonstrates blocked uncertainty; saga demonstrates compensation and late callback.
16. Retry/hedging/circuit-breaker composition avoids amplification.
17. One tenant/dependency overload is contained by bulkheads/admission.
18. Load shedding preserves minimum service and recovery capacity.
19. Zone and region failover avoid dual writers and measure data loss.
20. Deterministic scheduler finds/replays one nontrivial invariant violation.
21. Combined fault is diagnosed to first divergence through `disttriage`.

## Main results

The completed laboratory includes:

- system and failure model;
- invariant catalogue and property tests;
- client/message/replica histories;
- replication/consistency/quorum reports;
- partition placement and rebalancing evidence;
- messaging delivery/idempotency/replay evidence;
- lease/consensus/transaction/workflow histories;
- resilience and overload experiments;
- failover/recovery/capacity reports;
- deterministic fault runner and seeds;
- `disttriage` output and reliability review;
- 64 reproducible fault definitions.

## Execution order

1. Build reference domain and system/failure model.
2. Add RPC identity, deadlines and stateless scaling.
3. Implement replication, consistency and partitioning.
4. Implement durable messaging and idempotent effects.
5. Add leases, consensus and distributed workflows.
6. Add resilience, admission and graceful degradation.
7. Add multi-zone/region failover and recovery objectives.
8. Build deterministic simulation and fault catalogue.
9. Implement `disttriage` and reliability review.
10. Run blind assessment and clean reconstruction.

## Artifacts to commit

- service/protocol/model source;
- broker/database/topology configuration;
- invariant and property tests;
- bounded fault/load scripts;
- concise histories and experimental reports;
- architecture and failure-domain diagrams;
- read-only diagnostic tooling;
- commands to regenerate large evidence;
- links to generalized `knowledge` notes.

Do not commit:

- broker/database volumes or large snapshots;
- credentials, certificates or private keys;
- raw large logs/traces/captures;
- production topology, incidents or user data;
- unbounded chaos/stress scripts;
- generated binaries/images;
- state containing secrets or personal information.

## Safety

- every node, topic, shard and fault is labeled with repository and expiry;
- network faults target exact namespace/interface/proxy and auto-expire;
- partitions preserve a management/control path;
- load and replay have rate, concurrency, duration and record caps;
- disk pressure uses dedicated bounded volumes;
- clock faults never change host time;
- multi-region experiments use local simulated sites;
- fault controller cannot access unrelated namespaces/clusters;
- cleanup verifies qdiscs, firewall rules, processes, leases, topics, volumes and routes.

## Результат для базы знаний

Итоговая работа должна завершить или исправить заметки по partial failures, time/order, retries, replication, consistency, quorums, CAP/PACELC, conflict resolution, CRDT, sharding, messaging, idempotency, coordination, consensus, distributed transactions, resilience, failover, recovery and distributed testing.

Source, histories, model code and fault evidence remain in `learning`; generalized mechanisms move to `knowledge`.
