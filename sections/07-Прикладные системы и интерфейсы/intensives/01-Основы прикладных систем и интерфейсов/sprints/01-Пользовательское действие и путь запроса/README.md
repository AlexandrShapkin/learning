# Спринт 01. Пользовательское действие и путь запроса

Ориентировочный объём: 13–19 часов.

## Центральный вопрос

Как одно пользовательское намерение превращается в последовательность interface events, network calls, server decisions, data changes and visible feedback?

## Результат спринта

После завершения необходимо уметь:

- определять actor, goal, preconditions and success criteria;
- разделять user journey, use case and technical request;
- строить sequence/data-flow diagram;
- различать browser, CLI, mobile and automation interfaces;
- выделять client, server, storage and external boundaries;
- определять synchronous and asynchronous steps;
- описывать loading, success, empty, error and retry states;
- задавать correlation and idempotency identifiers;
- различать system state, UI state and derived view;
- находить trust boundaries and authorization decisions;
- определять observable checkpoints;
- связывать business outcome with technical response;
- учитывать cancellation, timeout and duplicate action;
- создавать synthetic scenario fixtures;
- избегать premature decomposition into services/frameworks.

## Основной маршрут

### Шаг 1. User journey

Для каждого сценария записать:

```text
actor and intent
initial state
user actions
system decisions
visible feedback
persistent changes
external effects
failure/cancellation paths
```

### Шаг 2. Request path

Проследить путь:

```text
input event → client validation/state → HTTP request
→ routing/auth/validation → application use case
→ database/external dependency → response/event
→ client state/rendering → user confirmation
```

### Шаг 3. Boundaries

Отметить, где проверяются authentication, authorization, business invariants, serialization and retries. UI validation improves feedback but does not replace server/domain checks.

### Шаг 4. Observability

Определить request ID, user/tenant context, operation name, result category and timing segments without logging secrets or full payloads.

## Ресурсы

- MDN overview of browser/network request lifecycle.
- HTTP semantics from network intensive.
- UML sequence/data-flow diagram references.
- User-story/use-case material as lightweight notation.
- OpenTelemetry trace model overview.

## Практические задания

1. Model sign-in, product search, order creation and file upload journeys.
2. Compare browser and CLI interface for the same operation.
3. Add cancellation and duplicate-click behavior.
4. Identify every trust and transaction boundary.
5. Design minimal trace spans and audit events.

## Лабораторная работа

Создать `work/request-path/`.

### Scenario

Synthetic multi-tenant task/order application with:

- anonymous landing/search;
- authenticated item creation;
- file attachment;
- background processing;
- external webhook;
- status update in browser.

### Components

- journey definitions;
- sequence diagrams;
- minimal static client;
- Go stub server;
- in-memory repository;
- fake external dependency;
- structured event/trace log;
- scenario verifier.

### Requirements

- each action has explicit user-visible states;
- request and operation IDs propagate across components;
- repeated submit has defined behavior;
- cancellation semantics are stated;
- authorization decision location is marked;
- background completion is distinguishable from request acceptance;
- no framework-specific architecture is required yet;
- diagrams match observed trace output.

### Failure scenarios

1. Double-click creates two operations.
2. Client reports success before durable server result.
3. Timeout outcome is treated as definite failure.
4. Authorization only exists in UI.
5. Background task failure is invisible.
6. Request ID changes at every boundary.
7. External side effect occurs before source transaction commits.
8. Error message loses operation context.
9. UI state diverges after browser reload.

## Самопроверка

1. User journey versus HTTP request?
2. UI state versus persisted state?
3. Where business invariant belongs?
4. Why client validation is insufficient?
5. Synchronous versus accepted asynchronous result?
6. What makes duplicate action safe?
7. What does cancellation guarantee?
8. Where are trust boundaries?
9. Which identifiers correlate the path?
10. Which evidence proves the visible result?

## Результат для базы знаний

- **User journey, use case and request path**.
- **Client, server, storage and external boundaries**.
- **UI state versus system state**.
- **Synchronous and asynchronous application steps**.
- **Correlation and idempotency identifiers**.
- **Application trust and authorization boundaries**.
- **Observable checkpoints in a user scenario**.

## Когда переходить дальше

Можно переходить, когда one scenario can be traced from input to persistent/external effects and back, including duplicate, timeout, cancellation and background-failure paths.