# Спринт 13. Cardinality, aggregation, staleness и missing data

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как сохранить diagnostic dimensions without making the metric system unstable, and how distinguish true zero, stale series, collection loss and aggregation artifacts?

## Результат спринта

После завершения необходимо уметь:

- estimate series cardinality before deployment;
- identify bounded and unbounded labels;
- understand cardinality multiplication;
- choose pre-aggregation and recording dimensions;
- separate service, instance and request detail;
- detect stale/disappeared targets;
- represent unknown/missing values explicitly;
- understand aggregation bias and Simpson-like effects;
- manage histogram bucket cardinality;
- use logs/traces for high-cardinality drill-down;
- define series/sample limits and drop policies;
- diagnose sudden cardinality growth.

## Основной маршрут

1. Calculate expected series count for application and infrastructure metrics.
2. Add an unbounded label and observe memory/query/storage impact.
3. Remove it and recover drill-down through exemplars/logs/traces.
4. Stop targets and compare zero, stale, absent and delayed data.
5. Reproduce misleading global aggregation across routes/instances.

## Ресурсы

- Prometheus cardinality and storage guidance.
- OpenTelemetry attribute guidance.
- aggregation and missing-data references.

## Лабораторная работа

Создать `work/cardinality-data-quality/`.

### Requirements

- series budget is calculated per metric family and environment;
- raw URL, user, request, error message and object IDs are prohibited labels;
- bucket/label combinations are included in estimate;
- collectors/scrapes enforce sample/label limits with visible drop metrics;
- service-level aggregations preserve required route/status dimensions;
- missing, stale, down and zero states have distinct queries/panels;
- one aggregation bias is reproduced and corrected through segmentation/weighting;
- high-cardinality investigation links to traces/logs;
- cardinality growth alert identifies responsible metric/label;
- recovery procedure removes bad series source without losing all telemetry.

### Failure scenarios

1. Tenant/user/request ID multiplies series indefinitely.
2. Histogram buckets × routes × status × instances exceed budget.
3. Drop rule hides a critical metric without alert.
4. `or vector(0)` masks target disappearance.
5. Aggregate success rate hides one broken high-value route.
6. Per-instance averages are averaged without traffic weighting.
7. Stale series persists in dashboard interpretation.
8. Cardinality spike overloads Prometheus before application fails.

## Самопроверка

1. How calculate series cardinality?
2. Bounded versus unbounded labels?
3. Cardinality multiplication?
4. Zero, missing and stale?
5. Safe defaults for absent data?
6. Aggregation bias?
7. Weighted versus unweighted aggregation?
8. Histogram cardinality?
9. High-cardinality drill-down alternatives?
10. How detect/drop bad telemetry safely?

## Результат для базы знаний

- **Metric cardinality and series budgets**.
- **Metric label multiplication and histogram cost**.
- **Zero, missing, stale and unavailable telemetry**.
- **Metric aggregation bias and weighting**.
- **High-cardinality drill-down through logs and traces**.

## Когда переходить дальше

Можно переходить, когда an adversarial label cannot destabilize the metric system and dashboards distinguish healthy zero from collection failure or misleading aggregation.