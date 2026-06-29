# Каталог неисправностей

Все faults включаются только explicit lab mode, имеют bounded input and deterministic reproduction.

## Contracts, analysis and testing

1. `wrong-size-parameter` — complexity measured against irrelevant dimension.
2. `invalid-precondition` — algorithm runs outside valid domain.
3. `broken-invariant` — mutation/loop does not preserve required property.
4. `missing-termination` — range/recursion does not shrink.
5. `wrong-complexity` — hidden nested/library work contradicts claim.
6. `unfair-benchmark` — setup/copy differs between variants.
7. `optimized-away` — benchmark result unused.
8. `oracle-bug` — reference implementation violates contract.

## Linear structures and hashing

9. `vector-growth` — capacity arithmetic/overflow or lost elements.
10. `slice-alias` — caller mutates internal backing data.
11. `list-link` — lost/stale/cyclic link.
12. `ring-wrap` — head/tail/full calculation wrong.
13. `hash-contract` — equality/hash inconsistent.
14. `hash-delete` — tombstone/cluster broken.
15. `hash-resize` — entries lost during rehash.
16. `hash-adversarial` — collision pattern creates O(n) behavior.

## Searching, sorting and ordered structures

17. `binary-boundary` — off-by-one/infinite-loop/lower-bound error.
18. `nonmonotonic-predicate` — answer search assumption false.
19. `comparator-invalid` — non-transitive/overflow comparison.
20. `sort-stability` — equal-key order broken.
21. `quicksort-adversarial` — quadratic/deep recursion.
22. `counting-range` — key range makes memory explosive.
23. `tree-rotation` — parent/order metadata corrupted.
24. `tree-delete` — balance/occupancy violated.
25. `heap-index` — item index stale after swap/update.
26. `trie-delete` — shared prefix removed.

## Graphs and strings

27. `graph-direction` — directed/undirected assumption mixed.
28. `graph-visited` — vertex marked too late/early.
29. `topo-cycle` — topological order returned for cyclic graph.
30. `scc-order` — component pass/order incorrect.
31. `dijkstra-negative` — negative edge violates finalization.
32. `distance-overflow` — infinity/weight addition wraps.
33. `mst-disconnected` — tree promised for forest input.
34. `dsu-parent` — union/find creates stale size/loop.
35. `kmp-fallback` — prefix transition wrong.
36. `rolling-collision` — hash equality accepted without verification.

## Design paradigms

37. `recursion-depth` — degenerate split/stack exhaustion.
38. `greedy-counterexample` — local rule labeled optimal without property.
39. `dp-state` — state omits required information.
40. `dp-direction` — in-place update changes recurrence.
41. `dp-overflow` — impossible/sentinel arithmetic wraps.
42. `backtrack-restore` — mutable state not undone.
43. `unsafe-prune` — branch containing optimum removed.
44. `window-precondition` — monotonic window used with negative/invalid data.

## Scale, probability and parallelism

45. `bloom-version` — hash/parameters differ after serialization, causing false negatives.
46. `external-resource` — memory/fd/disk/temp cleanup failure.
47. `external-skew` — partition no longer fits memory.
48. `parallel-race` — shared state unsynchronized.
49. `parallel-reduction` — operation non-associative/order-sensitive.
50. `parallel-grain` — overhead/oversubscription defeats algorithm.

## Safety contract

Fault system must:

- require repository marker and lab mode;
- print seed, size, limits and exact enabled fault;
- enforce time/memory/node/file/worker limits;
- isolate panic/deadlock/exponential cases in subprocess with timeout;
- preserve original datasets;
- write temporary files only under project temp directory;
- support `status`, `disable`, `cleanup`;
- retain minimal failing input after fault and remove large generated data;
- never use external services or private data;
- verify baseline after fault is disabled.