# Спринт 05. Сбор, доставка, parsing и хранение логов

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как log record проходит от процесса до централизованного store, and where can it be delayed, duplicated, reordered, truncated or lost?

## Результат спринта

После завершения необходимо уметь:

- trace application stdout/file/journald/container log paths;
- compare agent, sidecar and gateway collection;
- understand multiline and structured parsing;
- distinguish event and ingestion timestamps;
- manage buffering, batching, retry and backpressure;
- understand at-most/at-least-once delivery trade-offs;
- detect duplicates and data loss;
- design index/label versus body fields;
- configure retention and chunk/object storage conceptually;
- observe collector and store health;
- handle rotation, truncation and container restart;
- prevent parser/schema changes from silently losing fields.

## Основной маршрут

1. Send container logs through OpenTelemetry Collector/Vector/Fluent Bit to Loki or equivalent.
2. Trace a record through receiver, processors, exporter and store.
3. Stop the store and observe buffering/retry/drop behavior.
4. Reproduce multiline, rotation, duplicate and out-of-order cases.

## Ресурсы

- OpenTelemetry Collector logs pipeline docs.
- Loki or selected store architecture/label guidance.
- container/journald log collection docs.

## Лабораторная работа

Создать `work/log-pipeline/`.

### Requirements

- source and ingestion timestamps remain separate;
- parsing preserves structured fields and raw event fallback;
- multiline rules are bounded and tested;
- index/label fields have controlled cardinality;
- collector queues/batches/retries have explicit capacity;
- store outage produces measurable backlog/drop behavior;
- duplicate and lost event counters are estimated through sequence IDs;
- log rotation/container restart does not skip or reread unbounded data;
- collector/store internal metrics and external synthetic log are monitored;
- retention and storage cleanup are configured;
- no secret appears in collector debug output.

### Failure scenarios

1. Multiline parser merges unrelated requests.
2. Rotation causes duplicate or missing lines.
3. Store outage fills collector memory/disk.
4. Retry creates duplicates without identifier.
5. Dynamic user/request value becomes index label.
6. Parser change drops fields silently.
7. Collector clock overwrites source event time.
8. Pipeline reports healthy while exporter drops data.
9. Log store disk fills and application is affected.

## Самопроверка

1. Agent, sidecar and gateway collection?
2. Event versus ingestion time?
3. At-least-once consequences?
4. Buffer/batch/retry/backpressure?
5. Labels/index versus log body?
6. Rotation and tailing risks?
7. How estimate log loss?
8. How monitor collector/store?
9. Multiline risks?
10. Retention ownership?

## Результат для базы знаний

- **Centralized log collection pipeline**.
- **Log buffering, retries, duplication and loss**.
- **Log parsing, multiline and schema changes**.
- **Log labels, indexes and cardinality**.
- **Log retention and pipeline health**.

## Когда переходить дальше

Можно переходить, когда log delivery behavior is measured under store outage, rotation and parser changes, and data loss cannot be mistaken for absence of application events.