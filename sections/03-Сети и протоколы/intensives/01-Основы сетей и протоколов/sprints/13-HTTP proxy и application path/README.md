# Спринт 13. HTTP, proxy и application path

Ориентировочный объём: 15–21 час.

## Центральный вопрос

Как an HTTP request moves through client, connections, intermediaries and server while preserving or transforming application semantics?

## Результат спринта

После завершения необходимо уметь:

- explain HTTP request/response semantics independently of transport version;
- distinguish method, target, status, headers, body and representation;
- use safe/idempotent/cacheable concepts correctly;
- understand Host/authority and virtual hosting;
- explain persistent connections, framing, Content-Length and chunked transfer in HTTP/1.1;
- distinguish HTTP/1.1, HTTP/2 and HTTP/3 at architecture level;
- explain multiplexing and head-of-line differences;
- use curl verbose/trace and captures;
- distinguish forward proxy, reverse proxy, gateway and tunnel;
- configure nginx as reverse proxy and forward proxy only where tool supports/appropriate;
- explain `X-Forwarded-*`, `Forwarded` and trust boundaries;
- implement caching with explicit rules and understand stale/validation behavior;
- diagnose wrong Host, redirect loop, timeout, buffering and proxy protocol errors;
- trace request ID across multiple hops.

## Место в интенсиве

DNS finds endpoint and TCP/UDP transports bytes. HTTP defines widely used application semantics and introduces intermediaries whose configuration can change routing, identity and performance.

## Основной маршрут

### Шаг 1. HTTP semantics

Read RFC 9110 selected sections:

- resources and representations;
- methods;
- status codes;
- fields;
- content negotiation;
- conditional requests;
- caching overview.

Use MDN as approachable secondary reference.

### Шаг 2. HTTP/1.1 message framing

Read RFC 9112 selected sections:

- request/status lines;
- field parsing;
- Content-Length;
- Transfer-Encoding;
- connection persistence;
- message smuggling security implications overview.

### Шаг 3. HTTP/2 and HTTP/3

Read architectural overviews of RFC 9113/9114 and QUIC RFC 9000. Focus on streams, multiplexing, header compression and transport relation, not full binary frame implementation.

### Шаг 4. Proxying and caching

Study nginx/curl docs:

- reverse proxy;
- upstream headers/timeouts/buffering;
- forward proxy CONNECT concept;
- cache-control, validators, Vary and proxy cache;
- client IP propagation and trusted proxies.

## Ресурсы

### Обязательный маршрут

- RFC 9110 selected sections.
- RFC 9112 framing sections.
- HTTP/2 and HTTP/3 overview.
- curl and nginx documentation.
- MDN HTTP reference.

### Альтернативные объяснения

- HTTP: The Definitive Guide for historical foundations.
- High Performance Browser Networking, selected chapters.
- browser/network devtools documentation.

### Углубление

- HPACK/QPACK;
- QUIC loss recovery;
- WebSocket and CONNECT;
- gRPC;
- CDN caching;
- request smuggling/desync;
- browser connection/coalescing behavior.

## Практические задания

### 1. Raw HTTP/1.1

Use `nc`/`socat` to send valid and invalid requests to local server:

- missing Host;
- GET with body;
- POST Content-Length;
- chunked request where supported;
- keep-alive multiple requests;
- malformed framing.

Observe server behavior; do not send ambiguous requests to external systems.

### 2. Methods and retries

Implement GET, PUT, POST and DELETE endpoints with request IDs. Simulate client timeout after server applied operation. Show why retrying idempotent and non-idempotent operations differs.

### 3. Conditional/cache requests

Implement ETag/Last-Modified and test `If-None-Match`, `If-Modified-Since`, Cache-Control and 304. Verify cache key includes relevant Vary dimensions.

### 4. Version comparison

Use curl to negotiate HTTP/1.1 and HTTP/2 against local TLS server/proxy. If HTTP/3 support available, run optional local QUIC endpoint. Compare connection/stream behavior, not only timings.

## Лабораторная работа

Create `work/httplab/`.

### Topology

```text
client -- forward-proxy(optional) -- nginx reverse proxy -- app-a/app-b
```

DNS lab name `api.example.test` points to proxy.

### Go application

Endpoints:

- `/echo`;
- `/items/{id}` with GET/PUT/DELETE;
- `/orders` POST with idempotency key support;
- `/slow`;
- `/stream`;
- `/large`;
- `/headers`;
- `/health` and `/ready`.

Logs include request ID, method, authority, remote peer and trusted client identity separately.

### Proxy configuration

- virtual host routing;
- upstream load distribution basic;
- explicit connect/read/send timeouts;
- buffering on/off experiment;
- request/response size limits;
- header forwarding rules;
- proxy cache for selected GET only;
- no trust in arbitrary inbound `X-Forwarded-For` from untrusted client.

### Failure scenarios

1. Wrong DNS/Host routes to default virtual host.
2. Proxy connects wrong upstream port.
3. Backend listens loopback in another namespace.
4. Read timeout shorter than valid backend response.
5. Redirect loop due to scheme/host forwarding.
6. Client-supplied forwarded header spoofing.
7. Cache serves wrong variant due to missing `Vary`/key.
8. POST retried and duplicated without idempotency key.
9. Content-Length/framing mismatch rejected.
10. Large/streaming response harmed by buffering/limits.
11. Backend returns before fully consuming body, affecting reuse.
12. One connection fails while another HTTP/2 stream behavior differs.

### Evidence

- curl `-v/--trace-time`;
- proxy/app logs with request IDs;
- pcap for unencrypted internal HTTP;
- connection state `ss`;
- cache status headers;
- tests for methods/idempotency/cache behavior.

## Дополнительный эксперимент

Implement a minimal explicit forward proxy supporting HTTP requests and CONNECT tunnel only for laboratory destinations. Enforce allowlist and explain why forward proxy policy differs from reverse proxy routing.

Alternative: run h2c/HTTP/2 and inspect frames through Wireshark where supported.

## Самопроверка

1. What are HTTP semantics versus HTTP transport version?
2. How is HTTP/1.1 message length determined?
3. What do safe and idempotent mean?
4. Why can timeout make POST result ambiguous?
5. How do forward and reverse proxies differ?
6. What is authority/Host used for?
7. Why are forwarded headers a trust boundary?
8. How do cache freshness and validation differ?
9. What does HTTP/2 multiplex?
10. How does HTTP/3 relate to QUIC/UDP?
11. Why can proxy buffering change latency/memory behavior?

Практическая проверка: given client trace and proxy/backend logs, locate failure among DNS, connection, virtual host, proxy routing, timeout, HTTP framing, cache or application semantics.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **HTTP message and semantics** — methods, status, fields and representations.
- **HTTP/1.1 framing** — lengths, chunks and persistence.
- **HTTP/2 and HTTP/3** — streams and transport differences.
- **Forward and reverse proxy** — client-side versus server-side intermediary.
- **HTTP caching** — freshness, validators, Vary and keys.
- **Forwarded client identity** — headers and trusted proxy boundary.
- **HTTP retries and idempotency** — ambiguous outcomes and request IDs.
- **HTTP diagnostics** — curl traces, logs and connection evidence.

## Когда переходить дальше

Можно переходить, когда application/proxy lab passes semantic tests, forwarded identity is protected, and failures can be traced across client/proxy/backend with one request ID.