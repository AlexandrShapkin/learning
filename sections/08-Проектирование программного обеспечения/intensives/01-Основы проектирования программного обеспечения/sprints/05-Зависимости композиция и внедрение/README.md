# Спринт 05. Зависимости, композиция и внедрение

Ориентировочный объём: 16–23 часа.

## Центральный вопрос

Как организовать dependencies so that policy remains stable while details can vary, and how to compose the application without hidden service locators or inheritance hierarchies?

## Результат спринта

После завершения необходимо уметь:

- различать source dependency, runtime call and data dependency;
- определять stable and volatile decisions;
- направлять compile-time dependencies toward owned policies;
- использовать constructor injection in Go;
- distinguish dependency injection from dependency-injection framework;
- создавать composition root;
- применять small consumer interfaces;
- избегать service locator and package globals;
- выбирать composition over inheritance/deep embedding;
- понимать delegation, embedding and substitutability in Go;
- проектировать optional dependencies without nil ambiguity;
- управлять lifecycle and ownership of shared resources;
- отделять configuration from runtime lookup;
- использовать fakes only at meaningful boundaries;
- обнаруживать dependency cycles and inversion theater;
- тестировать alternative composition and failure injection.

## Основной маршрут

### Шаг 1. Dependency map

For one user scenario draw:

```text
compile-time imports
runtime calls
data ownership and flow
resource lifecycle
configuration source
failure direction
```

Do not infer architecture from folder names alone.

### Шаг 2. Composition root

Move object/resource construction to `cmd/...` or dedicated bootstrap package. Core packages receive explicit dependencies through constructors.

### Шаг 3. Interface placement

Define interfaces near the consumer that needs variation. Keep concrete types when only one implementation exists and direct dependency is stable/appropriate.

### Шаг 4. Lifecycle

Composition owns database pools, HTTP clients, workers and shutdown ordering. Dependencies do not silently create unmanaged long-lived resources.

## Ресурсы

- Go interface and package design guidance.
- Dependency inversion and composition-root references.
- *A Philosophy of Software Design*, dependency and module discussions.
- *Clean Architecture* dependency rule as one perspective.

## Практические задания

1. Replace package global database/client with constructor dependency.
2. Create explicit composition root for CLI and HTTP variants.
3. Move interface from provider package to consumer package.
4. Replace type-switch/service locator with direct composition.
5. Compare embedding/inheritance-like design with explicit delegation.
6. Test shutdown order and dependency failure injection.

## Лабораторная работа

Создать `work/dependency-composition/`.

### Runtime variants

- in-memory command-line application;
- HTTP application with PostgreSQL;
- batch worker using the same application policies;
- fake notification provider for tests;
- real local provider adapter.

### Requirements

- composition root is the only place aware of most concrete adapters;
- application/domain packages do not import infrastructure bootstrap packages;
- dependencies are explicit constructor parameters;
- interfaces have minimal consumer-required methods;
- no package-level mutable singleton/service locator;
- resource ownership and close order are documented/tested;
- optional behavior uses explicit no-op/configuration, not accidental nil;
- application can start with alternate adapters without conditional logic spread through core;
- import graph has no cycles or neutral “interfaces” package created only to hide one;
- tests can inject controlled failure without mocking internal implementation details.

### Failure scenarios

1. Constructor has dozens of unrelated dependencies because component responsibility is mixed.
2. Interface exists for every concrete type with one implementation and no consumer need.
3. Dependency inversion adds an `interfaces` package imported by everyone.
4. Service locator hides runtime requirements.
5. Embedded implementation leaks methods and breaks substitution assumptions.
6. Adapter creates its own database/client and cannot be shut down centrally.
7. Optional dependency is nil and panics on rare path.
8. Tests replace too much and cannot detect integration contract mismatch.
9. Core package imports configuration/environment directly.
10. Composition root contains business decisions instead of wiring.

## Самопроверка

1. Source dependency versus runtime call?
2. What is composition root?
3. Dependency injection versus DI framework?
4. Why interface belongs near consumer?
5. When concrete dependency is simpler and correct?
6. Composition versus inheritance/embedding?
7. Why service locator harms reasoning?
8. Who owns dependency lifecycle?
9. What makes a fake meaningful?
10. What is inversion theater?

## Результат для базы знаний

- **Source, runtime and data dependencies**.
- **Composition root and explicit dependency wiring**.
- **Constructor injection in Go**.
- **Consumer-owned interfaces**.
- **Composition, delegation and embedding**.
- **Service locator and hidden dependency smell**.
- **Dependency lifecycle and resource ownership**.
- **Dependency inversion versus inversion theater**.

## Когда переходить дальше

Можно переходить, когда core policies run under multiple compositions, concrete resources are created and closed centrally, and no hidden global/service locator is required to understand a scenario.