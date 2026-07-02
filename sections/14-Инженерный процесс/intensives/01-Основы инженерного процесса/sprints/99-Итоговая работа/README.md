# Спринт 99. Итоговая работа

Ориентировочный объём: 70–105 часов.

## Задача

Создать `engineering-system-lab` — complete synthetic engineering system that carries one substantial product change from problem discovery through requirements, decomposition, planning, Git collaboration, review, verification, documentation, release evidence and process improvement.

Проект не является набором формальных шаблонов. Его задача — доказать through change history and reproducible evidence, что engineering process reduces uncertainty, enables coordination, preserves quality and learns from outcomes.

## Reference change

Choose a synthetic feature or migration involving:

- Go API and PostgreSQL schema/behavior;
- one external or cross-component contract;
- migration and backward compatibility;
- operational or security constraint;
- at least three independently releasable slices;
- one uncertain technical assumption;
- one deliberately injected defect/process failure;
- documentation and ownership change.

## Target engineering system

```text
problem and outcome
        |
requirements and acceptance
        |
research / decision / slicing
        |
priority / forecast / dependencies / WIP
        |
commits / branches / pull requests / reviews
        |
tests / CI / integration / release evidence
        |
docs / RFC / ADR / ownership / handoff
        |
flow and quality metrics
        |
retrospective and improvement experiment
        |
read-only engtriage
```

## Repository structure

```text
work/engineering-system-lab/
├── product/
├── requirements/
├── changes/
├── research/
├── decisions/
├── reviews/
├── tests/
├── ci/
├── docs/
├── ownership/
├── metrics/
├── experiments/
├── faults/
├── scripts/
├── Makefile
└── README.md
```

## Документы итоговой работы

- [`IMPLEMENTATION.md`](IMPLEMENTATION.md) — mandatory stages, artifacts and evidence.
- [`FAULTS.md`](FAULTS.md) — catalogue of 56 bounded process and change-system faults.
- [`ASSESSMENT.md`](ASSESSMENT.md) — blind change cases, clean reconstruction and final defense.

## Mandatory capabilities

1. Evidence-based problem statement, baseline, outcome and hypothesis.
2. Functional, quality, operational, migration and compatibility requirements.
3. Example-based acceptance and completion evidence.
4. Vertical slices, risk sequencing and one timeboxed experiment.
5. Priority rationale, range forecast, dependency graph and WIP policy.
6. Atomic commits, short-lived branches and reversible integration.
7. Focused pull requests and multi-perspective review.
8. Ownership, fallback maintainers and combined-state verification.
9. Risk-based test strategy and layered test suite.
10. Fast deterministic CI with blocking/advisory gate policy.
11. Defect causal analysis and recurrence prevention.
12. Current documentation, RFC, ADR and technical specification.
13. Verified onboarding/handoff and ownership transfer.
14. Role/team interfaces and recorded decision rights.
15. Flow, review, quality and reliability metrics with anti-gaming controls.
16. Retrospective and bounded improvement experiment.
17. Technical/process debt decision plus one standardization/automation.
18. Read-only `engtriage` and systemic process review.

## Mandatory scenarios

1. Reframe a solution request into an evidence-based problem/outcome.
2. Resolve conflicting or unverifiable requirements.
3. Slice a component-heavy plan into vertical increments.
4. Use a spike/experiment to resolve one high-risk uncertainty.
5. Reprioritize after an urgent defect or dependency change.
6. Reforecast after scope and throughput change.
7. Reduce one critical dependency and integrate early.
8. Limit WIP and recover an overloaded review queue.
9. Rewrite tangled commits/branches into reviewable history.
10. Detect one regression through bisect and recover one lost ref.
11. Resolve a meaningful review disagreement through evidence.
12. Handle unavailable owner and stale ownership routing.
13. Replace one brittle/low-value test with faithful risk coverage.
14. Quarantine and repair one flaky CI check.
15. Analyze one escaped defect and prevent a class-level recurrence.
16. Remove stale/duplicated documentation and record one superseding decision.
17. Verify handoff through an independent contributor task.
18. Detect metric gaming or local optimization.
19. Run one process improvement experiment and retain/adapt/stop it.
20. Use `engtriage` to reconstruct one combined delay/rework/quality case.

## Main results

The completed laboratory includes:

- problem/outcome and requirement package;
- acceptance and traceability evidence;
- slice/dependency/forecast/flow artifacts;
- complete Git and pull-request history;
- review findings and resolution records;
- layered tests and CI evidence;
- defect and corrective-action analysis;
- documentation, RFC, ADR and specification;
- ownership, onboarding and handoff evidence;
- metric definitions and synthetic history analysis;
- retrospective and process experiment;
- technical-debt/standardization decision;
- `engtriage` output and systemic review;
- 56 reproducible process faults.

## Execution order

1. Build baseline product and engineering history.
2. Frame the problem and define requirements/acceptance.
3. Run uncertainty reduction and create vertical slices.
4. Prioritize, forecast and map dependencies/flow.
5. Implement through commits, PRs and reviews.
6. Build layered tests and CI gates.
7. Inject and analyze a defect/process failure.
8. Complete docs, decisions, ownership and handoff.
9. Analyze metrics and run improvement experiment.
10. Implement `engtriage`, systemic review and assessment.

## Artifacts to commit

- synthetic product source and tests;
- requirements/change/decision documents;
- reproducible Git/PR/review simulations;
- CI and quality-gate configuration;
- generated-history scripts and seeds;
- concise metric and improvement reports;
- current documentation and ownership files;
- read-only diagnostic tooling;
- links to generalized `knowledge` notes.

Do not commit:

- real company issues, reviews, chats or metrics;
- personal performance data;
- credentials or private repository exports;
- copied proprietary process documents;
- large generated CI histories/artifacts;
- empty templates or dashboards with no decision purpose;
- database volumes, binaries or transient caches.

## Safety

- destructive Git operations use disposable repositories/branches;
- scripts default to dry-run outside the exact lab path;
- no automation writes to external repositories or issue trackers;
- histories and roles are synthetic;
- metrics never rank individuals;
- CI/test/metric generation is time/resource bounded;
- cleanup removes temporary repositories, containers, databases and generated histories.

## Результат для базы знаний

Итоговая работа должна завершить или исправить заметки по lifecycle, problem framing, requirements, slicing, research, prioritization, forecasting, flow, Git, review, testing, CI, documentation, decisions, ownership, communication, metrics, retrospectives, debt and automation.

Synthetic histories, review evidence and experiments remain in `learning`; generalized mechanisms move to `knowledge`.
