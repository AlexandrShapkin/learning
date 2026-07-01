# Спринт 10. Prometheus collection, PromQL и recording rules

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как Prometheus discovers, scrapes, stores and queries targets, and how to write queries/rules that preserve label meaning and detect target failure correctly?

## Результат спринта

После завершения необходимо уметь:

- configure service discovery and scrape jobs;
- understand target labels, relabeling and metric relabeling;
- use `up`, scrape duration and sample-limit signals;
- write selectors, aggregations, rates, increases and joins;
- handle counter resets and label matching;
- understand staleness and absent series;
- create recording rules for stable expensive expressions;
- test rules with `promtool` or equivalent;
- avoid many-to-many and accidental aggregation;
- manage rule evaluation intervals;
- inspect TSDB/query behavior at practical level;
- diagnose scrape, discovery and query failures.

## Основной маршрут

1. Scrape application, node and Kubernetes targets.
2. Relabel discovery metadata into controlled service/environment labels.
3. Write service-rate/error/latency/saturation queries.
4. Stop/relabel targets and observe `up`, staleness and `absent` behavior.
5. Convert repeated expressions into tested recording rules.

## Ресурсы

- Prometheus configuration, data model and PromQL docs.
- recording/alerting rule and `promtool` docs.
- service-discovery/relabeling references.

## Лабораторная работа

Создать `work/prometheus/`.

### Requirements

- scrape jobs have explicit interval, timeout, sample and label limits;
- target identity is stable and environment/service labels are controlled;
- relabeling drops unstable discovery metadata where unnecessary;
- queries preserve required labels and document aggregation scope;
- `rate`/`increase` windows are compatible with scrape interval;
- missing target is detected independently from zero application traffic;
- joins have explicit cardinality expectations;
- recording-rule names encode aggregation level and unit;
- rule tests cover reset, missing target and multi-instance cases;
- query cost and series touched are inspected;
- Prometheus itself is externally checked.

### Failure scenarios

1. Scrape timeout equals/exceeds interval and targets overlap.
2. Discovery metadata creates unstable labels.
3. `sum` removes route/environment needed for diagnosis.
4. `rate` window is too short for scrape interval.
5. Join creates many-to-many error or duplicates values.
6. Missing series is interpreted as zero.
7. Recording rule changes semantics without version/test.
8. Metric relabeling drops critical signal silently.
9. Prometheus is down and all dashboards show no data.

## Самопроверка

1. Discovery, scrape and exposition path?
2. Target versus metric relabeling?
3. `up` means what?
4. Staleness and absent series?
5. `rate` window selection?
6. Label matching and joins?
7. Recording rules purpose?
8. Rule naming and tests?
9. Query cost?
10. How observe Prometheus externally?

## Результат для базы знаний

- **Prometheus scrape and service discovery**.
- **Prometheus relabeling and target identity**.
- **PromQL rates, aggregation and vector matching**.
- **Prometheus staleness and absent-series detection**.
- **Prometheus recording rules and rule testing**.

## Когда переходить дальше

Можно переходить, когда target disappearance, resets and multi-instance aggregation produce expected tested results and repeated queries are captured in stable recording rules.