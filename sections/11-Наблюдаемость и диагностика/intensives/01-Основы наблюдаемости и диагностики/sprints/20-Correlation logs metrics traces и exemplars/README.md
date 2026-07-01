# Спринт 20. Correlation logs, metrics, traces и exemplars

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Как переходить от aggregate symptom к representative request and detailed event/profile evidence without pretending that all signals have identical sampling and retention?

## Результат спринта

После завершения необходимо уметь:

- link logs to trace/span identifiers;
- attach exemplars from metric observations to traces;
- correlate service/release/config/schema/resource identity;
- preserve time range and labels in dashboard links;
- distinguish exact correlation from contextual comparison;
- correlate profiles with release/load/time windows;
- handle sampled traces and unsampled logs/metrics;
- avoid high-cardinality metric labels for correlation;
- design drill-down from SLO/golden signal to detailed evidence;
- validate cross-store time and retention overlap;
- detect broken correlation context;
- document confidence and gaps.

## Основной маршрут

1. Add trace/span IDs to structured logs.
2. Add histogram exemplars linked to sampled traces.
3. Build dashboard links metric → trace → logs.
4. Link release annotation to profile comparison.
5. Delete/delay one signal and observe degraded correlation.

## Ресурсы

- OpenTelemetry logs/traces correlation model.
- Prometheus exemplar docs.
- Grafana data-link/correlation docs.

## Лабораторная работа

Создать `work/telemetry-correlation/`.

### Requirements

- service/resource/release attributes use the same canonical values across signals;
- logs contain trace/span IDs only when context exists;
- latency/error histogram includes usable exemplars;
- dashboard drill-down preserves route, service, environment and time window;
- trace links to corresponding structured events;
- profile comparison is bounded by same release/load/time context;
- sampled-trace absence is not represented as absence of request;
- metric labels remain low-cardinality;
- retention overlap supports required investigation window;
- broken propagation/schema mismatch is detected automatically or by test;
- correlation report states exact links versus probabilistic/contextual evidence.

### Failure scenarios

1. Request ID is added as metric label.
2. Trace ID in log belongs to wrong/reused operation context.
3. Exemplar points to expired/unsampled trace.
4. Dashboard link drops environment/time range.
5. Services use different release/service names.
6. Logs and traces retain different windows unexpectedly.
7. Profile from different load/release is compared.
8. No trace match is interpreted as no request.
9. Clock/time-zone mismatch shifts cross-store search.

## Самопроверка

1. Exact versus contextual correlation?
2. Log-trace correlation?
3. Metric exemplars?
4. Why not correlation IDs as metric labels?
5. Canonical resource/release identity?
6. Link context preservation?
7. Sampling effects?
8. Retention overlap?
9. Profile correlation requirements?
10. How test correlation integrity?

## Результат для базы знаний

- **Correlation of logs, metrics, traces and profiles**.
- **Prometheus exemplars and trace drill-down**.
- **Canonical telemetry resource and release identity**.
- **Cross-store time, sampling and retention limitations**.
- **Exact and contextual diagnostic correlation**.

## Когда переходить дальше

Можно переходить, когда a metric anomaly leads to a representative trace and its events/profile context without adding high-cardinality metric labels or overstating certainty.