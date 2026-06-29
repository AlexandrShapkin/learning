# Спринт 99. Итоговая работа

Ориентировочный объём: 50–80 часов.

## Задача

Создать `architecture-evolution-lab` — воспроизводимую Go-систему и набор архитектурных экспериментов, показывающих безопасное развитие намеренно запутанного приложения into an evidence-backed modular monolith with one selectively extracted runtime boundary.

Проект не является эталонной “чистой архитектурой” или production ERP. Его задача — доказать, что design decisions reduce named change/failure risks, preserve behavior and remain evolvable through executable contracts and migration paths.

## Domain

Synthetic work-management and fulfillment platform:

- organizations, users and memberships;
- work orders, lines and state transitions;
- catalog/inventory reservations;
- billing/settlement placeholder;
- fulfillment and document processing;
- attachments;
- notifications and external integrations;
- reporting/read models;
- audit/domain/integration events.

No production, personal or proprietary source/data is used.

## Starting point

The repository includes or generates an intentionally tangled baseline:

```text
legacy-app/
├── main.go
├── handlers.go
├── service.go
├── models.go
├── database.go
├── provider.go
└── globals.go
```

Traits:

- duplicated business rules;
- direct SQL/HTTP calls;
- global configuration/resources;
- shared canonical models;
- ambiguous states and primitives;
- missing tests;
- provider/storage DTO leakage;
- mixed synchronous/background effects;
- no module/data ownership;
- undocumented compatibility assumptions.

The baseline remains available for change-impact comparison.

## Target architecture

```text
clients/adapters
├── HTTP API
├── CLI/batch
└── message/job adapters
            |
     modular Go application
├── workorders module
├── inventory module
├── billing module
├── fulfillment module
├── identity module
├── notifications/integrations module
└── reporting module
            |
 PostgreSQL + outbox + local broker/object/provider adapters

optional extracted boundary:
- document processing or notifications worker/service
```

The exact package layout may differ. Boundaries must be justified by language, invariants, data ownership, changes and quality scenarios.

## Структура проекта

```text
work/architecture-evolution-lab/
├── baseline/
├── cmd/
│   ├── app/
│   ├── worker/
│   └── archtriage/
├── internal/
│   ├── modules/
│   │   ├── workorders/
│   │   ├── inventory/
│   │   ├── billing/
│   │   ├── fulfillment/
│   │   ├── identity/
│   │   ├── notifications/
│   │   └── reporting/
│   ├── adapters/
│   ├── architecture/
│   └── bootstrap/
├── contracts/
│   ├── http/
│   ├── events/
│   └── provider/
├── migrations/
├── fixtures/
├── diagrams/
├── adr/
├── scenarios/
├── reports/
├── scripts/
├── compose/
├── Makefile
├── go.mod
└── README.md
```

## Документы итоговой работы

- [`IMPLEMENTATION.md`](IMPLEMENTATION.md) — mandatory design evidence and implementation stages.
- [`FAULTS.md`](FAULTS.md) — catalogue of 50 bounded design/architecture faults.
- [`ASSESSMENT.md`](ASSESSMENT.md) — blind change/incident exercises, final defense and delayed assessment.

## Mandatory change scenarios

1. Add a new work-order transition rule.
2. Add a second provider implementation.
3. Add a CLI/batch entry point.
4. Change internal persistence representation.
5. Add a new reporting query without changing command model.
6. Split overloaded `Order` meaning between contexts.
7. Add compatibility-preserving API/event field evolution.
8. Move notification/document-processing capability behind a module contract.
9. Introduce background processing with outbox/idempotency.
10. Migrate owned data to the extracted boundary.
11. Handle provider outage, timeout and duplicate result.
12. Roll back or forward-fix a partial architecture migration.

Each scenario is performed or simulated against baseline and target architecture with comparable evidence.

## Mandatory quality scenarios

- modifiability: named rule/provider/report change locality;
- reliability: dependency outage and duplicate event handling;
- performance: command/read/background paths and call-chain cost;
- security: tenant/data/trust boundary preservation;
- testability: policy and adapter verification without false fakes;
- operability: correlation, architecture/runtime diagnostics and recovery;
- compatibility: old/new clients/messages during migration;
- deployability: modular monolith and extracted-boundary comparison;
- recoverability: interrupted backfill/cutover and source-of-truth restoration.

## Main results

The completed laboratory must include:

- baseline behavior and characterization tests;
- vocabulary and context map;
- entities, values, aggregates and state transitions;
- explicit application/domain/infrastructure boundaries;
- consumer-oriented ports and adapters;
- modular-monolith module/data ownership rules;
- contract versioning and anti-corruption translation;
- transactional outbox and idempotent async workflow;
- one real service/process extraction experiment;
- quality scenarios and architecture drivers;
- ADRs and reproducible context/container/component/dynamic views;
- architecture fitness functions and forbidden-dependency tests;
- expand-contract/strangler/branch-by-abstraction migration;
- architecture evaluation including no-change option and total cost;
- read-only `archtriage` and controlled fault injection;
- before/after change-impact and runtime evidence.

## Порядок выполнения

1. Build/generate legacy baseline and capture behavior.
2. Execute initial change scenarios and measure spread.
3. Improve names, invariants, functions, packages and dependencies.
4. Introduce domain model and bounded contexts proportionally.
5. Establish layered/hexagonal application boundaries.
6. Form modular monolith with executable module/data rules.
7. Add event/outbox integration and versioned contracts.
8. Define quality scenarios, ADRs, diagrams and fitness checks.
9. Perform one incremental extraction/data migration experiment.
10. Evaluate alternatives, costs and accepted risks.
11. Implement fault catalogue and `archtriage`.
12. Run blind changes/incidents, final defense and delayed assessment.

## Обязательные артефакты

Коммитить:

- baseline and target source with tests;
- small synthetic fixtures and migrations;
- context map and vocabulary;
- state/aggregate/module/data-ownership diagrams;
- architecture rules and compatibility tests;
- quality scenarios and concise evaluation reports;
- ADRs with alternatives/consequences;
- generated-diagram sources and commands;
- migration/backfill/reconciliation scripts;
- change-impact comparisons;
- fault definitions and incident/design cards;
- links to generalized `knowledge` notes.

Не коммитить:

- proprietary/production code or architecture documents;
- real customer/data/credentials;
- database/container volumes;
- binaries/caches;
- huge raw dependency/history/profile outputs;
- generated diagrams without source;
- unbounded load/migration/fault scripts;
- framework templates copied without modification/analysis.

## Safety

- all services bind locally and use synthetic data;
- fault/migration scripts require repository marker and explicit lab flag;
- extracted service experiments use isolated ports/databases;
- workloads cap rows, messages, requests, retries and duration;
- destructive migrations target disposable schemas/data;
- external calls terminate in local sandbox;
- cleanup verifies processes, ports, containers, schemas, queues and temporary branches/files.

## Результат для базы знаний

Итоговая работа должна завершить или исправить заметки по complexity, cohesion/coupling, contracts, dependencies, design principles, refactoring, DDD, patterns, architecture styles, bounded contexts, integration contracts, quality attributes, ADRs, fitness functions, evolutionary migration, legacy systems and architecture evaluation.

Source code, diagrams, ADRs, change reports and incident evidence remain in `learning`; generalized mechanisms move to `knowledge`.
