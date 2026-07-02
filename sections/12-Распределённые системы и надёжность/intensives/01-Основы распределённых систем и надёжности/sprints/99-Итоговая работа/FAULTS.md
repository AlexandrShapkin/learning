# Каталог неисправностей

Every fault is opt-in, bounded, reversible and limited to labeled synthetic resources. Each definition includes invariant, expected evidence, maximum scope and cleanup.

## RPC, discovery and scaling

1. `lost-request` — request never reaches server.
2. `lost-response-after-effect` — effect commits but response disappears.
3. `paused-not-crashed` — process stops progressing without exit.
4. `clock-skew-order` — wall time misorders events.
5. `nested-retry-storm` — multiple layers multiply attempts.
6. `late-response-overwrite` — abandoned request returns after newer operation.
7. `stale-discovery-endpoint` — client keeps removed instance.
8. `connection-load-skew` — keep-alive pins load unevenly.
9. `health-operation-split` — health path works while real path fails.
10. `unbounded-request-queue` — overload grows latency/memory without limit.

## Replication and consistency

11. `replica-lag-stale-read` — follower misses recent write.
12. `old-leader-resume` — promoted system sees stale leader write.
13. `minority-conflicting-write` — isolated side accepts incompatible update.
14. `premature-ack` — operation acknowledged before required durability/quorum.
15. `sloppy-quorum-nonoverlap` — assumed quorum intersection is absent.
16. `read-repair-conflict-loss` — repair overwrites concurrent value.
17. `wall-clock-lww-loss` — skewed timestamp selects wrong update.
18. `tombstone-resurrection` — deleted value returns from stale replica.
19. `nonmonotonic-session-read` — repeated reads move backward.
20. `replica-snapshot-log-mismatch` — restored replica diverges.

## Partitioning and rebalancing

21. `hot-range-key` — monotonic/range key overloads one shard.
22. `low-cardinality-partition-key` — uneven ownership/load.
23. `stale-partition-map` — request reaches old owner.
24. `dual-writer-rebalance` — source and destination accept writes.
25. `snapshot-misses-live-writes` — migration loses concurrent updates.
26. `rebalance-resource-saturation` — transfer overloads network/disk.
27. `interrupted-migration-duplication` — restart repeats/corrupts copy.
28. `cross-shard-invariant` — operation updates only part of distributed invariant.

## Messaging and event processing

29. `outbox-publish-gap` — business state commits but event is not published.
30. `relay-duplicate-publish` — relay crashes after publish before marking sent.
31. `consumer-effect-before-ack` — crash duplicates side effect.
32. `consumer-ack-before-effect` — crash loses work.
33. `stale-consumer-after-rebalance` — revoked owner commits later.
34. `dedup-expiry-late-replay` — delayed duplicate arrives after record expiry.
35. `poison-partition-block` — permanent failure stops ordered partition.
36. `retry-topic-order-change` — retry path violates assumed order.
37. `dlq-context-loss` — original metadata/reason is missing.
38. `replay-external-effect` — historical replay repeats irreversible action.
39. `event-schema-required-field` — old consumer cannot process new event.
40. `event-semantic-reuse` — field keeps name but changes meaning.

## Coordination and transactions

41. `expired-lease-holder-resume` — paused holder writes after TTL.
42. `missing-fencing-check` — protected resource accepts stale token.
43. `lost-term-vote-state` — consensus node restarts unsafely.
44. `premature-consensus-commit` — uncommitted entry is exposed as committed.
45. `nondeterministic-state-machine` — replicas apply same log differently.
46. `snapshot-index-term-mismatch` — consensus restore corrupts history.
47. `2pc-vote-before-durable-prepare` — participant cannot honor vote after crash.
48. `2pc-coordinator-decision-loss` — participants disagree or block indefinitely.
49. `2pc-prepared-timeout-guess` — participant guesses outcome unsafely.
50. `saga-lost-success` — step effect succeeds but workflow sees timeout.
51. `saga-duplicate-compensation` — compensation executes twice.
52. `saga-late-callback` — old success arrives after compensation.

## Resilience and overload

53. `hedge-on-saturated-dependency` — hedging doubles overload.
54. `circuit-half-open-herd` — all clients probe recovery together.
55. `breaker-scope-too-wide` — one bad endpoint opens all traffic.
56. `per-instance-limit-multiplication` — scale-out exceeds global capacity.
57. `noisy-tenant-pool-exhaustion` — one tenant consumes shared resources.
58. `fallback-recursion` — fallback reaches same failed dependency.
59. `recovery-admission-storm` — full traffic returns before backlog clears.
60. `zone-capacity-shortfall` — surviving topology cannot meet minimum service.

## Failover, recovery and testing

61. `region-dual-writer` — old and promoted regions both accept writes.
62. `async-replication-rpo-gap` — promotion loses unmeasured recent state.
63. `failback-overwrite` — old region overwrites newer primary state.
64. `nonreproducible-chaos-history` — fault reveals issue but seed/timeline is lost.

## Combined scenario library

- lost response + nested retry + duplicate external effect;
- stale discovery + paused old leader + late response;
- minority write + sloppy quorum + read repair conflict;
- lagging replica + tombstone expiry + anti-entropy resurrection;
- stale partition map + interrupted rebalance + hot key;
- outbox duplicate + consumer rebalance + dedup expiry;
- poison message + retry storm + dependency saturation;
- expired lease + missing fencing + delayed old writer;
- consensus leader partition + premature commit + snapshot mismatch;
- 2PC prepared block + coordinator loss + resource exhaustion;
- saga late success + duplicate compensation + manual intervention;
- hedging + breaker herd + per-instance limit multiplication;
- zone loss + retry amplification + insufficient DB/broker capacity;
- region failover + DNS split + asynchronous replication lag;
- observability loss + backlog growth + misleading health checks;
- deterministic model passes but real disk persistence assumption fails.

## Fault definition contract

Each implementation includes:

```text
name and affected invariant
preconditions, topology and exact target
injected message/process/network/storage behavior
expected user and protocol symptom
expected IDs, terms, epochs, versions, offsets and histories
maximum duration, traffic, messages, bytes and resources
disable/rollback/recovery procedure
cleanup and baseline verification
new guard, invariant test, admission rule or redesign
```

## Safety contract

Fault tooling must:

- require repository marker and explicit `--lab`;
- validate exact cluster, namespace, proxy, process, stream and volume;
- reject public/unknown targets;
- print topology, scope and expiry before activation;
- cap traffic, messages, partitions, disk, memory and duration;
- preserve one control/management path;
- never change the host clock;
- use dedicated synthetic topics, databases and providers;
- scope `tc`, firewall and process controls precisely;
- support `status`, `disable`, `rollback-all` and `cleanup`;
- verify qdiscs, firewall rules, processes, leases, topics, offsets, volumes and routes after cleanup.
