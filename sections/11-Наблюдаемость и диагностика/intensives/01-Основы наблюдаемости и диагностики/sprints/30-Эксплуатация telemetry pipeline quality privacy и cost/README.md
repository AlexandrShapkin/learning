# Спринт 30. Эксплуатация telemetry pipeline, quality, privacy и cost

Ориентировочный объём: 20–30 часов.

## Центральный вопрос

Как эксплуатировать observability platform as a production dependency, контролируя ingestion loss, schema quality, access, retention, capacity and cost?

## Результат спринта

После завершения необходимо уметь:

- define telemetry platform SLOs and external checks;
- monitor agents, collectors, queues, stores and queries;
- measure accepted, dropped, retried and rejected data;
- understand backpressure and overload shedding;
- govern schemas, semantic conventions and ownership;
- enforce cardinality, payload and sample limits;
- manage tenancy, access and audit;
- classify sensitive telemetry and retention;
- estimate ingest/storage/query/egress cost;
- design graceful degradation and priority signals;
- plan upgrades and compatibility of collectors/stores;
- recover from data corruption or platform outage without harming applications.

## Основной маршрут

1. Inventory all telemetry producers, collectors, stores and consumers.
2. Define platform health and synthetic canary telemetry.
3. Overload logs, metrics and traces independently.
4. Apply priority, sampling, limits and retention policies.
5. Upgrade one Collector/store component with schema/query compatibility checks.

## Ресурсы

- OpenTelemetry Collector scaling and internal telemetry docs.
- Prometheus/Loki/Tempo storage and operations docs.
- Grafana access/multi-tenancy references.
- telemetry governance and privacy guidance.

## Лабораторная работа

Создать `work/observability-platform/`.

### Requirements

- dependency/data-flow map includes every producer, queue and store;
- external synthetic telemetry confirms end-to-end ingestion/query;
- accepted/dropped/retried/rejected counts are visible per signal;
- overload policy preserves user-impact and platform-health signals first;
- cardinality, event size, span count and tenant quotas are enforced;
- schema owners and compatibility tests exist;
- access roles separate operators, developers and sensitive environments;
- retention and deletion follow data classification;
- cost model separates ingestion, storage, indexing/query and egress;
- platform outage does not block application request path indefinitely;
- upgrade/rollback preserves queued data or documents bounded loss;
- recovery/cleanup procedures are exercised.

### Failure scenarios

1. Collector/drop metrics live only in failed observability backend.
2. One tenant/service exhausts shared ingestion/storage.
3. Retry/backpressure consumes application memory/disk.
4. Schema change breaks dashboards/alerts silently.
5. Sensitive logs/traces are broadly queryable.
6. Long retention is applied uniformly.
7. Query storm affects ingestion.
8. Upgrade changes protocol/schema and loses data.
9. Cost controls drop critical SLO/alert signals first.
10. Observability outage is mistaken for full application outage.

## Самопроверка

1. Observability platform SLOs?
2. External synthetic telemetry?
3. Accepted/dropped/rejected visibility?
4. Backpressure and shedding?
5. Priority signals?
6. Schema governance?
7. Tenancy/access/privacy?
8. Main cost dimensions?
9. Upgrade compatibility?
10. Application independence from telemetry outage?

## Результат для базы знаний

- **Observability platform architecture and health**.
- **Telemetry ingestion loss, backpressure and overload shedding**.
- **Telemetry schema governance and ownership**.
- **Telemetry privacy, access and retention**.
- **Observability platform capacity, cost and upgrades**.

## Когда переходить дальше

Можно переходить, когда telemetry loss and platform failure are externally detectable, one noisy producer cannot destabilize the system, and cost/privacy controls preserve critical diagnostic signals.