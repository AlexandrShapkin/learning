# Каталог неисправностей

Каждый fault должен иметь precondition, bounded effect, expected evidence, rollback and baseline verification. Fault injector работает только в explicit lab mode.

## Language, types and API

1. `typed-nil` — interface contains nil concrete pointer.
2. `slice-alias` — returned/internal backing array is mutated externally.
3. `map-order` — nondeterministic output breaks golden/protocol result.
4. `shadowed-error` — inner declaration suppresses failure.
5. `panic-worker` — worker panics during one job.
6. `invalid-state` — bypassed constructor creates forbidden transition.

## Build, modules and runtime startup

7. `dependency-api` — selected module version breaks consumer API/behavior.
8. `local-replace` — build relies on developer path.
9. `build-tag` — required implementation excluded.
10. `wrong-arch` — incompatible executable target.
11. `missing-shared-library` — cgo/loader dependency absent.
12. `stale-binary` — running version differs from source/config expectation.
13. `init-panic` — package initialization fails.
14. `reflection-type` — invalid reflective operation/type mismatch.

## I/O, serialization and storage

15. `truncated-frame` — input ends mid-header/payload.
16. `bad-checksum` — payload corruption.
17. `oversized-frame` — declared size exceeds limit.
18. `partial-write` — writer fails after N bytes.
19. `close-error` — final flush/close fails.
20. `compact-rename` — atomic replacement step fails.
21. `json-precision` — large integer decoded through float.
22. `unicode-invalid` — malformed UTF-8/policy violation.

## Process and resource lifecycle

23. `child-start` — executable missing/permission denied.
24. `child-deadlock` — stdout/stderr pipeline not drained.
25. `child-tree-leak` — grandchild survives timeout.
26. `fd-leak` — file/socket descriptor not closed.
27. `signal-ignore` — work/process ignores termination path.
28. `startup-partial` — resource acquired before later init failure.

## Concurrency and asynchronous execution

29. `data-race` — unsynchronized shared state.
30. `lost-update` — logical check-then-act race.
31. `mutex-deadlock` — lock-order inversion/reentrant callback.
32. `goroutine-leak` — producer/worker remains blocked.
33. `channel-close` — send on closed or close by wrong owner.
34. `queue-growth` — missing admission/backpressure bound.
35. `cancel-ignored` — task continues after client/shutdown cancellation.
36. `timer-leak` — ticker/timer lifecycle forgotten.
37. `order-buffer` — ordered results retain unbounded pending output.
38. `event-loop-block` — comparative Node/Python CPU task blocks I/O.

## Memory and performance

39. `heap-retain` — cache/object graph remains reachable.
40. `slice-retain` — tiny subslice holds large backing array.
41. `alloc-churn` — excessive temporary allocations increase GC CPU.
42. `gc-pressure` — memory limit/heap goal causes high collection overhead.
43. `pool-stale` — pooled buffer retains stale data or memory.
44. `stack-depth` — unbounded recursion/instruction limit.
45. `cpu-hotloop` — inefficient transform consumes CPU.
46. `lock-contention` — synchronized hot path raises latency.

## Network, configuration and service lifecycle

47. `http-body-leak` — response body not closed/drained.
48. `timeout-retry` — timed-out non-idempotent work duplicated.
49. `readiness-early` — service reports ready before journal/dependency works.
50. `shutdown-hang` — queue/child/network operation prevents bounded drain.

## Safety contract

Fault system must:

- require marker file and lab mode;
- reject production/non-loopback targets;
- enforce memory/time/process/fd/concurrency limits;
- isolate race/deadlock/panic in subprocess where required;
- print planned change before activation;
- record exact rollback state;
- support `status`, `rollback`, `rollback-all`;
- verify process/goroutine/fd/queue baseline after rollback;
- never expose fault or profile endpoints publicly;
- never delete user data outside temporary project directory.