# Спринт 26. Проверка качества и инженерного контекста

Ориентировочный объём: 15–22 часа.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 19–25.

## Исходная задача

Создать `work/quality-context-checkpoint/` — complete verification and context package for a risky feature: strategy, layered tests, CI gates, defect analysis, documentation, RFC/ADR and handoff.

## Required artifacts

- risk/test strategy;
- unit/integration/contract/end-to-end evidence;
- CI workflow and gate policy;
- one injected escaped defect and recurrence analysis;
- current user/contributor/operational docs;
- RFC, ADR and interface/migration specification;
- onboarding/handoff exercise.

## Mandatory failure cases

1. High coverage misses critical integration risk.
2. Mock/fake diverges from real contract.
3. End-to-end suite becomes slow and broad.
4. Flaky check is rerun until green.
5. CI and local commands differ.
6. Root cause is “human error”.
7. Fix has no class-level regression.
8. Documentation duplicates stale facts.
9. RFC is post-hoc or single-option.
10. ADR/specification omits consequences/failure behavior.
11. Handoff contains no decisions/risks.
12. Knowledge transfer is not verified independently.

## Defense

1. Which risks drive the test strategy?
2. Why is each test at its chosen level?
3. Which boundary is validated realistically?
4. Which CI checks block and why?
5. How are flaky/infrastructure failures handled?
6. Why did the defect escape?
7. Which systemic correction prevents recurrence?
8. Where is authoritative documentation?
9. Why was RFC/ADR/spec chosen?
10. What trade-offs and migration behavior are recorded?
11. How can a new contributor perform a safe change?
12. How was handoff understanding verified?

## Критерии прохождения

- critical risks have layered, reproducible evidence;
- CI is fast enough, deterministic and proportionate;
- defect analysis changes code/test/process conditions;
- docs and decisions are current, navigable and non-duplicative;
- transfer is verified through independent task;
- all twelve failure cases are reproduced or corrected;
- at least 10 of 12 defense answers cite tests, artifacts or timelines;
- obsolete checks/docs/templates are removed.

## Результат для базы знаний

Checkpoint-specific note не требуется. Update quality/documentation/decision notes where exercise evidence changed assumptions.