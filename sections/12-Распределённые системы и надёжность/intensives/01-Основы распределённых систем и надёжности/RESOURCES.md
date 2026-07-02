# Ресурсы интенсива

Это общая библиография. Внутри каждого спринта указан обязательный minimum route. Не требуется читать всё последовательно.

## Foundations

- *Designing Data-Intensive Applications*, Martin Kleppmann.
- *Distributed Systems*, Maarten van Steen and Andrew Tanenbaum.
- *Distributed Systems: Principles and Paradigms* and related open materials.
- *Understanding Distributed Systems*, Roberto Vitillo.
- *Release It!*, Michael Nygard, for failure propagation and stability patterns.
- Google SRE books for overload, availability and recovery.

## Time, failure and consistency

- Lamport, “Time, Clocks, and the Ordering of Events in a Distributed System”.
- CAP papers and Gilbert/Lynch formalization.
- PACELC material by Daniel Abadi.
- consistency-model papers and Jepsen consistency documentation.
- vector clocks, version vectors and logical-clock references.
- CRDT papers and Shapiro et al. survey.

## Replication, partitioning and consensus

- Raft paper and official visualization/materials.
- Ongaro’s Raft dissertation, selected chapters.
- Paxos papers as reference after Raft.
- consistent hashing and rendezvous hashing papers.
- Dynamo, Bigtable, Spanner and related system papers as case studies.
- etcd/Raft documentation for implementation behavior.

## Messaging and streaming

- Kafka protocol/design and consumer documentation.
- NATS JetStream documentation.
- RabbitMQ reliability/consumer acknowledgement documentation as comparison.
- transactional outbox/inbox and idempotent-consumer patterns.
- event schema compatibility documentation for selected format/registry.
- streaming papers such as MillWheel/Dataflow concepts where relevant.

## Coordination and transactions

- two-phase commit and atomic commit references.
- saga paper by Garcia-Molina and Salem.
- leases, fencing tokens and distributed lock references.
- workflow engine documentation used only as an implementation comparison.
- TLA+/PlusCal official materials for optional specifications.

## Reliability and overload

- Google SRE chapters on handling overload, cascading failures and addressing reliability.
- AWS Builders’ Library articles on timeouts, retries, jitter and backoff, used critically.
- circuit breaker, bulkhead, load shedding and admission-control references.
- queueing theory introductions and Little’s Law.
- tail-at-scale and hedged-request papers.

## Testing and diagnosis

- Jepsen analyses and consistency-model documentation.
- FoundationDB deterministic simulation material.
- Antithesis/Lineage-driven fault-injection public papers/materials where accessible.
- Chaos Engineering principles used with explicit hypotheses and safety limits.
- OpenTelemetry/Prometheus documentation for evidence.
- Linux network fault and process-control documentation.

## Rules for sources

1. Papers and specifications define models; product docs define version-specific behavior.
2. A vendor claim is not accepted as a guarantee without configuration and fault evidence.
3. “Exactly once”, “strong consistency” and “high availability” must be decomposed into observable properties.
4. Every algorithm is evaluated under explicit timing, crash, storage and network assumptions.
5. Case-study architecture is not copied without workload and failure-domain comparison.
6. Fault tests use synthetic data and bounded local resources.
7. Formal notation is used to clarify invariants, not to decorate reports.
8. Do not copy private incident reports, proprietary course content or production credentials/topologies.
