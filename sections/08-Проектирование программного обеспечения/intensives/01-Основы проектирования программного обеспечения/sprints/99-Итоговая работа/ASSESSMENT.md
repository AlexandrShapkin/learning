# Итоговая проверка

## Blind change and incident exercise

Решить минимум 18 hidden exercises:

- four code/module/dependency changes;
- four domain/model/pattern changes;
- four architecture/contract/migration cases;
- two evaluation/documentation cases;
- four combined cases.

Combined examples:

- duplicated policy + wrong aggregate + generic repository;
- shared canonical model + cross-module table access + contract evolution;
- outbox gap + choreography without owner + replayed notification;
- service extraction + shared database + synchronous retry cascade;
- legacy seam + global race + weak fake contract;
- dual-path migration + old event consumer + stale feature flag;
- outdated ADR + fitness exception + hidden dependency cycle;
- local refactor + improved metric + worse target change locality.

For each exercise:

```text
Change request or user/runtime symptom
Affected capabilities, modules and versions
Initial behavior/evidence-preservation action
Expected invariant, contract and ownership
Import/history/test/runtime evidence
First missing, duplicated or leaked design decision
Ranked hypotheses and discriminating experiment
Root cause, trigger and secondary effects
Minimal reversible repair or justified no-change
Behavior, change-locality and runtime verification
Architecture guard, contract test or decision update
```

## Clean reconstruction

From clean checkout and empty local volumes:

1. verify Go/container/PostgreSQL/tool environment;
2. build and test the legacy baseline;
3. generate deterministic fixtures;
4. reproduce baseline change-impact report;
5. build target modular monolith;
6. run unit, characterization, integration, contract and architecture tests;
7. generate context/module/dependency diagrams and ADR index;
8. start broker/provider/extracted-boundary experiment;
9. execute quality and mandatory change scenarios;
10. run migration/extraction/rollback verification and cleanup.

## Change exercise

Without reading prepared solution notes, implement three random changes:

- one domain invariant/state transition;
- one new integration/provider/contract variant;
- one reporting or deployment-boundary change.

For each compare baseline and target:

- touched files/packages/modules;
- duplicated/new decisions;
- migration and compatibility work;
- tests/evidence required;
- runtime/operational consequences;
- whether architecture should remain unchanged.

## Evolution failure exercise

Perform one complete scenario:

1. introduce compatible module/contract seam;
2. begin restartable backfill/data ownership transfer;
3. interrupt before concurrent changes are caught up;
4. resume and reconcile;
5. switch selected traffic to new path;
6. deliver old and duplicate events;
7. fail the extracted dependency temporarily;
8. roll back routing or forward-fix according to state;
9. verify one source of truth and no duplicate effect;
10. remove temporary path/flag after completion.

## Architecture review exercise

Evaluate a new proposal: split three core modules into separate services. The result may approve, modify or reject it. Required evidence:

- quality scenarios and drivers;
- module/context/data boundaries;
- network/consistency/deployment costs;
- migration/reversibility;
- no-change and selective-extraction alternatives;
- highest uncertainty experiment;
- accepted risks and triggers.

## Final defense

Answer using project evidence:

1. Essential versus accidental complexity?
2. How does design reduce change amplification and cognitive load?
3. How are naming, locality and invariants connected?
4. How are cohesion, coupling and package boundaries evaluated?
5. What should encapsulation and a software contract hide/state?
6. How are dependencies, composition root and interfaces organized in Go?
7. How are SOLID/DRY/KISS/YAGNI used without dogma?
8. How is behavior preserved during refactoring and debt prioritized?
9. Entity, value object and aggregate differences?
10. Domain service, application service, domain event and process manager roles?
11. How are state machines and long-running workflows modeled?
12. How do ubiquitous language, bounded contexts and context maps guide boundaries?
13. How are patterns selected by forces and removed when unnecessary?
14. Transaction Script, Domain Model, Repository, direct SQL and CQRS trade-offs?
15. Layered versus hexagonal architecture?
16. What makes a monolith modular and its data boundaries enforceable?
17. When events improve coupling and when they hide control flow?
18. Which drivers justify a service boundary and which costs follow?
19. How do published contracts and anti-corruption layers preserve independent evolution?
20. How are quality attributes converted into architecture drivers?
21. How do ADRs, diagrams and fitness functions stay aligned with code?
22. How do expand-contract, branch by abstraction and strangler migrations work?
23. How are legacy seams and characterization tests used safely?
24. How are architecture alternatives, risks, reversibility and total cost evaluated?
25. How does `archtriage` locate the first structural cause?
26. Which evidence proves target architecture is better for named scenarios rather than generally “cleaner”?

Every answer references at least one commit, change report, test, contract, diagram, ADR, trace, migration or incident.

## Completion criteria

Интенсив завершён, когда:

- clean checkout recreates baseline and target laboratory;
- baseline behavior and change-impact evidence are preserved;
- target design has explicit invariant, dependency and module owners;
- domain and context models are proportionate and tested;
- application/domain/infrastructure dependencies follow executable rules;
- modular monolith module/data boundaries pass architecture tests;
- patterns are justified by forces and unjustified ones are rejected/removed;
- integration events/outbox/process manager handle duplicate/reorder/replay cases;
- old/new API/event/provider contracts pass compatibility tests;
- at least 15 quality scenarios drive decisions;
- at least 12 ADRs and reproducible architecture views match code/runtime;
- fitness functions detect deliberate boundary/contract violations;
- one full architectural migration survives interruption and cleanup;
- selective extraction has measured benefit and added ownership cost;
- architecture evaluation compares at least five options including no change;
- `archtriage` is read-only and evidence-based;
- all 50 faults are safe/reproducible or have documented equivalent substitute;
- at least 18 blind exercises and four combined cases are solved;
- all 26 defense answers are supported by evidence;
- generalized knowledge is transferred to `knowledge`.

## Delayed assessment

Через 7–14 дней без перечитывания:

1. reconstruct baseline-to-target evolution and main decisions;
2. answer the 26 defense questions;
3. implement one new domain rule and one provider/contract change;
4. diagnose four random faults including one combined case;
5. draw context/module/dependency views from code and compare with committed diagrams;
6. write one ADR and one quality scenario for a new constraint;
7. perform one interrupted migration or legacy change under characterization tests;
8. evaluate one service-extraction proposal including no-change option;
9. identify one architecture rule that is too strict or too weak and correct it;
10. explain which remaining problems belong to distributed systems, security, infrastructure or engineering-process intensives.

После delayed assessment уровень 3–4 можно считать закреплённым.
