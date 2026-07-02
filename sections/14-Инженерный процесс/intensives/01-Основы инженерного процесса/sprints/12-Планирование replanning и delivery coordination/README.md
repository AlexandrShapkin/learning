# Спринт 12. Планирование, replanning и delivery coordination

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как координировать поставку в условиях меняющейся информации, не превращая план в неизменяемый контракт или постоянный хаос?

## Результат спринта

После завершения необходимо уметь:

- distinguish plan, forecast, target and decision checkpoint;
- plan by outcomes, slices and dependencies;
- define decision/review cadence based on risk;
- maintain contingency and fallback paths;
- replan after evidence, scope or capacity changes;
- communicate impact of added work;
- manage integration and release coordination;
- avoid hidden multitasking and date-driven scope dumping;
- set escalation criteria for blocked critical path;
- preserve decision rationale.

## Основной маршрут

1. Build a release/change plan from the previous slice/dependency work.
2. Add confidence ranges and checkpoints.
3. Inject scope, incident and dependency changes.
4. Replan explicitly and record displaced outcomes.

## Лабораторная работа

Создать `work/planning-replanning/`.

### Requirements

- plan names outcome, slices, dependencies and evidence;
- target dates are separated from forecasts;
- decision checkpoints occur before irreversible commitments;
- scope, time and quality trade-offs are explicit;
- added urgent work displaces or delays named work;
- critical-path blocks have escalation conditions;
- release/integration readiness is verified incrementally;
- replan history captures changed facts, not blame.

### Failure scenarios

1. Plan is a list of tasks with no outcome.
2. New urgent work is added without displacement.
3. Forecast changes are hidden to protect a date.
4. Quality/migration work is removed silently.
5. Critical dependency escalates only at deadline.
6. Replanning happens daily with no stable decision horizon.

## Результат для базы знаний

- **Engineering planning and replanning**.
- **Targets, forecasts and decision checkpoints**.
- **Scope, time and quality trade-offs**.
- **Delivery coordination and escalation**.

## Когда переходить дальше

Можно переходить, когда changing evidence causes an explicit replan with visible trade-offs rather than hidden scope or quality erosion.