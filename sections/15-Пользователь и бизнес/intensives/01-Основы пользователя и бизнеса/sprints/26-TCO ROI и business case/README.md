# Спринт 26. TCO, ROI и business case

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как сравнить investment and alternatives over time, including implementation, operation, migration, risk and opportunity cost?

## Результат спринта

После завершения необходимо уметь:

- distinguish cost, cash flow, benefit and avoided loss;
- calculate total cost of ownership across lifecycle;
- model one-time and recurring costs;
- estimate benefits with attribution and uncertainty;
- use ROI, payback and NPV conceptually;
- compare build, buy, process change and do-nothing options;
- include migration, training, downtime and decommissioning;
- model opportunity cost and constrained capacity;
- run sensitivity and scenario analysis;
- state non-financial value and risk without fake monetization.

## Основной маршрут

1. Build 3-year synthetic cash-flow model.
2. Compare build, buy and process-only alternatives.
3. Add migration, support, risk and decommissioning costs.
4. Calculate ROI/payback/NPV ranges.
5. Identify break-even assumptions.

## Лабораторная работа

Создать `work/business-case/`.

### Requirements

- baseline/do-nothing scenario is explicit;
- costs include implementation, integration, migration, training, operation and retirement;
- benefits distinguish revenue, savings, capacity and avoided loss;
- attribution assumptions are documented;
- discount/horizon assumptions are visible where used;
- scenario ranges include downside/base/upside;
- opportunity cost and displaced work are included;
- break-even drivers are identified;
- non-financial obligations are separated from monetized estimates;
- model is reproducible from inputs/formulas.

### Failure scenarios

1. Only development cost is included.
2. Benefits are counted immediately and fully.
3. Do-nothing and process-only alternatives are absent.
4. Savings are counted without headcount/capacity realization.
5. Risk avoidance is monetized with unsupported precision.
6. Decommissioning/vendor exit cost is ignored.

## Результат для базы знаний

- **Total cost of ownership for software systems**.
- **ROI, payback and NPV business cases**.
- **Build, buy, process and do-nothing comparisons**.
- **Benefit attribution, opportunity cost and sensitivity**.

## Когда переходить дальше

Можно переходить, когда investment choice and break-even conditions remain explicit under downside, base and upside assumptions.