# Спринт 11. Предметные сценарии и модели состояний

Ориентировочный объём: 17–24 часа.

## Центральный вопрос

Как выразить business process and allowed transitions так, чтобы сложные сценарии не распадались на неявные флаги, условные цепочки и временные соглашения между компонентами?

## Результат спринта

После завершения необходимо уметь:

- различать entity state, process state and UI/workflow state;
- строить explicit state transition table;
- определять events, commands, guards and effects;
- проектировать finite state machine where it improves clarity;
- понимать when state pattern is useful or excessive;
- избегать combinatorial boolean flags;
- различать valid transition and valid side effect;
- моделировать long-running process/saga at application level conceptually;
- хранить process progress and correlation identity;
- проектировать timeout, cancellation and compensation states;
- учитывать duplicate/reordered events;
- делать terminal and recoverable states explicit;
- отделять decision from effect execution;
- сохранять history/audit of important transitions;
- тестировать transition matrix and unreachable states;
- связывать state model with user/API contract.

## Основной маршрут

### Шаг 1. State inventory

For one work-order/fulfillment flow list all status/flags and identify contradictions. Replace unrelated booleans with one or more independent explicit state machines.

### Шаг 2. Transition table

Define:

```text
current state
command/event
preconditions/guard
next state
emitted fact
effects requested
error/terminal behavior
```

### Шаг 3. Decision/effect split

Pure transition decides new state and requested effects. Application layer executes persistence, external calls and retries.

### Шаг 4. Long-running process

Model one process coordinating inventory, billing and fulfillment. Persist process state and handle duplicate, timeout and compensation without claiming one distributed transaction.

## Ресурсы

- State pattern and state-machine references.
- DDD process manager/saga material.
- Enterprise Integration Patterns process/message concepts.
- Transactional outbox and idempotency material from previous intensives.

## Практические задания

1. Replace three booleans with explicit state model.
2. Write transition matrix and generate table-driven tests.
3. Separate state decision from notification/provider effect.
4. Model cancellation before and after irreversible step.
5. Handle duplicate/out-of-order event in process manager.
6. Map domain states to API/UI states without one-to-one leakage.

## Лабораторная работа

Создать `work/domain-workflows/`.

### Workflows

- work-order approval and fulfillment;
- attachment processing;
- settlement/invoice placeholder;
- cancellation and compensation;
- timeout/manual-review path.

### Requirements

- state spaces and independent dimensions are explicit;
- impossible combinations cannot be constructed through normal APIs;
- transition guards live with decision model;
- effects are returned/requested, not executed inside pure transition;
- process state is durable and versioned;
- event IDs/versions handle duplicates and stale ordering;
- terminal, retryable and manual-intervention states differ;
- cancellation semantics depend on current irreversible effects;
- history records actor/command/from/to/result;
- table/property tests cover every allowed/forbidden transition;
- API/UI mapping is explicit and may aggregate internal states safely.

### Failure scenarios

1. `isPaid`, `isCanceled`, `isShipped`, `isFailed` permit contradictions.
2. Status string is changed directly from multiple packages.
3. State object class/type explosion adds indirection for a simple enum.
4. Pure model sends emails or calls provider.
5. Process resumes after crash without correlation/version and repeats effect.
6. Older event regresses state.
7. Compensation is described as rollback although external effect is irreversible.
8. Timeout is treated as definite failure.
9. UI status exposes internal transition implementation and blocks evolution.
10. Transition history lacks failed/denied attempts needed for audit.

## Самопроверка

1. Entity state versus process state?
2. Why booleans create combinatorial states?
3. Command, event, guard and effect?
4. State pattern versus simple transition table?
5. Why separate decision and effect?
6. Saga/process manager means what?
7. Compensation versus rollback?
8. How duplicate/reordered events affect workflow?
9. Terminal versus manual/retry state?
10. Why API/UI state may differ from internal state?

## Результат для базы знаний

- **Explicit domain state machines**.
- **Commands, events, guards and effects**.
- **Boolean-state explosion**.
- **Decision and side-effect separation**.
- **Process manager and long-running workflow**.
- **Timeout, cancellation and compensation states**.
- **Transition history and table-driven tests**.
- **Internal, API and UI state mapping**.

## Когда переходить дальше

Можно переходить, когда every important transition is enumerable/tested, crash/duplicate/timeout paths have durable states, and external effects are not hidden inside pure domain decisions.