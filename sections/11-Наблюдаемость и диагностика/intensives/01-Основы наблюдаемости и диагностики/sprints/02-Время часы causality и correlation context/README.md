# Спринт 02. Время, часы, causality и correlation context

Ориентировочный объём: 15–22 часа.

## Центральный вопрос

Как восстановить последовательность событий, если разные процессы и хосты имеют несинхронные часы, asynchronous work and incomplete correlation context?

## Результат спринта

После завершения необходимо уметь:

- различать wall clock, monotonic clock and event duration;
- понимать clock skew, drift and synchronization limits;
- нормализовать timestamps and time zones;
- избегать duration calculation from unrelated wall clocks;
- использовать request, trace, job and correlation identifiers;
- понимать causal order versus timestamp order;
- связывать asynchronous producer and consumer events;
- учитывать retries, duplicate IDs and clock jumps;
- формировать technical timeline from multiple sources;
- различать event time and ingestion time;
- понимать late/out-of-order telemetry;
- оценивать confidence of reconstructed ordering.

## Основной маршрут

1. Emit events from API, worker and database simulator with controlled clock offsets.
2. Compare wall timestamps with monotonic durations.
3. Propagate request/trace/job identifiers through synchronous and asynchronous paths.
4. Reconstruct a failure timeline with delayed log/trace ingestion.

## Ресурсы

- Go time and monotonic-clock documentation.
- W3C Trace Context overview.
- OpenTelemetry context and timestamp model.
- clock synchronization and distributed-ordering references.

## Лабораторная работа

Создать `work/time-correlation/`.

### Requirements

- all telemetry records UTC event timestamp and source identity;
- durations use monotonic or same-process measurement;
- correlation IDs are generated once and propagated without becoming user identity;
- job/message events use stable operation ID plus attempt ID;
- ingestion timestamp is stored separately from event timestamp;
- a 30–90 second clock skew does not break causal reconstruction;
- delayed/out-of-order records are identified;
- timeline marks known order, inferred order and unknown order;
- duplicate/retried operations remain distinguishable;
- no sensitive identifier is used as public correlation value.

### Failure scenarios

1. Two host timestamps are subtracted to calculate request latency.
2. Local time zones create apparent event reversal.
3. NTP adjustment produces negative wall-clock duration.
4. Retry reuses ID without attempt context.
5. Queue consumer loses producer correlation.
6. Ingestion time is mistaken for occurrence time.
7. Correlation ID is treated as proof that events caused each other.
8. User email/order ID leaks through telemetry.

## Самопроверка

1. Wall versus monotonic time?
2. Clock skew and drift?
3. Event time versus ingestion time?
4. Timestamp order versus causal order?
5. Correlation ID versus trace ID?
6. How link async work?
7. How represent retries?
8. Why UTC is insufficient alone?
9. How handle late telemetry?
10. How express timeline confidence?

## Результат для базы знаний

- **Wall clock, monotonic time and durations**.
- **Clock skew and technical timelines**.
- **Correlation context for synchronous and asynchronous work**.
- **Event time, ingestion time and out-of-order telemetry**.
- **Causal order versus timestamp order**.

## Когда переходить дальше

Можно переходить, когда a multi-service timeline remains coherent under clock skew, delayed ingestion and retries, with uncertainty explicitly marked.