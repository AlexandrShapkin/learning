# Спринт 05. JavaScript и TypeScript в браузере

Ориентировочный объём: 17–24 часа.

## Центральный вопрос

Как browser code manages values, asynchronous work and side effects, и какую часть ошибок TypeScript может обнаружить до запуска?

## Результат спринта

После завершения необходимо уметь:

- использовать modules, lexical scope and strict mode;
- различать primitive values, objects, references and mutation;
- применять arrays, maps, sets and immutable transformations;
- понимать closures and callback lifetime;
- использовать promises and `async/await`;
- различать synchronous exception, rejected promise, abort and domain error;
- понимать task/microtask ordering in practical scenarios;
- применять TypeScript unions, intersections, generics and narrowing;
- моделировать state as discriminated union;
- отличать compile-time type from runtime data;
- валидировать unknown JSON at runtime;
- использовать `unknown` instead of unsafe `any`;
- проектировать typed function/module boundaries;
- избегать implicit shared mutable state;
- тестировать pure logic separately from DOM/network effects;
- использовать source maps and debugger.

## Основной маршрут

### Шаг 1. Values and state

Trace reference sharing, shallow copies and mutation. Use immutable update where it clarifies state transitions; do not copy blindly without cost awareness.

### Шаг 2. Asynchrony

Build sequential, parallel and cancellable operations. Compare `Promise.all`, `allSettled`, race and bounded concurrency.

### Шаг 3. TypeScript model

Represent request/UI states:

```ts
type LoadState<T> =
  | { kind: "idle" }
  | { kind: "loading"; requestId: string }
  | { kind: "success"; data: T }
  | { kind: "empty" }
  | { kind: "error"; error: AppError };
```

### Шаг 4. Runtime validation

Treat `fetch().json()` as unknown. Validate shape, enum values, dates and numeric semantics before using it.

## Ресурсы

- MDN JavaScript Guide and Web APIs.
- ECMAScript modules/promises sections as reference.
- TypeScript Handbook.
- browser debugger/source-map documentation.

## Практические задания

1. Reproduce object aliasing and stale closure bugs.
2. Implement cancellable async search with request identity.
3. Create typed state machine for form submission.
4. Validate malformed API payloads at runtime.
5. Refactor side-effect-heavy code into pure functions and adapters.
6. Compare sequential, parallel and bounded request execution.

## Лабораторная работа

Создать `work/typed-browser-core/`.

### Components

- typed domain/view models;
- runtime decoders/validators;
- cancellable HTTP client;
- state reducer/state machine;
- pure formatting/filtering/sorting functions;
- DOM adapter;
- fake API and test suite.

### Requirements

- TypeScript strict mode;
- no unexplained `any` or non-null assertions;
- network payload enters as `unknown`;
- states are exhaustive and impossible combinations unrepresentable where practical;
- abort is not displayed as server error;
- stale responses cannot replace current state;
- time and money stay explicit types/representations;
- pure logic has deterministic unit tests;
- unhandled promise rejection fails tests/build checks;
- build emits source maps for local debugging only.

### Failure scenarios

1. Type assertion accepts malformed payload.
2. Closure reads stale selected item.
3. Shared object mutation changes unrelated component.
4. `Promise.all` failure cancels interpretation incorrectly.
5. Abort shown as red error notification.
6. Floating-point value used for money.
7. Date string assumed local/UTC without parsing contract.
8. Missing union case silently renders blank UI.
9. Event handler exception is swallowed.
10. Source map or build output exposes sensitive source/config unintentionally.

## Самопроверка

1. Primitive versus reference value?
2. Closure captures what?
3. Promise rejection versus thrown synchronous error?
4. Task versus microtask?
5. `unknown` versus `any`?
6. Compile-time type versus runtime validation?
7. What is discriminated union?
8. How exhaustive checking helps?
9. Why stale request identity matters?
10. What belongs in pure function versus adapter?

## Результат для базы знаний

- **JavaScript references, mutation and closures**.
- **Promises, async-await and cancellation**.
- **TypeScript narrowing and discriminated unions**.
- **Compile-time types versus runtime data**.
- **Runtime validation of API payloads**.
- **Typed UI state machines**.
- **Pure logic and side-effect adapters in frontend code**.

## Когда переходить дальше

Можно переходить, когда malformed runtime data is rejected, async cancellation/stale responses are correct, and UI states are represented exhaustively rather than by unrelated booleans.