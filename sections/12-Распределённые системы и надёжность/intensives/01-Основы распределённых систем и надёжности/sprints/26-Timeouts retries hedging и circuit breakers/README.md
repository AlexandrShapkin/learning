# Спринт 26. Timeouts, retries, hedging и circuit breakers

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как ограничить latency and dependency pressure while avoiding retry storms, premature circuit opening and duplicated work?

## Результат спринта

После завершения необходимо уметь:

- выбирать timeout from end-to-end budget and latency distribution;
- distinguish connection, request and queue timeout;
- применять retry only to safe/transient failures;
- использовать backoff, jitter and retry budget;
- понимать hedged requests and tail-latency trade-offs;
- проектировать circuit-breaker states and probes;
- distinguish breaker from timeout/rate limiter;
- prevent synchronized recovery storms;
- handle per-endpoint versus shared breaker scope;
- instrument attempts, abandoned work and late responses;
- verify downstream capacity impact;
- combine patterns without multiplicative behavior.

## Основной маршрут

1. Introduce variable-tail dependency latency.
2. Tune timeout from user budget and measured distribution.
3. Compare retry and hedging under spare versus saturated capacity.
4. Add circuit breaker and controlled half-open probes.

## Лабораторная работа

Создать `work/resilience-calls/`.

### Requirements

- timeout leaves budget for caller recovery/response;
- retries have attempt and elapsed-time budget;
- hedging is limited to idempotent operations and spare capacity;
- original/hedged attempts are canceled where possible;
- breaker scope matches failure isolation boundary;
- open/half-open/closed transitions are observable;
- half-open probes are bounded and jittered;
- dependency recovery ramps gradually;
- logical operations and physical attempts are separated;
- overload test proves patterns do not amplify traffic without bound.

### Failure scenarios

1. Timeout is copied from arbitrary default.
2. Retried request continues running after caller timeout.
3. Hedging doubles load on already saturated dependency.
4. Shared breaker opens for healthy endpoint/tenant.
5. Every client half-opens simultaneously.
6. Retry wraps circuit breaker incorrectly and creates loops.
7. Late first response overwrites hedged result/state.

## Результат для базы знаний

- **Timeout selection and end-to-end latency budgets**.
- **Retry budgets, jitter and amplification**.
- **Hedged requests and tail latency**.
- **Circuit breaker states and recovery probes**.
- **Composition of remote-call resilience patterns**.

## Когда переходить дальше

Можно переходить, когда latency tails and dependency outages produce bounded attempts and predictable degradation without recovery storms.