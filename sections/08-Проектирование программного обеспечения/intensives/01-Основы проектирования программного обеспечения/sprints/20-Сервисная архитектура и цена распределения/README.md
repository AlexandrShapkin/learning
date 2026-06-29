# Спринт 20. Сервисная архитектура и цена распределения

Ориентировочный объём: 20–29 часов.

## Центральный вопрос

Когда deployment/process/data separation into services provides enough independent change or scaling value to justify network, consistency and operational costs?

## Результат спринта

После завершения необходимо уметь:

- различать modular boundary and service boundary;
- определять service ownership by business capability and data;
- понимать independent deployment as capability and cost;
- учитывать network latency, partial failure and retries;
- понимать distributed transaction limitations;
- проектировать service API/message contract;
- выбирать data ownership and duplication strategy;
- избегать shared database as hidden monolith coupling;
- понимать synchronous call chains and availability multiplication;
- применять timeout, circuit/bulkhead and fallback only with semantics;
- оценивать deployment, observability, testing and support overhead;
- различать scale-by-component and organizational autonomy drivers;
- понимать service granularity and nanoservice/god-service risks;
- проектировать extraction from modular monolith incrementally;
- сравнивать monolith, modular monolith and services by quality scenarios;
- отклонять microservice decomposition without evidence.

## Основной маршрут

### Шаг 1. Drivers

A service boundary requires named drivers such as:

- independent release cadence;
- independent ownership/security boundary;
- distinct scaling/resource profile;
- fault isolation;
- technology/runtime constraint;
- external product/platform contract.

“Best practice” and team size alone are insufficient.

### Шаг 2. Distributed costs

For one extraction enumerate:

```text
network/protocol
timeouts/retries/ambiguity
consistency and duplicated data
contract compatibility
observability and incident ownership
deployment/security/configuration
local development and testing
```

### Шаг 3. Extraction experiment

Extract one stable module behind HTTP/gRPC/message adapter. Keep contract and data migration explicit. Run failure and latency scenarios.

### Шаг 4. Decision

Compare retained modular monolith, extracted service and hybrid alternative against quality scenarios and total ownership cost.

## Ресурсы

- *Monolith to Microservices*.
- *Building Microservices*, selected chapters.
- DDIA distributed-data/message chapters.
- Release It! stability patterns.
- Adjacent distributed systems intensive for deeper mechanisms.

## Практические задания

1. Write service-boundary driver matrix for three modules.
2. Calculate synchronous availability/latency chain implications.
3. Extract one module into local service with owned data copy/migration.
4. Reproduce timeout, duplicate retry and unavailable dependency.
5. Replace cross-service join with API/read model/duplication strategy.
6. Compare deployment/test/observability complexity.
7. Reject at least one proposed service extraction.

## Лабораторная работа

Создать `work/service-boundary-lab/`.

### Candidate extraction

Notification, document processing or reporting is preferred because it can demonstrate independent resource/failure profile without forcing transactional core apart.

### Requirements

- extraction driver and rejected alternatives documented;
- service owns its runtime and persisted state where appropriate;
- no direct access to monolith internal tables after target migration;
- API/message contract is versioned and tested;
- timeout/retry/idempotency/ambiguity semantics explicit;
- duplicated/read data has source and reconciliation;
- synchronous dependency chain is bounded;
- local development/test commands remain reproducible;
- traces/logs correlate across boundary;
- deployment/config/secret/monitoring additions are counted;
- rollback/coexistence path exists;
- before/after quality-scenario evidence includes added costs.

### Failure scenarios

1. Package is moved behind HTTP but still shares database and release lifecycle.
2. Every module becomes service without independent driver.
3. Synchronous chain creates coupled availability and latency.
4. Retry duplicates non-idempotent operation.
5. Service boundary cuts an atomic invariant without process design.
6. Shared database permits schema changes that break service secretly.
7. Cross-service reporting performs chatty fan-out joins.
8. Local testing requires entire production-like estate.
9. Ownership/on-call/observability is undefined.
10. Extraction improves diagram but worsens target changes.
11. Return to monolith or rollback path is absent.

## Самопроверка

1. Module versus service boundary?
2. What drivers justify service?
3. Independent deployability costs what?
4. How synchronous calls multiply risk?
5. Why shared database weakens service boundary?
6. Distributed transaction alternatives?
7. Data duplication needs what?
8. Service granularity risks?
9. What makes extraction incremental/reversible?
10. Which evidence can reject microservices?

## Результат для базы знаний

- **Module and service boundaries**.
- **Service decomposition drivers**.
- **Cost of distributed service architecture**.
- **Synchronous dependency chains and partial failure**.
- **Service data ownership and duplication**.
- **Incremental service extraction**.
- **Microservice granularity and shared-database traps**.
- **Modular monolith versus services evaluation**.

## Когда переходить дальше

Можно переходить, когда one extraction has real contract/data/failure evidence and total operational cost, and at least one service proposal is rejected because modularity provides the required benefit more cheaply.