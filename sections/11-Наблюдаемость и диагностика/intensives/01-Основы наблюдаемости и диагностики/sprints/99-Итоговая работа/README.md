# Спринт 99. Итоговая работа

Ориентировочный объём: 65–95 часов.

## Задача

Создать `observability-diagnostics-lab` — fully instrumented synthetic distributed system and observability platform proving that user symptoms can be traced through logs, metrics, traces, profiles, synthetic checks and host evidence to the first failing boundary.

Проект не является production monitoring platform. Его задача — показать controlled telemetry design, bounded cost, alert quality and evidence-based cross-layer diagnosis through reproducible faults.

## Reference system

Synthetic work-management service:

- Go HTTP API;
- background worker and queue/table-backed jobs;
- PostgreSQL;
- object storage;
- external-provider simulator;
- ingress/network path;
- configurable retries, timeouts and feature flags;
- release/config/schema metadata;
- injectable latency, errors, leaks, lock contention, saturation and telemetry loss.

## Observability platform

```text
clients and load generator
          |
          v
API → PostgreSQL / object storage / provider
 |
 └→ worker and asynchronous jobs

telemetry path
├── OpenTelemetry SDK
├── OpenTelemetry Collector
├── Prometheus + Alertmanager
├── Loki
├── Tempo/Jaeger
├── Grafana
├── optional Pyroscope/Parca
├── synthetic/black-box probes
└── host Linux and eBPF tools
```

## Repository structure

```text
work/observability-diagnostics-lab/
├── app/
├── instrumentation/
├── collector/
├── prometheus/
├── alertmanager/
├── grafana/
├── logs/
├── traces/
├── profiles/
├── synthetic/
├── load/
├── faults/
├── queries/
├── reports/
├── scripts/
├── Makefile
└── README.md
```

## Документы итоговой работы

- [`IMPLEMENTATION.md`](IMPLEMENTATION.md) — mandatory capabilities, stages and evidence.
- [`FAULTS.md`](FAULTS.md) — catalogue of 60 bounded observability and diagnostic faults.
- [`ASSESSMENT.md`](ASSESSMENT.md) — blind incidents, clean reconstruction and final defense.

## Mandatory capabilities

1. User-journey, dependency and telemetry-strategy map.
2. Stable service/resource/release/config/schema identity across signals.
3. Structured log schemas, collection, retention and privacy controls.
4. Prometheus metrics with tested recording rules and dashboards.
5. RED, USE and asynchronous-work monitoring.
6. Cardinality, sample, retention and query limits.
7. OpenTelemetry traces across HTTP, database, queues and retries.
8. Head/tail sampling and semantic-convention policy.
9. Log/metric/trace correlation and exemplars.
10. CPU, heap, allocation, goroutine, mutex and block profiling.
11. Linux CPU/memory/disk/network and bounded eBPF diagnostics.
12. Reproducible load, saturation and soak tests.
13. Startup/readiness/liveness and external synthetic checks.
14. Actionable alert rules, grouping, routing, inhibition and silences.
15. SLO multi-window burn-rate alerts.
16. Observability-platform self-monitoring, quality, privacy and cost controls.
17. Read-only `obstriage` tool.
18. Controlled fault catalogue and cross-layer diagnostic exercises.

## Mandatory scenarios

1. Trace a normal user request and asynchronous job through all components.
2. Compare healthy and faulty technical timelines under clock skew.
3. Lose/delay/duplicate logs and detect collection failure.
4. Trigger metric cardinality growth and contain it.
5. Stop a scrape target and distinguish zero from missing.
6. Interrupt remote write and Collector exporters without harming application.
7. Break trace propagation and restore cross-service context.
8. Preserve rare/error/slow traces under sampling budget.
9. Diagnose fan-out/retry/queue latency from critical path.
10. Find CPU hotspot and verify optimization.
11. Find heap/goroutine/lock problem under sustained load.
12. Localize network retransmission or disk I/O delay with host evidence.
13. Determine saturation point without generator/coordinated-omission artifacts.
14. Detect a real failure externally while internal health check misleads.
15. Create dependency outage producing one actionable grouped notification.
16. Replay fast and slow SLO burn.
17. Overload observability platform and preserve priority signals.
18. Diagnose at least eight combined application/platform/telemetry faults.

## Main results

The completed laboratory includes:

- telemetry schema and ownership inventory;
- log event contracts and query library;
- metric contracts, rules and dashboards;
- trace instrumentation and sampling policy;
- profile and performance experiment reports;
- synthetic checks and alert routing tests;
- telemetry platform capacity/privacy/cost report;
- canonical cross-layer identity map;
- read-only diagnostic tool;
- 60 reproducible fault definitions;
- sanitized technical timelines and findings.

## Execution order

1. Build reference system and failure/dependency map.
2. Add common resource/release/correlation context.
3. Implement logs and centralized pipeline.
4. Implement metrics, dashboards and storage controls.
5. Implement tracing, sampling and cross-signal correlation.
6. Add profiling, host tools and load experiments.
7. Add health/synthetic observation and alerts.
8. Harden telemetry platform under overload and schema change.
9. Implement `obstriage` and cross-layer fault cases.
10. Run blind assessment and clean reconstruction.

## Artifacts to commit

- instrumentation source code;
- collector/store configuration;
- metric/log/trace schema definitions;
- Prometheus and Alertmanager rules/tests;
- dashboards as code;
- bounded queries and `obstriage` source;
- load/fault scripts with safety limits;
- concise performance/diagnostic reports;
- sanitized timelines and evidence references;
- commands to regenerate profiles/captures/exports;
- links to generalized `knowledge` notes.

Do not commit:

- raw large logs, traces, metrics exports or profiles;
- heap/core dumps or packet captures;
- telemetry stores/volumes;
- credentials, tokens, cookies or private keys;
- real user/customer data;
- unredacted diagnostic bundles;
- unbounded stress or system-wide eBPF scripts.

## Safety

- every workload, collector and fault is labeled with repository and expiry;
- load, cardinality and log storms have hard request/series/byte limits;
- profiling and eBPF sessions have target and duration bounds;
- packet captures use exact namespace/interface/filter and cleanup;
- synthetic checks use isolated data and credentials;
- alerts route only to local synthetic receivers;
- observability failures preserve at least one external signal;
- cleanup verifies processes, containers, rules, silences, data volumes and temporary captures.

## Результат для базы знаний

Итоговая работа должна завершить или исправить заметки по telemetry design, logs, metrics, Prometheus, cardinality, dashboards, distributed tracing, OpenTelemetry, profiling, Linux diagnostics, load testing, health checks, alerting, observability-platform operation and hypothesis-driven troubleshooting.

Instrumentation, queries, dashboards, profiles and fault evidence remain in `learning`; generalized mechanisms move to `knowledge`.
