# Основы наблюдаемости и диагностики

Основной интенсив раздела «Наблюдаемость и диагностика». Его цель — научиться получать достоверные сигналы о поведении системы, связывать их в техническую картину и последовательно локализовать неисправности без случайных изменений и преждевременных выводов.

Практика выполняется на одном synthetic distributed Go application: HTTP API, background worker, PostgreSQL, object storage and one external-provider simulator. Система намеренно содержит проблемы latency, errors, saturation, leaks, lock contention, queue lag, network faults and telemetry degradation.

## Результат прохождения

После завершения необходимо уметь самостоятельно:

- различать observation, monitoring, observability, diagnosis and incident response;
- отделять symptom, signal, error, fault, failure and root cause;
- строить timeline and falsifiable hypotheses;
- учитывать clocks, time zones, monotonic time and causal ambiguity;
- проектировать telemetry strategy from user journeys and failure modes;
- создавать structured logs with severity, event names and correlation context;
- управлять log collection, parsing, indexing, retention and redaction;
- проектировать metric names, labels, units and aggregation semantics;
- использовать counters, gauges, histograms and exemplars correctly;
- собирать и запрашивать Prometheus-compatible metrics;
- применять RED, USE, golden signals and saturation analysis;
- строить diagnostic and operational dashboards;
- контролировать cardinality, staleness, missing data and aggregation bias;
- проектировать distributed traces, spans, links and context propagation;
- инструментировать application and infrastructure through OpenTelemetry;
- настраивать Collector pipelines, processors, exporters and backpressure;
- применять head/tail sampling and baggage deliberately;
- анализировать critical path, fan-out, retries and asynchronous work;
- коррелировать traces, logs, metrics, profiles and deployment metadata;
- профилировать CPU, heap, allocations, goroutines, mutexes, blocking and I/O;
- использовать `pprof`, `perf`, `strace`, `tcpdump`, eBPF tools and flame graphs;
- проводить controlled benchmark and load tests;
- проектировать readiness, liveness, startup, synthetic and real-user checks;
- создавать alerts tied to user impact or actionable resource risk;
- применять routing, grouping, deduplication, inhibition and silences;
- строить multi-window burn-rate alerts from SLO signals;
- эксплуатировать observability stack under overload and partial failure;
- управлять telemetry schemas, ownership, access, retention and cost;
- локализовать first divergence across application, runtime, OS, network, storage, Kubernetes and dependencies;
- создавать read-only diagnostic tooling and reproducible fault cases.

Целевой уровень: 3 по всему разделу и 4 по telemetry design, distributed tracing, performance profiling, alert quality, telemetry-pipeline operation and cross-layer diagnosis.

## Границы

Интенсив не заменяет:

- deep kernel or eBPF development course;
- vendor-specific observability certification;
- full data-platform/search-engine administration course;
- production on-call and incident-command apprenticeship;
- distributed systems reliability specialization;
- security monitoring/SIEM specialization;
- statistical anomaly-detection or machine-learning course;
- complete network/database internals course.

Incident command, stakeholder communication and service recovery are treated only as context; their full practice belongs to «Доставка и эксплуатация».

## Предварительные знания

Рекомендуется завершить основные интенсивы по operating systems, networks, programming runtimes, data stores, application systems, infrastructure and delivery operations.

Минимально необходимы:

- Go application development and testing;
- Linux shell, processes, memory and filesystems;
- HTTP, DNS, TCP and TLS basics;
- PostgreSQL queries and transactions;
- Docker/OCI and Kubernetes basics;
- ability to run load tests and inspect system state;
- understanding of releases, SLO concepts and incident timelines;
- technical English.

## Лабораторное окружение

Default laboratory:

- Linux host or VM;
- Go, Docker/Podman and Compose;
- kind/k3d/k3s and `kubectl`;
- OpenTelemetry SDK and Collector;
- Prometheus and Alertmanager;
- Grafana;
- Loki or another log store;
- Tempo/Jaeger or another trace store;
- PostgreSQL and MinIO or equivalent object storage;
- Go `pprof`, `perf`, `strace`, `tcpdump`, `ss`, `iostat`, `vmstat`;
- optional Pyroscope/Parca and eBPF tools;
- k6/Vegeta or another bounded load generator;
- Blackbox Exporter or equivalent synthetic checker.

