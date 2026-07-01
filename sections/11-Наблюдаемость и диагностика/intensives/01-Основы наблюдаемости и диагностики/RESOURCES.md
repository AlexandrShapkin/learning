# Ресурсы интенсива

Это общая библиография. Внутри каждого спринта указан обязательный minimum route. Не требуется читать всё последовательно.

## Foundations and troubleshooting

- *Distributed Systems Observability*, Cindy Sridharan.
- Google SRE books: monitoring, alerting, troubleshooting and postmortem chapters.
- Brendan Gregg’s systems-performance methodology and USE material.
- *Systems Performance*, Brendan Gregg, selected chapters.
- *Debugging*, David Agans, as a lightweight hypothesis discipline.
- vendor-neutral material on causal reasoning, timelines and evidence.

## Logs and events

- OpenTelemetry Logs data model and semantic conventions.
- structured logging documentation for Go and selected log stack.
- Loki or equivalent log-store documentation.
- Fluent Bit/Vector/OpenTelemetry Collector log pipeline docs.
- privacy, redaction and retention guidance for operational telemetry.

## Metrics and Prometheus

- Prometheus official documentation: data model, metric types, exposition, PromQL, recording/alerting rules and federation.
- OpenMetrics specification.
- Prometheus instrumentation best practices.
- Grafana dashboard and data-source documentation.
- node exporter, cAdvisor and kube-state-metrics docs.
- *Prometheus: Up & Running*, selected chapters checked against current docs.

## Tracing and OpenTelemetry

- OpenTelemetry specifications, semantic conventions and protocol documentation.
- OpenTelemetry Go SDK and Collector docs.
- W3C Trace Context and Baggage specifications.
- Tempo/Jaeger and TraceQL/store query documentation.
- sampling and tail-sampling processor documentation.
- messaging/database instrumentation references for selected libraries.

## Profiling and performance

- Go `pprof`, execution tracer and runtime metrics documentation.
- Linux `perf`, procfs, `strace`, `tcpdump`, sysstat and pressure-stall docs.
- Brendan Gregg’s flame graph and Linux performance material.
- bpftrace/BCC/bpftool docs for bounded diagnostic use.
- Pyroscope/Parca documentation for optional continuous profiling.
- k6/Vegeta/Go benchmark documentation.

## Health, synthetic and user monitoring

- Kubernetes probe documentation.
- Prometheus Blackbox Exporter documentation.
- browser performance APIs and OpenTelemetry browser instrumentation as optional RUM references.
- HTTP/DNS/TLS synthetic-check documentation.

## Alerting and signal quality

- Prometheus alerting-rule and Alertmanager documentation.
- Google SRE alerting and SLO burn-rate material.
- multi-window/multi-burn-rate alerting references.
- vendor-neutral alert grouping, deduplication, inhibition and routing material.

## Observability-platform operation

- OpenTelemetry Collector deployment and scaling docs.
- Prometheus TSDB/storage/remote-write docs.
- Loki/Tempo/Grafana storage, retention and multi-tenancy docs.
- telemetry-schema governance and OpenTelemetry semantic-convention docs.
- cost/cardinality/retention material from official project docs.

## Rules for sources

1. Official specifications define telemetry formats and propagation behavior.
2. Tool documentation defines version-specific query, storage and failure semantics.
3. Books provide methods and trade-offs, not universal dashboards or alert thresholds.
4. Every copied dashboard/query/rule is tested against the local data model.
5. A signal is accepted only with unit, dimensions, collection path and known limitations.
6. A profiling or eBPF recipe is run only with bounded scope and explicit overhead assumptions.
7. Public incident examples are sanitized and used only for diagnostic reasoning.
8. Vendor recommendations are compared with simpler and provider-neutral alternatives.
9. Do not copy proprietary dashboards, private logs or paid-course material.
