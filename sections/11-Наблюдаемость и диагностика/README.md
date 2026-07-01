# Наблюдаемость и диагностика

Практическое изучение сигналов, логов, метрик, трассировок, профилирования, health checks, оповещений и доказательной диагностики программных систем.

Раздел соответствует области [«Наблюдаемость и диагностика»](https://github.com/AlexandrShapkin/knowledge/tree/main/content/Наблюдаемость%20и%20диагностика) базы знаний.

## Основной интенсив

### [01. Основы наблюдаемости и диагностики](intensives/01-Основы%20наблюдаемости%20и%20диагностики/)

Маршрут строится вокруг одного распределённого Go-приложения и его telemetry path: application events → logs/metrics/traces/profiles → collectors and storage → queries/dashboards/alerts → hypothesis-driven diagnosis.

После прохождения необходимо уметь:

- различать monitoring, observability, troubleshooting and diagnosis;
- строить проверяемые гипотезы из симптомов и доказательств;
- проектировать структурированные логи и correlation context;
- собирать, хранить, искать и защищать журналы;
- инструментировать сервисы метриками и временными рядами;
- применять RED, USE и golden signals;
- проектировать dashboards without hiding uncertainty;
- контролировать cardinality, aggregation, missing data and retention;
- связывать запросы через distributed tracing;
- применять OpenTelemetry SDK and Collector;
- использовать sampling, baggage and semantic conventions;
- находить critical path and asynchronous gaps;
- коррелировать logs, metrics, traces and exemplars;
- профилировать CPU, memory, goroutines, locks and I/O;
- применять Linux performance tools and bounded eBPF diagnostics;
- проводить load tests and benchmarks without confusing them;
- проектировать health checks, synthetic and real-user observation;
- создавать actionable alerts, routing, deduplication and inhibition;
- реализовывать SLO/burn-rate alerting;
- эксплуатировать telemetry pipeline under backpressure and partial loss;
- управлять telemetry volume, privacy, retention and cost;
- локализовать неисправности между приложением, runtime, OS, network, storage and platform;
- восстанавливать техническую timeline and first divergence.

Ориентировочный объём: 330–460 часов.

## Планируемые тематические углубления

- **Advanced OpenTelemetry and telemetry pipelines**;
- **Prometheus query and metric-system engineering**;
- **Distributed tracing and asynchronous systems**;
- **Go and Linux performance profiling**;
- **eBPF diagnostics and continuous profiling**;
- **Alert quality and SLO-based monitoring**;
- **Log analytics and telemetry governance**;
- **Kubernetes and cloud-native troubleshooting**;
- **Database and network observability**;
- **Observability platform scalability and cost**.

Каждое углубление будет самостоятельным маршрутом.

## Связи с другими разделами

- Linux/system mechanisms — [«Операционные системы»](../02-Операционные%20системы/).
- Packet and protocol diagnosis — [«Сети и протоколы»](../03-Сети%20и%20протоколы/).
- Runtime and application instrumentation — [«Программирование и среды выполнения»](../04-Программирование%20и%20среды%20выполнения/).
- Database internals and query/storage diagnosis — [«Данные и хранилища»](../06-Данные%20и%20хранилища/).
- Kubernetes, containers and infrastructure signals — [«Инфраструктура и платформы»](../09-Инфраструктура%20и%20платформы/).
- Incident command and service recovery — [«Доставка и эксплуатация»](../10-Доставка%20и%20эксплуатация/).
- Partial failures and resilience models — [«Распределённые системы и надёжность»](../12-Распределённые%20системы%20и%20надёжность/).
- Telemetry privacy and access control — [«Безопасность»](../13-Безопасность/).
