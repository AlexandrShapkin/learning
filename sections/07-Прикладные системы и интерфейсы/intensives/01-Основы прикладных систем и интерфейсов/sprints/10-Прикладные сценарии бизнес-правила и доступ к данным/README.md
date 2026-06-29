# Спринт 10. Прикладные сценарии, бизнес-правила и доступ к данным

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Где должна находиться логика пользовательского сценария, чтобы transport, storage and external systems could change without duplicating business decisions?

## Результат спринта

После завершения необходимо уметь:

- различать transport validation, application orchestration and business invariant;
- моделировать command/query/use case inputs and outputs;
- проектировать explicit application service boundaries;
- отделять domain decisions from HTTP status/JSON shape;
- использовать repository/gateway interfaces at consumer boundary;
- выбирать transaction boundary by invariant;
- применять dependency injection through constructors;
- избегать anemic service wrappers and god objects;
- различать pure decision and side-effect orchestration;
- проектировать authorization check with resource context;
- сохранять operation/audit metadata;
- обрабатывать partial dependency failure explicitly;
- определять retry and idempotency boundary;
- возвращать typed application errors;
- тестировать use case with fakes and real adapters;
- понимать where architecture depth becomes unnecessary ceremony.

## Основной маршрут

### Шаг 1. One use case

Take “create order/task with attachment” and separate:

```text
transport parsing/auth context
application command
business validation/state transition
transactional data operations
external/background effects
result/error mapping
```

### Шаг 2. Rules and invariants

Keep rules close to the model/state transition they protect. Database constraints remain final persisted guard where expressible.

### Шаг 3. Ports/adapters

Define only interfaces required by use case. Avoid one huge repository interface and abstractions that merely rename standard library methods.

### Шаг 4. Tests

Use pure tests for decisions, fake ports for orchestration and real PostgreSQL integration for transaction/constraint behavior.

## Ресурсы

- Go interface/design guidance.
- Patterns of Enterprise Application Architecture selected service/repository patterns.
- Application service/domain service terminology as reference.
- Previous data-storage transaction and constraint material.

## Практические задания

1. Refactor handlers that contain SQL/business logic into use cases.
2. Model create, update status and cancel operations.
3. Define typed errors independent from HTTP.
4. Add authorization decision requiring loaded resource ownership.
5. Test transaction rollback after dependency/application error.
6. Compare direct SQL use with overgeneralized repository abstraction.

## Лабораторная работа

Создать `work/application-core/`.

### Use cases

- create item/order;
- update status with allowed transition;
- attach file metadata;
- cancel operation;
- list/detail query;
- enqueue background work through outbox/task record.

### Requirements

- HTTP handler only parses, authenticates, calls use case and maps result;
- business rules have no `net/http` dependency;
- transaction boundary is explicit;
- authorization uses subject/action/resource, not only role string;
- repository/gateway interfaces are narrow;
- time, IDs and external clients are injectable;
- errors preserve machine category and safe context;
- no raw database/internal error reaches client;
- audit actor/operation/resource/result captured;
- unit tests verify decisions;
- integration tests verify database constraints/transactions;
- rollback leaves no partial source state.

### Failure scenarios

1. Handler duplicates status-transition rule.
2. Domain package imports HTTP/SQL driver types.
3. Repository abstraction exposes every table operation.
4. Authorization checks role before loading tenant/resource.
5. Transaction commits source state but task/outbox record is missing.
6. External API called inside transaction and blocks locks.
7. Fake repository passes while real constraint fails.
8. Typed error loses underlying diagnostic cause.
9. Clock/ID generation makes tests nondeterministic.
10. Layering adds pass-through methods without responsibility.

## Самопроверка

1. Transport validation versus business invariant?
2. Use case/application service role?
3. Why business error should not be HTTP status directly?
4. Where transaction boundary belongs?
5. What makes an interface useful in Go?
6. Pure decision versus orchestration?
7. How authorization needs resource context?
8. Unit fake versus real-adapter test?
9. How outbox/task record closes partial state?
10. When abstraction is unnecessary?

## Результат для базы знаний

- **Transport, application and business-rule boundaries**.
- **Application use case and orchestration**.
- **Typed application errors**.
- **Narrow ports and adapters in Go**.
- **Transaction boundary in application scenarios**.
- **Authorization with subject, action and resource**.
- **Pure decisions and side-effect orchestration**.
- **Unit and real-adapter testing boundaries**.

## Когда переходить дальше

Можно переходить, когда handlers contain no duplicated business decisions, use cases are testable without HTTP, and real integration tests prove transaction/constraint behavior.