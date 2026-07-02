# Реализация итоговой работы

## 1. Baseline product and change history

Create a small Go/PostgreSQL product with:

- API and background worker;
- one external/provider contract;
- tests and basic CI;
- intentionally imperfect docs and ownership;
- generated historical changes, reviews and defects.

Record repository seed, versions and synthetic-history assumptions.

## 2. Problem and outcome

Write:

- observed current state and affected workflow;
- baseline evidence;
- outcome and falsifiable hypothesis;
- actors/stakeholders and decision owner;
- assumptions, unknowns, non-goals and stop/change conditions;
- alternative interventions including no-build/process option.

## 3. Requirements and acceptance

Required:

- functional behavior and actors;
- latency/capacity/reliability/security requirements where relevant;
- failure/error behavior;
- migration, rollback and backward compatibility;
- operational/diagnostic needs;
- example-based positive, negative and boundary acceptance;
- completion evidence for code, tests, deployment, docs and ownership;
- lightweight links from outcome to requirements, slices and tests.

## 4. Research and decisions

Run one bounded spike/prototype/experiment:

- exact question and decision;
- time/resource box;
- representative evidence;
- supported/rejected/unknown conclusions;
- disposable-code boundary;
- resulting decision and residual risk.

Create an RFC for the cross-component decision, an ADR for the selected outcome and a precise interface/migration specification.

## 5. Decomposition

Create:

- user/system workflow map;
- thin walking skeleton;
- at least five vertical slices;
- slice acceptance and rollback evidence;
- high-risk assumption in an early slice;
- compatibility/migration sequence;
- feature-toggle removal conditions where used.

No long frontend/backend/database phase is accepted.

## 6. Priority and forecasting

Provide:

- candidate set and selection rationale;
- value, urgency, risk reduction and cost-of-delay considerations;
- range/confidence estimate;
- historical throughput/cycle-time assumptions;
- optional Monte Carlo script;
- target versus forecast separation;
- reforecast after injected scope/capacity change;
- explicit displaced work.

## 7. Dependencies and flow

Required:

- dependency graph and critical path;
- provider/consumer/contract/readiness evidence;
- early contract/integration verification;
- workflow states and operational definitions;
- WIP limits and queue policies;
- blocked/aging/expedite rules;
- measured wait versus active time;
- replan after one dependency delay and one urgent defect.

## 8. Git and commits

Produce a history with:

- atomic coherent commits;
- rationale-oriented messages;
- separated refactor, behavior and generated changes;
- short-lived branches;
- explicit merge/squash/rebase policy;
- incremental integration and compatibility;
- one safe revert;
- one reflog recovery and one reproducible bisect.

## 9. Pull requests and reviews

Create at least five focused PR simulations containing:

- problem/context and linked slice;
- change and non-goals;
- risk and migration notes;
- test/review evidence;
- screenshots or API examples only where useful.

Review from implementer, maintainer, quality, security/operations and dependent-interface perspectives. Mark blocking, question and suggestion intent. Resolve one disagreement through data or experiment.

## 10. Ownership and merge flow

Implement:

- component/path ownership;
- primary and backup maintainers;
- risk-based required reviewers;
- unavailable-owner escalation;
- merge-queue or combined-state verification simulation;
- emergency merge path and later review;
- ownership transfer and orphaned-code decision;
- review concentration analysis without individual ranking.

## 11. Quality strategy

Map critical risks to:

- prevention controls;
- unit/component tests;
- realistic integration tests;
- API/provider contract tests;
- minimal end-to-end journeys;
- exploratory checks;
- operational/migration/rollback evidence;
- residual risk and release decision.

Remove at least one redundant low-signal test.

## 12. CI and quality gates

Required:

- one local command source used by CI;
- formatting, static analysis, unit/integration/contract tests;
- race/fuzz/vulnerability checks where relevant;
- fast-to-slow stage ordering;
- blocking versus advisory policy;
- safe caching and deterministic dependencies;
- timeouts and bounded artifacts;
- flaky/infrastructure/product failure classification;
- temporary waiver with owner and expiry;
- measured queue and execution time.

