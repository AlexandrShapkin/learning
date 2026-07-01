# Спринт 30. Delivery metrics, change risk и непрерывное улучшение

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как measure delivery flow and stability to identify system constraints and change risk without turning metrics into individual targets or optimizing one number at the expense of outcomes?

## Результат спринта

После завершения необходимо уметь:

- calculate deployment frequency, lead time, change failure rate and recovery time with explicit definitions;
- distinguish commit-to-production, active time and waiting time;
- define deployment/change/incident denominator consistently;
- understand metric limitations and Goodhart effects;
- segment by service/change type without cherry-picking;
- combine flow, quality, reliability and workload indicators;
- identify queue/bottleneck from value-stream data;
- evaluate batch size, flaky gates and approval delay;
- measure recovery and rework;
- design improvement experiment with baseline and guardrails;
- avoid ranking people/teams from delivery metrics;
- use qualitative evidence alongside numbers.

## Основной маршрут

1. Instrument synthetic repository/release/incident history.
2. Define and calculate four DORA-like metrics.
3. Decompose lead time into coding/review/queue/build/release/deploy segments.
4. Identify one bottleneck and run a small improvement experiment.
5. Check whether another quality/reliability metric worsened.

## Лабораторная работа

Создать `work/delivery-improvement/`.

### Requirements

- metric definitions, timestamps, exclusions and data quality are versioned;
- changes/deployments/incidents have traceable identifiers;
- lead time separates waiting from active work;
- change failure includes agreed rollback/repair/incident outcomes;
- recovery-time start/end definitions are explicit;
- dashboard supports diagnosis, not personal ranking;
- improvement experiment changes one constraint and states expected mechanism;
- guardrails include reliability, rework and responder burden;
- statistical uncertainty/small sample is acknowledged;
- qualitative interviews/timeline evidence explain the numbers;
- metric gaming scenarios are identified and mitigated.

### Failure scenarios

1. More deployments are achieved by splitting meaningless/no-op releases.
2. Lead time starts after review queue and hides waiting.
3. Rollbacks are avoided to protect change-failure metric.
4. MTTR closes when alert clears while backlog/data risk remains.
5. Teams with different service/change profiles are ranked directly.
6. Faster CI reduces checks and increases escaped defects.
7. Small sample is presented as strong trend.
8. Metric definition changes silently.
9. Local bottleneck improvement shifts queue downstream.

## Результат для базы знаний

- **Software delivery performance metrics**.
- **Delivery lead time and waiting-time decomposition**.
- **Change failure and recovery-time definitions**.
- **Goodhart effects in delivery metrics**.
- **Delivery improvement experiments and guardrails**.

## Когда переходить дальше

Можно переходить, когда one measured delivery constraint is improved through a mechanism-based experiment without degrading reliability, quality or responder load.