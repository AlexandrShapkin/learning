# Спринт 08. Метрики и временные ряды

Ориентировочный объём: 16–23 часа.

## Центральный вопрос

Как представить изменение состояния системы во времени так, чтобы значения, интервалы, единицы и агрегации не искажали реальное поведение?

## Результат спринта

После завершения необходимо уметь:

- понимать sample, time series, label set and scrape interval;
- различать event count, rate, ratio and state;
- выбирать units and base units consistently;
- понимать reset, wrap and monotonic counters;
- различать instant and range queries;
- учитывать scrape jitter and missed samples;
- понимать aggregation across instances and time;
- различать average, percentile and distribution;
- определять source and observer timestamps;
- распознавать aliasing and short spikes hidden by resolution;
- создавать metric contract;
- не использовать metric name/label as free-form event stream.

## Основной маршрут

1. Instrument request count, latency, in-flight work and queue depth.
2. Compare raw counts, rates and ratios over different windows.
3. Change scrape interval and generate short spikes.
4. Restart process and handle counter reset.
5. Aggregate two instances with uneven traffic.

## Ресурсы

- Prometheus data model and query basics.
- OpenMetrics specification overview.
- time-series aggregation references.

## Лабораторная работа

Создать `work/metric-foundations/`.

### Requirements

- every metric has name, type, unit, labels, source and owner;
- counters are monotonic within process lifetime;
- rates handle resets correctly;
- ratios use compatible numerator/denominator windows;
- in-flight/queue state is measured as gauge with collection limitations;
- short spikes are compared under multiple scrape intervals;
- per-instance and service-wide aggregations are both available;
- missing samples are distinguishable from zero;
- metric contracts are tested through exposition output;
- timestamps are not manually attached without justified need.

### Failure scenarios

1. Counter value is graphed directly as current traffic.
2. Requests and errors use different windows/label scopes.
3. Milliseconds are named as seconds.
4. Restart creates negative naive rate.
5. Average across instances weights idle and busy instances equally.
6. One-second saturation is hidden by one-minute scrape.
7. Missing target appears as zero load.
8. User/order ID becomes metric label.

## Самопроверка

1. Sample, series and labels?
2. Counter versus gauge?
3. Count versus rate?
4. Ratio requirements?
5. Counter reset handling?
6. Scrape interval effects?
7. Missing versus zero?
8. Instance versus service aggregation?
9. Unit conventions?
10. Why not store events as metrics?

## Результат для базы знаний

- **Metrics and time-series data model**.
- **Counts, rates, ratios and state metrics**.
- **Metric units, resets and scrape intervals**.
- **Time-series aggregation and missing samples**.
- **Metric contracts and ownership**.

## Когда переходить дальше

Можно переходить, когда request/error/load behavior remains correctly interpretable across restarts, missed samples, different scrape intervals and multi-instance aggregation.