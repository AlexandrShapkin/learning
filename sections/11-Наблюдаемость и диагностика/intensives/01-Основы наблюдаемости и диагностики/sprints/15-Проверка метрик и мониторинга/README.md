# Спринт 15. Проверка метрик и мониторинга

Ориентировочный объём: 14–21 час.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 08–14.

## Исходная задача

Создать `work/metrics-monitoring-checkpoint/` — complete Prometheus-compatible monitoring route for API, worker, PostgreSQL, host and Kubernetes resources.

## Required capabilities

- typed application metrics and histograms;
- service discovery and relabeling;
- RED and asynchronous-work views;
- USE views for bounded resources;
- versioned recording rules and dashboards;
- cardinality/sample limits;
- missing-data and target-down detection;
- local retention plus remote/long-term simulation;
- telemetry-platform self-monitoring.

## Mandatory fault cases

1. Counter resets after process restart.
2. Scrape interval hides short saturation spike.
3. Unbounded route/user label creates cardinality explosion.
4. Histogram buckets make percentile useless.
5. Retry amplification looks like user demand.
6. One instance/route fails while aggregate remains healthy.
7. Missing target is rendered as zero.
8. Recording rule drops required labels.
9. Remote-write outage grows queue/WAL.
10. HA replicas double-count.
11. Disk/compaction/query pressure degrades Prometheus.
12. Dashboard variable or query overloads the metric store.

## Defense

1. Metric contracts and units?
2. Counters, gauges and histograms?
3. Scrape/relabel/query path?
4. RED, USE and async workload signals?
5. Utilization versus saturation?
6. Cardinality budget and enforcement?
7. Zero versus missing/stale/down?
8. Aggregation and weighting choices?
9. Recording-rule semantics/tests?
10. Storage/retention/remote-write behavior?
11. Dashboard visual integrity?
12. How is the monitoring system observed externally?

## Критерии прохождения

- metrics remain semantically correct through restarts and multi-instance aggregation;
- known load/error/latency/saturation faults appear in expected signals;
- cardinality and sample limits contain adversarial input;
- dashboards show target/telemetry failure explicitly;
- recording rules and alert precursors are tested;
- remote-write/store failure behavior is measured;
- all twelve faults are reproduced and diagnosed;
- queries and retention have documented cost/diagnostic purpose;
- at least 10 of 12 defense answers use PromQL/configuration/evidence.

## Результат для базы знаний

Checkpoint-specific note не требуется. Update metric notes where measured scrape, aggregation, staleness or storage behavior changed assumptions.