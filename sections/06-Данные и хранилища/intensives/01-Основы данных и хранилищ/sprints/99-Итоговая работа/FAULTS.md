# Каталог неисправностей

Каждый fault включается только в explicit lab mode, имеет bounded effect, expected evidence, disable/rollback procedure and post-check. Fault system never targets non-laboratory endpoints or data.

## Data model, schema and SQL

1. `business-duplicate` — surrogate key exists, but business uniqueness is missing.
2. `tenant-reference` — foreign key or query allows cross-tenant relation.
3. `null-semantics` — absent/null/zero or `NOT IN` behavior breaks result.
4. `join-multiplication` — one-to-many join inflates aggregate.
5. `unstable-order` — result/pagination depends on implicit order.
6. `stale-derived-total` — duplicated total/read model diverges from source.
7. `schema-payload-version` — new payload breaks old consumer.
8. `retention-model` — delete/archive rule removes or retains wrong history.

## Transactions, locks and MVCC

9. `lost-update` — read-modify-write overwrites concurrent change.
10. `write-skew` — cross-row invariant fails under insufficient isolation.
11. `retry-side-effect` — serialization/deadlock retry duplicates external effect.
12. `idle-transaction` — session retains locks/snapshot.
13. `blocking-chain` — broad update or lock order blocks workload.
14. `deadlock-order` — transactions lock resources in opposite order.
15. `skip-locked-starvation` — task remains continually skipped.
16. `long-snapshot-vacuum` — old snapshot delays cleanup and increases bloat.

## Physical storage, indexes and planner

17. `unsafe-durability` — lab durability setting weakens commit guarantee.
18. `wal-growth` — checkpoint/archive/slot behavior retains excessive WAL.
19. `wrong-index-order` — multicolumn index does not support query shape.
20. `index-expression-mismatch` — cast/function prevents expected index use.
21. `partial-index-predicate` — query does not imply partial-index condition.
22. `index-only-heap-fetch` — visibility prevents expected heap-free scan.
23. `stale-statistics` — estimates and plan degrade after load/change.
24. `correlated-estimate` — independent-column assumption misestimates rows.
25. `query-spill` — sort/hash exceeds memory and writes temp data.
26. `redundant-indexes` — write/storage cost grows without read benefit.

## Migrations and database clients

27. `migration-lock` — DDL waits/blocks active workload.
28. `backfill-partial` — interrupted batch skips/duplicates or leaves mixed state.
29. `invalid-index` — interrupted concurrent build leaves invalid index.
30. `mixed-version-write` — old application overwrites new representation.
31. `pool-starvation` — all connections busy/leaked and queue grows.
32. `rows-transaction-leak` — unclosed result or transaction holds connection.
33. `ambiguous-commit` — connection loss leaves outcome unknown.
34. `bulk-partial` — batch/COPY handling violates intended atomicity/idempotency.

## Cache, search, objects and streams

35. `cache-stale` — invalidation missing/reordered and stale value served.
36. `cache-stampede` — synchronized miss/expiry overloads database.
37. `cache-key-scope` — tenant/version omitted from key.
38. `search-stale-version` — older event overwrites newer search document.
39. `search-mapping-analyzer` — identifier/text mapping produces wrong matches.
40. `search-delete-residual` — source deletion remains searchable.
41. `object-metadata-orphan` — database and object state diverge.
42. `multipart-residue` — interrupted upload leaves parts/resources.
43. `event-redelivery` — duplicate delivery repeats business side effect.
44. `event-ordering` — ordering assumed outside partition/key scope.
45. `poison-message` — repeated failure creates unbounded retry/lag.
46. `replay-side-effect` — projection replay repeats irreversible action.

## Replication, scale, recovery and lifecycle

47. `replica-stale-read` — read-after-write routed to lagging standby.
48. `failover-split-brain` — old and promoted primary both accept writes.
49. `shard-routing-migration` — stale shard map or incomplete catch-up loses/diverges data.
50. `backup-chain-delete` — missing WAL/corrupt backup/restore plus deletion reconciliation exposes recovery failure.

## Combined scenario library

The assessment may combine faults, for example:

- pool starvation + slow query + broad lock;
- long transaction + vacuum pressure + disk growth;
- replication slot + WAL archive failure + disk exhaustion;
- migration backfill + replica lag + failover;
- cache stampede + connection budget exhaustion;
- outbox backlog + stale search and cache;
- shard migration + stale router + duplicate events;
- PITR restore + stream replay resurrecting deleted data;
- object versioning + deletion workflow + backup restore;
- stale statistics + wrong index + plan spill.

## Fault definition contract

Each implementation includes:

```text
name and category
preconditions
synthetic target and size limits
exact injected change
expected user-visible symptom
expected metrics/logs/queries
maximum duration/resource use
disable or rollback steps
baseline verification
regression that proves repair
```

## Safety contract

Fault tooling must:

- require laboratory marker, expected repository path and explicit `--lab` flag;
- reject unknown hosts, public addresses and production-like ports;
- print target, limit and planned action before activation;
- cap rows, bytes, clients, retries, workers, duration and disk usage;
- isolate crash/corruption/disk tests in disposable copies or constrained volumes;
- preserve primary synthetic dataset or verified backup before destructive cases;
- support `status`, `disable`, `rollback-all` and `cleanup`;
- never log secrets, access tokens or full sensitive values;
- verify sessions, locks, replication, temp files, objects and services after cleanup;
- retain only minimal sanitized failing evidence in Git.