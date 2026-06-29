# Спринт 27. Системная диагностика дизайна и архитектуры

Ориентировочный объём: 20–30 часов.

## Центральный вопрос

Как from recurring change pain, defects, incidents and dependency/runtime evidence locate the first structural cause without blaming style or rewriting the system blindly?

## Результат спринта

После завершения необходимо уметь:

- формулировать exact design/architecture symptom;
- различать local code smell, module defect and system architecture issue;
- reconstruct change and runtime path;
- identify source of truth, invariant owner and decision owner;
- use import graph, change history and runtime traces together;
- detect cycles, boundary leaks and hidden shared state;
- diagnose duplicated/contradictory business policy;
- identify abstraction leak and wrong contract ownership;
- distinguish performance/reliability symptom from structural cause;
- diagnose event choreography, service call chain and data ownership failures;
- find architecture drift from ADR/diagram/rule mismatch;
- rank falsifiable structural hypotheses;
- run one discriminating change/failure experiment;
- apply minimal reversible design repair;
- verify future change, behavior and runtime consequence;
- add architecture test, contract test or decision update;
- avoid pattern/framework replacement as unexplained fix;
- produce concise evidence-based incident/design record.

## Diagnostic loop

```text
state symptom and affected changes/incidents
→ preserve code/history/runtime/version evidence
→ define expected invariant, contract and boundary
→ locate first duplicated/leaked/missing decision ownership
→ classify local/module/context/system issue
→ rank hypotheses
→ run discriminating change or failure experiment
→ repair minimally
→ repeat behavior/change/runtime verification
→ add executable guard or decision update
```

## Evidence map

### Change evidence

- commits/files/packages changing together;
- number/location of duplicated decisions;
- review/merge conflicts and repeated regressions;
- feature changes crossing unrelated modules;
- compatibility/migration burden.

### Structural evidence

- import/dependency cycles;
- exported/public surface;
- cross-module table/model access;
- package/module ownership;
- contract and schema coupling;
- global state/service locator.

### Runtime evidence

- synchronous call chain and failure propagation;
- transaction and lock boundaries;
- event lag/duplicates/reordering;
- resource ownership/leaks;
- service/data coupling;
- traces showing unexpected dependency.

### Decision evidence

- quality scenarios and drivers;
- ADR assumptions/consequences;
- diagrams versus code/runtime;
- architecture-test exceptions;
- temporary migration paths and expired flags.

## Лабораторная работа

Создать `work/design-diagnostics/`.

### `archtriage`

Read-only bounded collector/analyzer:

```text
archtriage imports --module NAME
archtriage changes --paths ... --since REF
archtriage contracts --boundary NAME
archtriage data-ownership --table NAME
archtriage runtime --trace FILE
archtriage decisions --component NAME
archtriage scenario --change NAME
```

It never rewrites code or applies fixes automatically.

### Incident catalogue

Solve at least 20, including five combined cases:

1. business rule duplicated in handler, worker and consumer;
2. invariant owner missing or bypassed;
3. utility/common package dependency hub;
4. import cycle hidden through neutral interfaces package;
5. abstraction leaks provider/storage semantics;
6. fake adapter has stronger behavior than production;
7. generic repository blocks query/transaction requirement;
8. wrong aggregate boundary causes contention or inconsistency;
9. canonical model couples bounded contexts;
10. shared database bypasses module/service contract;
11. event choreography has no workflow owner;
12. synchronous service chain amplifies outage;
13. schema-compatible event change is semantically breaking;
14. temporary dual path diverges and becomes permanent;
15. architecture diagram/ADR differs from code/runtime;
16. fitness-function exception becomes backdoor;
17. performance optimization breaks boundary/invariant;
18. feature flag/config creates multiple undocumented architectures;
19. legacy seam introduces global race;
20. refactor improves local code but worsens target changes;
21. service extraction adds cost without driver;
22. pattern stack obscures simple flow;
23. multiple simultaneous structural and runtime failures.

### Combined examples

- shared model + cross-module table access + contract drift;
- event choreography + duplicate policy + missing process state;
- service chain + retry storm + ambiguous transaction boundary;
- migration dual write + stale legacy consumer + expired feature flag;
- utility hub + import-cycle workaround + broad interface;
- wrong aggregate + generic repository + lock contention;
- outdated ADR + architecture exception + unnoticed service extraction;
- local refactor + test mocks + production contract mismatch.

## Incident artifact

```text
Symptom and affected changes/incidents
Scope, versions and timeline
Expected invariant/contract/boundary
Preserved code/history/runtime evidence
First missing, duplicated or leaked decision ownership
Ranked hypotheses and discriminating experiment
Root cause, trigger and secondary effects
Minimal reversible repair
Behavior, change-locality and runtime verification
Architecture guard or decision update
```

## Самопроверка

1. Code smell versus architectural issue?
2. What is first structural cause?
3. How change history and imports complement each other?
4. How runtime trace can reveal hidden architecture?
5. Decision owner versus data/invariant owner?
6. Abstraction leak versus expected contract limitation?
7. How detect context/module/service boundary erosion?
8. Why pattern replacement is not diagnosis?
9. What proves repair improved design?
10. Which executable guard prevents recurrence?
11. When architecture recommendation should be no change?
12. How temporary migration state becomes architectural debt?

## Критерии прохождения

- `archtriage` remains read-only and reproducible;
- at least 20 incidents and five combined cases are solved;
- each incident identifies expected owner/boundary and first divergence;
- repair is minimal and reversible;
- verification includes behavior, target change and runtime impact where relevant;
- no framework/pattern/service rewrite is accepted without evidence;
- each repaired class gains architecture/contract/change guard or ADR update;
- cleanup returns generated reports/services/branches to baseline;
- at least 10 of 12 answers are mechanism-based.

## Результат для базы знаний

- **Systematic software-design diagnostics**.
- **Local smell, module defect and architecture issue**.
- **Change-history, dependency and runtime evidence**.
- **Decision, invariant, contract and data ownership diagnosis**.
- **Architecture drift and boundary erosion**.
- **Minimal structural repair and change verification**.
- **Architecture guards after incidents**.

## Когда переходить дальше

Можно переходить к итоговой работе, когда unknown design and architecture symptoms are localized through change/structure/runtime evidence and repaired with executable prevention rather than stylistic replacement.