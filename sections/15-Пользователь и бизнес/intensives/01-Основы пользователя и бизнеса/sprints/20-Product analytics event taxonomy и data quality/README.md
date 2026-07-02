# Спринт 20. Product analytics, event taxonomy и data quality

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Какие события и свойства нужны для product decisions, and how ensure they mean the same thing across product, data and business?

## Результат спринта

После завершения необходимо уметь:

- define analytics questions before instrumentation;
- create event taxonomy and naming conventions;
- distinguish user, account, device, session and workflow identities;
- define event time, source, properties and schema version;
- map events to product outcomes and process states;
- prevent duplicate, missing and reordered-event distortion;
- implement data-quality checks and lineage;
- handle consent, privacy and retention;
- distinguish operational facts from analytical derivations;
- avoid collecting every click without decision use.

## Основной маршрут

1. Define decisions and metric requirements.
2. Create event catalogue for request-to-completion flow.
3. Instrument/generate synthetic events.
4. Validate identity, completeness, ordering and schema quality.

## Лабораторная работа

Создать `work/product-analytics/`.

### Requirements

- every event has purpose, owner and consumer;
- names describe completed facts consistently;
- identity model covers anonymous/authenticated/account/workflow transitions;
- schema includes source, event/effective time and version;
- duplicate/retry behavior is defined;
- critical metrics reconcile with operational source;
- data-quality tests cover volume, nulls, uniqueness, ordering and drift;
- privacy/retention minimizes properties;
- unused events are removed or rejected.

### Failure scenarios

1. Same event name means different actions on clients.
2. Login merges or splits identities incorrectly.
3. Retry duplicates inflate conversion.
4. Late/out-of-order events change funnel results.
5. Schema changes silently.
6. Sensitive property is collected without decision need.
7. Dashboard metric cannot reconcile with source process.

## Результат для базы знаний

- **Product-analytics event taxonomies**.
- **User, account, session and workflow identity models**.
- **Event time, schema versioning and duplicate handling**.
- **Analytics data quality, lineage and reconciliation**.

## Когда переходить дальше

Можно переходить, когда critical metrics can be regenerated from versioned events and reconciled to authoritative operational facts.