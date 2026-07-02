# Спринт 02. Проблема, outcome и проверяемая гипотеза

Ориентировочный объём: 16–23 часа.

## Центральный вопрос

Как отличить реальную проблему и желаемый результат от заранее выбранного решения?

## Результат спринта

После завершения необходимо уметь:

- формулировать problem statement from observed evidence;
- отделять symptom, cause, need, outcome and solution;
- определять affected users/systems and current baseline;
- писать falsifiable hypothesis;
- выбирать leading and outcome evidence;
- фиксировать assumptions and unknowns;
- задавать non-goals and boundaries;
- определять stop/change criteria.

## Основной маршрут

1. Take a vague request such as “add caching” or “rewrite service”.
2. Reconstruct the actual problem and baseline.
3. Define outcome, hypothesis and evidence.
4. Compare three solution options including no-build/process change.

## Лабораторная работа

Создать `work/problem-framing/`.

### Requirements

- problem statement describes current undesirable state and affected context;
- evidence distinguishes observed facts from interpretation;
- outcome is measurable without requiring one specific implementation;
- hypothesis names intervention, expected change and observation window;
- assumptions and unknowns have validation paths;
- non-goals prevent uncontrolled scope expansion;
- failure/stop criteria are explicit;
- solution choice follows comparison rather than precedes framing.

### Failure scenarios

1. “Need microservices” is written as a problem.
2. Metric improves without user/system outcome.
3. Baseline is unknown.
4. Hypothesis cannot be disproved.
5. Stakeholder request is copied without affected workflow.
6. Non-goals and stop criteria are absent.

## Результат для базы знаний

- **Engineering problem statements**.
- **Outcomes versus solutions**.
- **Falsifiable engineering hypotheses**.
- **Baselines, assumptions and non-goals**.

## Когда переходить дальше

Можно переходить, когда multiple solutions can be evaluated against one evidence-based problem and outcome.