# Лабораторное окружение

## Базовая система

Recommended workstation or VM:

```text
observability-diagnostics-lab
├── 8–12 CPU threads
├── 24–32 GiB RAM
├── 180+ GiB SSD
├── current supported Linux distribution
└── isolated local network and synthetic data
```

A reduced topology can run with 16 GiB RAM by disabling long retention, continuous profiling and redundant collectors. Record all reductions because they affect saturation and failure experiments.

## Required tools

- Git, Bash, Make, curl, jq and yq;
- Go toolchain;
- Docker or Podman and Compose;
- `kubectl` plus kind/k3d/k3s;
- Helm and Kustomize;
- PostgreSQL client/server or container;
- OpenTelemetry Collector or container image;
- Prometheus and Alertmanager or container images;
- Grafana;
- Loki and Tempo/Jaeger or equivalent stores;
- `pprof`, `perf`, `strace`, `lsof`, `ss`, `tcpdump`;
- `vmstat`, `iostat`, `pidstat`, `sar` where available;
- k6 or Vegeta;
- checksums, OpenSSL and standard text utilities.

Recommended:

- `promtool`, `amtool`, `logcli`, `traceql`/store-specific CLI;
- Prometheus Blackbox Exporter;
- Pyroscope or Parca;
- bpftrace, BCC tools and bpftool;
- node exporter, cAdvisor and kube-state-metrics;
- OpenTelemetry auto-instrumentation where supported;
- MinIO for object-store and telemetry-retention exercises;
- `tc`, `nsenter`, `dig`, `traceroute`, `fio` and `stress-ng`;
- pprof visualization dependencies.

## Default topology

```text
client/load generator
        |
        v
Go API ───── PostgreSQL
  |
  ├──── object storage
  |
  └──── background worker / queue

telemetry
├── OpenTelemetry Collector
├── Prometheus + Alertmanager
├── Loki
├── Tempo/Jaeger
├── Grafana
├── optional Pyroscope/Parca
└── synthetic probes
```

For Kubernetes sprints, deploy application and telemetry stack into separate namespaces. Do not rely on the observability namespace to diagnose its own complete failure; keep one host-side or external check.

## Reference application

The synthetic system should expose:

- synchronous HTTP request path;
- fan-out to two dependencies;
- asynchronous job path;
- PostgreSQL transactions and slow queries;
- object storage reads/writes;
- one external-provider simulator;
- configurable retries, timeouts and feature flags;
- build, release, config and schema revision metadata;
- fault switches for latency, errors, leaks, lock contention and dropped telemetry.

## Workspace

```text
sprints/<NN-topic>/work/
├── app/
├── instrumentation/
├── collector/
├── prometheus/
├── alertmanager/
├── grafana/
├── logs/
├── traces/
├── profiles/
├── load/
├── faults/
├── queries/
├── reports/
└── README.md
```

Create only directories actually used.

## Telemetry safety

- use synthetic users, request payloads and identifiers;
- never log secrets, tokens, passwords, authorization headers or raw personal data;
- cap label values, log field sizes, span attributes and event payloads;
- configure explicit retention and storage limits;
- bound profiling and packet-capture duration;
- run eBPF tools only on the laboratory host/namespaces;
- do not expose Grafana, collectors or debug endpoints publicly;
- use read-only credentials for query/triage tools;
- keep raw packet captures, profiles and dumps out of Git;
- redact incident evidence before committing summaries.

## Reproducibility evidence

Record:

- host OS/kernel/architecture;
- application, collector, Prometheus, Grafana and storage versions;
- configuration revisions and container digests;
- instrumentation library versions;
- clock/time-zone settings;
- telemetry schema and semantic-convention versions where relevant;
- load/fault parameters;
- sample/retention/cardinality limits;
- query and dashboard revisions;
- alert rule and routing revisions;
- expected and observed telemetry loss;
- cleanup result.

## Fault limits

- load tests cap virtual users, requests and duration;
- memory/CPU/disk stress stays below host safety thresholds;
- network faults apply only to isolated namespaces/containers;
- packet captures use filters and short durations;
- profiler sessions have explicit start/stop and output limits;
- log/cardinality storms have hard row/series/byte caps;
- alert storms route only to local synthetic receivers;
- collector/storage failures are reversible and preserve at least one external signal;
- cleanup verifies processes, containers, namespaces, volumes, captures and temporary rules.

## Commit policy

Commit:

- application instrumentation code;
- collector and storage configuration;
- Prometheus/Alertmanager rules;
- dashboards as code;
- bounded queries and diagnostic scripts;
- load/fault definitions;
- small synthetic fixtures;
- concise profile/trace/log/metric findings;
- sanitized incident timelines;
- commands to regenerate large artifacts.

Do not commit:

- raw production-like logs, traces or metrics exports;
- profiles, heap dumps or packet captures;
- telemetry databases or object-store data;
- credentials, tokens, cookies or private keys;
- large generated dashboards/screenshots;
- real user/customer data;
- unbounded stress or destructive scripts.
