# Спринт 25. Revenue model и unit economics

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Какая economic unit creates or destroys value, and how revenue, variable cost, acquisition, retention and support interact?

## Результат спринта

После завершения необходимо уметь:

- identify customer, contract, user, transaction and service units;
- distinguish revenue, bookings, cash and recognized value conceptually;
- calculate gross margin and contribution margin;
- model CAC, LTV and payback with explicit assumptions;
- account for onboarding, support, infrastructure and partner costs;
- segment economics by customer type and usage;
- analyze churn/retention sensitivity;
- avoid average economics hiding loss-making segments;
- distinguish scalable and non-scalable manual work;
- state uncertainty and accounting limitations.

## Основной маршрут

1. Define the economic unit for the synthetic B2B product.
2. Build revenue and variable-cost model.
3. Calculate contribution margin, CAC/LTV and payback ranges.
4. Segment by company size/use pattern.
5. Stress-test churn, support and infrastructure cost.

## Лабораторная работа

Создать `work/unit-economics/`.

### Requirements

- economic unit and time horizon are explicit;
- revenue and cost recognition assumptions are documented;
- onboarding/support/transaction/platform costs are included;
- gross and contribution margin are separated;
- CAC includes relevant acquisition/sales effort in the synthetic model;
- LTV depends on retention and margin, not revenue alone;
- segment economics reveal cross-subsidy;
- sensitivity analysis covers churn, price, usage and support;
- financial outputs are ranges and not presented as audited accounts.

### Failure scenarios

1. Revenue is treated as profit.
2. Support/onboarding labor is excluded.
3. LTV uses infinite lifetime or optimistic churn.
4. CAC ignores sales implementation effort.
5. Average customer hides an unprofitable segment.
6. Free/low-usage accounts still create meaningful cost.

## Результат для базы знаний

- **Revenue, gross margin and contribution margin**.
- **Customer acquisition cost, lifetime value and payback**.
- **Segmented unit economics**.
- **Retention, support and cost sensitivity**.

## Когда переходить дальше

Можно переходить, когда economic conclusions remain valid after segment, churn, support and infrastructure cost assumptions are varied.