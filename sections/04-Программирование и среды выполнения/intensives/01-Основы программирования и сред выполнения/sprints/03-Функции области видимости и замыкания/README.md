# Спринт 03. Функции, области видимости и замыкания

Ориентировочный объём: 11–16 часов.

## Центральный вопрос

Как разделить вычисление на именованные operations, управлять доступностью данных и понимать время жизни captured state?

## Результат спринта

После завершения необходимо уметь:

- проектировать function signature как контракт;
- различать parameters, arguments, results and local variables;
- объяснять value semantics и pointer parameters;
- использовать multiple returns и named results без скрытого поведения;
- понимать lexical scope, shadowing и package scope;
- создавать closures и объяснять captured variables;
- использовать functions as values, callbacks and higher-order functions;
- выбирать method или function;
- понимать receiver semantics and method sets на базовом уровне;
- применять recursion только при подходящей problem structure;
- отделять pure computation от I/O and global state;
- управлять dependencies через explicit parameters;
- распознавать closure lifecycle/loop capture mistakes;
- тестировать functions через boundary and invariant cases.

## Основной маршрут

### Шаг 1. Function contracts

Изучить Go spec/tour:

- function declarations/types;
- parameters and results;
- variadic functions;
- methods and receivers.

Для каждой function записывать preconditions, outputs, errors and side effects через code/tests, не formal template.

### Шаг 2. Scope and lifetime

Изучить lexical scope и short declaration shadowing. Использовать compiler/linter diagnostics и targeted tests.

### Шаг 3. Closures

Проверить:

- closure captures variable, not frozen textual value;
- returned closure can extend variable lifetime;
- loop variable semantics according to current Go version verified by tests;
- concurrent closure use may require synchronization.

### Шаг 4. Functional composition

Реализовать map/filter/reduce-like functions only as learning exercise. Compare explicit loops and generic helpers by clarity, allocations and error handling.

## Ресурсы

### Обязательный маршрут

- A Tour of Go: functions, methods, closures.
- Go specification: function types, declarations, scope.
- Effective Go: functions, methods, pointer/value receivers.

### Альтернативные объяснения

- SICP chapters on procedures and scope.
- *The Go Programming Language*, functions and methods.

### Углубление

- lambda calculus;
- continuations;
- currying/partial application;
- escape analysis of closures;
- tail calls;
- effect systems.

## Практические задания

### 1. Signature review

Даны functions with booleans, positional strings and multiple side effects. Redesign signatures using named types, options/config structs or separate functions. Prove behavior with tests.

### 2. Shadowing

Создать examples where `:=` shadows `err` or config value. Diagnose through debugger/print/tests, then refactor. Add static analysis where helpful.

### 3. Closures

Implement:

- counter closure;
- rate/sample generator with injected clock;
- middleware-style wrapper;
- callback registry;
- closure capturing loop variable;
- concurrent closure with intentional race for later observation.

### 4. Recursion

Implement tree traversal recursively and iteratively. Compare stack depth, error propagation and cancellation potential.

## Лабораторная работа

Создать `work/pipeline/` — generic transformation pipeline library and CLI.

### Pipeline stages

```text
Source → Decode → Validate → Transform → Filter → Sink
```

### Требования

- each stage represented by clear function type;
- stages composable without global registry;
- context/error flow explicit;
- injected clock and ID generator;
- reusable transformations through generics where justified;
- methods only where state/invariants belong to type;
- CLI assembles pipeline but library does not import CLI package;
- supports in-memory tests and file-backed integration;
- no hidden goroutines yet;
- tests for stage order, early failure, empty input and side effects;
- one example showing closure-created configurable transform.

### Failure scenarios

1. Stage returns error after partial output.
2. Closure retains large object unexpectedly.
3. Mutable config captured then changed.
4. Shadowed error suppresses failure.
5. Recursive traversal exceeds safe depth on synthetic input.
6. Callback invokes nil dependency.

## Дополнительный эксперимент

Use `go build -gcflags=-m` to observe which closures/variables escape. Record only relevant lines and revisit in sprint 11.

## Самопроверка

1. Что выражает function signature?
2. Как value and pointer parameters differ?
3. Что такое lexical scope?
4. Что такое shadowing?
5. Что closure captures?
6. Почему returned closure can extend lifetime?
7. Когда method is preferable to function?
8. Почему pure functions easier to test?
9. Какие risks у callbacks?
10. Когда recursion unsuitable?

Практическая проверка: по code snippet предсказать visible variables, captured state and side effects before execution.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Function as contract**.
- **Parameters and value semantics**.
- **Lexical scope and shadowing**.
- **Closure and captured variables**.
- **Higher-order functions and callbacks**.
- **Methods and receivers in Go**.
- **Pure and impure functions**.
- **Recursion and stack depth**.

## Когда переходить дальше

Можно переходить, когда pipeline stages independently tested, dependencies explicit, and closure/shadowing failures reproduced and explained.