# Реализация итоговой работы

## 1. System model and invariants

Write before implementation:

- nodes, processes, messages, local/durable state and failure domains;
- timing model and clock assumptions;
- crash/restart/storage/network assumptions;
- authoritative state and ownership;
- safety invariants;
- liveness/progress expectations;
- unacceptable ambiguity and manual-intervention states.

Minimum invariants:

```text
inventory never becomes negative without an explicit oversell policy
one logical payment/fulfillment effect is applied at most once
only current partition/lease epoch writes authoritative state
committed replicated-log entries never change
one workflow reaches one valid terminal or intervention state
one region/leader is authoritative for protected writes
```

## 2. Canonical identity and evidence

Every path exposes:

```text
operation_id
attempt_id
request_id / trace_id
message_id and event version
workflow_id and step_id
partition_id and ownership_epoch
replica_id, term and log index
consumer_group, partition and offset
release, config and schema revision
zone and region
```

Histories distinguish invocation, response, timeout, durable effect, acknowledgement and observation.

## 3. RPC and stateless service layer

Implement:

- discovery and balancing across at least three replicas;
- propagated end-to-end deadlines;
- cancellation and bounded child budgets;
- retry classification, backoff, jitter and global attempt budget;
- idempotency keys for commands;
- stale/late response rejection;
- readiness, draining and replaceable stateless instances;
- bounded request queues and admission.

Test lost requests/responses, pauses, stale discovery, load skew, cold starts and scale-down.

## 4. Replicated state

Implement an educational replicated state group or faithful wrapper with visible protocol state.

Required:

- leader-follower or leaderless mode;
- durable/log positions and lag;
- term/epoch and stale-writer rejection;
- configurable acknowledgement/read policy;
- client histories for at least linearizable/read-your-writes/eventual modes;
- follower bootstrap and snapshot/catch-up;
- divergence/checksum detection;
- majority/minority partition experiments;
- read repair/anti-entropy where applicable.

Do not claim production-grade storage or consensus from an educational implementation.

## 5. Versions, conflicts and CRDT

Provide:

- conditional compare-and-set writes;
- vector/version metadata or equivalent causal tracking;
- concurrent-value detection;
- domain-specific merge and explicit unresolved conflict state;
- tombstone/resurrection tests;
- one CRDT with merge-law property tests;
- one invariant that demonstrates why coordination remains necessary.

## 6. Partitioning and rebalancing

Implement:

- logical partition key and routing;
- consistent/rendezvous hashing or versioned directory;
- replication placement by failure domain;
- ownership epochs;
- online snapshot + catch-up + cutover + retire migration;
- stale-router redirect/rejection;
- resumable interrupted migration;
- hot-key/partition/node detection and at least two mitigations;
- checksum/offset verification.

## 7. Durable messaging

Use NATS JetStream, Kafka-compatible broker or equivalent.

Required:

- work queue and durable event-log examples;
- partitions/subjects and consumer groups;
- explicit acknowledgement/offset boundary;
- delivery/order/replay contract;
- consumer rebalance handling;
- lag, backlog age, attempts and ownership telemetry;
- bounded producer buffering during broker outage;
- isolated historical replay.

## 8. Outbox, inbox and external effects

Implement:

- local business transaction plus outbox;
- restartable relay that may publish duplicates;
- consumer inbox/dedup plus business effect;
- payload-conflict detection for reused idempotency key;
- external provider idempotency or durable reconciliation state;
- dedup retention exceeding retry/replay window;
- reconciliation reports for outbox/inbox/provider state.

Crash before/after every durable effect and acknowledgement.

## 9. Retry, DLQ and schema lifecycle

Required:

- transient/permanent error taxonomy;
- bounded delayed retry with jitter;
- poison-message isolation;
- DLQ with original metadata and failure history;
- reviewed, filtered, rate-limited redrive;
- event envelope and compatibility policy;
- old/new producer/consumer coexistence;
- retained-event replay tests;
- field/event deprecation with usage evidence.

## 10. Leases and fencing

Implement or configure:

- lease acquisition, renewal, expiry and release;
- unique holder/process epoch;
- monotonically increasing fencing token;
- protected resource validation;
- paused-holder recovery test;
- contention and lock-service partition behavior;
- one redesign that removes the lock.

## 11. Consensus model

Use a deterministic Raft simulation or educational implementation.

Required:

