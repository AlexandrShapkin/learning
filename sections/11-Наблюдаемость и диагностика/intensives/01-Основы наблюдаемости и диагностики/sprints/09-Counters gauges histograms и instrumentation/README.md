# Спринт 09. Counters, gauges, histograms и instrumentation

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Как выбрать metric instrument and label dimensions so that aggregation remains mathematically valid and diagnostic value exceeds cardinality and overhead?

## Результат спринта

После завершения необходимо уметь:

- выбирать counter, gauge, histogram and up-down counter appropriately;
- понимать histogram buckets, count and sum;
- отличать client-side summaries from aggregatable histograms;
- проектировать latency/size distributions;
- выбирать bucket boundaries from SLO and workload ranges;
- использовать labels only for bounded dimensions;
- distinguish resource and metric attributes;
- instrument errors by stable class, not message;
- measure in-progress operations and queue wait;
- avoid double counting across middleware and handlers;
- use exemplars where supported;
- measure instrumentation overhead.

## Основной маршрут

1. Add request/DB/external-call counters and histograms.
2. Choose buckets from expected latency objectives and generated distributions.
3. Compare histogram quantiles with raw sample truth.
4. Add bounded labels and deliberately trigger cardinality failure.
5. Attach trace exemplars to selected observations.

## Ресурсы

- Prometheus metric types and histogram guidance.
- OpenTelemetry metrics instruments/specification.
- instrumentation best practices.

## Лабораторная работа

Создать `work/metric-instrumentation/`.

### Requirements

- instruments match monotonicity/state/distribution semantics;
- latency and payload-size units are base-unit consistent;
- histogram buckets cover SLO boundary and useful tail range;
- error labels use controlled taxonomy;
- route labels use templates, not raw URLs;
- duplicate middleware/handler observations are prevented;
- queue wait and processing time are separate;
- summary/histogram trade-off is demonstrated;
- exemplars link a slow bucket to trace where supported;
- series count and application overhead are measured before/after;
- metric removal/rename has compatibility plan.

### Failure scenarios

1. Gauge is used for cumulative request total.
2. Histogram buckets place all values in one bucket.
3. Raw URL/query/user ID creates series explosion.
4. Error message becomes label.
5. Client summaries are averaged across instances.
6. Retry attempts and logical operations are double-counted ambiguously.
7. Queue wait is hidden inside handler latency.
8. Metric instrumentation materially increases allocations/latency.

## Самопроверка

1. Instrument types and semantics?
2. Histogram count/sum/buckets?
3. Histogram versus summary?
4. Bucket selection?
5. Bounded labels?
6. Route templates?
7. Error taxonomy?
8. Logical operation versus attempt?
9. Exemplars?
10. Instrumentation overhead?

## Результат для базы знаний

- **Metric instrument selection**.
- **Prometheus histograms, summaries and quantiles**.
- **Metric labels and bounded dimensions**.
- **Latency, queue and retry instrumentation**.
- **Metric exemplars and instrumentation overhead**.

## Когда переходить дальше

Можно переходить, когда distributions are aggregatable, labels remain bounded under adversarial input, and measured overhead stays within the declared budget.