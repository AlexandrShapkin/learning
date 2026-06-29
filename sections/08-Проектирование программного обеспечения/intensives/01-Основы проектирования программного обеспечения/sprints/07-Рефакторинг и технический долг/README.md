# Спринт 07. Рефакторинг и технический долг

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как улучшать внутреннюю структуру существующей системы небольшими проверяемыми шагами, сохраняя поведение and controlling debt intentionally?

## Результат спринта

После завершения необходимо уметь:

- определять refactoring as behavior-preserving structural change;
- отделять refactoring, feature, bug fix and migration;
- создавать safety net from tests and observations;
- применять extract/inline/move/rename/encapsulate refactorings;
- использовать parallel change and branch by abstraction at small scale;
- делать commits small and reversible;
- различать code smell, root cause and preference;
- классифицировать technical debt by principal, interest and risk;
- связывать debt with blocked change/incident/quality scenario;
- выбирать opportunistic versus planned refactoring;
- избегать cleanup without an exit criterion;
- измерять improvement through named future changes;
- использовать Git bisect/revert and feature flags cautiously;
- сохранять compatibility during refactor;
- понимать when rewrite may be justified and what evidence is required;
- создавать rollback/forward-fix path.

## Основной маршрут

### Шаг 1. Safety net

Before structural change:

- establish behavior/characterization tests;
- capture API/data compatibility;
- record benchmark or runtime behavior if relevant;
- isolate nondeterministic dependencies;
- define success and abort criteria.

### Шаг 2. Small-step sequence

Write a sequence of transformations where each step compiles/tests. Avoid mixing rename, behavior change, data migration and dependency replacement in one commit.

### Шаг 3. Debt register by impact

For selected debts record:

```text
constraint or shortcut
why it was accepted
current interest: delays, incidents, duplicated decisions
affected change scenarios
risk if untouched
paydown/refinance/accept option
trigger for action
```

No generic backlog of every code smell is required.

### Шаг 4. Verify value

Repeat one feature/change scenario from sprint 01 and compare touched areas, defects and reasoning burden.

## Ресурсы

- *Refactoring*, Martin Fowler.
- *Working Effectively with Legacy Code*, Michael Feathers.
- *Refactoring to Patterns*, selected sequences.
- Git bisect/revert/rerere documentation.

## Практические задания

1. Perform a five-to-ten-step refactoring with green commits.
2. Separate one mixed feature/refactor patch into safe sequence.
3. Create characterization test for undocumented behavior.
4. Use branch by abstraction to replace one dependency.
5. Classify five debts and reject three as low-value cleanup.
6. Re-run a previous change scenario and compare impact.
7. Practice revert/rollback after an intentionally bad refactor.

## Лабораторная работа

Создать `work/refactoring-debt/` based on the evolving system.

### Target changes

- move state-transition rules to owned model/module;
- replace provider-specific client usage with adapter;
- separate reporting query from transactional command path;
- remove shared mutable global;
- rename one public concept with compatibility layer;
- retire duplicated legacy path.

### Requirements

- baseline tests and behavior evidence before change;
- each transformation has clear intent and small diff;
- public/API/data compatibility maintained or explicitly staged;
- no broad formatting/generated-file churn in logic commits;
- debt decisions reference actual change/incident evidence;
- architecture/dependency checks run after each major step;
- one intentionally failed step is safely reverted;
- final comparison repeats at least two change scenarios;
- leftover temporary abstraction/flag has removal condition;
- report distinguishes paid, refinanced, accepted and newly introduced debt.

### Failure scenarios

1. Refactoring changes behavior without explicit test/decision.
2. Giant commit cannot be reviewed or reverted.
3. Tests mirror internals and fail on every move.
4. Formatting/renaming hides semantic changes.
5. Compatibility layer is added with no removal plan.
6. Debt list becomes aesthetic complaint catalog.
7. “Pay all debt” delays necessary feature without evidence.
8. Rewrite begins before extracting behavior and migration path.
9. New abstraction remains after replacement and doubles complexity.
10. Local code improves while package/system dependency worsens.

## Самопроверка

1. Refactoring versus behavior change?
2. What makes a safety net sufficient?
3. Why small green steps matter?
4. What is parallel change/branch by abstraction?
5. Code smell versus root cause?
6. Technical-debt principal and interest?
7. Opportunistic versus planned refactoring?
8. What proves refactoring value?
9. When rewrite might be justified?
10. Why temporary compatibility needs exit condition?

## Результат для базы знаний

- **Behavior-preserving refactoring**.
- **Refactoring safety net and small-step sequence**.
- **Parallel change and branch by abstraction**.
- **Code smell versus structural cause**.
- **Technical-debt principal, interest and risk**.
- **Opportunistic and planned refactoring**.
- **Compatibility and rollback during refactoring**.
- **Rewrite decision evidence**.

## Когда переходить дальше

Можно переходить, когда repeated change scenarios touch fewer accidental areas, refactoring history is reviewable/reversible, and debt decisions are tied to actual cost and risk.