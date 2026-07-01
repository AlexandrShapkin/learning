# Итоговая проверка

## Blind diagnostic exercise

Solve at least 24 hidden incidents:

- four logs/time/context cases;
- four metrics/dashboard/storage cases;
- four tracing/Collector cases;
- four profiling/system/load cases;
- four health/alert/platform cases;
- four combined cross-layer cases.

For each incident:

```text
Exact user/system symptom and scope
Expected request/resource/telemetry path
Release, configuration, schema and identity context
Preserved logs, metrics, traces, profiles and host evidence
Technical timeline with event/ingestion time and uncertainty
Competing hypotheses and discriminating observation
First divergence, trigger and contributing factors
Minimal repair
User, data, resource and telemetry verification
Instrumentation/query/alert/runbook improvement
```

## Clean reconstruction

From clean checkout and empty laboratory state:

1. verify tools, host capacity and safety markers;
2. build and start the reference system;
3. provision Collector, Prometheus, Alertmanager, Grafana, log and trace stores;
4. validate canonical resource/release identity;
5. run structured-log contract and pipeline tests;
6. run metric/rule/cardinality/missing-data tests;
7. run trace propagation/sampling/correlation tests;
8. load dashboards and verify release annotations/drill-down;
9. run CPU/runtime/Linux profiling exercises;
10. execute bounded saturation and soak tests;
11. run health/synthetic and alert-routing tests;
12. overload one telemetry component and preserve priority signals;
13. execute `obstriage` smoke tests and fault catalogue;
14. destroy all services, volumes, captures, rules and silences safely.

## Complete diagnostic exercise

Perform one scenario:

1. a release introduces allocation churn and one rare correctness error;
2. retries amplify provider load and DB pool wait;
3. one service loses trace propagation;
4. a raw route label causes metric cardinality growth;
5. Prometheus remote write and Collector exporter slow down;
6. dashboard aggregate remains apparently healthy;
7. synthetic user journey starts failing;
8. SLO burn and resource alerts fire with downstream noise;
9. grouping/inhibition reduce notifications without hiding independent telemetry failure;
10. `obstriage` reconstructs timeline and identifies first divergence;
11. minimal repair restores user path and telemetry baseline;
12. instrumentation/rule/cardinality controls are improved and the scenario is replayed.

## Telemetry-platform failure exercise

1. log store becomes unavailable;
2. trace exporter rejects a subset of spans;
3. Prometheus local disk reaches bounded pressure;
4. application remains serving traffic;
5. external synthetic checks preserve service truth;
6. queues, retries, drops and priority shedding are measured;
7. observability-platform alert is routed separately from service impact;
8. stores recover without unbounded replay storm;
9. missing intervals and evidence confidence are documented;
10. capacity/retention/cost controls are adjusted and retested.

## Final defense

Answer using project evidence:

1. Observation, monitoring, observability and diagnosis?
2. Signal, symptom, error, fault and failure?
3. What makes a hypothesis falsifiable and discriminating?
4. Wall time, monotonic time, clock skew and causal order?
5. How are synchronous, asynchronous and retry contexts correlated?
6. What questions do logs, metrics, traces and profiles answer?
7. How are structured log schemas, severity and error ownership designed?
8. Where can logs be delayed, duplicated, truncated or lost?
9. How are log search, retention, privacy and cost controlled?
10. What are metric samples, series, labels, rates and ratios?
11. How are counters, gauges, histograms and exemplars selected?
12. How do Prometheus scrape, relabeling, staleness and recording rules work?
13. How are RED, USE and golden signals applied?
14. How do dashboards preserve visual and query integrity?
15. How are cardinality, missing data and aggregation bias handled?
16. How do metric retention, remote write and long-term storage behave?
17. What are traces, spans, links and propagation?
18. How do OpenTelemetry SDK and Collector pipelines work?
19. How are head/tail sampling, baggage and semantic conventions used?
20. How is a trace critical path found under fan-out, retries and queues?
21. How are logs, metrics, traces, exemplars and profiles correlated?
22. How are CPU hotspots found and optimizations verified?
23. How are allocation churn, heap leaks, goroutine leaks and lock waits distinguished?
24. How are Linux CPU, memory, disk and network problems localized?
25. When are perf, strace, tcpdump and eBPF appropriate?
26. How are load tests designed without generator or coordinated-omission artifacts?
27. Startup, readiness, liveness, synthetic and RUM differences?
28. What makes an alert actionable?
29. How do grouping, routing, inhibition, deduplication and silences work?
30. How are SLO burn-rate alerts implemented and tuned?
31. How is the observability platform itself monitored and protected?
32. How are telemetry schema, privacy, retention and cost governed?
33. How does systematic troubleshooting locate first divergence?
34. How does `obstriage` correlate cross-layer identities safely?
35. Which evidence proves observability reduced uncertainty rather than only adding data?

Every answer references a query, rule test, dashboard, trace, profile, host command, fault result or technical timeline.

## Completion criteria

The intensive is complete when:

- clean reconstruction creates the application and telemetry platform;
- canonical service/release/config/schema identity is consistent across signals;
- log contracts and pipeline loss/duplicate tests pass;
- metric contracts, recording rules and dashboards are tested;
- cardinality and missing-data failures are contained and visible;
- traces cover HTTP, database, provider, retries and asynchronous work;
- sampling preserves known rare/error/slow cases within budget;
- metric/log/trace/profile drill-down works with explicit limitations;
- CPU, heap, goroutine, lock, disk and network faults are diagnosed;
- load generator and measurement artifacts are ruled out;
- health/synthetic checks expose real user-path failures;
- alerts are actionable, grouped and replay-tested;
- SLO fast/slow burn behavior matches intended horizons;
- observability-platform overload preserves priority signals;
- privacy, retention, access and cost policies are enforced;
- `obstriage` is read-only, bounded and redacted;
- all 60 faults are reproducible or have a documented equivalent;
- at least 24 blind incidents and four combined cases are solved;
- all 35 defense answers are supported by evidence;
- cleanup finds no unintended process, volume, rule, silence, capture or credential;
- generalized knowledge is transferred to `knowledge`.

## Delayed assessment

After 7–14 days without rereading:

1. rebuild the telemetry platform from clean state;
2. answer the 35 defense questions;
3. diagnose four random faults including one combined and one telemetry-platform case;
4. write one structured-log schema and one tested PromQL rule from scratch;
5. instrument one new HTTP/queue path with trace propagation;
6. capture and interpret one CPU and one runtime profile;
7. design one bounded load test and identify saturation point;
8. create one actionable alert and routing test;
9. reconstruct a skewed/out-of-order technical timeline;
10. use `obstriage` to locate first divergence without mutating the system;
11. remove one low-value signal and justify cost/diagnostic trade-off;
12. explain which remaining problems belong to delivery operations, distributed reliability, security or domain-specific diagnostics.

После delayed assessment уровень 3–4 можно считать закреплённым.
