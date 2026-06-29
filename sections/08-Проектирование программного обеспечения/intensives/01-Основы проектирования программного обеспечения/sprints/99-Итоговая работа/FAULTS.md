# Каталог неисправностей

Каждый fault включается только в explicit laboratory mode, имеет bounded scope, expected evidence, disable/rollback path and post-check. Fault tooling never targets unrelated repositories, hosts or data.

## Complexity, code and modules

1. `duplicated-policy` — one business rule differs across handler, worker and consumer.
2. `misleading-language` — the same term has conflicting meanings in one context.
3. `primitive-invalid-state` — invalid money/status/ID bypasses model through primitive or zero value.
4. `mutable-exposure` — caller mutates internal slice/map/entity fields.
5. `mixed-responsibility` — one component parses, decides, persists and emits effects.
6. `utility-hub` — common/helper package becomes dependency and policy center.
7. `shotgun-change` — one rule/provider change touches many unrelated packages.
8. `divergent-component` — one package changes for unrelated business/infrastructure reasons.
9. `service-locator-global` — hidden global dependency/configuration changes behavior.
10. `fake-contract-gap` — fake adapter has stronger/different semantics than real implementation.

## Dependencies, principles and refactoring

11. `broad-interface` — provider-like interface exposes unrelated methods to every consumer.
12. `interface-theater` — interfaces package exists only to invert arrows cosmetically.
13. `dependency-cycle-workaround` — re-export/neutral package hides conceptual cycle.
14. `wrong-dry-abstraction` — similar but independently evolving concepts share one abstraction.
15. `speculative-extension` — plugin/factory/strategy exists for unsupported variants.
16. `pass-through-layer` — handler/service/repository chain only forwards arguments.
17. `giant-refactor` — behavior, migration and structure change in one unrevertable commit.
18. `temporary-forever` — compatibility adapter/flag has no removal condition.
19. `local-cleanup-system-regression` — local code improves while target change/runtime dependency worsens.
20. `debt-without-impact` — aesthetic debt drives work without change/incident/risk evidence.

## Domain model and patterns

21. `entity-equality` — entity identity depends on mutable attributes.
22. `oversized-aggregate` — global/unbounded aggregate creates contention/loading/coupling.
23. `aggregate-bypass` — child/state is mutated outside aggregate root.
24. `domain-service-god` — “domain service” performs repositories, HTTP and orchestration.
25. `state-boolean-explosion` — contradictory process states exist through booleans.
26. `event-command-confusion` — imperative request is published as fact or vice versa.
27. `canonical-domain-model` — all contexts share one `Order/User/Product` model.
28. `shared-kernel-growth` — shared kernel becomes global common domain.
29. `pattern-without-forces` — pattern adds types/indirection without real variants.
30. `generic-repository` — universal CRUD/filter abstraction hides transaction/query semantics.

## Application and modular architecture

31. `layer-direction` — domain/application imports HTTP, SQL or provider details.
32. `transaction-leak` — transaction ownership is split or SQL transaction leaks into core.
33. `module-internal-import` — one module imports another module’s internals.
34. `cross-module-data-write` — module updates another module’s tables directly.
35. `god-module` — one coordinator module owns policy/data from most modules.
36. `reporting-backdoor` — reporting/read path writes operational data or bypasses module contracts.
37. `event-bus-locator` — in-process bus hides synchronous dependencies and ownership.
38. `shared-transaction-coupling` — convenience transaction silently binds modules that should evolve independently.

## Events, services and contracts

39. `outbox-gap` — state commits without durable event or event publishes before state commit.
40. `event-replay-effect` — replay repeats irreversible payment/notification/provider effect.
41. `choreography-no-owner` — multi-step workflow has no process state or reconciliation owner.
42. `service-shared-database` — extracted service still depends on monolith internal tables/schema.
43. `sync-chain-cascade` — synchronous service chain amplifies latency/outage/retries.
44. `semantic-contract-break` — schema remains valid but field/event meaning changes incompatibly.
45. `acl-leak` — anti-corruption layer forwards provider model/semantics directly.
46. `dual-path-divergence` — old/new read/write paths disagree without source/comparison/repair.

## Architecture evidence and evolution

47. `diagram-decision-drift` — diagrams/ADRs describe boundaries no longer present in code/runtime.
48. `fitness-backdoor` — ignored/allowlisted architecture-rule exception becomes permanent dependency path.
49. `migration-cutover-gap` — data/contract ownership switches before backfill/in-flight/reconciliation verification.
50. `distribution-without-driver` — service extraction adds network/deployment/operations cost without quality-scenario benefit.

## Combined scenario library

Assessment may combine faults, for example:

- duplicated policy + state boolean explosion + generic repository;
- utility hub + hidden cycle + broad interface;
- oversized aggregate + shared transaction + lock/runtime contention;
- canonical model + cross-module data write + semantic contract break;
- outbox gap + choreography without owner + replayed side effect;
- shared-database service + synchronous chain + timeout retry cascade;
- temporary compatibility path + dual divergence + cutover gap;
- stale ADR + fitness exception + distribution without driver;
- giant refactor + weak characterization + provider contract mismatch;
- local cleanup + change amplification + no quality-scenario evidence.

## Fault definition contract

Each implementation includes:

```text
name and category
preconditions and synthetic target
exact injected structural/runtime change
expected change/behavior/incident symptom
expected import/history/test/trace/contract evidence
maximum scope, duration, requests, rows and messages
disable or rollback steps
baseline verification
regression or architecture guard proving repair
```

## Safety contract

Fault tooling must:

- require repository marker, expected path and explicit `--lab` flag;
- reject unrelated repositories, non-local endpoints and production-like data;
- print target, scope and planned effect before activation;
- cap files, rows, requests, messages, retries, workers and duration;
- create changes on dedicated branch/worktree where practical;
- preserve baseline commit and synthetic database backup before destructive migration cases;
- never output secrets, real paths/data or proprietary source;
- support `status`, `disable`, `rollback-all` and `cleanup`;
- verify code tree, tests, schemas, services, queues and temporary branches after cleanup;
- retain only minimal sanitized failing evidence in Git.