## 13. Defect prevention

Inject one defect that escapes initial checks.

Document:

- introduction, detection and impact timeline;
- trigger and contributing conditions;
- failed/missing detection points;
- immediate fix;
- class-level regression test;
- guardrail/interface/process correction;
- similar-path review;
- action effectiveness and recurrence check.

“Developer should be more careful” is not a corrective action.

## 14. Documentation and context

Create current:

- product overview and quick start;
- contributor build/test/change path;
- API/configuration reference linked to authoritative sources;
- operational/migration/rollback guidance;
- architecture/system map;
- RFC, ADR and specification index;
- ownership and escalation guide;
- documentation freshness/retirement rules.

Test commands/examples and remove one stale duplicated document.

## 15. Onboarding and handoff

Simulate a new contributor:

- environment setup from clean checkout;
- one small safe modification;
- system/change walkthrough;
- teach-back of critical boundaries;
- handoff of incomplete slice with decisions, risks, blockers and next checkpoint;
- ownership/access/document update.

## 16. Roles and communication

Define:

- decision rights and accountability for requirements, implementation, review, release and operation;
- team/role interfaces and expected inputs/outputs;
- escalation and exception paths;
- one asynchronous decision proposal;
- one timeboxed meeting with recorded outcome;
- one difficult feedback and early risk-escalation scenario.

## 17. Metrics

Generate and analyze synthetic:

- lead/cycle time distributions;
- throughput, WIP and aging;
- review wait and iterations;
- CI queue/execution/failure classes;
- rework and escaped defects;
- deployment/change-failure/recovery measures where represented;
- ownership/review concentration in aggregate.

Every metric includes definition, data source, exclusions, decision use and anti-gaming risk. No individual scoring.

## 18. Improvement experiment

Use the metric/qualitative evidence to:

- select one systemic problem;
- formulate mechanism and hypothesis;
- define baseline, intervention and balancing metric;
- run a bounded synthetic before/after experiment;
- record confounders and unintended effects;
- retain, adapt or stop the change;
- update policy/tool/docs accordingly.

## 19. Debt, standardization and automation

Provide:

- debt inventory with principal/interest/risk evidence;
- one incremental modernization plan;
- one repeated workflow selected for standardization;
- one bounded automation with dry-run and failure behavior;
- adoption and maintenance-cost evidence;
- escape hatch and exception policy;
- retirement of one obsolete tool/template/path.

## 20. `engtriage`

Read-only commands:

```text
engtriage change
engtriage requirement
engtriage slice
engtriage dependency
engtriage review
engtriage test
engtriage decision
engtriage ownership
engtriage flow
engtriage defect
engtriage experiment
```

The tool uses only local synthetic history, limits output, exposes definitions and never writes to Git, CI, issue trackers or metrics data.

## 21. Systemic review

For the complete change document:

- first meaningful delay and rework point;
- bottleneck/queue and contributing conditions;
- policy versus actual behavior;
- ownership/knowledge concentration;
- quality and feedback gaps;
- metric distortions;
- immediate fix versus process/architecture change;
- no more than three prioritized experiments;
- expected benefit, trade-off and review date.

## 22. Verification commands

```text
make check
make setup
make test
make test-integration
make test-contract
make test-e2e
make lint
make static
make race
make fuzz-smoke
make ci-local
make docs-check
make history-generate
make metrics
make fault-smoke
make triage-smoke
make verify-change
make clean
```

## 23. Implementation stages

### Stage 1. Framing

Baseline, outcome, requirements, acceptance and research.

### Stage 2. Planning

Slices, priority, forecast, dependencies, WIP and replan.

### Stage 3. Collaboration

Git history, PRs, reviews, ownership and integration.

### Stage 4. Quality

Test strategy, layered tests, CI and defect prevention.

### Stage 5. Context

Documentation, RFC/ADR/specification, onboarding and handoff.

### Stage 6. Improvement

Roles, metrics, retrospective, debt, standardization and automation.

### Stage 7. Assessment

`engtriage`, systemic review, blind cases and clean reconstruction.
