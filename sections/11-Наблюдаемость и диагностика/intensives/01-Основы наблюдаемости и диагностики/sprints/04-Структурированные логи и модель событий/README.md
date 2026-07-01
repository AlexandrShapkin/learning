# Спринт 04. Структурированные логи и модель событий

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Какие события должны становиться лог-записями, чтобы они были пригодны для поиска, correlation and diagnosis без дублирования метрик и утечки данных?

## Результат спринта

После завершения необходимо уметь:

- отличать event logging from printf-style debugging;
- определять stable event name and schema;
- использовать structured fields and consistent types;
- выбирать severity by operational meaning;
- добавлять request/trace/job/release context;
- логировать errors once at ownership boundary;
- сохранять stack/cause without repeated amplification;
- проектировать start/completion/failure events deliberately;
- ограничивать payload size and cardinality;
- redacting sensitive data at source;
- избегать dynamic message parsing as primary schema;
- test log contracts.

## Основной маршрут

1. Inventory existing application logs and classify their purpose.
2. Replace free-text critical events with stable structured schemas.
3. Add context propagation through API, database and worker.
4. Reproduce one error amplified at four layers and redesign ownership.
5. Write schema/contract tests for important events.

## Ресурсы

- OpenTelemetry Logs data model.
- Go structured logging documentation.
- log-level and error-handling references.

## Лабораторная работа

Создать `work/structured-logging/`.

### Requirements

- critical events have stable names, versions and typed fields;
- timestamp, severity, service, release, trace/request/job and instance context are consistent;
- error is logged at the layer that owns handling or escalation;
- stack trace is bounded and connected to one event;
- user input is not used as field name;
- secret/auth/personal fields are redacted before output;
- high-volume success events use sampling/summary decision rather than default logging;
- log contract tests reject missing/wrong field types;
- stdout/stderr behavior works in containers;
- log volume under load is measured.

### Failure scenarios

1. Same error is logged by every layer.
2. Severity `error` is used for handled user validation.
3. Dynamic text must be regex-parsed for request ID/status.
4. Password/token/body appears in logs.
5. One large object creates multi-megabyte entry.
6. Field type changes from integer to string.
7. Success logging saturates disk/collector.
8. Multiline stack is split into unrelated events.

## Самопроверка

1. Event name versus message?
2. Stable structured schema?
3. Severity semantics?
4. Where log an error?
5. Context fields?
6. Why avoid dynamic field names?
7. How bound stack/payload size?
8. Redaction at source?
9. Log contract tests?
10. When not to log every event?

## Результат для базы знаний

- **Structured application logging**.
- **Log event names, schemas and field types**.
- **Log severity and error ownership**.
- **Log correlation context and release metadata**.
- **Sensitive-data redaction and log-volume control**.

## Когда переходить дальше

Можно переходить, когда important events are queryable by stable fields, one failure is not amplified across layers, and log volume/sensitive-data behavior is tested.