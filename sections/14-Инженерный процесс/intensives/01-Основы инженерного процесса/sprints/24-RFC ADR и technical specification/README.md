# Спринт 24. RFC, ADR и technical specification

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Какой decision artifact нужен для конкретной uncertainty, scope and reversibility, and how preserve rationale without turning every change into a document project?

## Результат спринта

После завершения необходимо уметь:

- distinguish research note, proposal, RFC, ADR and specification;
- choose artifact by decision scope, reversibility and coordination need;
- state context, forces, options, decision and consequences;
- define interface/behavior precisely where needed;
- run asynchronous review with decision deadline;
- record dissent and unresolved risk;
- link decision to implementation and later supersession;
- avoid post-hoc ADR and template filling;
- retire/supersede stale decisions.

## Основной маршрут

1. Write one RFC for a cross-component change.
2. Compare at least three options with evidence.
3. Record the resulting ADR.
4. Write one precise interface/migration specification.
5. Supersede the decision after changed context.

## Лабораторная работа

Создать `work/technical-decisions/`.

### Requirements

- artifact type matches decision need;
- context/problem and decision owner are explicit;
- options include status quo and meaningful alternatives;
- trade-offs cover quality, operation, migration and cost;
- evidence and uncertainty are separated;
- review has deadline and unresolved items;
- ADR records actual decision and consequences;
- specification defines contracts, failure and compatibility behavior;
- superseded state links old and new rationale;
- no template section exists solely to be filled.

### Failure scenarios

1. RFC is written after implementation to justify it.
2. Only preferred option is described.
3. ADR copies implementation details but no rationale.
4. Specification ignores errors/migration/versioning.
5. Review remains open indefinitely.
6. Old decision appears current after context changes.
7. Every small local change requires full RFC.

## Результат для базы знаний

- **Engineering RFCs and design proposals**.
- **Architecture Decision Records**.
- **Technical specifications and normative contracts**.
- **Decision review, supersession and consequences**.

## Когда переходить дальше

Можно переходить, когда a future maintainer can reconstruct why a significant decision was made, its limits and what replaced it.