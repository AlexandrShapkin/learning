# Спринт 04. Инкапсуляция, контракты и абстракции

Ориентировочный объём: 16–23 часа.

## Центральный вопрос

Как скрыть изменяемые решения behind a small contract without leaking representation, policy or lifecycle details to every caller?

## Результат спринта

После завершения необходимо уметь:

- понимать information hiding as design goal;
- различать data hiding and decision hiding;
- проектировать contract from consumer needs;
- определять preconditions, postconditions and failure semantics;
- выбирать stable external representation;
- не раскрывать mutable internal collections/state;
- использовать constructors and methods to preserve invariants;
- различать abstraction and indirection;
- выявлять leaky abstraction;
- понимать temporal coupling and lifecycle contracts;
- проектировать API around capability, not storage mechanics;
- использовать errors and results as part of contract;
- поддерживать substitutability only where alternatives truly exist;
- избегать speculative generalized interfaces;
- оценивать abstraction through replacement and change scenarios;
- документировать unavoidable limitations honestly.

## Основной маршрут

### Шаг 1. Leaked decisions

Найти callers, которые знают:

- SQL/table layout;
- status representation;
- cache/storage lifecycle;
- retry timing;
- internal collection/map ownership;
- external provider field names.

Classify whether knowledge belongs to caller or should be hidden.

### Шаг 2. Consumer contract

For one capability define:

```text
operation and intent
inputs and valid states
result and failure categories
atomicity/idempotency expectations
ownership and lifecycle
performance/ordering limits
compatibility commitments
```

### Шаг 3. Encapsulation refactor

Replace public mutable structures and multi-step protocols with a capability that preserves invariant. Example: `ReserveInventory` instead of `GetStock` + calculate + `SetStock`.

### Шаг 4. Abstraction test

Swap one persistence/external adapter or change one representation. Measure which callers change. If every caller changes, the abstraction leaks or hides the wrong decision.

## Ресурсы

- *A Philosophy of Software Design*, modules, information hiding and leakage.
- *Designing Data-Intensive Applications*, abstraction/contract examples as secondary context.
- Go API/interface/package design guidance.
- *Refactoring*, encapsulate collection/record and replace primitive patterns.

## Практические задания

1. Encapsulate mutable collection and prevent external invariant bypass.
2. Replace multi-call temporal protocol with one operation.
3. Redesign repository/API that exposes SQL/storage concepts.
4. Create consumer-oriented interface for an external provider.
5. Test replacement of in-memory and PostgreSQL adapters.
6. Document one intentionally leaky abstraction and its boundary.

## Лабораторная работа

Создать `work/contracts-abstractions/`.

### Capabilities

- work-order state transition;
- inventory reservation;
- attachment storage;
- notification dispatch;
- pricing policy;
- clock/identity generation.

### Requirements

- each capability has explicit input/result/error contract;
- callers cannot mutate owned state directly;
- multi-step operations that must be atomic are not exposed as separate public calls;
- storage/provider data types do not enter domain/application contracts;
- interfaces are defined by consumers and remain small;
- at least one concrete implementation is replaced with limited caller changes;
- zero value and nil behavior are explicit;
- ownership of returned slices/maps/readers is documented/tested;
- temporal/lifecycle constraints are encoded or surfaced;
- contract tests verify implementations where meaningful;
- no abstraction is added only to “future-proof” an unknown variation.

### Failure scenarios

1. Getter returns internal slice/map and caller mutates it.
2. Interface mirrors a concrete implementation method-for-method.
3. Repository exposes table/transaction mechanics to business code.
4. One operation requires callers to invoke methods in undocumented order.
5. Abstraction hides errors or consistency limitations.
6. Generic interface uses `any` and loses semantic guarantees.
7. Adapter returns provider DTO directly.
8. In-memory fake has stronger guarantees than real implementation.
9. Contract promises atomicity the implementation cannot provide.
10. Extra layer adds indirection but hides no decision.

## Самопроверка

1. Information hiding hides what?
2. Data hiding versus decision hiding?
3. Contract includes which non-type semantics?
4. What is temporal coupling?
5. What makes an abstraction leaky?
6. Abstraction versus indirection?
7. Why define interface from consumer side?
8. Why repository should not expose storage mechanics?
9. How replacement scenario tests abstraction?
10. When leakage should be documented rather than hidden?

## Результат для базы знаний

- **Information hiding and encapsulation**.
- **Consumer-oriented software contracts**.
- **Decision hiding versus data hiding**.
- **Temporal coupling and lifecycle contracts**.
- **Leaky abstractions and honest limitations**.
- **Capability-oriented APIs**.
- **Contract tests and implementation substitutability**.
- **Abstraction versus unnecessary indirection**.

## Когда переходить дальше

Можно переходить, когда at least one major representation/provider changes behind a stable consumer contract and callers can no longer bypass the protected invariant or lifecycle.