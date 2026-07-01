# Каталог неисправностей

Every fault is opt-in, bounded, reversible and limited to labeled synthetic resources. Each definition records expected symptom, telemetry evidence, maximum scope and cleanup.

## Signals, time and logs

1. `clock-skew-order` — host timestamps make event order appear reversed.
2. `ingestion-delay` — log arrival time differs materially from event time.
3. `correlation-loss` — request/job context disappears at one boundary.
4. `retry-id-collapse` — attempts reuse an indistinguishable identifier.
5. `error-log-amplification` — one fault is logged by every layer.
6. `sensitive-log-field` — token/personal data reaches structured event.
7. `multiline-merge` — stack parser merges unrelated records.
8. `rotation-duplicate-loss` — log rotation/restart duplicates or skips events.
9. `collector-buffer-full` — store outage exhausts log queue.
10. `log-schema-break` — field type/name change breaks queries.

## Metrics and Prometheus

11. `counter-reset-query` — naive rate misinterprets process restart.
12. `scrape-hidden-spike` — short saturation is missed by interval.
13. `metric-unit-mismatch` — milliseconds are exposed/interpreted as seconds.
14. `label-cardinality-storm` — route/user/error value creates series explosion.
15. `histogram-bucket-blindness` — buckets cannot resolve target latency.
16. `retry-demand-amplification` — attempt rate looks like user demand.
17. `aggregate-hides-segment` — one route/instance fails under healthy aggregate.
18. `missing-as-zero` — target/store failure appears as zero traffic.
19. `recording-rule-label-loss` — aggregation removes diagnostic dimension.
20. `remote-write-backpressure` — queue/WAL grows during remote outage.

## Dashboards and metric storage

21. `dashboard-absent-green` — missing data renders as healthy panel.
22. `quantile-average` — per-instance quantiles are averaged incorrectly.
23. `dashboard-variable-storm` — high-cardinality variable overloads store.
24. `ha-double-count` — redundant Prometheus replicas are not deduplicated.
25. `tsdb-disk-pressure` — WAL/blocks/compaction exhaust local storage.
26. `query-ingestion-contention` — expensive query degrades ingestion.
27. `retention-evidence-loss` — required investigation data expires.
28. `downsample-detail-loss` — recording/downsampling removes needed segment/tail.
29. `relabel-drop-critical` — metric relabeling removes required signal silently.
30. `stale-series-confusion` — old series remains in interpretation after target loss.

## Tracing and OpenTelemetry

31. `http-context-break` — trace propagation stops at one service.
32. `queue-link-loss` — producer and consumer traces cannot be related.
33. `duplicate-auto-manual-span` — instrumentation creates misleading nested duplicates.
34. `retry-span-collapse` — retries appear as one long call.
35. `hidden-pool-wait` — connection-pool delay is absent from trace.
36. `partial-trace-sampling` — services make inconsistent sampling decisions.
37. `tail-sampler-overload` — decision buffer exhausts memory.
38. `baggage-leak` — sensitive or oversized context crosses services.
39. `semantic-attribute-drift` — services use incompatible attribute names/values.
40. `collector-export-reject` — backend rejects telemetry while process looks healthy.

## Profiling, system and load

41. `cpu-hot-loop` — algorithmic hotspot consumes CPU.
42. `allocation-churn` — high allocation rate drives GC without retained leak.
43. `heap-retention-leak` — live heap grows across steady workload.
44. `goroutine-leak` — blocked goroutines accumulate.
45. `mutex-contention` — lock wait dominates latency.
46. `disk-io-latency` — storage queue/wait causes request delay.
47. `network-retransmission` — packet loss/retransmit increases latency.
48. `single-core-saturation` — host CPU average hides one busy core.
49. `generator-bottleneck` — load generator limits observed throughput.
50. `coordinated-omission` — test underreports overloaded latency.

## Health, alerts and observability platform

51. `liveness-dependency-loop` — external dependency outage restarts all replicas.
52. `readiness-false-green` — real user path fails while readiness succeeds.
53. `synthetic-checker-down` — checker outage looks like target outage.
54. `nonactionable-page` — harmless resource threshold pages responders.
55. `alert-grouping-storm` — one incident creates hundreds of notifications.
56. `broad-silence` — maintenance silence suppresses unrelated impact.
57. `slo-missing-perfect` — absent SLI data appears as perfect reliability.
58. `telemetry-noisy-neighbor` — one producer exhausts shared ingestion/storage.
59. `observability-platform-outage` — signal loss is mistaken for service outage.
60. `cross-layer-first-divergence` — downstream alerts hide an upstream application/platform boundary failure.

## Combined scenario library

- clock skew + delayed ingestion + retry ID collapse;
- log collector outage + application error spike + missing-as-zero metric;
- cardinality storm + Prometheus disk pressure + dashboard timeout;
- retry amplification + DB pool wait + aggregate healthy latency;
- broken trace propagation + rare error removed by head sampling;
- tail-sampler overload + exporter rejection + missing exemplars;
- CPU hotspot + HPA scale-out + telemetry noisy neighbor;
- heap leak + long soak test + profile comparison mismatch;
- disk latency + mutex contention + queue backlog;
- network retransmission + misleading application span + SLO burn;
- liveness restart loop + collector outage + alert storm;
- broad silence + real independent outage + checker failure.

## Fault definition contract

Each fault implementation includes:

```text
name and layer
preconditions and exact target
injected behavior
expected user/system symptom
expected logs/metrics/traces/profiles/host evidence
maximum duration, traffic, series, bytes and resources
disable/rollback procedure
cleanup and baseline verification
new query, alert, instrumentation or runbook improvement
```

## Safety contract

Fault tooling must:

- require repository marker and explicit `--lab`;
- validate exact cluster, namespace, process, interface and store;
- reject unknown/public targets;
- print scope and limits before activation;
- cap requests, duration, memory, disk, series, logs and spans;
- use synthetic data and local alert receivers;
- preserve minimal evidence before destructive tests;
- never print secrets or raw sensitive payloads;
- scope eBPF/perf/strace/tcpdump to exact target and duration;
- support `status`, `disable`, `rollback-all` and `cleanup`;
- verify processes, containers, rules, silences, queues, volumes and captures after cleanup.
