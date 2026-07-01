# Спринт 17. OpenTelemetry SDK, Collector и pipelines

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как instrument applications through OpenTelemetry and operate receiver/processor/exporter pipelines without coupling application code to one telemetry backend?

## Результат спринта

После завершения необходимо уметь:

- configure tracer/meter/logger providers and resources;
- use manual and library instrumentation;
- understand propagators and exporters;
- configure Collector receivers, processors, exporters and connectors;
- choose agent, gateway and layered collector patterns;
- use batching, memory limiter, retry and queue processors;
- transform/filter attributes with schema awareness;
- route signals to multiple backends;
- monitor Collector internal telemetry;
- handle config reload/restart safely;
- diagnose exporter rejection and partial success;
- separate application shutdown from telemetry flush limits.

## Основной маршрут

1. Add OTel SDK to API and worker.
2. Export OTLP to local Collector.
3. Route metrics, traces and logs to separate stores.
4. Add batching, memory limiting and persistent queue where available.
5. Stop exporters and overload receiver to observe backpressure/drop behavior.

## Ресурсы

- OpenTelemetry specification, Go SDK and Collector docs.
- OTLP protocol and Collector deployment guidance.

## Лабораторная работа

Создать `work/opentelemetry-pipeline/`.

### Requirements

- application code exports OTLP and does not depend on backend-specific SDK APIs for core telemetry;
- resource attributes are consistent across signals;
- propagators are explicitly configured;
- Collector config is versioned and validated;
- memory limiter precedes batching according to chosen design;
- queue/retry capacities and drop behavior are measured;
- invalid/oversized telemetry is rejected visibly;
- multiple exporters cannot block application indefinitely;
- Collector internal metrics/logs and one external synthetic signal are monitored;
- shutdown flush has bounded timeout and known loss behavior;
- config transformation preserves schema compatibility;
- credentials/TLS are scoped and not committed.

### Failure scenarios

1. Application exports directly to three vendor SDKs.
2. Collector memory grows without limiter/backpressure.
3. Exporter outage blocks or drops telemetry silently.
4. Processor removes trace/service attributes needed downstream.
5. Resource identity differs between metrics and traces.
6. Application shutdown hangs on exporter flush.
7. Invalid endpoint/TLS causes continuous retry storm.
8. Collector reports healthy process while one exporter rejects data.
9. Config reload loses queued telemetry.

## Самопроверка

1. SDK provider/resource/processor/exporter roles?
2. OTLP purpose?
3. Receiver, processor and exporter?
4. Agent versus gateway collector?
5. Memory limiter, batch and queue?
6. Partial success/rejection?
7. Collector self-observability?
8. Shutdown flush semantics?
9. Backend independence limits?
10. Schema-transform risks?

## Результат для базы знаний

- **OpenTelemetry SDK architecture**.
- **OTLP and OpenTelemetry Collector pipelines**.
- **Collector agent and gateway deployment patterns**.
- **Collector batching, queues, retries and memory limiting**.
- **OpenTelemetry resource identity and pipeline self-observability**.

## Когда переходить дальше

Можно переходить, когда all three signals travel through a versioned Collector pipeline and exporter outage/backpressure produces measurable bounded loss rather than application failure.