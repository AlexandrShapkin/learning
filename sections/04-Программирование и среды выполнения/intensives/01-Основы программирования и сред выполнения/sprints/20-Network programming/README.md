# Спринт 20. Network programming

Ориентировочный объём: 15–22 часа.

## Центральный вопрос

Как application code uses sockets and protocol libraries without losing control over timeouts, connection lifecycle, framing, resource limits and failure context?

## Результат спринта

После завершения необходимо уметь:

- use Go `net`, `net/http`, `url`, `tls` and context APIs;
- distinguish listener, connection, request and stream lifecycle;
- implement TCP framing and handle partial reads/writes;
- implement UDP request/reply with datagram boundaries;
- configure dial, TLS handshake, response-header, request and idle timeouts;
- understand HTTP client transport/connection pooling and body-close requirements;
- implement HTTP server with request limits, deadlines and graceful shutdown;
- propagate cancellation from client through handler/work;
- validate addresses/URLs and avoid SSRF-like unrestricted targets in tools;
- handle DNS/connect/TLS/protocol/status errors separately;
- bound headers, bodies, connections and concurrent requests;
- understand retry/idempotency interaction;
- implement TLS verification correctly without insecure defaults;
- instrument request IDs and phase timings;
- test network code using loopback/in-memory test servers;
- diagnose leak, timeout, stale pooled connection, slow client and partial response.

## Основной маршрут

### Шаг 1. TCP/UDP sockets

Review network intensive and Go `net` package. Implement deadline-aware connection loops, framing and close behavior.

### Шаг 2. HTTP client

Study `http.Client` and `http.Transport` ownership:

- reuse clients/transports;
- close/read response bodies;
- connection pooling;
- redirects;
- per-phase timeouts;
- context cancellation;
- proxy/environment behavior.

### Шаг 3. HTTP server

Study `http.Server` limits/timeouts, handler concurrency, body limits, graceful `Shutdown`, `ConnState` and TLS.

### Шаг 4. Failure taxonomy

Represent phases:

```text
resolve → dial → TLS → write request → wait headers
→ read body → validate protocol/status → application result
```

Do not collapse all failures into “network error”.

## Ресурсы

### Обязательный маршрут

- Go `net`, `net/http`, `net/url`, `crypto/tls` docs.
- Go blog/examples on context and HTTP.
- Relevant RFC concepts from networking intensive.
- `httptest` docs.

### Альтернативные объяснения

- *Network Programming with Go*.
- Stevens Unix Network Programming selected socket chapters.

### Углубление

- HTTP/2 transport internals;
- QUIC/HTTP3;
- gRPC;
- custom DNS resolver;
- zero-copy networking;
- eBPF/network tracing;
- load shedding and adaptive concurrency.

## Практические задания

### 1. TCP protocol

Implement framed request/response with max frame size, checksum and request ID. Test split/coalesced writes, half-close and reset.

### 2. UDP protocol

Implement sequence/timeout/duplicate tracking. Never infer reliable delivery from local success.

### 3. HTTP client leak

Reproduce connection/resource leak by not closing/reading body; observe with server connection count/`ss`/profiles, then fix.

### 4. Timeout matrix

Inject delays into DNS substitute/dial/TLS/header/body/handler and verify phase-specific errors/deadlines.

## Лабораторная работа

Create `work/netapp/`:

### Components

- `netapp-server` with TCP, UDP and HTTP endpoints;
- `netapp-client` with retries, deadlines and JSON report;
- local TLS CA/cert generation scripts without committed private keys;
- fault proxy/server modes;
- integration tests.

### HTTP endpoints

- `/echo`;
- `/stream`;
- `/upload` with size limit;
- `/slow-headers`;
- `/slow-body`;
- `/work` idempotent/non-idempotent variants;
- `/health` and `/metrics-lite`.

### Requirements

- all listeners loopback/isolated by default;
- bounded body/header/concurrency;
- per-request context propagated;
- client transport reused and idle connections closed on shutdown;
- response body always handled;
- TLS hostname/chain verification;
- retry only eligible operations with attempt/request IDs and budget;
- graceful server shutdown;
- phase timing report;
- integration tests use dynamic ports;
- no sleeps where readiness synchronization can be used;
- race detector clean.

### Failure scenarios

1. DNS resolution fails.
2. Connection refused/timeout.
3. TLS unknown CA/hostname mismatch.
4. Server accepts but never sends headers.
5. Body stalls/truncates.
6. Client fails to close body and exhausts connections.
7. Server slow-read/slow-write client consumes resources.
8. Request exceeds body/header limit.
9. TCP frame too large/corrupt.
10. UDP packet lost/duplicated/out of order.
11. Retry duplicates non-idempotent work.
12. Context canceled but backend goroutine continues.
13. Graceful shutdown races active requests.
14. Pooled connection becomes stale/reset.

## Дополнительный эксперимент

Use custom `http.RoundTripper` middleware to record DNS/connect/TLS/first-byte phases through `httptrace`, then correlate with packet/server evidence.

## Самопроверка

1. Socket versus connection versus request?
2. Why TCP needs application framing?
3. Which UDP boundaries are preserved?
4. Why reuse `http.Client`/Transport?
5. Why close/read response body?
6. What timeout phases exist?
7. How does context cancellation propagate?
8. Why retry can duplicate operation?
9. What limits protect server?
10. How does TLS validation differ from encryption only?
11. How to distinguish network phase from HTTP status?
12. What makes graceful server shutdown correct?

Практическая проверка: given client phase report, server logs and socket state, identify exact resolve/dial/TLS/request/body/application failure.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Socket and connection lifecycle in application**.
- **TCP framing and partial I/O**.
- **UDP application semantics**.
- **Go HTTP client transport and pooling**.
- **HTTP server limits and graceful shutdown**.
- **Network deadlines and phase timeouts**.
- **Request cancellation and retry semantics**.
- **TLS verification in clients/servers**.
- **Network programming failure taxonomy**.

## Когда переходить дальше

Можно переходить, когда netapp classifies all failures, leaks no connections/goroutines, retries preserve semantics, and server limits/shutdown are verified.