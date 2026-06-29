# Спринт 22. Атрибуты качества и архитектурные драйверы

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как превратить vague goals such as “fast”, “secure”, “scalable” or “maintainable” into measurable scenarios that actually drive architecture choices and trade-offs?

## Результат спринта

После завершения необходимо уметь:

- различать functional requirements, constraints and quality attributes;
- формулировать quality-attribute scenario;
- определять stimulus, source, environment, artifact, response and measure;
- понимать performance, availability, modifiability, security, testability, operability and usability as contextual qualities;
- выявлять conflicting qualities and trade-offs;
- отличать architectural driver from general wish;
- связывать tactics with mechanisms and costs;
- выбирать scenarios by business/technical risk;
- понимать sensitivity and trade-off points;
- учитывать development/deployment/operations constraints;
- сравнивать candidate architectures against the same scenarios;
- создавать architecture experiment/spike;
- избегать premature scale/availability assumptions;
- включать maintainability through concrete change scenarios;
- связывать quality attributes with acceptance/fitness evidence;
- пересматривать drivers as system/context changes.

## Основной маршрут

### Шаг 1. Driver inventory

For the evolving platform classify:

```text
functional capabilities
hard constraints
quality attribute scenarios
business/technical risks
assumptions and unknowns
```

### Шаг 2. Scenario format

Example:

```text
source: product team
stimulus: add a second billing provider
artifact: billing module and contracts
environment: normal development, old provider still active
response: add adapter and staged migration
measure: no changes in work-order core; old/new coexist; rollback available
```

### Шаг 3. Tactics and trade-offs

Map tactics such as caching, redundancy, isolation, abstraction, queueing, validation, observability and compatibility to scenario benefit and introduced cost.

### Шаг 4. Architecture comparison

Evaluate layered monolith, modular monolith and extracted-service candidates against a prioritized scenario set. Perform one spike for highest uncertainty.

## Ресурсы

- *Software Architecture in Practice*, quality attributes and scenarios.
- *Designing Software Architectures*, attribute-driven design.
- *Fundamentals of Software Architecture*, trade-off perspective.
- Adjacent performance, reliability and security materials.

## Практические задания

1. Rewrite ten vague quality goals into measurable scenarios.
2. Separate hard constraint from assumed preference.
3. Identify three conflicting qualities and explicit trade-offs.
4. Build tactic-to-scenario matrix.
5. Compare three architecture candidates.
6. Run one risk-reduction spike.
7. Define one scenario whose correct result is “do not distribute”.

## Лабораторная работа

Создать `work/architecture-drivers/`.

### Required scenarios

- add/change business rule;
- add provider/integration;
- isolate high-cost background processing;
- handle dependency outage;
- meet response-time/throughput target;
- protect tenant/private data;
- deploy compatible contract change;
- diagnose failed workflow;
- restore/recover source state;
- onboard a developer and change one module safely.

### Requirements

- each scenario has source, stimulus, environment, artifact, response and measure;
- scenarios are prioritized by value/risk;
- assumptions and constraints are separated;
- architecture tactics map to mechanisms and consequences;
- at least two quality conflicts are explicit;
- candidate architectures are scored/argued against same scenarios, not generic pros/cons;
- one uncertainty is tested through executable spike;
- scenario evidence links to tests, metrics or change simulations;
- maintainability is expressed as named modifications, not “clean code”;
- drivers have owner/review trigger;
- final selection includes unmet/accepted risks.

### Failure scenarios

1. “Scalable” has no workload, environment or measure.
2. Every quality is marked highest priority.
3. Tactic is selected because fashionable, not scenario-linked.
4. Constraint is actually an unverified assumption.
5. Candidate architectures are compared using different criteria.
6. Maintainability is reduced to code metrics.
7. Availability target ignores dependency and recovery model.
8. Security is listed as one nonfunctional checkbox.
9. Spike becomes production architecture without evaluation.
10. Drivers remain unchanged after context/requirements shift.

## Самопроверка

1. Functional requirement versus quality attribute?
2. What are six parts of a quality scenario?
3. What makes a scenario an architectural driver?
4. Constraint versus assumption?
5. Tactic versus architecture style?
6. Sensitivity and trade-off points?
7. How maintainability becomes measurable?
8. Why prioritize scenarios?
9. What is architecture spike for?
10. How compare architectures fairly?

## Результат для базы знаний

- **Functional requirements, constraints and quality attributes**.
- **Quality-attribute scenario structure**.
- **Architecture drivers and prioritization**.
- **Architectural tactics and trade-offs**.
- **Sensitivity and trade-off points**.
- **Maintainability as change scenarios**.
- **Architecture spikes and uncertainty reduction**.
- **Candidate architecture comparison**.

## Когда переходить дальше

Можно переходить, когда architecture choices are traceable to prioritized measurable scenarios, trade-offs and assumptions are explicit, and the highest uncertainty has executable evidence.