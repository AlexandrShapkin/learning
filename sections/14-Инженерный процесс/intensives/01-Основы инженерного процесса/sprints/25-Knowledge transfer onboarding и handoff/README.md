# Спринт 25. Knowledge transfer, onboarding и handoff

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Как передавать ownership and working context so that another engineer can make safe changes without depending on oral memory?

## Результат спринта

После завершения необходимо уметь:

- identify tacit and explicit knowledge;
- design onboarding by tasks and progressive responsibility;
- create system maps, contributor paths and troubleshooting entry points;
- use pairing, walkthroughs and shadowing deliberately;
- verify transfer through teach-back and independent task;
- hand off active changes with decisions, risks and next actions;
- avoid documentation dump as transfer;
- preserve ownership and escalation context;
- retire outdated onboarding paths.

## Основной маршрут

1. Prepare a new-contributor path for the synthetic product.
2. Create one system/change walkthrough.
3. Perform handoff of an incomplete change.
4. Validate with an independent small modification and teach-back.

## Лабораторная работа

Создать `work/knowledge-transfer/`.

### Requirements

- onboarding starts with runnable environment and one real task;
- system map identifies boundaries, owners and evidence sources;
- contributor guide explains build/test/change/review flow;
- handoff records current state, decisions, risks, blockers and next checkpoint;
- learner verifies understanding through independent action;
- missing/stale context is captured and fixed;
- access and escalation are included without secrets;
- transfer reduces single-person dependency measurably.

### Failure scenarios

1. New contributor receives only a large document list.
2. Environment setup is undocumented or irreproducible.
3. Handoff says only “continue this branch”.
4. Critical rationale exists only in meeting/chat memory.
5. Transfer is considered complete without independent verification.
6. Ownership changes but permissions/escalation do not.

## Результат для базы знаний

- **Engineering onboarding and progressive responsibility**.
- **Knowledge transfer and teach-back**.
- **Change handoff and context preservation**.
- **Reducing tacit-knowledge concentration**.

## Когда переходить дальше

Можно переходить, когда another role can set up, understand and safely modify the system using preserved context and verified handoff.