# Спринт 10. Product goals, outcomes и metric tree

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как связать product goal with user behavior, business result and guardrails without turning a metric into the product itself?

## Результат спринта

После завершения необходимо уметь:

- distinguish output, outcome, impact and activity;
- formulate product goals with baseline and horizon;
- build metric tree from business result to user behavior and system enablers;
- define leading, lagging and guardrail metrics;
- identify metric ownership and controllability;
- detect proxy failure and Goodhart effects;
- balance value, quality, accessibility, support and risk;
- define decision thresholds and review cadence;
- avoid one north-star metric for incompatible contexts.

## Основной маршрут

1. Define one product/business outcome.
2. Build causal metric tree and assumptions.
3. Add guardrails and segment views.
4. Stress-test gaming and unintended consequences.

## Лабораторная работа

Создать `work/product-goals-metrics/`.

### Requirements

- goal names baseline, target direction, horizon and population;
- output metrics are separated from outcomes;
- each metric-tree edge states a causal assumption;
- guardrails cover harm, reliability, accessibility and support burden;
- metric definitions include numerator, denominator and exclusions;
- segment effects are visible;
- target does not become an individual performance metric;
- one attractive but misleading metric is rejected.

### Failure scenarios

1. Goal is “ship feature X”.
2. Adoption count rises while task success worsens.
3. Revenue metric ignores churn/support cost.
4. Metric tree implies causality without assumptions.
5. Average hides a harmed segment.
6. Target creates spam, forced usage or dark patterns.

## Результат для базы знаний

- **Product goals, outcomes and impact**.
- **Metric trees and causal assumptions**.
- **Leading, lagging and guardrail metrics**.
- **Product-metric definitions and Goodhart effects**.

## Когда переходить дальше

Можно переходить, когда a goal can be evaluated through a balanced metric system whose causal assumptions and failure modes are explicit.