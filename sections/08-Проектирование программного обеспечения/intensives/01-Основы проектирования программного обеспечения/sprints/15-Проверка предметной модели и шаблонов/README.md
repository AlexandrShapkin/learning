# Спринт 15. Проверка предметной модели и шаблонов

Ориентировочный объём: 14–21 час.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 09–14.

## Исходная задача

Создать `work/domain-design-checkpoint/` — спроектировать предметную модель and application patterns for a synthetic work-order/fulfillment domain, сохраняя пропорциональность сложности.

## Domain requirements

- organizations and memberships;
- work orders with lines and statuses;
- inventory reservation;
- billing/settlement placeholder;
- attachments;
- cancellation and compensation;
- reporting view;
- external provider integration;
- domain and integration events.

## Part 1. Language and boundaries

- define ubiquitous language for at least three contexts;
- identify overloaded terms;
- create bounded-context map;
- state source-of-truth ownership and published contracts;
- implement one anti-corruption translation.

## Part 2. Tactical model

- entities and value objects;
- aggregate roots and invariants;
- domain/application services;
- state transition table;
- domain events and integration-event translation;
- repository and transaction boundary.

## Part 3. Pattern selection

For at least six candidate patterns state context, forces, simpler alternative and consequences. Implement only patterns that remain justified.

Mandatory comparisons:

- Transaction Script versus Domain Model;
- direct SQL/read model versus generic repository;
- switch/table versus Strategy/State;
- function/closure versus interface implementation;
- synchronous collaboration versus domain/integration event.

## Part 4. Change scenarios

Execute:

1. add one new status rule;
2. add second billing/provider variant;
3. change one reporting requirement;
4. split one overloaded concept between contexts;
5. evolve one integration event compatibly.

## Mandatory fault cases

1. Entity identity depends on all mutable fields.
2. Invalid value bypasses constructor through zero/exported field.
3. Aggregate is unbounded or too global.
4. Child entity mutated outside root.
5. Domain service performs infrastructure orchestration.
6. Event command/fact semantics are confused.
7. One canonical model is shared across contexts.
8. Shared kernel becomes global common package.
9. Pattern exists without demonstrated variation/force.
10. Generic repository/service hides no meaningful decision.
11. CQRS/read model is treated as source of truth.
12. API/database/provider DTO leaks into domain model.

## Defense

1. Entity versus value object?
2. How identity and equality differ?
3. Aggregate boundary is chosen by what?
4. Domain service versus application service?
5. Domain event versus integration event?
6. Entity/process/UI state differences?
7. Bounded context versus service/module?
8. Shared kernel versus duplicated concepts?
9. Pattern selection requires which forces?
10. Transaction Script versus Domain Model?
11. Repository/direct SQL/CQRS trade-offs?
12. Which evidence proves the model handles change?

## Критерии прохождения

- three contexts have distinct language and ownership;
- aggregates protect named invariants and remain bounded;
- transition matrix covers success, rejection, timeout and compensation paths;
- persistence/API/provider models remain adapters;
- transaction and event publication semantics are explicit;
- six patterns are assessed and unjustified ones rejected/removed;
- five changes remain localized to intended contexts/components;
- all twelve faults are reproduced or prevented with tests;
- at least 10 of 12 defense answers are mechanism-based;
- no context/aggregate/pattern is created solely to satisfy terminology.

## Результат для базы знаний

Checkpoint-specific note не требуется. Update only mechanisms whose boundaries or trade-offs changed after implementation evidence.