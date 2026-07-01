# Спринт 16. Traces, spans, context propagation и links

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как представить один distributed operation as a trace of causal/related spans, сохранив контекст через HTTP, database calls, queues and retries?

## Результат спринта

После завершения необходимо уметь:

- понимать trace, span, parent/child, root and span events;
- проектировать span boundaries around operations;
- использовать W3C Trace Context;
- propagate context across HTTP and internal calls;
- use links for queues/batches and non-parent relationships;
- distinguish operation from retry attempt;
- record status, errors and relevant attributes;
- avoid creating spans for trivial/high-frequency details;
- handle asynchronous context without false parentage;
- understand clock skew effects in trace visualization;
- define service/resource identity;
- avoid sensitive/high-cardinality span attributes.

## Основной маршрут

1. Instrument API → database → external provider path manually.
2. Propagate trace context through HTTP headers.
3. Add producer/consumer spans for background jobs.
4. Represent retries as child attempts and batching through links.
5. Break propagation and diagnose fragmented traces.

## Ресурсы

- OpenTelemetry tracing specification and Go SDK docs.
- W3C Trace Context.
- messaging trace semantic conventions.

## Лабораторная работа

Создать `work/trace-foundations/`.

### Requirements

- one user operation produces coherent multi-service trace;
- span names are stable operations, not raw URLs/data;
- server/client/database/producer/consumer kinds are used consistently;
- release, environment and service resource attributes are present;
- errors record status and bounded exception/event details;
- retries expose logical operation and attempt count;
- async work uses propagated context or links according to semantics;
- batch processing links to multiple producers without false single parent;
- sensitive payloads and unbounded IDs are excluded;
- context-loss test detects where trace fragments.

### Failure scenarios

1. Every function creates a span and trace becomes unusable.
2. Raw URL/user/order ID becomes span name/attribute.
3. Queue consumer starts unrelated root trace.
4. Retry overwrites previous attempt and hides amplification.
5. Client/server instrumentation creates duplicate nested spans.
6. Error response has no span status/event.
7. Clock skew creates apparent negative/overlapping timings.
8. Traceparent is trusted from untrusted source without policy.

## Самопроверка

1. Trace, span and event?
2. Parent-child versus link?
3. Span kinds?
4. Stable span naming?
5. Trace context propagation?
6. Async and batch relationships?
7. Retries in traces?
8. Error recording?
9. Clock skew effects?
10. Attribute privacy/cardinality?

## Результат для базы знаний

- **Distributed traces, spans and span events**.
- **W3C trace-context propagation**.
- **Span parentage and links for asynchronous work**.
- **Trace representation of retries and errors**.
- **Trace attribute and span-name design**.

## Когда переходить дальше

Можно переходить, когда synchronous and asynchronous operations produce coherent traces and a deliberate propagation break can be localized precisely.