# Спринт 31. Technical debt, standardization и automation

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как управлять accumulated design/process friction and decide what to standardize or automate without creating another platform or policy burden?

## Результат спринта

После завершения необходимо уметь:

- distinguish technical debt, defect, missing feature and intentional trade-off;
- record principal, interest, risk and trigger conditions;
- prioritize debt by change friction and operational exposure;
- choose incremental modernization and strangler paths;
- standardize repeated high-value decisions;
- automate stable understood workflows;
- design paved roads with escape hatches;
- measure adoption and maintenance cost;
- retire obsolete tools, templates and standards;
- avoid automation of unclear or low-frequency work.

## Основной маршрут

1. Inventory synthetic code/process/tooling debt.
2. Rank by recurring cost and risk.
3. Modernize one path incrementally.
4. Standardize and automate one repeated workflow.
5. Remove one obsolete standard/tool.

## Лабораторная работа

Создать `work/debt-standardization/`.

### Requirements

- each debt item names evidence of interest/risk;
- priority links to outcome, incident, queue or change cost;
- modernization has compatibility and rollback stages;
- standard solves repeated variability with clear owner;
- automation has input/output/error/override behavior;
- paved road reduces cognitive load and preserves justified exceptions;
- adoption and failure cost are measured;
- obsolete path has retirement/migration plan;
- no automation is built for a one-off unclear task.

### Failure scenarios

1. All disliked code is called technical debt.
2. Rewrite is planned without incremental value/compatibility.
3. Standard is mandated without solving observed variation.
4. Automation hides an unstable process and fails opaquely.
5. Internal platform becomes mandatory bottleneck.
6. Exception path is impossible, causing shadow workarounds.
7. Old tool/standard is never retired.

## Результат для базы знаний

- **Technical debt principal, interest and risk**.
- **Incremental modernization and retirement**.
- **Engineering standards and paved roads**.
- **Process/tooling automation criteria**.

## Когда переходить дальше

Можно переходить, когда one recurring source of risk/friction is reduced through incremental change and an automation/standard demonstrates net benefit and a retirement path.