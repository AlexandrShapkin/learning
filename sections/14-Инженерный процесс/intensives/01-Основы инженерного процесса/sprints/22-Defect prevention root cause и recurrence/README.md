# Спринт 22. Defect prevention, root cause и recurrence

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как превратить defect from one repaired symptom into a change that reduces recurrence across code, tests, process and architecture?

## Результат спринта

После завершения необходимо уметь:

- distinguish trigger, defect, contributing conditions and systemic causes;
- perform blameless causal analysis;
- use five-whys/fault-tree concepts critically;
- identify detection and escape points;
- add regression tests at the right level;
- improve guardrails, interfaces and observability;
- avoid “be more careful” actions;
- verify corrective-action effectiveness;
- track recurrence and similar-risk areas;
- separate root cause from single simplistic narrative.

## Основной маршрут

1. Inject one escaped defect in the synthetic product.
2. Reconstruct discovery, introduction and escape path.
3. Identify contributing technical/process conditions.
4. Implement regression, guardrail and one systemic correction.
5. Verify against a similar variant.

## Лабораторная работа

Создать `work/defect-prevention/`.

### Requirements

- timeline distinguishes facts and hypotheses;
- analysis includes why existing checks did not detect it;
- actions cover immediate fix, recurrence prevention and detection;
- each action has owner, expected effect and verification;
- regression test reproduces original failure;
- similar components/paths are checked;
- process action changes system conditions rather than asking vigilance;
- recurrence metric and review date are defined.

### Failure scenarios

1. Root cause is “developer mistake”.
2. Five whys stops at first convenient answer.
3. Only original input is tested, not class of failures.
4. Action is “add checklist/training” without control change.
5. Fix is not verified in integrated/runtime context.
6. Similar paths remain exposed.
7. Corrective action is never reviewed for effectiveness.

## Результат для базы знаний

- **Defect causal analysis and contributing conditions**.
- **Detection and escape points**.
- **Regression tests and recurrence prevention**.
- **Corrective-action effectiveness**.

## Когда переходить дальше

Можно переходить, когда the original defect and a meaningful variant are prevented or detected through changed system conditions, not only repaired code.