- terms, votes, leader role, log indexes and commit index;
- durable term/vote/log state;
- majority election and append/commit behavior;
- divergent-log repair;
- state-machine determinism;
- snapshot and restore;
- randomized schedule invariant checks;
- explicit distinction between educational model and production library.

## 12. Distributed operations

### Two-phase commit

- durable coordinator and participant logs;
- prepare/commit/abort idempotence;
- crash before/after decision;
- blocked prepared state and operator recovery evidence;
- resource-hold measurement.

### Saga

- durable workflow state machine;
- idempotent step commands and callbacks;
- reservations, expirations and compensations;
- late success and duplicate compensation handling;
- irreversible step and manual-intervention state;
- user-visible status and complete history.

## 13. Resilience controls

Implement and test:

- timeout allocation from user budget;
- retry and hedging budgets;
- circuit breaker with bounded half-open probes;
- bulkheads for critical/noncritical work;
- per-tenant and global concurrency/rate controls;
- admission before expensive work;
- retry-after/backoff guidance;
- fallback capacity and failure isolation;
- recovery ramp/hysteresis.

## 14. Graceful degradation

Define:

- critical, optional and deferrable capabilities;
- minimum viable service;
- stale/partial response semantics;
- load-shedding trigger and priority;
- preserved health/control/recovery capacity;
- backlog drain policy;
- restoration-to-normal criteria.

## 15. Multi-zone and multi-region recovery

Simulate at least three zones and two regions.

Required:

- placement/quorum map;
- synchronous/asynchronous replication choice;
- zone-loss capacity test;
- region promotion with new epoch;
- old-primary fencing;
- DNS/traffic/connection behavior;
- replication-position and data-loss evidence;
- minimum service capacity;
- failback or new-primary reconciliation;
- independent recovery/identity/control dependencies.

## 16. Reliability objectives and capacity

Define and measure:

- user-journey SLI/SLO;
- dependency and common-mode failure model;
- RTO/RPO by zone loss, region loss and corruption;
- normal, peak, burst, one-failure and recovery workloads;
- Little’s Law inputs/results;
- saturation knee and first bottleneck;
- retry/fan-out/replication overhead;
- backlog drain capacity;
- reliability cost and rejected alternatives.

## 17. Deterministic and fault testing

Create a deterministic event scheduler/model supporting:

- message delay, drop, duplication and reordering;
- process pause, crash and restart;
- durable-state persistence/failure assumptions;
- clock offset/logical time;
- random seeds and history replay;
- invariant checking after each transition;
- failing-history reduction.

Mirror selected cases through Toxiproxy/`tc`/container failures. Chaos tests require steady state, hypothesis, abort and cleanup.

## 18. `disttriage`

Read-only commands:

```text
disttriage operation
disttriage message
disttriage workflow
disttriage replica
disttriage partition
disttriage quorum
disttriage leader
disttriage backlog
disttriage topology
disttriage timeline
disttriage capacity
disttriage recovery
```

The tool limits time/output, redacts payloads and never changes routing, ownership, offsets, terms, leases or workflow state.

## 19. Reliability review

For every critical invariant document:

- controlling mechanism;
- hidden timing/storage/network assumption;
- telemetry/evidence;
- single and combined fault tests;
- recovery/failback procedure;
- known gap and accepted risk;
- correctness, availability, operability and cost trade-off.

## 20. Verification commands

```text
make check
make up
make test-unit
make test-histories
make test-replication
make test-consistency
make test-partitions
make test-messaging
make test-idempotency
make test-leases
make test-consensus
make test-workflows
make test-resilience
make test-failover
make test-model
make fault-smoke
make triage-smoke
make verify-invariants
make down
make cleanup-check
```

## 21. Implementation stages

### Stage 1. Foundations

System model, identities, RPC, discovery, stateless scaling.

### Stage 2. Distributed state

Replication, consistency, quorums, conflicts, CRDT and partitioning.

### Stage 3. Messaging

Queues/logs, groups, outbox/inbox, retries, DLQ and schemas.

### Stage 4. Coordination

Leases/fencing, consensus, 2PC and saga workflows.

### Stage 5. Resilience

Timeout/retry/hedging, breakers, bulkheads, admission and degradation.

### Stage 6. Recovery

Multi-zone/region failover, SLO, RTO/RPO and capacity.

### Stage 7. Testing and diagnosis

Deterministic simulation, chaos, `disttriage` and reliability review.

### Stage 8. Assessment

Blind histories, clean reconstruction, combined incident and delayed assessment.
