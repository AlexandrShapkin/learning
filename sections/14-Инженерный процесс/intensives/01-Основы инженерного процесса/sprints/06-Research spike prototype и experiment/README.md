# Спринт 06. Research, spike, prototype и experiment

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Когда uncertainty требует отдельного исследования, а когда можно безопасно перейти к production implementation?

## Результат спринта

После завершения необходимо уметь:

- различать research, spike, prototype, proof of concept and experiment;
- формулировать question and decision before investigation;
- timebox work and define stopping criteria;
- choose representative data/load/integration;
- separate disposable and production-quality code;
- preserve findings, assumptions and limitations;
- convert result into decision, requirement or follow-up slice;
- avoid prototype accidentally becoming production;
- reject research with no decision consequence.

## Основной маршрут

1. Identify one technical and one product/process uncertainty.
2. Design a timeboxed spike and a measurable experiment.
3. Build minimal evidence, not complete solution.
4. Make and document a decision.
5. Delete or isolate disposable code.

## Лабораторная работа

Создать `work/research-experiments/`.

### Requirements

- each activity begins with exact question and decision owner;
- time/resource box and stop condition are explicit;
- evidence is representative enough for the claim;
- prototype limitations and unsafe shortcuts are documented;
- result includes supported, rejected and still-unknown conclusions;
- decision and next change are linked;
- disposable code cannot enter production silently;
- failed experiment still reduces uncertainty.

### Failure scenarios

1. Spike goal is “investigate technology” without decision.
2. Prototype is productionized without hardening.
3. Benchmark uses unrealistic data/load.
4. Research continues because no stop criterion exists.
5. Findings remain in chat or memory only.
6. Experiment changes multiple variables at once.

## Результат для базы знаний

- **Engineering spikes and prototypes**.
- **Timeboxed technical research**.
- **Engineering experiments and decision evidence**.
- **Prototype-to-production boundaries**.

## Когда переходить дальше

Можно переходить, когда an uncertainty is reduced enough to make a named decision and disposable work cannot masquerade as finished implementation.