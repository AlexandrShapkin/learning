# Итоговая проверка

## Blind distributed-system exercise

Solve at least 26 hidden incidents:

- four RPC/discovery/scaling cases;
- four replication/consistency cases;
- four partitioning/rebalancing cases;
- four messaging/event-processing cases;
- four coordination/workflow cases;
- four resilience/failover cases;
- two combined multi-layer cases.

For each incident:

```text
Exact user-visible symptom and violated/suspected invariant
Topology, failure domains and authoritative state
Operation, attempt, message, partition, replica, term and epoch identities
Preserved client/message/replica/workflow histories
Causal timeline with uncertainty
Competing hypotheses and discriminating read-only check
First divergence, trigger and contributing conditions
Minimal repair or isolation
Authoritative-state, convergence, backlog and user verification
Invariant test, admission control or design correction
```

## Clean reconstruction

From clean checkout and empty laboratory state:

1. verify tools, host capacity and safety markers;
2. build services, models and fault controller;
3. create discovery/load-balancing topology;
4. provision replicated state and partition map;
5. provision broker, consumer groups, outbox/inbox and DLQ;
6. provision lease/coordinator and workflow components;
7. load observability, identities and `disttriage`;
8. run RPC/deadline/retry/discovery tests;
9. run replication/consistency/quorum histories;
10. run rebalance/hot-shard tests;
11. run crash/replay/schema messaging tests;
12. run lease/consensus/2PC/saga tests;
13. run overload/degradation/capacity tests;
14. run zone/region failover and recovery;
15. run deterministic model and selected real fault replay;
16. destroy all processes, networks, topics, leases, rules and volumes safely.

## Complete combined exercise

Perform one scenario:

1. one region receives a release with slower dependency calls;
2. tail latency triggers retries and hedged requests;
3. provider and DB pools saturate;
4. event backlog grows and consumer group rebalances;
5. outbox duplicates are delivered after dedup pressure;
6. partition rebalance starts while one hot key dominates;
7. a zone fails and old partition/lease holders resume later;
8. replica lag and stale routing create conflicting observations;
9. load shedding preserves critical reads but defers fulfillment;
10. region failover begins with asynchronous replication lag;
11. old region is fenced before traffic promotion;
12. `disttriage` reconstructs the first divergence and all stale epochs;
13. authoritative state, workflows and backlog are reconciled;
14. deterministic and real fault tests are updated and replayed.

## Consensus and transaction exercise

1. partition a Raft-like group into majority/minority;
2. crash current leader around append/commit boundary;
3. restart one node from snapshot plus log;
4. execute one 2PC transaction and lose coordinator around decision;
5. execute one saga with lost success and failed compensation;
6. prove committed-log safety, explicit 2PC uncertainty and valid saga terminal/intervention state;
7. compare which operations required consensus, atomic commit or compensation.

## Final defense

Answer using project evidence:

1. What makes a system distributed?
2. Why can delay not be distinguished immediately from failure?
3. Safety versus liveness?
4. Physical, monotonic and logical time?
5. Causal versus total order?
6. Operation versus attempt identity?
7. What remains unknown after RPC timeout?
8. How are deadline and retry budgets composed?
9. How do discovery and load balancing fail?
10. What makes a component stateless and horizontally scalable?
11. Leader-follower, multi-leader and leaderless replication?
12. Synchronous versus asynchronous replication?
13. Linearizable, sequential, causal and eventual consistency?
14. Session guarantees?
15. Read/write quorums and overlap assumptions?
16. What do CAP and PACELC constrain?
17. Logical/vector clocks and concurrent versions?
18. Conflict resolution and tombstone resurrection?
19. CRDT convergence laws and limitations?
20. Range/hash/directory partitioning?
21. Consistent/rendezvous hashing?
22. Online rebalancing and ownership epochs?
23. Hot key, hot partition and hot node?
24. Queue, pub-sub and durable log differences?
25. At-most-once, at-least-once and effectively-once?
26. Ordering and consumer-group ownership?
27. Idempotency, deduplication, outbox and inbox?
28. Backpressure, poison messages, DLQ and replay?
29. Event compatibility and semantic evolution?
30. Locks, leases and fencing tokens?
31. Leader election versus consensus?
32. Raft terms, votes, logs and commit?
33. Two-phase commit and its blocking behavior?
34. Saga orchestration, choreography and compensation?
35. Timeouts, retries, hedging and circuit breakers?
36. Bulkheads, rate limits and admission control?
37. Load shedding and graceful degradation?
38. Zone/region failover and stale-writer prevention?
39. Availability, SLO, RTO and RPO?
40. Deterministic simulation versus chaos engineering?
41. Little’s Law, saturation and failure headroom?
42. How does `disttriage` locate first divergence?
43. Which evidence proves a claimed guarantee?
44. Which guarantees remain outside the tested model?

Every answer references a client history, message trace, term/epoch/offset, invariant test, fault seed, capacity report or recovery result.

## Completion criteria

The intensive is complete when:

- clean reconstruction creates the complete local distributed system;
- system, timing, storage and failure assumptions are explicit;
- critical safety/liveness invariants are machine-checked where practical;
- RPC ambiguity, retries and stale responses preserve domain invariants;
- discovery churn and stateless scale preserve bounded behavior;
- replica lag, promotion and stale writers are observable and controlled;
- documented consistency modes pass client-history tests;
- quorum/partition behavior matches explicit assumptions;
- concurrent versions and tombstones converge without silent loss;
- CRDT experiment passes merge laws and documents invariant limits;
- online rebalancing survives interruption and stale routing;
- messaging crash/rebalance/replay cases preserve intended effects;
- event schemas remain compatible through retained replay;
- stale lease holders are rejected by protected resources;
- consensus model preserves committed-log safety;
- 2PC and saga failure boundaries are reconstructed correctly;
- resilience controls contain retry storms and noisy neighbors;
- graceful degradation preserves minimum service and recovery capacity;
- zone/region failover maintains one authoritative writer;
- measured SLO/RTO/RPO and capacity gaps are honest;
- deterministic fault histories are reproducible;
- `disttriage` is read-only, bounded and redacted;
- all 64 faults are reproducible or have documented equivalent substitutes;
- at least 26 blind incidents and two combined cases are solved;
- all 44 defense answers are evidence-based;
- cleanup finds no unintended qdisc, firewall rule, process, lease, topic, offset, route or volume;
- generalized knowledge is transferred to `knowledge`.

## Delayed assessment

After 7–14 days without rereading:

1. rebuild the laboratory from clean state;
2. answer the 44 defense questions;
3. diagnose five random faults including one messaging, one consensus/coordination and one combined case;
4. write one client-history consistency test from scratch;
5. reproduce one crash boundary around outbox/inbox or external effect;
6. run one lease expiration/fencing test;
7. replay one deterministic seed and explain the invariant;
8. perform one interrupted shard rebalance;
9. contain one retry/overload scenario through admission and shedding;
10. execute one zone/region failover and measure data loss/recovery;
11. use `disttriage` without mutating state;
12. explain which remaining work belongs to databases, infrastructure, delivery, observability or security.

После delayed assessment уровень 3–4 можно считать закреплённым.
