# Каталог неисправностей

Every fault is opt-in, bounded, reversible and limited to synthetic repositories, histories and data. Each definition includes affected decision/control, expected evidence and cleanup.

## Problem, requirements and decomposition

1. `solution-as-problem` — requested technology is accepted without problem evidence.
2. `outcome-without-baseline` — success cannot be measured.
3. `unfalsifiable-hypothesis` — no result could disprove the claim.
4. `vague-quality-requirement` — fast/reliable/secure has no context or threshold.
5. `design-hidden-as-requirement` — implementation preference becomes mandatory silently.
6. `failure-path-omitted` — errors, rollback or recovery are absent.
7. `acceptance-equals-merge` — completion lacks runtime/docs/operation evidence.
8. `component-only-decomposition` — no end-to-end usable slice.
9. `foundation-before-feedback` — enabling work delays all learning.
10. `prototype-becomes-production` — disposable shortcuts cross boundary.

## Priority, forecasting and flow

11. `everything-critical` — priority system cannot discriminate.
12. `false-precision-score` — numeric ranking exceeds evidence.
13. `point-estimate-promise` — uncertainty and confidence disappear.
14. `forecast-excludes-integration` — review/test/release time omitted.
15. `scope-growth-hidden` — forecast remains unchanged after added work.
16. `implicit-critical-dependency` — provider/contract/readiness unknown.
17. `late-integration` — parallel work converges only at deadline.
18. `review-queue-overload` — coding continues while review ages.
19. `blocked-work-never-exits` — WIP/status hides indefinite waiting.
20. `permanent-expedite` — urgent lane bypasses normal limits continuously.

## Git, pull requests and ownership

21. `mixed-purpose-commit` — refactor, behavior and generated changes are tangled.
22. `long-lived-branch-divergence` — integration debt accumulates.
23. `unsafe-shared-history-rewrite` — force/rebase disrupts collaborators.
24. `unreviewable-large-pr` — multiple risks and intents hide in one diff.
25. `empty-pr-context` — reviewer cannot reconstruct problem/risk/evidence.
26. `style-review-misses-defect` — cosmetic focus hides correctness issue.
27. `ambiguous-review-severity` — suggestion/question/blocker are indistinguishable.
28. `stale-approval` — approval no longer covers latest revision.
29. `single-reviewer-bottleneck` — one owner blocks all integration.
30. `stale-codeowners` — routing and real responsibility diverge.
31. `combined-state-not-tested` — individually green changes fail together.
32. `unsafe-revert` — rollback breaks schema/API/compatibility.

## Quality, CI and defects

33. `coverage-without-risk` — high percentage misses critical behavior.
34. `mock-contract-drift` — fake passes while real dependency fails.
35. `stateful-test-ordering` — shared fixtures create order dependence.
36. `oversized-e2e-suite` — feedback becomes slow and flaky.
37. `local-ci-command-drift` — different commands produce different confidence.
38. `rerun-until-green` — flaky test is hidden rather than repaired.
39. `cache-hides-change` — incompatible artifact is reused.
40. `every-check-blocks` — gate proliferation slows all feedback.
41. `root-cause-human-error` — systemic conditions remain unchanged.
42. `narrow-regression-fix` — original input passes but failure class remains.
43. `corrective-action-unverified` — recurrence prevention is assumed.
44. `quality-cut-for-date` — migration/test/recovery work disappears silently.

## Documentation, decisions and knowledge

45. `duplicated-documentation` — same facts diverge across pages.
46. `broken-example` — documented command no longer works.
47. `post-hoc-rfc` — proposal only rationalizes completed implementation.
48. `single-option-rfc` — alternatives and status quo are absent.
49. `adr-without-rationale` — decision record contains only implementation.
50. `stale-decision-current` — superseded context is not linked.
51. `handoff-branch-only` — decisions, risks and next state are absent.
52. `documentation-dump-onboarding` — no runnable progressive task.

## Teams, metrics and improvement

53. `ownerless-shared-area` — critical decision/system has no accountable owner.
54. `meeting-without-decision` — coordination produces no output or owner.
55. `metric-individual-ranking` — activity counts become performance measure.
56. `average-hides-tail` — aging/long-cycle work remains invisible.

## Combined scenario library

- vague requirement + large PR + review churn;
- long-lived branch + contract mismatch + late integration;
- overloaded owner + stale CODEOWNERS + review queue;
- point estimate + hidden scope growth + quality cut;
- high coverage + drifting mock + escaped defect;
- flaky CI + rerun policy + stale approval;
- post-hoc RFC + repeated disagreement + rework;
- onboarding gap + owner absence + incident delay;
- metric target + status gaming + actual WIP growth;
- expedite abuse + dependency delay + normal work starvation;
- debt rewrite + no slices + delayed feedback;
- automation of unstable process + opaque failure + shadow workaround.

## Fault definition contract

Each implementation includes:

```text
name and affected engineering outcome
synthetic repository/history preconditions
injected artifact, policy or state error
expected delay, rework, quality or decision symptom
expected commits, reviews, tests, metrics and decision evidence
maximum generated items, duration and resources
disable/rollback/cleanup procedure
new test, policy, automation or structural correction
```

## Safety contract

Fault tooling must:

- require exact laboratory marker and `--lab`;
- reject external repositories, issue trackers and CI systems;
- operate on disposable refs and synthetic histories;
- default destructive Git operations to dry-run;
- cap generated issues, commits, jobs, logs and database rows;
- never ingest real employee or private organization data;
- never compute individual productivity rankings;
- support `status`, `disable`, `rollback-all` and `cleanup`;
- verify temporary branches, repositories, containers and histories are removed.
