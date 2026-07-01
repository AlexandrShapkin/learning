# Спринт 03. Telemetry model и стратегия инструментирования

Ориентировочный объём: 17–24 часа.

## Центральный вопрос

Какие telemetry signals нужны для конкретных пользовательских сценариев и failure modes, и где их измерять, чтобы не собирать всё подряд?

## Результат спринта

После завершения необходимо уметь:

- различать logs, metrics, traces, profiles and events by information model;
- выбирать signal by diagnostic question;
- строить user-journey and dependency instrumentation map;
- определять service, resource and operation identities;
- проектировать common attributes and revision metadata;
- задавать telemetry ownership and schema lifecycle;
- учитывать observer effect and instrumentation overhead;
- определять collection, sampling and retention budgets;
- избегать duplicate contradictory instrumentation;
- формулировать diagnostic questions before dashboards;
- учитывать telemetry availability as dependency;
- создавать minimum viable telemetry for a service.

## Основной маршрут

1. List user journeys and top failure modes of the reference application.
2. For each question select log, metric, trace, profile or external check.
3. Define shared resource/service/release attributes.
4. Estimate event, series, span and profile volume.
5. Remove signals without a named consumer or question.

## Ресурсы

- OpenTelemetry data-model and resource concepts.
- Google SRE monitoring philosophy.
- Distributed Systems Observability introductory material.

## Лабораторная работа

Создать `work/telemetry-strategy/`.

### Requirements

- at least five user journeys and ten failure modes are mapped;
- every signal names question, producer, collection path, owner and retention;
- common attributes include service, environment, release and instance identity;
- high-cardinality fields are explicitly classified;
- telemetry volume/cost estimate includes logs, series, spans and profiles;
- one signal is removed as redundant and one added to close a diagnostic gap;
- application and collector failure modes are separated;
- minimum telemetry works when the primary dashboard/store is unavailable;
- schema changes have compatibility/version notes;
- overhead budget is measured under representative load.

### Failure scenarios

1. Every request body is logged “for debugging”.
2. Same latency is measured differently across logs, metrics and traces.
3. Release/config revision is absent.
4. User ID becomes metric label.
5. Instrumentation adds material latency/allocation overhead.
6. Collector failure is interpreted as zero traffic.
7. Dashboard is built without a diagnostic question.
8. Telemetry has no owner or retention policy.

## Самопроверка

1. Logs, metrics, traces and profiles answer which questions?
2. What is a telemetry resource?
3. Minimum viable telemetry?
4. Observer effect?
5. Signal ownership?
6. Common attributes?
7. Why estimate volume before deployment?
8. How identify redundancy?
9. What survives observability-platform failure?
10. How evolve telemetry schema?

## Результат для базы знаний

- **Telemetry signals and diagnostic questions**.
- **Observability instrumentation strategy**.
- **Telemetry resource and common attributes**.
- **Telemetry ownership, schema and lifecycle**.
- **Instrumentation overhead and signal budgets**.

## Когда переходить дальше

Можно переходить, когда every collected signal has a named question and owner, and the proposed instrumentation budget is measured rather than assumed.