# Спринт 09. Go HTTP server и жизненный цикл запроса

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как Go server принимает, ограничивает, обрабатывает и завершает HTTP request, сохраняя корректный context, resource ownership and graceful shutdown?

## Результат спринта

После завершения необходимо уметь:

- создавать `http.Server` with explicit timeouts;
- понимать listener, connection, request and response lifecycle;
- использовать routing and method dispatch;
- читать path, query, headers and body with size limits;
- кодировать structured JSON and HTML responses;
- применять middleware with clear order;
- распространять `context.Context` and cancellation;
- различать client disconnect, deadline and application error;
- ограничивать request body and concurrency;
- использовать structured logging without sensitive payloads;
- устанавливать request/correlation ID;
- понимать streaming and response-commit boundary;
- реализовывать graceful shutdown and readiness behavior;
- управлять dependencies/resources explicitly;
- тестировать handlers through `httptest` and real server integration;
- избегать global mutable state and hidden framework lifecycle.

## Основной маршрут

### Шаг 1. Server lifecycle

Create listener/server, configure read header, request/application and idle limits according to lab scenario. Understand that one timeout value does not cover every phase.

### Шаг 2. Handler contract

For each handler define accepted method/content type/body size, authentication context, validation, use case call, response schema and errors.

### Шаг 3. Middleware

Use middleware for cross-cutting transport concerns: request ID, logging, recovery, security headers, authentication extraction and metrics. Business rules stay out of middleware.

### Шаг 4. Shutdown

On signal: stop accepting new work, mark unready, allow bounded in-flight completion, cancel owned workers and close dependencies in order.

## Ресурсы

- Go `net/http`, `context`, `encoding/json`, `log/slog` docs.
- Go blog/articles on context and HTTP servers.
- HTTP semantics and server timeout references.
- `httptest` and race detector docs.

## Практические задания

1. Build standard-library JSON and HTML endpoints.
2. Add request ID, logging, panic recovery and metrics middleware.
3. Reproduce oversized body and slow client behavior.
4. Cancel database/fake dependency work after client disconnect.
5. Stream a bounded response and observe committed headers.
6. Perform graceful shutdown during active requests.

## Лабораторная работа

Создать `work/go-http-server/`.

### Endpoints

```text
GET    /health/live
GET    /health/ready
GET    /v1/items
POST   /v1/items
GET    /v1/items/{id}
GET    /download/{id}
GET    /events
```

### Requirements

- explicit `http.Server` settings;
- router rejects unsupported method correctly;
- body and multipart limits;
- content type checked;
- JSON decoder rejects/handles unknown fields by documented policy;
- context passed to every dependency;
- request ID returned and logged;
- no full authorization token/body in logs;
- response writer is not used concurrently unsafely;
- panic recovery occurs before partial response where possible;
- readiness changes during shutdown;
- shutdown deadline and forced-exit behavior tested;
- goroutine/race/leak checks return to baseline.

### Failure scenarios

1. Default unbounded body consumes memory/disk.
2. Missing server timeouts allows slow-client resource exhaustion.
3. Handler ignores canceled context.
4. Middleware writes header/body then next handler writes again.
5. Panic after partial response cannot become clean JSON error.
6. Request logger records secrets.
7. Shutdown closes database before active handlers finish.
8. Readiness stays true while server drains.
9. Background goroutine outlives server ownership.
10. Handler test misses real connection/disconnect behavior.

## Самопроверка

1. Listener, connection and request lifecycle?
2. Which server timeouts protect which phases?
3. What belongs in middleware?
4. When is response committed?
5. How client cancellation reaches dependency?
6. Why body size/content type limits matter?
7. Liveness versus readiness?
8. What is graceful shutdown sequence?
9. Why global state harms tests/lifecycle?
10. Handler unit test versus real-server integration?

## Результат для базы знаний

- **Go HTTP server lifecycle**.
- **HTTP handler transport contract**.
- **Go context and client cancellation**.
- **HTTP middleware order and responsibilities**.
- **Request body and concurrency limits**.
- **Response commit and streaming**.
- **Application liveness, readiness and graceful shutdown**.
- **HTTP handler testing with httptest and real connections**.

## Когда переходить дальше

Можно переходить, когда requests are bounded/cancellable, middleware order is explicit, and shutdown drains or cancels every owned resource without races or hidden goroutines.