# Спринт 07. Проверка постановки и декомпозиции

Ориентировочный объём: 14–21 час.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 01–06.

## Исходная задача

Создать `work/framing-checkpoint/` — complete change proposal for a substantial feature or migration, from problem evidence through requirements, acceptance, slicing and one uncertainty-reduction experiment.

## Required artifacts

- change lifecycle and stakeholders;
- problem statement, baseline, outcome and hypothesis;
- requirements, constraints, assumptions and non-goals;
- acceptance examples and completion evidence;
- vertical slice map and dependency order;
- one timeboxed spike/prototype/experiment;
- decision and residual unknowns.

## Mandatory failure cases

1. Solution is presented as the problem.
2. Outcome has no measurable baseline.
3. Requirement is vague or embeds unnecessary implementation.
4. Failure/migration/rollback behavior is absent.
5. Acceptance means only “code merged”.
6. Decomposition is component-only.
7. First feedback arrives only after all components finish.
8. High-risk assumption is delayed.
9. Spike has no decision or stop criterion.
10. Prototype is treated as production-ready.
11. Requirement change cannot be traced to tests/docs.
12. Scope expands without non-goals.

## Defense

1. What evidence proves the problem exists?
2. What outcome matters and how is it measured?
3. Which assumptions remain uncertain?
4. Which requirements are truly mandatory?
5. How are quality attributes verified?
6. What proves completion beyond merge?
7. Why are slices vertical and independently useful?
8. Which risk is tested first?
9. Why is the spike/experiment appropriate?
10. What is deliberately out of scope?
11. How will requirement changes propagate?
12. What would cause the proposal to stop or change?

## Критерии прохождения

- problem, outcome and solution are clearly separated;
- critical requirements are measurable and testable;
- acceptance covers normal, failure, migration and operational behavior;
- slices produce early value/learning and remain reviewable;
- research reduces a named uncertainty and results in a decision;
- all twelve failure cases are identified or corrected;
- at least 10 of 12 defense answers cite artifacts or evidence;
- the proposal contains no duplicate bureaucracy without decision value.

## Результат для базы знаний

Checkpoint-specific note не требуется. Update framing/requirements/decomposition notes where the exercise changed assumptions.