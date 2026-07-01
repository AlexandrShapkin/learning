# Спринт 19. Critical path, fan-out, retries и asynchronous traces

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как по trace определить critical path and latency amplification, если операция содержит parallel fan-out, retries, queueing and asynchronous continuation?

## Результат спринта

После завершения необходимо уметь:

- находить critical path rather than summing all span durations;
- distinguish sequential, parallel and overlapping work;
- analyze fan-out width and slowest dependency;
- expose retry attempts and backoff;
- separate queue wait from processing;
- represent producer/consumer and batch links;
- identify hidden client-side wait and connection-pool delay;
- compare stable and candidate traces statistically, not from one sample;
- detect missing spans/context gaps;
- understand async trace lifetime and storage implications;
- correlate trace latency with service/resource metrics;
- avoid attributing all parent time to child spans.

## Основной маршрут

1. Add sequential and parallel dependency calls.
2. Inject one slow branch and compare total versus critical-path duration.
3. Add retries/backoff and connection-pool wait.
4. Trace queue enqueue, wait and processing with links.
5. Compare distributions of healthy and faulty traces.

## Ресурсы

- OpenTelemetry span/link conventions.
- Tempo/Jaeger trace analysis docs.
- distributed tracing performance-analysis material.

## Лабораторная работа

Создать `work/trace-analysis/`.

### Requirements

- trace view distinguishes client wait, network/server work, DB and queueing;
- parallel fan-out spans overlap correctly;
- report identifies actual critical path;
- retries show attempts, backoff and final result;
- connection-pool and queue wait are separate spans/events/metrics;
- async producer/consumer relationship is preserved without false wall duration;
- missing instrumentation is detected through unexplained parent/self time;
- candidate versus baseline uses a bounded trace set and route/release filters;
- slow trace links to matching resource/service metrics;
- trace query identifies one repeated latency pattern;
- conclusions include sampling/clock/instrumentation limitations.

### Failure scenarios

1. Child durations are summed and exceed request latency.
2. Slowest parallel branch is missed by averages.
3. Retries look like one long dependency call.
4. Queue wait is attributed to worker processing.
5. Parent span self-time hides client pool contention.
6. Async job is represented as one multi-hour parent span.
7. One outlier trace is generalized to all requests.
8. Missing span makes network time appear unexplained.
9. Sampling removes successful baseline traces.

## Самопроверка

1. Critical path in parallel trace?
2. Parent self-time?
3. Fan-out amplification?
4. Retry/backoff representation?
5. Queue wait versus processing?
6. Links for async/batch work?
7. How detect missing spans?
8. One trace versus population?
9. How correlate resource metrics?
10. Main trace-analysis limitations?

## Результат для базы знаний

- **Distributed trace critical-path analysis**.
- **Fan-out and retry latency amplification**.
- **Queueing and connection-pool wait in traces**.
- **Asynchronous and batch trace relationships**.
- **Trace population comparison and limitations**.

## Когда переходить дальше

Можно переходить, когда a fan-out/retry/queue latency incident can be reduced to the actual critical path and confirmed with independent metrics rather than span-duration summation.