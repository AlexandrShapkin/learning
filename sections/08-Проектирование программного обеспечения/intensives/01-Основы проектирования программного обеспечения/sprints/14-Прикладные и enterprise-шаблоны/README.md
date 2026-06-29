# Спринт 14. Прикладные и enterprise-шаблоны

Ориентировочный объём: 19–27 часов.

## Центральный вопрос

Какие patterns help organize application workflows, persistence and read/write responsibilities, и когда они добавляют ceremony without solving a concrete boundary or consistency problem?

## Результат спринта

После завершения необходимо уметь:

- различать Transaction Script, Domain Model, Table Module and Service Layer;
- выбирать application service and use-case boundary;
- применять Repository only for meaningful aggregate/domain isolation;
- понимать Unit of Work and transaction scope;
- различать Data Mapper, Active Record and direct SQL approaches;
- проектировать DTO/Assembler/Mapper boundaries;
- понимать CQRS as model separation, not mandatory infrastructure split;
- различать read model and source model;
- использовать Specification cautiously;
- применять Identity Map/Lazy Load only where real object graph requires them;
- понимать Gateway, Remote Facade and anti-corruption roles;
- различать domain event dispatcher and integration messaging;
- избегать generic base repositories/services;
- выбирать pattern based on domain complexity and change pressure;
- тестировать transactional and mapping semantics;
- упрощать pattern stack when direct code is clearer.

## Основной маршрут

### Шаг 1. Application style comparison

Implement the same simple use case as:

- Transaction Script;
- application service + Domain Model;
- intentionally over-layered generic architecture.

Compare rule ownership, change locality and test scope.

### Шаг 2. Persistence patterns

Compare direct SQL/Data Mapper and repository over an aggregate. Do not hide useful SQL/query semantics behind weak CRUD abstractions.

### Шаг 3. Read/write separation

Create one query-specific read model without forcing command model to serve reporting needs. CQRS remains in-process unless separate deployment/data path is justified.

### Шаг 4. Mapping and transactions

Make transaction ownership explicit and map API/database/provider types at boundaries. Test rollback and concurrency behavior.

## Ресурсы

- *Patterns of Enterprise Application Architecture*.
- DDD tactical patterns.
- Data-storage transaction and query materials.
- CQRS writings used critically and in context.

## Практические задания

1. Compare Transaction Script and Domain Model for simple and complex rule sets.
2. Replace generic CRUD repository with aggregate/query-specific contracts.
3. Implement direct SQL Data Mapper.
4. Build read model for dashboard/reporting query.
5. Add explicit transaction/unit-of-work boundary.
6. Map DTO/domain/row/provider models.
7. Remove one pattern layer that only forwards calls.

## Лабораторная работа

Создать `work/application-patterns/`.

### Scenarios

- simple reference-data update;
- complex work-order transition;
- multi-step transactional command;
- dashboard/report query;
- external provider call;
- event/outbox publication.

### Requirements

- simple scenario remains simple; it is not forced into rich domain model;
- complex invariant has clear model/aggregate owner;
- application service coordinates transaction and effects;
- repositories do not expose universal CRUD/filter language;
- query/read path can use tailored SQL/DTO;
- transaction boundary is visible and tested;
- domain objects do not depend on ORM/HTTP/provider types;
- CQRS split is justified by different model/query needs;
- read model staleness/rebuild semantics are explicit if asynchronous;
- mappers preserve exact value/identity semantics;
- no generic base service/repository with reflection or `any`;
- selected pattern set is the minimum satisfying scenarios.

### Failure scenarios

1. Transaction Script becomes giant procedural service as rules grow.
2. Rich Domain Model is built for simple CRUD with no invariants.
3. Repository hides SQL but leaks table/filter concepts anyway.
4. Generic repository cannot express transactions/joins/locking correctly.
5. Unit of Work is duplicated around native database transaction with no benefit.
6. Active Record couples domain rules to persistence lifecycle unexpectedly.
7. CQRS becomes two services/databases without demonstrated need.
8. Read model is treated as authoritative source.
9. Mapping layer copies fields mechanically and loses semantic validation.
10. Service Layer methods only forward to repository.
11. Domain event is synchronously dispatched before commit and called integration-safe.

## Самопроверка

1. Transaction Script versus Domain Model?
2. Application Service/Service Layer role?
3. Repository useful for what?
4. Direct SQL versus repository?
5. Unit of Work/transaction ownership?
6. Data Mapper versus Active Record?
7. CQRS means what minimally?
8. Read model versus source model?
9. DTO/mapper boundary purpose?
10. When enterprise pattern adds ceremony?

## Результат для базы знаний

- **Transaction Script, Domain Model and Service Layer**.
- **Repository and aggregate persistence boundary**.
- **Direct SQL, Data Mapper and Active Record**.
- **Unit of Work and transaction ownership**.
- **DTO, assembler and model translation**.
- **CQRS and read-model separation**.
- **Enterprise-pattern overuse and generic CRUD abstractions**.

## Когда переходить дальше

Можно переходить, когда simple and complex scenarios use proportionate models, transactions/mappings are explicit, and read/write differences are handled without unnecessary distributed or generic infrastructure.