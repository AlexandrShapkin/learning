# Спринт 29. Rollout, adoption и organizational change

Ориентировочный объём: 20–29 часов.

## Центральный вопрос

Как перевести validated solution into actual changed behavior and business outcome without assuming that release creates adoption?

## Результат спринта

После завершения необходимо уметь:

- distinguish deployment, availability, adoption and realized outcome;
- choose pilot/cohort/phased/big-bang rollout appropriately;
- define readiness for users, data, process, support and operations;
- plan migration, coexistence and rollback;
- identify champions, resistance and incentive conflicts;
- create role-specific onboarding and training;
- measure activation, adoption depth and workflow completion;
- manage communication and feedback loops;
- define go/no-go, pause and expansion thresholds;
- avoid forcing usage through vanity targets.

## Основной маршрут

1. Select pilot cohort and rollout strategy.
2. Create readiness matrix and migration plan.
3. Design training, support and communication by role.
4. Simulate pilot results and expansion/pause decision.

## Лабораторная работа

Создать `work/rollout-adoption/`.

### Requirements

- pilot cohort includes representative and difficult cases;
- readiness covers permissions, data, process, support and continuity;
- coexistence and rollback preserve authoritative state;
- training is task- and role-based with independent verification;
- adoption metrics reflect successful workflow/value, not login count;
- guardrails include error, accessibility, support and workload shift;
- incentives and local workarounds are monitored;
- expansion criteria and maximum exposure are predeclared;
- pause/rollback decision is operationally executable.

### Failure scenarios

1. Release date is treated as adoption completion.
2. Pilot contains only champions.
3. Migration removes fallback before readiness.
4. Training is one generic presentation.
5. Login count is used as product success.
6. Managers force usage while users maintain shadow process.
7. Support capacity is absent during expansion.

## Результат для базы знаний

- **Product rollout and adoption stages**.
- **Pilot cohorts, readiness and expansion criteria**.
- **Role-based onboarding and organizational change**.
- **Adoption depth, shadow processes and guardrails**.

## Когда переходить дальше

Можно переходить, когда rollout expansion depends on demonstrated workflow value, readiness and bounded support/risk rather than software availability alone.