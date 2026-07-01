# Реализация итоговой работы

## 1. Reference application and failure model

Create API, worker, PostgreSQL, object storage and provider simulator.

Required:

- synchronous and asynchronous user journeys;
- retry, timeout and fan-out paths;
- build, release, config and schema revision metadata;
- graceful shutdown and health endpoints;
- bounded fault switches for latency, errors, leaks, locks, queueing and telemetry loss;
- dependency and resource/failure-domain map;
- synthetic data only.

## 2. Common telemetry identity

All signals use canonical:

```text
service.name
service.namespace
service.instance.id
deployment.environment
service.version / release revision
configuration revision
schema revision
host/node/container/pod identity where applicable
trace/request/job and attempt context
```

Define ownership, allowed values, privacy classification and compatibility rules. Correlation context never becomes an unbounded metric dimension.

## 3. Logs

Implement:

- stable structured event names and typed schemas;
- severity policy and error-ownership rules;
- request/trace/job/attempt context;
- source and ingestion timestamps;
- redaction and payload-size limits;
- Collector/agent parsing, batching, retry and queue controls;
- Loki/equivalent retention and access policy;
- sequence/synthetic records for loss detection;
- saved diagnostic queries;
- schema-contract tests.

Exercise rotation, multiline, duplicate, delay, drop and store-outage cases.

## 4. Metrics and Prometheus

Instrument:

- request count, errors, duration and in-flight work;
- queue arrivals, completions, age, backlog and processing time;
- database/external-call latency/errors/pool wait;
- process/runtime and dependency signals;
- selected application correctness indicators.

Required:

- metric contracts with type/unit/labels/owner;
- useful histogram buckets and exemplars;
- service discovery/relabeling;
- tested recording rules;
- RED, USE and golden-signal queries;
- missing/stale/down detection;
- cardinality/sample limits;
- storage/retention and remote-write simulation;
- Prometheus external health check.

## 5. Dashboards

Create:

- user/service overview;
- asynchronous workload dashboard;
- dependency dashboard;
- host/runtime resource dashboard;
- release diagnostic dashboard;
- observability-platform dashboard.

Every dashboard states audience/questions, shows missing data, annotates releases/config/schema, preserves units/windows and links to traces/logs/profiles.

## 6. Distributed tracing

Instrument HTTP, database, provider and queue paths through OpenTelemetry.

Required:

- stable span names/kinds;
- W3C context propagation;
- producer/consumer spans and links;
- retry attempts/backoff;
- queue and connection-pool wait;
- error/status/event recording;
- semantic conventions and custom-attribute namespace;
- head and tail sampling experiments;
- baggage trust-boundary policy;
- critical-path and fan-out queries;
- context-loss tests.

## 7. OpenTelemetry Collector

Create versioned pipelines for logs, metrics and traces.

Required:

- OTLP receivers;
- memory limiting, batching and queues;
- filtering/transformation with schema tests;
- multiple exporters where useful;
- retry/drop/reject visibility;
- bounded shutdown and flush;
- internal telemetry plus external canary telemetry;
- overload and exporter-outage experiments;
- TLS/credentials excluded from Git.

## 8. Cross-signal correlation

Implement:

- trace/span IDs in structured logs;
- metric exemplars to traces;
- canonical release/config/schema identity;
- dashboard links preserving service/environment/time;
- trace-to-log queries;
- profile comparison by release/load/time;
- explicit handling of sampled/missing signals;
- retention-overlap validation.

## 9. Profiling

Provide bounded commands and reports for:

- CPU profile and flame graph;
- heap and allocations;
- goroutines;
- mutex and block profiles;
- execution trace;
- optional continuous profiles.

Each profile records workload, release, duration, overhead, conclusion and service-level verification. Raw profiles remain uncommitted.

## 10. Linux and infrastructure diagnostics

Use question-driven:

