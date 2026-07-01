# Спринт 29. SLI, SLO, SLA и error budgets

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как express service reliability through user-relevant indicators and objectives, and use error-budget consumption to balance release speed, risk reduction and operational work?

## Результат спринта

После завершения необходимо уметь:

- distinguish SLI, SLO, SLA and internal target;
- define valid events, good events and measurement window;
- select availability, latency, correctness, freshness or durability indicators;
- avoid infrastructure proxy metrics as sole SLI;
- calculate error budget and burn rate;
- understand rolling versus calendar windows;
- set objectives from user need and achievable cost;
- design multi-window burn alerts conceptually;
- segment indicators without hiding global impact;
- apply error-budget policy to releases and reliability work;
- handle low-traffic and batch services;
- revise objectives without gaming historical performance.

## Основной маршрут

1. Define two user journeys for API and background job.
2. Specify events, success/latency/freshness criteria and exclusions.
3. Calculate SLO/error budget over synthetic data.
4. Simulate fast and slow burn.
5. Apply release policy under healthy, warning and exhausted budget states.

## Лабораторная работа

Создать `work/service-levels/`.

### Requirements

- at least three SLIs map to explicit user-visible behavior;
- data source, aggregation, missing data and exclusions are documented;
- objective and window have business/cost rationale;
- error budget calculation is reproducible;
- burn-rate scenarios distinguish short severe and long slow degradation;
- low-volume/batch service uses appropriate window/event model;
- release policy states actions, exceptions and decision authority;
- error-budget exhaustion does not automatically ban all changes, including risk-reducing fixes;
- SLA is separated from internal SLO and contractual remedies;
- target changes are versioned and explained, not retroactively rewritten.

### Failure scenarios

1. CPU utilization is used as availability SLI.
2. Health endpoint is green while user requests fail.
3. Average latency hides tail/user-segment failure.
4. Maintenance/failures are excluded until objective looks good.
5. Low traffic makes percentage unstable without event/window treatment.
6. Error budget becomes team performance quota.
7. Exhausted budget blocks reliability fix/dependency patch.
8. SLA and SLO are used interchangeably.
9. Objective is copied from “four nines” convention without cost/need.

## Результат для базы знаний

- **Service-level indicators, objectives and agreements**.
- **Good events, valid events and SLO windows**.
- **Error budgets and burn rates**.
- **User-facing reliability indicators**.
- **Error-budget release policies**.
- **Low-traffic and batch-service SLOs**.

## Когда переходить дальше

Можно переходить, когда release decisions can reference measured user-facing reliability and error-budget burn without treating SLOs as arbitrary uptime promises or personnel targets.