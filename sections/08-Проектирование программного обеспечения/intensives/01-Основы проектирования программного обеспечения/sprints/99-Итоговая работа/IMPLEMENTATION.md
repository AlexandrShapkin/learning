# Реализация итоговой работы

## 1. Baseline and behavior

Create an intentionally tangled but runnable Go application with:

- HTTP/CLI entry points;
- PostgreSQL persistence;
- work-order, inventory, billing and notification behavior;
- one background task;
- one external provider sandbox;
- duplicated rules and mixed concerns;
- deterministic synthetic fixtures.

Before redesign:

- establish characterization and critical behavior tests;
- record import/dependency graph;
- record exported API and mutable globals;
- execute mandatory change scenarios 1–6;
- measure touched files/packages/decisions and runtime/data effects;
- preserve baseline commits and commands.

## 2. Vocabulary and context model

Produce:

- vocabulary of at least 30 terms;
- ambiguous terms and context-specific meanings;
- subdomain/context candidates;
- context map and upstream/downstream relationships;
- source-of-truth and data ownership map;
- published contract and anti-corruption boundaries.

At least three bounded contexts must be implemented as independent modules/models. Contexts are not automatically deployment units.

## 3. Core code design

Refactor through small behavior-preserving commits:

- precise naming and explicit values;
- invariant-owning types and transitions;
- cohesive functions/types/packages;
- encapsulated collections and capabilities;
- contextual errors;
- no mutable package globals or service locator;
- explicit resource lifecycle;
- consumer-owned interfaces only for real boundaries/variants;
- one composition root.

Repeat initial changes and compare impact.

## 4. Domain model

Implement proportionate modeling:

- entities and value objects;
- aggregates with named invariants;
- state-transition tables;
- domain services only for ownerless policy;
- application services for orchestration;
- domain events and integration-event translation;
- repositories around aggregate lifecycle;
- tailored direct SQL/read model for reporting;
- transaction/outbox coordination.

Simple CRUD/reference capabilities may remain Transaction Scripts if evidence supports it.

## 5. Application boundaries

Required structure/evidence:

- presentation adapters parse/map protocol;
- application layer owns use-case orchestration, authorization and transaction scope;
- domain packages own business decisions/invariants;
- infrastructure adapters own SQL/network/filesystem/provider concerns;
- driving adapters include HTTP and CLI/batch;
- driven adapters include PostgreSQL, in-memory test adapter, provider sandbox and outbox/broker;
- no domain import of HTTP/SQL/provider packages;
- transaction runner does not leak `*sql.Tx` into domain.

## 6. Modular monolith

Modules should include at least:

- workorders;
- inventory;
- billing;
- fulfillment/document processing;
- identity/membership;
- notifications/integrations;
- reporting.

Requirements:

- one explicit public API per module or similarly enforceable boundary;
- internal packages hidden;
- allowed dependency matrix;
- no cycles;
- module-owned writes/data;
- no direct command access to another module’s tables;
- cross-module calls/events documented;
- reporting/read paths do not become write backdoors;
- shared kernel, if any, is tiny and governed;
- at least five target changes remain localized.

## 7. Patterns and proportionality

Assess at least twelve patterns across GoF and enterprise catalogs. For each record:

- context/problem/forces;
- simpler Go/direct alternative;
- consequences and failure modes;
- reason kept/rejected/removed.

Mandatory implemented/comparison cases:

- Adapter;
- Strategy/function alternative;
- Decorator with error/idempotency awareness;
- state table versus State pattern;
- Transaction Script versus Domain Model;
- Repository versus direct SQL read model;
- application service;
- process manager;
- anti-corruption layer.

No generic base repository/service/plugin framework is allowed without demonstrated need.

## 8. Events and asynchronous workflow

Implement:

```text
source transaction
→ domain fact
→ integration-event translation
→ transactional outbox
→ broker/consumer
→ idempotent processing
→ process state/read model
```

Requirements:

- versioned event IDs and aggregate versions;
- explicit ordering scope;
- duplicate/reordered/delayed handling;
- process manager for multi-step workflow;
- user-visible pending/failed/manual states;
- replay-safe projections;
- irreversible effects excluded from blind replay;
- dead-letter/reconciliation ownership;
- correlation/causation evidence.

## 9. Integration contracts

Create versioned contracts for:

- public/internal HTTP API;
- provider sandbox;
- integration events;
- reporting feed;
- optional protobuf service for extracted boundary.

Requirements:

- internal model not shared directly;
- semantic adapters/ACLs;
- old/new consumer/provider compatibility tests;
- enum/presence/default/null policies;
- error, idempotency and ordering semantics;
- deprecation/removal conditions;
- stored-event replay compatibility;
- semantic-change migration even when schema remains valid.

