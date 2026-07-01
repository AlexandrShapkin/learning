# Спринт 26. Health checks, synthetic monitoring и RUM

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как наблюдать service readiness and user journeys from inside and outside without allowing health endpoints to create false confidence or restart loops?

## Результат спринта

После завершения необходимо уметь:

- distinguish startup, readiness and liveness checks;
- design shallow versus deep health checks;
- avoid liveness dependence on shared external systems;
- use black-box synthetic HTTP/DNS/TLS probes;
- create multi-step synthetic transactions safely;
- understand probe location and network-path bias;
- distinguish synthetic monitoring from real-user monitoring;
- use browser/navigation/resource timing at overview level;
- correlate external failures with internal telemetry;
- manage probe credentials and test data;
- define check intervals, timeouts and failure thresholds;
- observe the checker itself.

## Основной маршрут

1. Implement startup/readiness/liveness endpoints with distinct semantics.
2. Add external HTTP/DNS/TLS probe.
3. Build a synthetic create/read/delete user journey.
4. Simulate dependency failure and compare internal/external views.
5. Add minimal browser/RUM timing or faithful synthetic alternative.

## Ресурсы

- Kubernetes probe documentation.
- Prometheus Blackbox Exporter docs.
- browser performance/RUM references.

## Лабораторная работа

Создать `work/health-synthetic-rum/`.

### Requirements

- liveness detects unrecoverable process state only;
- readiness represents ability to serve current traffic safely;
- startup protects slow initialization from premature liveness actions;
- deep dependency checks do not overload dependencies;
- external probe validates DNS, TLS, routing and response semantics;
- synthetic transaction uses isolated data and compensating cleanup;
- probe locations/paths and blind spots are documented;
- checker failure is distinguished from target failure;
- RUM/synthetic data contains no sensitive user details;
- probe alerts use consecutive/window logic rather than one failure;
- dashboard links external symptom to internal service/dependency evidence.

### Failure scenarios

1. Liveness checks database and restarts every replica during DB outage.
2. Readiness returns green before schema/cache/provider is usable.
3. Health endpoint succeeds while real authenticated path fails.
4. Probe runs inside same cluster/network failure domain.
5. Synthetic transaction creates permanent test records.
6. Probe credential expires or is rate-limited.
7. DNS/TLS failure is missed by direct internal IP check.
8. Checker outage pages every service.
9. RUM data is biased by blocked/unsupported clients.

## Самопроверка

1. Startup/readiness/liveness?
2. Shallow versus deep check?
3. Why avoid external dependencies in liveness?
4. Black-box versus white-box?
5. Probe-location bias?
6. Multi-step synthetic safety?
7. Synthetic versus RUM?
8. How observe checker health?
9. Consecutive/window failures?
10. Internal/external correlation?

## Результат для базы знаний

- **Startup, readiness and liveness checks**.
- **Black-box and synthetic service monitoring**.
- **Synthetic user transactions and test-data cleanup**.
- **Real-user monitoring and measurement bias**.
- **Health-check failure modes and external/internal correlation**.

## Когда переходить дальше

Можно переходить, когда the same failure is visible through an external user path and internal signals, while checker/dependency failures do not trigger destructive restart loops.