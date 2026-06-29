# Спринт 01. Сложность, изменения и стоимость дизайна

Ориентировочный объём: 14–20 часов.

## Центральный вопрос

Как отличить сложность предметной задачи от сложности, созданной структурой кода, и измерить качество дизайна через реальные изменения?

## Результат спринта

После завершения необходимо уметь:

- различать essential and accidental complexity;
- определять cognitive load, change amplification and unknown unknowns;
- понимать локальность изменения as a design property;
- строить change scenario before redesign;
- фиксировать observable behavior and invariants;
- читать codebase through entry points, data flow and dependencies;
- находить shotgun surgery and divergent change;
- различать symptom and structural cause;
- использовать repository history as evidence of coupling;
- измерять touched modules/files/decisions without fetishizing line count;
- формулировать design hypothesis and falsifiable expected effect;
- сравнивать before/after through the same feature changes;
- не путать unfamiliarity with inherent bad design;
- учитывать operational and team constraints;
- избегать rewrite as default response to complexity.

## Основной маршрут

### Шаг 1. Baseline system

Получить намеренно запутанное приложение `work/change-cost-baseline/`. Зафиксировать:

- supported user scenarios;
- package and dependency map;
- mutable data and side effects;
- test coverage by behavior;
- build/test commands;
- known pain points without immediate fixes.

### Шаг 2. Change scenarios

Выполнить три изменения:

1. добавить новый business rule;
2. заменить one external dependency;
3. добавить one delivery/interface variant.

Для каждого записать:

```text
expected behavior
touched files/packages
new decisions and duplicated decisions
required tests
unexpected dependencies
runtime/migration impact
```

### Шаг 3. Complexity classification

Разделить найденное на:

- essential domain decisions;
- accidental coupling;
- hidden state;
- unclear ownership;
- duplicated policy;
- unstable interfaces;
- tooling/familiarity gap.

### Шаг 4. Design hypothesis

Выбрать one structural improvement and predict which future changes become more local. Не выполнять broad rewrite; подготовить minimal experiment for sprint 02–07.

## Ресурсы

- *A Philosophy of Software Design*, chapters on complexity, change amplification and unknown unknowns.
- *Working Effectively with Legacy Code*, opening chapters.
- *Your Code as a Crime Scene*, selected change-history concepts.
- Git log/blame/diff documentation.

## Практические задания

1. Build entry-point and data-flow map of an unfamiliar package.
2. Measure one feature change by files, packages and decisions touched.
3. Identify one apparent complexity caused only by missing knowledge/documentation.
4. Use Git history to find files that change together.
5. Write two competing design hypotheses for the same pain point.
6. Reject one attractive redesign because it does not improve named scenarios.

## Лабораторная работа

Создать `work/change-cost-baseline/`.

### Domain

Synthetic fulfillment/work-order system containing:

- HTTP or CLI entry points;
- work orders and status rules;
- pricing/inventory placeholder;
- SQL persistence;
- notification/integration adapter;
- background task;
- deliberately shared mutable configuration and duplicated rules.

### Requirements

- behavior tests establish a baseline;
- three change scenarios are completed without structural cleanup first;
- every changed file is categorized by responsibility;
- dependency and change-coupling graph is generated;
- accidental and essential complexity are separated explicitly;
- no metric is used as a standalone quality score;
- design hypothesis states expected reduction in future change scope;
- commit history preserves baseline and each scenario separately;
- report remains concise: one page plus generated evidence.

### Failure scenarios

1. Line count is treated as complexity proof.
2. Unfamiliar code is labeled bad before tracing behavior.
3. One large package appears cohesive only because everything depends on everything.
4. “Clean architecture” folders are proposed without a change scenario.
5. Rewrite removes tests and observable compatibility.
6. Refactor is mixed with feature change, hiding cause.
7. History co-change is treated as causation without reading code.
8. Runtime/data migration cost is ignored.
9. Team/tool constraints are omitted from design recommendation.
10. New abstraction increases files touched for the target scenario.

## Самопроверка

1. Essential versus accidental complexity?
2. What is change amplification?
3. What does local reasoning require?
4. Shotgun surgery versus divergent change?
5. Why one complexity metric is insufficient?
6. How repository history helps?
7. What makes a design hypothesis falsifiable?
8. Why baseline behavior must be fixed first?
9. When unfamiliarity is not design defect?
10. Why rewrite is a high-risk architectural decision?

## Результат для базы знаний

- **Essential and accidental software complexity**.
- **Change amplification and local reasoning**.
- **Design quality through change scenarios**.
- **Shotgun surgery and divergent change**.
- **Repository history as coupling evidence**.
- **Falsifiable design hypotheses**.
- **Behavior baseline before structural change**.

## Когда переходить дальше

Можно переходить, когда at least three concrete changes expose where decisions and dependencies spread, and one improvement hypothesis predicts a measurable reduction in future change scope.