# Спринт 05. Ошибки, panic и управление ресурсами

Ориентировочный объём: 12–18 часов.

## Центральный вопрос

Как сообщать о failure, сохранять causal context, освобождать resources и определять границу, где программа может продолжить работу?

## Результат спринта

После завершения необходимо уметь:

- distinguish expected error, invalid input, invariant violation, panic and process crash;
- return and propagate errors idiomatically;
- wrap errors with `%w` and inspect through `errors.Is/As`;
- design sentinel, typed and opaque errors;
- preserve operation/path/identifier context without duplicate logs;
- choose where error is handled, transformed, retried or reported;
- use `defer` with predictable order and captured arguments;
- close files/sockets/rows safely on all paths;
- understand panic stack unwinding and recover boundary;
- avoid recover as universal error handling;
- aggregate multiple cleanup errors where relevant;
- distinguish retryable and permanent errors cautiously;
- prevent partial state corruption through transactional ordering;
- test failure paths and cleanup, not only success.

## Основной маршрут

### Шаг 1. Error values

Изучить Effective Go and standard `errors` package:

- errors as values;
- wrapping;
- `Is`, `As`, `Unwrap`, `Join`;
- API compatibility implications.

### Шаг 2. Context and boundaries

Build chain:

```text
low-level cause → operation context → domain classification
→ boundary formatting/logging → exit/status response
```

Avoid logging same error at every layer.

### Шаг 3. Defer and resource cleanup

Test argument evaluation, LIFO order, named returns and cleanup errors. Use `io.Closer` examples.

### Шаг 4. Panic/recover

Use panic for programmer/runtime invariant failures, not routine invalid input. Recovery is appropriate only at deliberate boundary that can isolate failed work and restore known state.

## Ресурсы

### Обязательный маршрут

- Go blog: Error handling and defer/panic/recover.
- `errors`, `fmt`, `runtime/debug` package docs.
- Effective Go: errors and panic.
- Standard library examples (`os.PathError`, `net.OpError`).

### Альтернативные объяснения

- Rust `Result`/panic comparison.
- Java exceptions and checked/unchecked comparison.
- Python exception chaining comparison.

### Углубление

- algebraic effect/error systems;
- transactional resource management;
- retry budgets;
- structured logging and error telemetry;
- exception safety guarantees.

## Практические задания

### 1. Error chain

Create layered file parser and preserve operation, path, line and domain cause. Verify `errors.Is` for underlying sentinel and `errors.As` for typed context.

### 2. Cleanup ordering

Write tests with fake closers that fail. Decide how primary operation error and cleanup errors are represented. Prove all resources close exactly once.

### 3. Panic boundary

Run worker function that may panic. Recover at top of isolated job, capture stack, mark job failed and continue only if shared state remains valid. Compare with panic in main goroutine.

### 4. Partial state

Implement file replacement via temporary file, fsync considerations overview and rename. Inject failures at write/close/rename and verify original remains intact where promised.

## Лабораторная работа

Создать `work/safetransform/` — transactional file transformation CLI.

```text
safetransform --input IN --output OUT --format jsonl --max-errors N
```

### Requirements

- reads and validates records;
- writes temporary output then atomically replaces target where filesystem semantics permit;
- preserves original output on failed transform;
- wraps errors with operation/path/record context;
- distinguishes usage, input, validation, output and internal failure exit codes;
- closes all files on every path;
- handles broken pipe;
- supports cancellation through signal later, but current structure must allow it;
- panic recovery only at process boundary to print stack in debug mode and fail;
- tests use fault-injecting Reader/Writer/Closer/FileOps;
- no duplicated logging in library layers.

### Failure scenarios

1. Input open/read error.
2. Malformed record.
3. Output disk-full simulation through writer.
4. Close/fsync error.
5. Rename target conflict.
6. Panic inside transformation.
7. Cleanup error after primary error.
8. Error wrapped incorrectly, breaking `errors.Is`.

## Дополнительный эксперимент

Implement same operation with Rust `Result` and Python exceptions on a small scale. Compare explicit propagation, stack context and cleanup constructs.

## Самопроверка

1. When should function return error?
2. What does wrapping with `%w` preserve?
3. How do `errors.Is` and direct equality differ?
4. Typed versus sentinel error trade-offs?
5. When are defer arguments evaluated?
6. What order do deferred calls run?
7. What does panic unwind?
8. When can recover be safe?
9. Why logging at every layer is harmful?
10. How to preserve original file on partial failure?
11. How to test cleanup errors?

Практическая проверка: given nested error output and code, reconstruct causal chain and identify correct handling boundary.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Errors as values in Go**.
- **Error wrapping and causal chain**.
- **Sentinel and typed errors**.
- **Error handling boundary**.
- **defer and resource cleanup**.
- **panic, recover and stack unwinding**.
- **Partial failure and transactional file update**.
- **Retryable versus permanent error**.

## Когда переходить дальше

Можно переходить, когда all injected failures preserve stated invariants, resources close exactly once, and error chain remains machine-inspectable and human-readable.