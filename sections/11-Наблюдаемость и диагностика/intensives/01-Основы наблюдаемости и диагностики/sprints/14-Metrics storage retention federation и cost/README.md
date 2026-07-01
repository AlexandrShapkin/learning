# Спринт 14. Metrics storage, retention, federation и cost

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как хранить и агрегировать метрики на требуемых временных горизонтах, сохраняя query semantics, availability and cost controls?

## Результат спринта

После завершения необходимо уметь:

- понимать Prometheus TSDB blocks, WAL and retention at practical level;
- estimate storage from series, scrape interval and retention;
- choose local retention and long-term storage/remote write;
- understand remote-write queue, retry and backpressure;
- compare federation, remote read/write and centralized query layers;
- create downsampled/recorded long-term series;
- define HA/deduplication labels conceptually;
- monitor query latency and ingestion health;
- design retention tiers by question/value;
- handle disk full and compaction pressure;
- back up configuration/rules rather than assuming TSDB restore needs;
- control cost through cardinality, interval, recording and retention.

## Основной маршрут

1. Measure local TSDB growth under known series/scrape load.
2. Calculate 7/30/365-day storage alternatives.
3. Configure remote-write or faithful local receiver and interrupt it.
4. Compare raw long-term retention with recording/downsampling.
5. Fill local storage safely and recover.

## Ресурсы

- Prometheus storage, TSDB and remote-write docs.
- federation and long-term storage project docs.
- retention/capacity references.

## Лабораторная работа

Создать `work/metrics-storage/`.

### Requirements

- storage model uses measured bytes/series/sample, not vendor estimate only;
- local retention supports immediate diagnosis;
- long-term series are selected from explicit capacity/SLO questions;
- remote-write queue capacity, shards, retries and drop behavior are observed;
- remote outage cannot exhaust host storage/memory silently;
- HA replicas use stable external labels and dedup assumptions;
- query path distinguishes local/raw/recorded/downsampled data;
- disk, compaction and query saturation are monitored;
- retention deletion is intentional and documented;
- cost report separates cardinality, scrape frequency, retention and query effects;
- configuration/rules/dashboards are rebuildable.

### Failure scenarios

1. Remote-write outage grows queue/WAL until disk full.
2. Both HA replicas double-count series.
3. Federation pulls too much detail and reproduces cardinality centrally.
4. Downsampling destroys needed tail/route information.
5. Long retention is chosen for every raw series.
6. Query scans months of high-resolution data interactively.
7. Compaction/disk pressure makes ingestion unavailable.
8. TSDB data is backed up but rules/configuration are not.
9. Retention change deletes required evidence unexpectedly.

## Самопроверка

1. Main TSDB storage components?
2. Storage estimate inputs?
3. Remote write behavior?
4. Federation versus remote storage?
5. HA labels/deduplication?
6. Recording/downsampling trade-offs?
7. Local versus long-term retention?
8. Disk-full recovery?
9. Main cost levers?
10. What must be rebuildable?

## Результат для базы знаний

- **Prometheus TSDB retention and capacity**.
- **Prometheus remote write, queues and backpressure**.
- **Metrics federation and long-term storage**.
- **Metrics downsampling and recording strategies**.
- **Metric-system cost and capacity controls**.

## Когда переходить дальше

Можно переходить, когда the metric platform survives remote outage and bounded disk pressure, and retention/downsampling choices are tied to explicit diagnostic questions.