- `ps`, `pidstat`, `vmstat`, `iostat`, `sar`, PSI;
- `ss`, `lsof`, procfs and cgroups;
- `strace` and `perf`;
- `tcpdump` with exact filters;
- optional bpftrace/BCC tools;
- Kubernetes events/status and container/node mapping.

Map service instance → Pod/container → host PID/cgroup/node. Every capture/tracer has time/output/target bounds.

## 11. Load and performance experiments

Create:

- Go micro/component benchmarks;
- closed-concurrency and open-arrival HTTP tests;
- step/ramp saturation test;
- bounded soak test;
- coordinated-omission demonstration/prevention;
- generator-capacity verification;
- baseline/candidate profile comparison.

Collect throughput, errors, latency distribution, queueing and resource saturation together.

## 12. Health and external observation

Implement:

- startup, readiness and liveness with distinct semantics;
- black-box HTTP, DNS and TLS probes;
- multi-step synthetic user transaction with cleanup;
- one external/host-side canary independent of the cluster telemetry stack;
- optional browser/RUM timing with privacy controls;
- checker-health and credential-expiry signals.

## 13. Alerts

Create and test:

- user-impact symptom page;
- resource exhaustion page;
- telemetry-pipeline failure alert;
- actionable ticket alert;
- fast and slow SLO burn alerts;
- target/missing-data alert.

Alertmanager configuration includes grouping, routing, deduplication, inhibition, scoped silences, receiver checks and runbook/dashboard links.

## 14. Observability-platform operation

Define platform data flow, capacity and service objectives.

Required:

- ingestion accepted/dropped/retried/rejected signals;
- per-service/tenant cardinality and byte budgets;
- priority shedding under overload;
- retention and sensitive-data classes;
- role-based query access;
- query/ingestion resource isolation where possible;
- cost model for ingest, storage, indexing/query and egress;
- upgrade/schema compatibility procedure;
- store/Collector/Prometheus failure and recovery exercises.

## 15. `obstriage`

Read-only commands:

```text
obstriage path
obstriage request
obstriage timeline
obstriage logs
obstriage metrics
obstriage trace
obstriage profile
obstriage process
obstriage pod
obstriage network
obstriage storage
obstriage telemetry
obstriage alerts
obstriage identity
```

The tool accepts exact time/service/instance/trace scopes, redacts sensitive fields, limits output and never changes runtime, dashboards, rules or silences.

## 16. Diagnostic exercises

For every fault:

```text
exact symptom and expected behavior
scope and onset
preserved release/config/schema/telemetry evidence
dependency and technical timeline
competing hypotheses and predicted observations
first divergence
minimal repair
user/data/telemetry verification
new instrumentation, query, alert or runbook improvement
```

Solve single-layer and combined faults, including cases where the observability platform itself is partially unavailable.

## 17. Verification commands

```text
make check
make up
make instrument-test
make test-logs
make test-metrics
make test-traces
make test-correlation
make test-dashboards
make test-alerts
make test-synthetic
make profile-cpu
make profile-runtime
make load-saturation
make load-soak
make telemetry-overload
make fault-smoke
make triage-smoke
make verify
make down
make cleanup-check
```

## 18. Implementation stages

### Stage 1. Signals and logs

Reference system, identity model, structured events, collection, retention and queries.

### Stage 2. Metrics

Prometheus, metric contracts, RED/USE, dashboards, cardinality and storage.

### Stage 3. Tracing

OpenTelemetry SDK/Collector, sampling, critical paths and correlation.

### Stage 4. Performance

Profiles, Linux/eBPF tools, load and saturation experiments.

### Stage 5. External monitoring and alerts

Health checks, synthetic journeys, actionable routing and SLO burns.

### Stage 6. Platform operation

Telemetry quality, overload, privacy, retention, capacity, cost and upgrades.

### Stage 7. Diagnostics

`obstriage`, cross-layer identity and fault catalogue.

### Stage 8. Assessment

Blind diagnosis, clean reconstruction, telemetry-platform failure and delayed assessment.
