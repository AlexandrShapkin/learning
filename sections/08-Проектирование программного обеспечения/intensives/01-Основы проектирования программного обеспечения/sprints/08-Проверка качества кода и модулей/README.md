# Спринт 08. Проверка качества кода и модулей

Ориентировочный объём: 14–20 часов.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 01–07.

## Исходная задача

Создать `work/code-design-checkpoint/` — взять намеренно запутанный Go-код и безопасно подготовить его к четырём изменениям, не переписывая приложение и не вводя архитектуру “по шаблону”.

## Required changes

1. Add a new business rule affecting status transition.
2. Add a second notification/provider implementation.
3. Add a batch/CLI entry point using the same policy.
4. Change one internal representation without changing public behavior.

## Part 1. Baseline

Before changes:

- map entry points, state, effects and dependencies;
- establish characterization/behavior tests;
- record files/packages/decisions touched by a dry-run or first implementation;
- list essential versus accidental complexity;
- identify one invariant owner and one missing owner.

## Part 2. Refactoring sequence

Perform a small-step sequence using:

- precise naming and vocabulary;
- explicit value/invariant types;
- cohesive functions/types/packages;
- encapsulated capability contracts;
- constructor wiring and composition root;
- consumer-owned interfaces only where variants exist;
- safe behavior-preserving commits.

## Part 3. Change execution

Implement all four required changes after refactoring. Compare:

```text
files/packages touched
new/duplicated decisions
exported API changes
dependency graph changes
tests required
unexpected coupling
runtime/data compatibility
```

## Part 4. Debt and decision

Create a concise decision record:

- what was improved;
- what remained intentionally coupled;
- which abstractions were rejected;
- debts accepted and their triggers;
- evidence that the target changes became safer/localer.

## Mandatory fault cases

1. Misleading duplicate term across code/API.
2. Business invariant enforced only in handler.
3. Mutable state exposed through slice/map.
4. Broad interface mirrors concrete service.
5. Global service locator or mutable configuration.
6. Utility package acting as dependency hub.
7. Wrong DRY abstraction combining different concepts.
8. Refactor mixed with behavior change in one large commit.
9. Replacement fake has stronger semantics than real adapter.
10. Temporary compatibility layer has no removal condition.

## Defense

1. Essential versus accidental complexity?
2. What makes a change local?
3. How is an invariant made explicit?
4. Cohesion versus small component count?
5. What should a package hide?
6. Consumer contract includes what beyond types?
7. Why constructor injection helps reasoning?
8. When an interface is justified?
9. How principles act as heuristics?
10. How behavior is preserved during refactoring?
11. What is technical-debt interest?
12. Which evidence proves the redesign helped?

## Критерии прохождения

- baseline behavior and dependency evidence exists;
- all four changes are completed;
- public behavior remains compatible where required;
- one invariant has a clear model/module owner;
- concrete resources are wired and closed through composition root;
- no hidden global/service locator remains in target path;
- all ten faults are reproduced or identified and repaired;
- change-impact comparison shows reduced accidental spread or explicitly rejects redesign;
- commits remain reviewable and reversible;
- at least 10 of 12 defense answers are mechanism-based.

## Результат для базы знаний

Checkpoint-specific note не требуется. Исправить существующие заметки, если practical evidence contradicted a rule or exposed missing context.