Подробности: [`LAB_ENVIRONMENT.md`](LAB_ENVIRONMENT.md).

Проверка:

```bash
bash scripts/check-environment.sh
```

## Принципы прохождения

1. Start from an exact symptom and expected behavior, not from a favorite tool.
2. Telemetry is evidence with collection and interpretation limits, not ground truth.
3. Every signal has owner, unit, dimensions, retention and known failure modes.
4. Logs record events; metrics summarize populations; traces explain individual request paths; profiles explain resource consumption.
5. Correlation identifiers are not proof of causality.
6. Missing telemetry is a signal only when collection health is independently known.
7. High-cardinality dimensions require explicit value and cost justification.
8. Dashboards support questions; they do not replace hypotheses.
9. Alerts must imply an action or escalation path.
10. Profiling and load generation are bounded and reproducible.
11. Before restart, rollout or cleanup, preserve the smallest useful evidence set.
12. Diagnosis seeks the first divergence, not merely the loudest downstream symptom.
13. The observability system itself must be observable and degradable.
14. General mechanisms move to `knowledge`; dashboards, queries, profiles and incident evidence remain in `learning`.

## Основной стек

- Go and OpenTelemetry SDK;
- OpenTelemetry Collector;
- Prometheus and Alertmanager;
- Grafana;
- Loki and Tempo/Jaeger;
- PostgreSQL and object storage;
- `pprof`, `perf`, `strace`, `tcpdump`, `ss`, `lsof`, `vmstat`, `iostat`;
- optional bpftrace/BCC/bpftool and continuous profiling;
- k6 or Vegeta;
- Docker/Compose and Kubernetes;
- Bash, Make, jq and yq.

## Порядок спринтов

1. [Сигналы, симптомы, ошибки и проверяемые гипотезы](sprints/01-Сигналы%20симптомы%20ошибки%20и%20проверяемые%20гипотезы/)
2. [Время, часы, causality и correlation context](sprints/02-Время%20часы%20causality%20и%20correlation%20context/)
3. [Telemetry model и стратегия инструментирования](sprints/03-Telemetry%20model%20и%20стратегия%20инструментирования/)
4. [Структурированные логи и модель событий](sprints/04-Структурированные%20логи%20и%20модель%20событий/)
5. [Сбор, доставка, parsing и хранение логов](sprints/05-Сбор%20доставка%20parsing%20и%20хранение%20логов/)
6. [Поиск, анализ, retention и защита логов](sprints/06-Поиск%20анализ%20retention%20и%20защита%20логов/)
7. [Проверка сигналов и логирования](sprints/07-Проверка%20сигналов%20и%20логирования/)
8. [Метрики и временные ряды](sprints/08-Метрики%20и%20временные%20ряды/)
9. [Counters, gauges, histograms и instrumentation](sprints/09-Counters%20gauges%20histograms%20и%20instrumentation/)
10. [Prometheus collection, PromQL и recording rules](sprints/10-Prometheus%20collection%20PromQL%20и%20recording%20rules/)
11. [RED, USE, golden signals и saturation](sprints/11-RED%20USE%20golden%20signals%20и%20saturation/)
12. [Dashboards, drill-down и visual integrity](sprints/12-Dashboards%20drill-down%20и%20visual%20integrity/)
13. [Cardinality, aggregation, staleness и missing data](sprints/13-Cardinality%20aggregation%20staleness%20и%20missing%20data/)
14. [Metrics storage, retention, federation и cost](sprints/14-Metrics%20storage%20retention%20federation%20и%20cost/)
15. [Проверка метрик и мониторинга](sprints/15-Проверка%20метрик%20и%20мониторинга/)
16. [Traces, spans, context propagation и links](sprints/16-Traces%20spans%20context%20propagation%20и%20links/)
17. [OpenTelemetry SDK, Collector и pipelines](sprints/17-OpenTelemetry%20SDK%20Collector%20и%20pipelines/)
18. [Sampling, baggage и semantic conventions](sprints/18-Sampling%20baggage%20и%20semantic%20conventions/)
19. [Critical path, fan-out, retries и asynchronous traces](sprints/19-Critical%20path%20fan-out%20retries%20и%20asynchronous%20traces/)
20. [Correlation logs metrics traces и exemplars](sprints/20-Correlation%20logs%20metrics%20traces%20и%20exemplars/)
21. [Проверка распределённой телеметрии](sprints/21-Проверка%20распределённой%20телеметрии/)
22. [CPU profiling и flame graphs](sprints/22-CPU%20profiling%20и%20flame%20graphs/)
23. [Memory, allocations, goroutines, locks и I-O profiling](sprints/23-Memory%20allocations%20goroutines%20locks%20и%20I-O%20profiling/)
24. [Linux performance tools и eBPF diagnostics](sprints/24-Linux%20performance%20tools%20и%20eBPF%20diagnostics/)
25. [Load testing, benchmarks и performance experiments](sprints/25-Load%20testing%20benchmarks%20и%20performance%20experiments/)
26. [Health checks, synthetic monitoring и RUM](sprints/26-Health%20checks%20synthetic%20monitoring%20и%20RUM/)
27. [Alert conditions, actionability и false signals](sprints/27-Alert%20conditions%20actionability%20и%20false%20signals/)
28. [Grouping, routing, deduplication, inhibition и silences](sprints/28-Grouping%20routing%20deduplication%20inhibition%20и%20silences/)
29. [SLO burn-rate alerts и alert tuning](sprints/29-SLO%20burn-rate%20alerts%20и%20alert%20tuning/)
30. [Эксплуатация telemetry pipeline, quality, privacy и cost](sprints/30-Эксплуатация%20telemetry%20pipeline%20quality%20privacy%20и%20cost/)
31. [Систематический troubleshooting и техническая timeline](sprints/31-Систематический%20troubleshooting%20и%20техническая%20timeline/)
32. [Cross-layer diagnostics и observability maturity](sprints/32-Cross-layer%20diagnostics%20и%20observability%20maturity/)
99. [Итоговая работа](sprints/99-Итоговая%20работа/)

