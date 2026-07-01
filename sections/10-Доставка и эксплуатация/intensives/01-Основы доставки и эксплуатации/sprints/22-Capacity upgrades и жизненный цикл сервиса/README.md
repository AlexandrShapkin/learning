# Спринт 22. Capacity, upgrades и жизненный цикл сервиса

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как планировать рост, обслуживание, dependency/runtime upgrades and retirement so that service capacity and compatibility do not fail unexpectedly?

## Результат спринта

После завершения необходимо уметь:

- forecast baseline, peak, growth and failure capacity;
- distinguish throughput, concurrency, saturation and headroom;
- identify scaling bottleneck across app, database, queue and platform;
- plan maintenance and one-failure capacity;
- manage runtime/library/base-image/dependency upgrades;
- understand support windows and end-of-life risk;
- use compatibility matrices and staged upgrades;
- define deprecation and service retirement process;
- plan data/archive/export and credential cleanup;
- verify capacity after release and configuration changes;
- avoid permanent overprovisioning as only strategy;
- maintain an operational lifecycle calendar with triggers, not bureaucracy.

## Основной маршрут

1. Measure normal and peak resource/throughput behavior.
2. Model 2× growth, one-node loss and maintenance.
3. Upgrade Go/runtime/base image/database client or Kubernetes dependency in stages.
4. Simulate end-of-support and service retirement.

## Лабораторная работа

Создать `work/service-lifecycle/`.

### Requirements

- capacity model includes user traffic, jobs, storage, connections and dependencies;
- headroom is justified for peak, rollout, maintenance and failure;
- bottleneck test identifies first saturation point;
- upgrade matrix covers old/new app, runtime, schema and dependencies;
- upgrade uses canary/staging and recovery path;
- end-of-life dates and owners are tracked by actionable triggers;
- deprecated interface/version has usage evidence and migration notice;
- retirement exports/archives required data and revokes credentials/routes;
- post-retirement checks confirm no traffic, jobs, resources or cost remain;
- capacity/upgrade reports avoid false precision and state assumptions.

### Failure scenarios

1. Average load hides peak/concurrency saturation.
2. Scale application while database connection/IO remains bottleneck.
3. Upgrade changes defaults/protocol compatibility silently.
4. Maintenance uses all failure headroom.
5. Base image/runtime becomes unsupported and cannot rebuild.
6. Deprecated client still sends traffic at removal.
7. Retired service leaves scheduler jobs, DNS, credentials or storage.
8. Overprovisioning hides inefficient or unbounded workload indefinitely.

## Результат для базы знаний

- **Service capacity planning and headroom**.
- **Operational scaling bottlenecks**.
- **Service dependency and runtime upgrades**.
- **Support windows and end-of-life risk**.
- **Service deprecation and retirement**.

## Когда переходить дальше

Можно переходить, когда service capacity survives peak/maintenance/failure scenarios and one staged upgrade plus one retirement exercise preserve compatibility and remove residual resources.