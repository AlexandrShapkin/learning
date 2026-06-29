# Спринт 18. Модульный монолит и компонентные границы

Ориентировочный объём: 20–29 часов.

## Центральный вопрос

Как сохранить простоту one deployment/process while enforcing domain/component boundaries strong enough for independent evolution and possible future extraction?

## Результат спринта

После завершения необходимо уметь:

- различать monolith, big ball of mud and modular monolith;
- определять module by capability/context and owned data;
- проектировать public module API and hidden internals;
- запрещать direct cross-module internal imports;
- управлять synchronous in-process calls and domain events;
- определять database/schema ownership within one database;
- избегать cross-module table access;
- выбирать shared transaction versus module independence consciously;
- проектировать module composition and startup;
- создавать architecture tests for import/data boundaries;
- понимать deployment simplicity and runtime coupling;
- измерять module change locality and cycles;
- использовать internal packages and module facades;
- проектировать extraction seam without pretending services already exist;
- учитывать migrations and reporting across modules;
- сравнивать modular monolith with layered monolith and microservices.

## Основной маршрут

### Шаг 1. Module candidates

Use bounded contexts and change history to define:

- Work Orders;
- Catalog/Inventory;
- Billing;
- Fulfillment;
- Identity/Membership;
- Notifications/Integrations;
- Reporting.

For each define purpose, API, owned data, events and forbidden dependencies.

### Шаг 2. Code boundary

Implement packages/modules with one exported facade/application API. Internal domain/adapters remain unexported/internal.

### Шаг 3. Data boundary

Use schemas/table ownership or clear repository ownership. Reporting may use published read models/views rather than arbitrary cross-module joins from command code.

### Шаг 4. Interaction and extraction

Use direct in-process calls for immediate required result and events for decoupled reactions. Extract one adapter/process boundary experimentally only after module contract is stable.

## Ресурсы

- Modular-monolith literature and case studies.
- DDD bounded contexts and context mapping.
- Go internal/package/module documentation.
- Database ownership and event/outbox materials.

## Практические задания

1. Convert one layered package set into capability modules.
2. Define exported facade for three modules.
3. Detect direct internal/table access and replace with contract.
4. Add architecture tests for import cycles/allowed dependencies.
5. Build reporting read model across modules.
6. Compare shared transaction and event-mediated workflow.
7. Simulate extraction of one stable module adapter.

## Лабораторная работа

Создать `work/modular-monolith/`.

### Target structure

```text
internal/modules/
├── workorders/
│   ├── api.go
│   └── internal/...
├── inventory/
├── billing/
├── fulfillment/
├── identity/
└── notifications/
```

Exact layout may differ, but public/internal boundary must be enforceable.

### Requirements

- each module owns vocabulary, behavior and persistence writes for its data;
- external module access goes through explicit API/event contract;
- no import cycles;
- no direct cross-module internal package import;
- command code does not query another module’s tables directly;
- shared database transactions are used only for named atomic invariant and documented coupling;
- cross-module async workflow has idempotency/reconciliation;
- reporting path does not become backdoor command dependency;
- composition root starts modules and resources explicitly;
- architecture tests verify allowed dependency matrix;
- at least five change scenarios remain inside one/two intended modules;
- extraction experiment records added network/data/operational cost.

### Failure scenarios

1. Folders are called modules but share one global model/repository.
2. Public facade exports every internal type.
3. Modules query/update each other’s tables.
4. Shared transaction is used for convenience and prevents separation.
5. Event bus becomes hidden in-process service locator.
6. Reporting module owns no source but writes back into operational tables.
7. Shared `common` package contains domain logic from all modules.
8. Architecture tests check folder names but not imports/data access.
9. One module depends on all others and becomes new god module.
10. Extraction is claimed easy without contract/data/runtime experiment.

## Самопроверка

1. Monolith versus big ball of mud?
2. What makes monolith modular?
3. Module boundary evidence?
4. What belongs in module public API?
5. How module owns data in one database?
6. Direct call versus internal event?
7. Shared transaction trade-off?
8. How reporting crosses modules safely?
9. What architecture tests can enforce?
10. Why modular monolith may precede microservices?

## Результат для базы знаний

- **Monolith, big ball of mud and modular monolith**.
- **Capability module and public module API**.
- **Module data ownership in a shared database**.
- **In-process calls and module events**.
- **Architecture tests for modular boundaries**.
- **Shared transaction versus module independence**.
- **Reporting/read models across modules**.
- **Module extraction seam and cost**.

## Когда переходить дальше

Можно переходить, когда module import/data boundaries are executable and change scenarios remain localized, while one extraction experiment demonstrates both feasibility and added distribution cost.