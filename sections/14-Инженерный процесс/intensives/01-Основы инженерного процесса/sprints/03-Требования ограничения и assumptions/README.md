# Спринт 03. Требования, ограничения и assumptions

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Какие observable capabilities and quality constraints must hold, and which assumptions could invalidate the solution?

## Результат спринта

После завершения необходимо уметь:

- различать functional, quality, operational and compliance requirements;
- писать requirements in observable language;
- distinguish requirement, design decision and preference;
- define interfaces, actors, inputs, outputs and failure behavior;
- specify latency, capacity, availability, security and compatibility constraints;
- record assumptions, dependencies and open questions;
- prioritize must/should/could without hiding trade-offs;
- identify conflicting and unverifiable requirements.

## Основной маршрут

1. Convert the framed problem into requirement categories.
2. Add failure, migration and operational requirements.
3. Review each statement for observability and design leakage.
4. Resolve or expose conflicts.

## Лабораторная работа

Создать `work/requirements/`.

### Requirements

- functional requirements identify actor, trigger and observable result;
- non-functional requirements include measurement method and load/context;
- error, rollback, migration and compatibility behavior are present;
- assumptions have owners or validation actions;
- constraints identify source and consequence;
- solution preferences are separated from mandatory requirements;
- conflicts and unresolved questions are visible;
- each critical requirement has planned verification evidence.

### Failure scenarios

1. “System must be fast/scalable/secure” has no threshold or context.
2. Requirement embeds a database/framework choice without necessity.
3. Happy path is specified but failure behavior is absent.
4. Migration and backward compatibility are omitted.
5. Two requirements conflict silently.
6. Assumption about external dependency is treated as fact.

## Результат для базы знаний

- **Functional and non-functional requirements**.
- **Requirements versus design decisions**.
- **Operational, migration and compatibility requirements**.
- **Constraints, assumptions and open questions**.

## Когда переходить дальше

Можно переходить, когда critical behavior and quality expectations are observable, testable and separated from implementation choice.