## Покрытие основных вопросов

| Вопрос | Спринты |
|---|---|
| Какие сигналы описывают состояние системы? | 01–03, 08–14, 16–20 |
| Как проектировать и анализировать логи? | 04–07 |
| Как измерять load, errors, latency and saturation? | 08–15 |
| Как связать запросы между сервисами? | 16–21 |
| Когда применять profiling and system tools? | 22–25 |
| Как наблюдать систему изнутри и снаружи? | 11–12, 26 |
| Как создавать actionable alerts? | 27–29 |
| Как эксплуатировать observability platform? | 14, 17–18, 30 |
| Как сформировать и проверить diagnostic hypothesis? | 01–03, 31–32 |
| Как определить boundary между application/network/storage/platform? | 24–26, 31–32 |
| Как восстановить technical timeline? | 02, 20–21, 31–32 |
| Как управлять telemetry volume and cost? | 06, 13–14, 18, 30 |

## Итоговая работа

Финальный проект — `observability-diagnostics-lab`: fully instrumented synthetic service and observability platform containing structured logs, Prometheus metrics, distributed traces, profiles, synthetic checks, actionable alerts, telemetry quality monitoring, controlled fault injection and read-only `obstriage` diagnostics.

Система должна позволять:

- trace a user request across services, queue and database;
- correlate release/config/schema identifiers with telemetry;
- diagnose latency, errors, saturation, leaks, lock contention and packet/storage problems;
- distinguish application fault from telemetry-pipeline failure;
- stop alert storms and preserve meaningful escalation;
- execute load/profiling experiments safely;
- reconstruct technical timelines from independent evidence;
- quantify telemetry loss, cardinality, retention and cost;
- locate first divergence across application, runtime, OS, network, storage and Kubernetes.

## Вклад в базу знаний

Each sprint names exact recommended notes. General mechanisms move to `knowledge`; instrumentation code, dashboards, queries, profiles, collectors and fault evidence remain in `learning`.

## Общая библиография

Official specifications, documentation and selected books are listed in [`RESOURCES.md`](RESOURCES.md). Each sprint identifies the required minimum route.
