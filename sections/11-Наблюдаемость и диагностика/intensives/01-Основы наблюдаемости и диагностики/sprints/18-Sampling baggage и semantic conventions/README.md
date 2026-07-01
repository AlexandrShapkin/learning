# Спринт 18. Sampling, baggage и semantic conventions

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как reduce trace volume and enrich context without systematically dropping rare failures, leaking data or breaking cross-service attribute semantics?

## Результат спринта

После завершения необходимо уметь:

- distinguish head, parent-based and tail sampling;
- calculate effective sample rate across services;
- preserve error/slow/rare traces deliberately;
- understand sampling bias and extrapolation limits;
- propagate sampling decisions;
- use baggage sparingly and safely;
- distinguish baggage from span/resource attributes;
- apply semantic conventions consistently;
- version/customize domain attributes without collisions;
- handle unsampled spans with metrics/log correlation;
- monitor dropped/sampled telemetry;
- estimate storage and Collector costs.

## Основной маршрут

1. Generate normal, slow, error and rare-route traffic.
2. Apply parent-based head sampling and measure bias.
3. Configure tail sampling for errors/latency/rare cohorts.
4. Propagate one bounded baggage value and remove it at trust boundary.
5. Validate semantic attributes across HTTP, DB and messaging spans.

## Ресурсы

- OpenTelemetry sampling and semantic-convention docs.
- W3C Baggage.
- Collector tail-sampling processor docs.

## Лабораторная работа

Создать `work/trace-sampling/`.

### Requirements

- sampling goals state volume budget and failure classes to retain;
- parent-based decisions remain consistent across trace;
- head sampling loss/bias is quantified;
- tail sampling preserves known errors, high latency and one rare route;
- Collector decision wait/buffer capacity is bounded;
- sampling metadata/rates are observable;
- baggage is bounded, nonsecret and removed before external boundary where required;
- HTTP/DB/messaging attributes follow selected semantic conventions;
- custom attributes use stable namespace and ownership;
- metrics provide population truth where sampled traces cannot;
- cost comparison covers unsampled/head/tail strategies.

### Failure scenarios

1. Independent service samplers create partial traces.
2. 1% random sample misses rare correctness failure.
3. Tail sampler exhausts memory during traffic burst.
4. Error sampling keeps only already-classified errors and misses unknown failure.
5. Baggage carries user email/token to every service.
6. Baggage size increases request overhead materially.
7. Semantic attribute names differ by service/version.
8. Sampled traces are treated as exact traffic proportions without correction.

## Самопроверка

1. Head versus tail sampling?
2. Parent-based sampling?
3. Sampling bias?
4. How preserve rare failures?
5. Tail-sampler resource costs?
6. Baggage versus attributes?
7. Trust-boundary handling?
8. Semantic conventions purpose?
9. How correlate unsampled traffic?
10. How observe sampling itself?

## Результат для базы знаний

- **Distributed-trace head and tail sampling**.
- **Sampling bias and effective sample rates**.
- **OpenTelemetry baggage and trust boundaries**.
- **OpenTelemetry semantic conventions and custom attributes**.
- **Trace sampling capacity and cost**.

## Когда переходить дальше

Можно переходить, когда the trace budget is bounded, known rare/error/slow cases survive sampling, and baggage/attribute semantics remain safe across service boundaries.