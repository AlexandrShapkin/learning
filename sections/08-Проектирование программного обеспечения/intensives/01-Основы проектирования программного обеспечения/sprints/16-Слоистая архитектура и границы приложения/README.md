# Спринт 16. Слоистая архитектура и границы приложения

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Как разделить presentation, application, domain and infrastructure responsibilities without turning layers into pass-through bureaucracy or allowing policy to depend on delivery/storage details?

## Результат спринта

После завершения необходимо уметь:

- различать logical layer and deployment unit;
- определять presentation, application, domain and infrastructure responsibilities;
- проектировать allowed dependency direction;
- понимать strict and relaxed layering;
- избегать layer skipping that leaks internals;
- избегать pass-through service/repository chains;
- размещать transaction and authorization coordination intentionally;
- отделять input/output models from domain model;
- различать application workflow and business policy;
- использовать package boundaries to enforce layers;
- понимать shared horizontal concerns and middleware limits;
- проектировать exception for performance-critical read path;
- тестировать dependency rules;
- оценивать layered architecture through change scenarios;
- понимать when simple application needs fewer layers;
- предотвращать circular dependencies between layers.

## Основной маршрут

### Шаг 1. Responsibility map

For representative use case classify code:

```text
presentation: protocol parsing and response mapping
application: orchestration, transaction, authorization coordination
domain: invariant and decision
infrastructure: SQL, network, filesystem, broker
```

### Шаг 2. Dependency rules

Create package/import rule. Domain must not import presentation/infrastructure. Application may depend on domain and consumer-side ports. Infrastructure implements adapters.

### Шаг 3. Read and command paths

Compare rich command path with simple query path. A tailored read adapter may bypass domain model while preserving authorization and contract.

### Шаг 4. Proportionality

Build minimal two-layer variant for a simple capability and four-layer variant for complex scenario. Compare ceremony and change locality.

## Ресурсы

- *Patterns of Enterprise Application Architecture*.
- Layered architecture references.
- Go package/module design docs.
- Application-boundary material from previous intensive.

## Практические задания

1. Classify mixed handler/service/repository code by responsibility.
2. Create package dependency rules and failing architecture test.
3. Move domain policy out of infrastructure/presentation.
4. Implement query-specific read path without fake domain hydration.
5. Remove one pass-through layer.
6. Compare strict and relaxed layer dependency for one scenario.

## Лабораторная работа

Создать `work/layered-architecture/`.

### Target structure

```text
internal/
├── domain/
├── application/
├── adapters/
│   ├── http/
│   ├── postgres/
│   └── messaging/
└── bootstrap/
```

### Requirements

- responsibilities and allowed imports documented;
- architecture test checks forbidden imports;
- domain model has no transport/storage/provider dependency;
- application layer owns use-case transaction/orchestration;
- presentation maps protocol models/errors;
- infrastructure maps database/provider representations;
- query path is proportionate and does not duplicate business authorization;
- no service/repository method chain that only forwards unchanged arguments;
- cross-cutting logging/metrics do not contain business policy;
- simple capability is not forced through unnecessary layers;
- at least four change scenarios compare before/after locality.

### Failure scenarios

1. Folder names imply layers but imports point in every direction.
2. Domain imports SQL/HTTP/framework annotations.
3. Application service merely forwards to repository.
4. Handler performs business rule and transaction.
5. Repository performs user authorization/presentation formatting.
6. Strict layering forces inefficient/read-hostile object reconstruction.
7. Relaxed layering becomes arbitrary layer skipping.
8. Shared `common` layer is imported by all and owns mixed concerns.
9. Middleware hides business state transition.
10. Every simple CRUD endpoint receives four empty abstraction layers.

## Самопроверка

1. Logical layer versus deployment unit?
2. Presentation/application/domain/infrastructure responsibilities?
3. Strict versus relaxed layering?
4. Where transaction coordination belongs?
5. Why DTO/domain separation matters?
6. When query can bypass domain model?
7. What is pass-through layer smell?
8. How package rules enforce architecture?
9. Cross-cutting concern versus business policy?
10. When fewer layers are better?

## Результат для базы знаний

- **Layered software architecture**.
- **Presentation, application, domain and infrastructure responsibilities**.
- **Strict and relaxed layer dependencies**.
- **Command and query paths in layered systems**.
- **Pass-through layers and proportional architecture**.
- **Architecture dependency tests for packages**.

## Когда переходить дальше

Можно переходить, когда package dependencies match stated responsibilities, business policy remains independent from delivery/storage, and simple/read-heavy paths avoid empty layer ceremony.