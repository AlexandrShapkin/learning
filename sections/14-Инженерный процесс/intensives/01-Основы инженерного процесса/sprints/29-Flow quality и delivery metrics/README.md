# Спринт 29. Flow, quality и delivery metrics

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Какие measurements help improve the system of work, and how prevent metrics from becoming targets or individual surveillance?

## Результат спринта

После завершения необходимо уметь:

- define lead time, cycle time, throughput, WIP and aging;
- understand deployment frequency, change-failure and recovery metrics;
- measure review wait, rework and defect escape;
- define data source, start/end events and exclusions;
- use distributions and percentiles rather than averages only;
- segment by work type/system without individual ranking;
- detect Goodhart effects and gaming;
- distinguish leading, lagging and balancing metrics;
- connect metric to decision and experiment;
- audit metric-data quality.

## Основной маршрут

1. Generate a synthetic change/PR/defect history.
2. Calculate flow and quality distributions.
3. Compare averages, medians and percentiles.
4. Inject metric gaming and detect distortion.
5. Design a small decision dashboard/report.

## Лабораторная работа

Создать `work/engineering-metrics/`.

### Requirements

- every metric has definition, question, owner and decision use;
- state boundaries and exclusions are reproducible;
- distributions expose tail/aging behavior;
- flow, quality and reliability are considered together;
- metric is not assigned to individual evaluation;
- changes in work mix/definitions are annotated;
- missing/canceled/reopened data are handled explicitly;
- gaming scenario demonstrates unintended behavior;
- one metric is removed because it has no decision value.

### Failure scenarios

1. Commit or ticket count ranks engineers.
2. Average cycle time hides long tail.
3. Teams change status timing to improve metric.
4. Deployment frequency rises while failures/rework increase.
5. Different work types are compared without segmentation.
6. Metric definition changes silently.
7. Dashboard grows without decisions or experiments.

## Результат для базы знаний

- **Engineering flow and delivery metrics**.
- **DORA-style delivery and reliability measures**.
- **Metric distributions, segmentation and data quality**.
- **Goodhart’s law and metric gaming**.

## Когда переходить дальше

Можно переходить, когда each metric answers a decision question and cannot reasonably be interpreted as an individual productivity score.