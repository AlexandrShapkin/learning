# Спринт 09. Сущности, объекты-значения и инварианты

Ориентировочный объём: 17–24 часа.

## Центральный вопрос

Как представить предметные concepts so that identity, equality, validity and state transitions are explicit in code rather than scattered through handlers and storage?

## Результат спринта

После завершения необходимо уметь:

- различать entity, value object, record/DTO and service;
- определять identity independent from mutable attributes;
- проектировать value equality and immutability;
- создавать validated constructors/factories;
- защищать invariants in every state transition;
- использовать explicit domain types for money, quantity, interval and identifiers;
- моделировать optionality and absence deliberately;
- различать domain state and persistence representation;
- избегать anemic model and behavior-everywhere extremes;
- понимать zero-value implications in Go;
- проектировать serialization boundaries;
- сохранять historical facts separately from mutable current state when required;
- использовать errors expressing domain rejection;
- тестировать state space and edge cases;
- различать invariant and validation policy that belongs elsewhere.

## Основной маршрут

### Шаг 1. Concept classification

Для concepts `WorkOrder`, `Line`, `Money`, `Quantity`, `Status`, `Address`, `Period`, `TenantID` определить:

```text
identity/equality
valid states
lifecycle
mutability
owner of invariants
serialization/persistence form
```

### Шаг 2. Value objects

Implement immutable/controlled values with constructors and operations. Do not add wrappers that only rename primitives without semantics.

### Шаг 3. Entity transitions

Entity methods express allowed transitions and produce domain results/events. Callers cannot set status/critical fields directly.

### Шаг 4. Persistence boundary

Map database rows and API DTOs to domain types explicitly. Test invalid legacy data and migration behavior.

## Ресурсы

- *Domain-Driven Design*, entities and value objects.
- *Implementing Domain-Driven Design*, tactical modeling chapters.
- Go value semantics, methods and zero-value guidance.
- Data modeling material from the data-storage intensive.

## Практические задания

1. Replace primitive money/quantity/status values with meaningful types.
2. Define entity identity and equality tests.
3. Move status invariants from service/handler into model transition.
4. Model time interval and address as values.
5. Map DB/API representations without leaking tags/types into core model.
6. Test invalid zero values and legacy persisted states.

## Лабораторная работа

Создать `work/domain-values/`.

### Requirements

- entity identity remains stable across attribute changes;
- value equality is based on complete semantic value;
- constructors reject invalid state;
- zero value behavior is safe or inaccessible/documented;
- monetary operations preserve currency and exactness;
- quantity/unit semantics are explicit;
- transitions cannot be bypassed by exported fields;
- API/database DTOs remain adapters;
- domain errors distinguish invalid value and prohibited transition;
- historical status facts are not overwritten when history matters;
- tests cover boundaries, equality and invalid combinations;
- model contains no HTTP, SQL-driver or provider dependencies.

### Failure scenarios

1. Entity equality compares every mutable field.
2. Value object has setters and shared mutable internals.
3. Type alias gives no validation or semantic operation.
4. Zero value enters model and bypasses constructor.
5. Currency/unit is lost in arithmetic.
6. ORM/database tags define domain model directly.
7. Handler updates exported status field.
8. Domain object becomes serialization dump with no invariants.
9. Every calculation becomes method on a giant entity.
10. Validation requiring external policy is forced into isolated value object incorrectly.

## Самопроверка

1. Entity versus value object?
2. Identity versus equality?
3. What makes a value immutable?
4. Which invariants belong in constructor versus transition?
5. Why primitive wrappers may still be weak?
6. How Go zero values affect domain types?
7. Domain type versus DTO/row?
8. Current state versus historical fact?
9. What is an anemic model?
10. When behavior should not live on an entity?

## Результат для базы знаний

- **Entity identity and lifecycle**.
- **Value objects and semantic equality**.
- **Validated domain constructors**.
- **Domain invariants and state transitions**.
- **Primitive obsession in domain models**.
- **Go zero values in validated types**.
- **Domain model versus DTO and persistence row**.
- **Current state and historical facts**.

## Когда переходить дальше

Можно переходить, когда core invariants cannot be bypassed through ordinary application code, and API/database representations can change without redefining entity identity or value semantics.