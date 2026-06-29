# Спринт 13. Шаблоны проектирования и условия применимости

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как использовать named design patterns to communicate recurring forces and consequences without forcing object-oriented templates onto idiomatic Go code?

## Результат спринта

После завершения необходимо уметь:

- понимать pattern as context, problem, forces, solution and consequences;
- отличать pattern from code snippet and framework feature;
- выбирать simple language construct before named pattern;
- адаптировать creational patterns to Go constructors/options;
- использовать adapter, facade, decorator and proxy deliberately;
- применять strategy, command, observer and state when variation requires them;
- понимать template method and inheritance limitations in Go;
- использовать iterator/pipeline patterns idiomatically;
- различать mediator/event bus and hidden global coupling;
- понимать composite and visitor trade-offs;
- распознавать singleton, service locator and god-object anti-patterns;
- оценивать pattern by added variation/coupling/testability;
- удалять pattern after pressure disappears;
- сравнивать functional composition with object pattern;
- документировать consequences and alternatives;
- избегать pattern catalog as architecture.

## Основной маршрут

### Шаг 1. Pattern anatomy

For each selected pattern write:

```text
context/problem
forces and variants
minimal Go mechanism
consequences and failure modes
simpler alternative
removal/extension signal
```

### Шаг 2. Creational and structural

Implement:

- constructor + functional options;
- adapter for provider API;
- decorator for metrics/retry with contract awareness;
- facade over multi-step subsystem;
- composite only where recursive uniform structure exists.

### Шаг 3. Behavioral

Implement strategy, command and state variants. Compare closures/functions, interfaces and explicit switch/table approaches.

### Шаг 4. Pattern removal

Take one overengineered design and simplify it after variants disappear or become stable.

## Ресурсы

- *Design Patterns*, Gang of Four.
- *Head First Design Patterns* as secondary practical material.
- *Refactoring to Patterns*.
- Go standard library examples of adapter/decorator/strategy-like structures.

## Практические задания

1. Implement one pattern with interfaces and one with functions; compare.
2. Replace provider-specific code using Adapter.
3. Add metrics/logging decorator without changing core policy.
4. Compare Strategy with switch/table for three variants.
5. Model state transitions with enum/table and State pattern; select one.
6. Remove Singleton/service locator from one path.
7. Delete an unnecessary factory/visitor/mediator and measure simplification.

## Лабораторная работа

Создать `work/pattern-forces/`.

### Cases

- notification/pricing strategies;
- external provider adapters;
- command execution and undo/compensation metadata;
- metrics/retry decorators;
- attachment tree or rule composite;
- state transition implementation;
- event subscriber registry;
- object construction with required/optional configuration.

### Requirements

- at least eight patterns are analyzed, but only justified ones remain;
- every remaining pattern has two or more real forces/variants;
- simple alternatives are implemented for comparison;
- decorators preserve error/cancellation/idempotency semantics;
- adapters translate semantics, not only names;
- observer/event callbacks have lifecycle, ordering and failure policy;
- no hidden global registry/service locator;
- pattern names appear in docs only where they aid communication;
- tests verify consequences and substitutability;
- final report includes patterns rejected/removed.

### Failure scenarios

1. Factory exists only to call one constructor.
2. Builder allows invalid partial object states.
3. Decorator retries unsafe command and duplicates effect.
4. Adapter forwards provider DTO unchanged.
5. Strategy interface has one implementation and no expected variation.
6. Observer errors/order/lifecycle are ignored.
7. Mediator/event bus hides all dependencies.
8. State pattern creates type explosion for simple table.
9. Composite is used for non-recursive data.
10. Singleton becomes global mutable service locator.
11. Pattern catalog determines architecture before requirements.

## Самопроверка

1. Pattern includes which parts beyond solution?
2. Pattern versus language feature?
3. Adapter versus facade?
4. Decorator versus proxy?
5. Strategy versus simple function/switch?
6. Command pattern useful when?
7. Observer lifecycle/failure questions?
8. State pattern versus state machine table?
9. Why singleton/service locator is risky?
10. When should pattern be removed?

## Результат для базы знаний

- **Design pattern context, forces and consequences**.
- **Creational patterns in Go**.
- **Adapter, facade, decorator and proxy**.
- **Strategy, command, observer and state**.
- **Functional composition versus object patterns**.
- **Pattern overuse and pattern removal**.
- **Singleton, service locator and hidden coupling**.

## Когда переходить дальше

Можно переходить, когда patterns are selected through demonstrated forces, simpler Go alternatives are compared, and at least one unnecessary pattern has been removed without loss of behavior.