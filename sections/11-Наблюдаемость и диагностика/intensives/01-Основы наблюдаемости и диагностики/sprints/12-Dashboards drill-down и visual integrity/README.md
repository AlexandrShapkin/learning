# Спринт 12. Dashboards, drill-down и visual integrity

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Как создать dashboard, который отвечает на конкретные вопросы, сохраняет label/window semantics and guides drill-down instead of presenting decorative graphs?

## Результат спринта

После завершения необходимо уметь:

- distinguish overview, diagnostic, capacity and release dashboards;
- choose panel by question and data type;
- preserve units, scales and time windows;
- display distributions and tails honestly;
- use variables without high-cardinality explosion;
- annotate releases/config/migrations/incidents;
- design drill-down links to logs/traces/profiles;
- show missing/stale data explicitly;
- avoid misleading dual axes, truncated scales and averages;
- create dashboards as versioned code;
- test queries and permissions;
- define owner and review lifecycle.

## Основной маршрут

1. Create one service overview and one diagnostic dashboard.
2. Add release/config annotations and exemplar links.
3. Reproduce misleading visualization choices and correct them.
4. Test dashboard under missing targets and high-cardinality variables.

## Ресурсы

- Grafana dashboard/provisioning documentation.
- visualization integrity and operational dashboard references.
- PromQL query guidance from previous sprints.

## Лабораторная работа

Создать `work/dashboards/`.

### Requirements

- every dashboard states audience and questions;
- service overview starts from user-impact and workload signals;
- diagnostic dashboard follows service → dependency → resource path;
- panel titles include unit/statistic/window where ambiguity exists;
- release/config/schema changes are annotated;
- missing data and target-down states are visible;
- percentile/histogram views do not average quantiles across instances;
- variables have bounded options and stable labels;
- links preserve service, time range and correlation context;
- JSON/provisioning source is versioned and validated;
- one reviewer can answer target questions without oral guidance.

### Failure scenarios

1. Green dashboard hides absent telemetry.
2. Average latency hides tail degradation.
3. Two y-axes imply false relationship.
4. Auto-scaled axis exaggerates tiny variation.
5. Dashboard variable runs expensive global query.
6. Release event is absent, delaying correlation.
7. Quantiles from instances are averaged.
8. Dashboard mixes staging and production labels.
9. Panels have no owner and become stale.

## Самопроверка

1. Dashboard types?
2. Question-first panel design?
3. Visual integrity risks?
4. How show missing data?
5. Release annotations?
6. Drill-down context?
7. Why not average quantiles?
8. Variable cardinality?
9. Dashboard as code?
10. Dashboard lifecycle ownership?

## Результат для базы знаний

- **Operational and diagnostic dashboards**.
- **Dashboard visual integrity and missing data**.
- **Release annotations and telemetry drill-down**.
- **Dashboard variables, units and time windows**.
- **Dashboards as versioned code**.

## Когда переходить дальше

Можно переходить, когда another operator can detect a known regression, identify the affected path and reach supporting telemetry without mistaking absent data for health.