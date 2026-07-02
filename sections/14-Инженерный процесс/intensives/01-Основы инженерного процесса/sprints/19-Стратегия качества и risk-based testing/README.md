# Спринт 19. Стратегия качества и risk-based testing

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Какие проверки дают достаточную уверенность для конкретных рисков, а какие только создают медленный шум?

## Результат спринта

После завершения необходимо уметь:

- define quality attributes and failure costs;
- build risk-based test strategy;
- distinguish prevention, detection and recovery checks;
- map risks to test levels and evidence;
- balance speed, fidelity and maintenance cost;
- identify untestable design and observability gaps;
- choose exploratory/manual checks deliberately;
- define release confidence and residual risk;
- avoid coverage percentage as quality proxy.

## Основной маршрут

1. Identify critical user, data and operational risks.
2. Build test/risk matrix for the synthetic product.
3. Remove redundant low-value checks.
4. Add one missing high-value verification path.

## Лабораторная работа

Создать `work/quality-strategy/`.

### Requirements

- each critical risk has prevention/detection/recovery evidence;
- test level matches failure scope and feedback speed;
- flaky/slow tests have containment and repair policy;
- exploratory checks have charter and recorded findings;
- production/operational verification is included where needed;
- coverage data is interpreted by untested risk, not target alone;
- residual risk and release decision are explicit;
- one check is removed due low signal/cost ratio.

### Failure scenarios

1. Strategy is only “more unit tests”.
2. High coverage misses critical integration behavior.
3. End-to-end suite duplicates all lower-level cases and becomes slow.
4. Flaky tests are rerun indefinitely.
5. Operational rollback/migration is untested.
6. Manual testing has no scope or result record.

## Результат для базы знаний

- **Risk-based software testing strategy**.
- **Quality attributes and failure-cost analysis**.
- **Test confidence, fidelity and feedback speed**.
- **Residual quality risk**.

## Когда переходить дальше

Можно переходить, когда test investment is traceable to real failure risk and release confidence is supported by layered evidence.