## 10. Quality scenarios and drivers

Define and prioritize at least 15 quality scenarios covering:

- modifiability;
- performance;
- reliability/availability;
- security/isolation;
- testability;
- operability/diagnostics;
- compatibility;
- deployability;
- recoverability.

Each includes source, stimulus, environment, artifact, response and measure. Link every major architectural decision to one or more scenarios.

## 11. ADRs and diagrams

Required:

- at least 12 ADRs;
- context, container and component/module views;
- critical workflow sequence view;
- data/module ownership view;
- migration/cutover view;
- trust/failure boundary view;
- source/generation commands;
- superseded decision example.

ADRs include alternatives, negative consequences, assumptions, validation and review trigger.

## 12. Architecture fitness functions

Automate at least:

- forbidden Go imports;
- dependency cycles;
- module public/internal boundary;
- forbidden shared model/common dependency;
- cross-module data access rule where statically/checkably represented;
- API/protobuf/event compatibility;
- critical characterization/quality smoke tests;
- temporary migration flag/path expiration check;
- maximum allowed synchronous dependency chain or explicit reviewed allowlist.

Rules must fail on deliberate violations with actionable messages.

## 13. Evolutionary migration

Perform one complete migration:

```text
introduce seam and compatible contract
→ add target module/implementation
→ backfill/copy owned data
→ capture concurrent changes
→ shadow/compare or dual-read
→ cut over selected traffic/entities
→ verify business invariants
→ stop old writes/reads
→ remove compatibility code/data/flag
```

The migration must survive interruption/restart. Source of truth, rollback/forward-fix and in-flight events/jobs are explicit at every stage.

## 14. Selective extraction experiment

Extract document processing, notifications or reporting into a separate local process/service.

Requirements:

- named independent scaling/fault/release driver;
- versioned API/message contract;
- independent runtime and state ownership where applicable;
- no direct access to monolith internal tables after cutover;
- timeout/retry/idempotency/ambiguity semantics;
- traces and operability;
- local development/test support;
- coexistence/rollback path;
- measured added deployment/network/testing/operations cost;
- final recommendation may reverse the extraction.

## 15. Legacy rescue exercise

Preserve a separate baseline or subsystem and demonstrate:

- characterization tests;
- seams for time/global/provider/database;
- sprout/wrap technique;
- intentional correction of one characterized bug;
- incremental replacement;
- comparison and retirement of old path;
- real adapter contract test after fakes.

## 16. Architecture evaluation

Compare at least:

1. existing/tightened layered monolith;
2. modular monolith;
3. modular monolith plus extracted boundary;
4. broader service decomposition;
5. no further change.

Evaluation includes scenarios, risks, sensitivity/trade-off points, reversibility and total ownership cost:

- implementation/migration;
- infrastructure;
- CI/CD/environments;
- testing/local development;
- observability/on-call/security;
- data duplication/reconciliation;
- compatibility/deprecation;
- cognitive/coordination load.

## 17. Diagnostics

`archtriage` provides read-only bounded evidence for:

```text
imports and cycles
change/co-change history
module and exported API
contract compatibility
module/data ownership
runtime trace/call chain
migration state
ADR/diagram/fitness alignment
change-scenario impact
```

It never applies refactoring automatically and does not expose secrets or proprietary paths.

## 18. Test and verification commands

```text
make fmt
make lint
make test
make test-race
make test-integration
make test-contracts
make test-architecture
make test-characterization
make scenario-changes
make migrate-test
make extraction-test
make evaluate
make fault-smoke
make cleanup
```

## 19. Implementation stages

### Stage 1. Baseline and change evidence

Build baseline, characterize behavior and execute initial change scenarios.

### Stage 2. Code and dependency design

Improve naming, invariants, cohesion, contracts, composition and refactoring safety.

### Stage 3. Domain and context model

Introduce values/entities/aggregates/workflows/contexts proportionately.

### Stage 4. Application and modular architecture

Establish layers, ports/adapters and modular-monolith boundaries.

### Stage 5. Contracts and asynchronous architecture

Add integration translation, outbox/events/process manager and compatibility tests.

### Stage 6. Architecture evidence

Add quality scenarios, ADRs, diagrams and fitness functions.

### Stage 7. Evolution and extraction

Perform compatibility migration and selective process/service extraction.

### Stage 8. Evaluation and diagnostics

Compare alternatives/costs, implement `archtriage`, faults and blind incidents.

### Stage 9. Assessment

Run clean rebuild, change/failure exercises, final defense and delayed assessment.
