# Спринт 03. Функции, типы, пакеты и смысловая цельность

Ориентировочный объём: 16–23 часа.

## Центральный вопрос

Как определить размер и границы функции, типа and package so that each has one coherent reason to change without fragmenting the system into meaningless pieces?

## Результат спринта

После завершения необходимо уметь:

- различать cohesion and accidental proximity;
- находить mixed levels of abstraction;
- проектировать function around one intention and result;
- разделять calculation and effect where useful;
- понимать command-query separation;
- выбирать data-oriented and behavior-oriented types;
- определять package responsibility and public surface;
- скрывать implementation details through unexported names;
- проектировать package around capability/domain, not technical layer alone;
- избегать utility/helper/common dumping grounds;
- обнаруживать cyclic conceptual dependencies before import cycle;
- использовать internal packages and module boundaries deliberately;
- различать stable abstraction and premature micro-package;
- оценивать cohesion through change scenarios;
- использовать tests as consumer of package contract, not internal structure mirror.

## Основной маршрут

### Шаг 1. Function responsibilities

Select three long/mixed functions and label statements by intention:

```text
parse/normalize
load state
make decision
mutate state
persist
emit/log/notify
map response
```

Extract only where a new name creates a meaningful concept or isolates a volatile/effectful step.

### Шаг 2. Types and invariants

Move behavior to the type that owns required state when it protects an invariant. Keep orchestration in application flow. Avoid both “all logic in services” and artificial method-heavy objects.

### Шаг 3. Package boundaries

Map package responsibilities, exported identifiers and import graph. For each package answer:

- what capability/concept it owns;
- what changes should stay inside;
- which consumers need it;
- which details must remain hidden.

### Шаг 4. Cohesion experiment

Implement two future changes and compare candidate package structures. Choose the structure that keeps conceptually related changes together without creating broad dependencies.

## Ресурсы

- Structured Design cohesion/coupling concepts.
- Go package design guidance and standard library package examples.
- *A Philosophy of Software Design*, deep modules.
- *Refactoring*, extract function/class/module refactorings.

## Практические задания

1. Split one mixed-level function by intention, not line count.
2. Convert a getter/setter data bag into a type protecting one invariant.
3. Replace a `utils` package by concept-owned functions or standard library use.
4. Minimize exported surface of one package.
5. Build import and exported-API reports.
6. Compare package-by-layer and package-by-capability for two changes.

## Лабораторная работа

Создать `work/cohesive-modules/`.

### Target structure experiment

Create two branches or variants:

```text
variant-layered/
├── handlers/
├── services/
├── repositories/
└── models/

variant-capability/
├── workorders/
├── inventory/
├── billing/
└── notifications/
```

The goal is not to declare one universally correct. Apply the same four changes and measure locality, exported API and dependencies.

### Requirements

- every exported package/type/function has a consumer-facing purpose;
- packages do not exist solely to satisfy a diagram;
- one package owns each selected invariant;
- pure calculations are testable without I/O;
- effects remain explicit in orchestration;
- no `common`, `misc`, `helpers` or circular re-export package;
- package tests use public behavior where appropriate;
- import graph and change-impact report are reproducible;
- selected structure is justified by observed changes;
- rejected structure and contexts where it might be better are documented.

### Failure scenarios

1. Every five lines become a function and reading requires excessive jumping.
2. Functions stay long because “single responsibility” is interpreted as one business feature.
3. Package name reflects implementation technology rather than owned concept.
4. All model types are shared globally and couple every module.
5. `utils` becomes dependency hub.
6. Interface/types package exists only to break import cycle.
7. Exported fields allow bypassing invariants.
8. Layered variant requires changes across every layer for each concept.
9. Capability variant duplicates genuinely shared stable policy inconsistently.
10. Package count/line count is used as final evidence.

## Самопроверка

1. Cohesion means what?
2. One intention versus one line-level action?
3. Mixed abstraction levels?
4. Command-query separation?
5. When behavior belongs on a type?
6. Package by layer versus capability?
7. What makes a deep module?
8. Why exported surface matters?
9. Why utility packages become coupling hubs?
10. How change scenarios test cohesion?

## Результат для базы знаний

- **Cohesion of functions, types and modules**.
- **Mixed abstraction levels and intention-revealing functions**.
- **Calculation versus side effect**.
- **Command-query separation**.
- **Go package responsibility and exported surface**.
- **Package-by-layer and package-by-capability trade-offs**.
- **Deep modules and information hiding**.
- **Utility package as dependency smell**.

## Когда переходить дальше

Можно переходить, когда package/function boundaries are justified by concrete changes, one invariant has a clear owner, and exported API/import graph are smaller and more intentional.