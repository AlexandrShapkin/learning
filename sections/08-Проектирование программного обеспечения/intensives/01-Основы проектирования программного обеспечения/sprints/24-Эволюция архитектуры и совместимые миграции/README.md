# Спринт 24. Эволюция архитектуры и совместимые миграции

Ориентировочный объём: 20–29 часов.

## Центральный вопрос

Как изменить module, contract, data ownership or deployment boundary постепенно, сохраняя работу старых и новых путей and avoiding a risky all-at-once rewrite?

## Результат спринта

После завершения необходимо уметь:

- проектировать evolutionary architecture around change increments;
- использовать expand-and-contract for code, API and data;
- применять branch by abstraction;
- использовать strangler pattern for route/capability migration;
- создавать seams and parallel run;
- управлять old/new compatibility window;
- определять source of truth during migration;
- применять shadow reads/writes cautiously;
- выполнять compare/reconciliation before cutover;
- проектировать feature flags with removal condition;
- различать rollback and forward fix;
- мигрировать data ownership between modules/services;
- учитывать background/replay/in-flight operations;
- сохранять idempotency and event/schema compatibility;
- измерять migration progress and correctness;
- планировать cleanup of temporary paths;
- избегать permanent dual architecture;
- решать when full rewrite is justified by evidence.

## Основной маршрут

### Шаг 1. Migration state machine

Define stages:

```text
prepare compatible seam
introduce new implementation/contract
copy/backfill state
shadow/compare or dual-read
switch selected traffic/source
verify and expand
stop old writes/reads
remove compatibility path
```

### Шаг 2. Contract and code evolution

Use additive API/event/schema changes and adapter layer. Old/new versions coexist under tests.

### Шаг 3. Data ownership migration

Move one data set from shared/legacy ownership to target module/service through backfill, change capture/outbox, reconciliation and cutover.

### Шаг 4. Failure and rollback

Interrupt each stage, restart, revert routing/flag where safe and verify no duplicated/lost state. Irreversible steps require forward repair.

## Ресурсы

- *Monolith to Microservices*, strangler/extraction patterns.
- *Refactoring*, parallel change and branch by abstraction.
- *Building Evolutionary Architectures*.
- Schema/data migration materials from data-storage intensive.

## Практические задания

1. Rename public concept through additive compatibility layer.
2. Replace one implementation via branch by abstraction.
3. Strangle one legacy endpoint/capability gradually.
4. Migrate table/data ownership between modules.
5. Run shadow comparison and reconcile differences.
6. Interrupt migration at each stage and resume/rollback.
7. Remove flag/adapter/old path after completion.

## Лабораторная работа

Создать `work/evolutionary-migration/`.

### Migration

Move notification or document-processing capability from tangled monolith internals to explicit module and optional extracted process/service.

### Requirements

- migration stages and invariants are explicit;
- old/new contracts coexist with compatibility tests;
- source of truth is defined at every stage;
- backfill is idempotent, restartable and verifiable;
- new changes during migration are captured;
- shadow comparison has metrics and accepted-difference policy;
- routing/feature flag changes are observable and reversible where possible;
- duplicate external effects are prevented;
- in-flight jobs/events and retries are accounted for;
- cutover requires counts/checksums/business invariants;
- cleanup removes compatibility code/data/flags;
- irreversible transitions have forward-fix procedure;
- final architecture fitness rules replace temporary migration checks.

### Failure scenarios

1. New code deployed before old client/schema compatibility exists.
2. Dual writes diverge with no reconciliation/source of truth.
3. Backfill misses concurrent changes.
4. Shadow path performs real external side effects.
5. Feature flag changes semantics per instance unpredictably.
6. Cutover occurs by percentage without entity/workflow consistency.
7. Rollback reactivates stale old data/path.
8. Old events/jobs continue after new owner takes control.
9. Temporary adapter/flag remains permanently.
10. Cleanup removes data before rollback/verification window closes.
11. “Strangler” becomes routing layer over two permanently coupled implementations.

## Самопроверка

1. Evolutionary architecture means what?
2. Expand-contract stages?
3. Branch by abstraction?
4. Strangler pattern?
5. Source of truth during migration?
6. Shadow read/write risks?
7. How capture concurrent changes?
8. Rollback versus forward fix?
9. What verifies cutover?
10. Why temporary migration paths need removal condition?

## Результат для базы знаний

- **Evolutionary architecture and incremental migration**.
- **Expand-and-contract for code, contracts and data**.
- **Branch by abstraction**.
- **Strangler migration pattern**.
- **Shadow comparison and reconciliation**.
- **Data ownership migration**.
- **Migration source of truth, rollback and forward fix**.
- **Temporary compatibility path cleanup**.

## Когда переходить дальше

Можно переходить, когда one architectural boundary is moved through restartable compatibility stages, cutover is verified by business invariants, and every temporary path has been removed or has an explicit remaining trigger.