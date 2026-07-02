# Спринт 21. Funnels, activation, retention и cohorts

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как измерить путь к ценности and continued use without confusing activity, repeated necessity and real retention?

## Результат спринта

После завершения необходимо уметь:

- define funnel steps by meaningful progress;
- distinguish acquisition, signup, activation, engagement, conversion and retention;
- define activation by experienced value rather than setup completion;
- use time windows and eligible populations correctly;
- build cohorts by start period, segment and behavior;
- distinguish user, account and workflow retention;
- interpret churn, resurrection and seasonality;
- analyze drop-off with qualitative context;
- avoid survivorship and denominator errors;
- identify leading versus vanity activity.

## Основной маршрут

1. Build request/dispatcher/worker funnels.
2. Define activation and retention hypotheses.
3. Generate cohort tables and curves.
4. Segment drop-off and investigate causes.

## Лабораторная работа

Создать `work/funnels-retention/`.

### Requirements

- each funnel has eligible population, order/window and success definition;
- activation links to first realized value;
- repeated usage is interpreted in the process context;
- cohorts preserve start period and exposure;
- churn/resurrection definitions are explicit;
- account and individual behavior are not mixed silently;
- seasonality and incomplete recent cohorts are handled;
- drop-off findings link to journeys/support/research;
- confidence and sample limits are visible.

### Failure scenarios

1. Signup is treated as activation.
2. Funnel denominator changes at each step silently.
3. Mandatory repeated work is mistaken for satisfaction.
4. Recent cohorts look worse because observation is incomplete.
5. User churn differs from account retention but is merged.
6. Overall average hides one failing segment.

## Результат для базы знаний

- **Product funnels and eligible populations**.
- **Activation and first value**.
- **Retention, churn, resurrection and cohorts**.
- **User versus account retention**.
- **Funnel drop-off triangulation**.

## Когда переходить дальше

Можно переходить, когда activation and retention definitions represent experienced value and cohort conclusions survive denominator, window and segment checks.