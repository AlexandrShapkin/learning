# Спринт 06. Поиск, анализ, retention и защита логов

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Как находить закономерности и редкие события в логах, не полагаясь на ручное чтение, и как ограничить доступ, срок хранения и стоимость?

## Результат спринта

После завершения необходимо уметь:

- строить queries from structured fields and time bounds;
- use correlation and aggregation without losing event detail;
- compare rates, patterns and exemplars across releases;
- distinguish absence of matches from missing ingestion;
- create saved diagnostic queries and links;
- use sampling carefully for high-volume events;
- define retention by diagnostic/legal/value needs;
- apply access control and audit to telemetry;
- redact/delete sensitive records where supported;
- understand compression/index/storage cost drivers;
- avoid using logs as an unbounded analytics database;
- verify search correctness after schema changes.

## Основной маршрут

1. Build queries for one request, one job, one release and one error class.
2. Compare healthy and faulty time windows.
3. Aggregate errors without losing drill-down to events.
4. Reduce retention/indexing and measure search/cost impact.
5. Run an access/redaction review.

## Ресурсы

- Loki/selected store query and retention docs.
- operational telemetry privacy and access-control guidance.
- structured-query and sampling references.

## Лабораторная работа

Создать `work/log-analysis/`.

### Requirements

- saved queries answer at least ten named diagnostic questions;
- query starts from bounded time/service/release scope;
- aggregation links back to representative raw events;
- sequence/synthetic records distinguish zero events from ingestion loss;
- release/config/schema comparisons are reproducible;
- retention tiers are defined for high-value, routine and debug events;
- sensitive fields have deny/redaction tests;
- query roles restrict access by environment/data class;
- deletion/expiry behavior is verified on synthetic sensitive record;
- storage/index/query cost drivers are measured;
- schema migration keeps old/new queries usable during transition.

### Failure scenarios

1. Search across all time/services overloads the store.
2. No matching logs is interpreted as no errors.
3. Sampled logs hide a rare correctness failure.
4. Aggregation removes trace/request drill-down.
5. Retention expires evidence before incident review.
6. Debug logging becomes permanent high-cost stream.
7. Broad users can query secrets/personal data.
8. Field rename silently breaks saved queries.
9. Regex parsing returns false matches.

## Самопроверка

1. How bound a log query?
2. Zero events versus missing ingestion?
3. Aggregation with drill-down?
4. Sampling risks?
5. Retention tiers?
6. Main cost drivers?
7. Access and audit requirements?
8. Redaction versus deletion?
9. Schema migration for queries?
10. When use metrics/traces instead of logs?

## Результат для базы знаний

- **Structured log search and diagnostic queries**.
- **Log aggregation with event drill-down**.
- **Log sampling and rare-event risk**.
- **Log retention tiers and cost drivers**.
- **Log access control, redaction and deletion**.

## Когда переходить дальше

Можно переходить, когда important questions are answered through bounded reproducible queries and retention/access choices are tested against diagnostic value and data risk.