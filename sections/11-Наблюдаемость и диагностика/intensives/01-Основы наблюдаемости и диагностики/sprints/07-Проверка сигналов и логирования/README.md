# Спринт 07. Проверка сигналов и логирования

Ориентировочный объём: 14–21 час.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 01–06.

## Исходная задача

Создать `work/signals-logs-checkpoint/` — instrumented API/worker/database path with structured logs, correlation context, centralized collection, retention and evidence-based diagnosis.

## Required flow

- one synchronous HTTP path;
- one asynchronous job path;
- one database transaction;
- one external-provider call;
- release/config/schema metadata;
- local collector and log store;
- saved diagnostic queries;
- controlled clock skew and pipeline outage.

## Mandatory fault cases

1. Downstream timeout hides upstream saturation.
2. Different hosts have skewed clocks.
3. Retry reuses operation ID without attempt distinction.
4. Error is logged at multiple layers.
5. Sensitive field reaches application log.
6. Multiline stack is parsed incorrectly.
7. Rotation/restart duplicates or loses records.
8. Store outage exhausts collector buffer.
9. High-cardinality value becomes index label.
10. Parser/schema change breaks query.
11. Sampled success logs hide rare event.
12. No matches are caused by ingestion failure, not healthy system.

## Defense

1. Symptom, signal, fault and failure?
2. How was first divergence found?
3. Wall time versus causal ordering?
4. How are retries and async work correlated?
5. Why is each event logged at its chosen layer?
6. What fields are stable schema versus message text?
7. Where can logs be lost or duplicated?
8. How is pipeline health observed independently?
9. Which fields are indexed and why?
10. How are retention and access determined?
11. What uncertainty remains after log analysis?
12. Which question requires another signal type?

## Критерии прохождения

- complete request/job paths are reconstructable despite clock skew;
- logs use stable typed event schemas and bounded context;
- sensitive-data tests pass;
- collection behavior under rotation, restart and store outage is measured;
- saved queries answer named diagnostic questions;
- high-cardinality and retention limits are enforced;
- all twelve faults are reproduced and diagnosed;
- absence of log records is never accepted without pipeline-health evidence;
- at least 10 of 12 defense answers reference concrete events/configuration.

## Результат для базы знаний

Checkpoint-specific note не требуется. Update existing notes where measured delivery, parsing or timeline behavior changed assumptions.