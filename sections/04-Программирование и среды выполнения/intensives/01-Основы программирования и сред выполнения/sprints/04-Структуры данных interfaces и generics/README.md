# Спринт 04. Структуры данных, interfaces и generics

Ориентировочный объём: 14–19 часов.

## Центральный вопрос

Как представить state and behavior так, чтобы invalid states were limited, code remained reusable, а runtime costs and aliasing были понятны?

## Результат спринта

После завершения необходимо уметь:

- различать arrays, slices, maps, structs, pointers and interfaces;
- объяснять slice header, length, capacity, append and backing array;
- понимать map semantics, zero value, missing key and iteration nondeterminism;
- проектировать structs around invariants;
- использовать composition/embedding без imitation inheritance;
- понимать interface satisfaction, method sets, typed nil problem;
- выбирать concrete type versus interface at consumer boundary;
- использовать type assertions и type switches safely;
- применять generics for type-safe reusable algorithms/data structures;
- понимать constraints and underlying type sets at practical level;
- distinguish compile-time polymorphism from interface dispatch conceptually;
- понимать aliasing and copy semantics;
- выбирать representation based on correctness before micro-optimization;
- создавать stable public API with minimal surface.

## Основной маршрут

### Шаг 1. Arrays, slices and maps

Изучить Go spec/tour и official slice article. Практически исследовать:

- nil versus empty slice/map;
- append within/beyond capacity;
- sub-slice retaining backing array;
- copy and aliasing;
- map lookup `value, ok`;
- concurrent map access limitations.

### Шаг 2. Structs and invariants

Use constructors/factories only where zero value is not valid/useful. Prefer useful zero values when possible.

### Шаг 3. Interfaces

Изучить:

- implicit implementation;
- small consumer-defined interfaces;
- method sets and pointer receivers;
- nil interface versus interface containing typed nil;
- `errors` and `io` packages as examples.

### Шаг 4. Generics

Изучить type parameters and constraints through current Go spec/tutorial. Implement narrow use cases and compare with interfaces/code generation/duplication.

## Ресурсы

### Обязательный маршрут

- Go Tour: arrays, slices, maps, methods, interfaces, generics.
- Go spec relevant sections.
- Go blog: slices internals and interface guidance.
- Effective Go: data, embedding, interfaces.

### Альтернативные объяснения

- *The Go Programming Language*, composite types/interfaces.
- Rust enums/traits or Java generics as comparison.

### Углубление

- interface representation;
- escape/devirtualization;
- persistent data structures;
- sum types;
- covariance/contravariance;
- generics implementation strategies.

## Практические задания

### 1. Slice laboratory

Predict and test len/cap/address/content across append, reslice, copy and function calls. Include a memory-retention example fixed by copying small sub-slice.

### 2. Typed nil

Create error/interface returning typed nil pointer, show non-nil interface and fix API. Add regression test.

### 3. Representation design

Model state machine with status enum and transitions. Ensure callers cannot create invalid transition without receiving error.

### 4. Generic utilities

Implement and benchmark simple generic `Set[T comparable]`, `MapSlice`, `Filter` and bounded queue. Explain where generics improve API and where explicit loop remains clearer.

## Лабораторная работа

Создать `work/typedstore/` — in-memory typed record store.

### Domain

```text
RecordID, Version, Record, Query, UpdateResult
```

### Requirements

- map-backed storage hidden behind concrete type;
- optimistic version check;
- generic repository only if it does not erase domain constraints;
- query predicates/composition;
- snapshots returned without exposing mutable internal backing data;
- interfaces defined by consumer packages;
- typed errors for not found/conflict/validation;
- deterministic listing order;
- zero value behavior documented/tested;
- concurrency not required until sprint 16;
- property tests or randomized invariant checks for insert/update/delete;
- benchmark optional.

### Failure scenarios

1. Caller mutates returned slice/map and corrupts store.
2. Typed nil error.
3. Missing map key mistaken for zero value.
4. Append modifies shared backing array.
5. Interface too broad and hard to fake/test.
6. Generic abstraction permits invalid domain combination.
7. Map iteration makes output flaky.

## Дополнительный эксперимент

Inspect compiler output/benchmarks for interface versus generic/concrete call in a small hot loop. Do not generalize from microbenchmark without real workload.

## Самопроверка

1. Чем array отличается от slice?
2. Что хранит slice descriptor?
3. Когда append reallocates?
4. Как nil and empty slice differ?
5. Как безопасно distinguish missing map key?
6. Что interface value conceptually contains?
7. Почему typed nil problematic?
8. Где interface should be defined?
9. Когда generics preferable?
10. Что такое aliasing?
11. Почему useful zero value desirable?

Практическая проверка: review unfamiliar API and identify aliasing, nil and abstraction risks before writing tests.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Array and slice in Go**.
- **Slice capacity, append and aliasing**.
- **Map semantics**.
- **Struct and invariant**.
- **Composition and embedding**.
- **Go interface and method set**.
- **Nil interface and typed nil**.
- **Generics and constraints in Go**.
- **Concrete types versus interfaces**.

## Когда переходить дальше

Можно переходить, когда store prevents external mutation, typed nil is understood, and interfaces/generics are justified by consumer behavior rather than abstraction habit.