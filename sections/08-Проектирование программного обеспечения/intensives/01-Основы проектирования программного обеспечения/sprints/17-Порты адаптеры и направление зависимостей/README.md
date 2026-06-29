# Спринт 17. Порты, адаптеры и направление зависимостей

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как сделать application core independently testable and replace delivery/infrastructure through explicit ports, сохраняя practical Go structure rather than diagram-driven abstraction?

## Результат спринта

После завершения необходимо уметь:

- понимать hexagonal/ports-and-adapters architecture;
- различать driving and driven ports;
- проектировать input/use-case ports and output ports;
- определять ports by application semantics;
- размещать interfaces near consumers;
- отделять adapter mapping and protocol concerns;
- создавать multiple driving adapters for same use case;
- заменять driven adapters without changing policy;
- понимать dependency rule and runtime control flow;
- избегать one interface per class/type;
- избегать domain “purity” that loses useful semantics;
- проектировать contract tests for driven adapters;
- управлять transactions crossing ports carefully;
- понимать where framework/library may remain inside adapter;
- сравнивать hexagonal and simple layered design;
- выявлять fake hexagonal architecture with inward folder names but outward dependencies.

## Основной маршрут

### Шаг 1. Port inventory

For selected use cases identify:

- driving actors: HTTP, CLI, scheduler, consumer;
- input ports/use cases;
- driven needs: repository, clock, ID, provider, publisher;
- semantic guarantees each port requires.

### Шаг 2. Adapter mapping

Create HTTP/CLI adapters translating inputs/results and PostgreSQL/provider adapters translating persistence/external models.

### Шаг 3. Dependency and transaction

Core owns semantic interfaces; composition root connects implementations. Database transaction may require application-level unit-of-work/transaction runner port without leaking SQL types.

### Шаг 4. Comparative experiment

Implement one small capability directly and one complex capability through ports. Reject ports that hide no volatility or testing/integration boundary.

## Ресурсы

- Alistair Cockburn’s Hexagonal Architecture writings.
- Clean/Onion architecture dependency-rule references.
- Go interface/package design guidance.
- Contract and application-layer materials from previous sprints.

## Практические задания

1. Expose one use case through HTTP and CLI adapters.
2. Replace PostgreSQL with in-memory adapter under shared contract tests.
3. Replace external provider adapter with sandbox implementation.
4. Introduce transaction runner without passing `*sql.Tx` into core.
5. Detect and remove one unjustified port/interface.
6. Draw source dependency and runtime control flow separately.

## Лабораторная работа

Создать `work/hexagonal-architecture/`.

### Required adapters

- HTTP and CLI driving adapters;
- PostgreSQL and in-memory repositories;
- local provider and fake provider;
- message/outbox adapter;
- real clock and deterministic clock;
- composition/bootstrap.

### Requirements

- core/use cases compile without HTTP/SQL/provider packages;
- input ports describe user/application intent, not transport verbs;
- output ports expose semantic operations and guarantees;
- adapter DTOs/rows do not enter core;
- all resources are wired in composition root;
- contract tests cover output-port implementations where guarantees overlap;
- fake does not claim stronger transaction/order behavior than real adapter;
- transaction scope remains explicit;
- forbidden-import architecture tests pass;
- simple capability may remain direct if port adds no value;
- change scenarios show adapter replacement without policy edits.

### Failure scenarios

1. Every internal type receives an interface “for cleanliness”.
2. Core imports adapter DTO or SQL transaction.
3. Port mirrors database CRUD/provider API exactly.
4. Input port returns HTTP status/response writer.
5. Adapter contains domain decisions to compensate for weak core model.
6. Transaction is split across repository calls with no atomic boundary.
7. In-memory adapter passes but ignores locking/uniqueness semantics.
8. Composition root becomes service locator.
9. Framework annotations/config leak through every layer.
10. Hexagonal design is applied to trivial script and multiplies work without change benefit.

## Самопроверка

1. Driving versus driven port?
2. Input versus output port?
3. Source dependency versus runtime flow?
4. Why ports use application semantics?
5. Where adapter mapping belongs?
6. How transaction crosses boundary?
7. Why interface near consumer?
8. Contract tests prove what?
9. How fake can mislead?
10. When not to use a port?

## Результат для базы знаний

- **Hexagonal architecture and ports/adapters**.
- **Driving and driven adapters**.
- **Input and output ports**.
- **Dependency direction versus runtime control flow**.
- **Semantic ports and adapter mapping**.
- **Transaction boundaries across ports**.
- **Contract tests for driven adapters**.
- **Over-abstraction in clean/hexagonal designs**.

## Когда переходить дальше

Можно переходить, когда multiple delivery/infrastructure adapters exercise the same application policy, forbidden dependencies are executable checks, and unnecessary ports have been consciously rejected.