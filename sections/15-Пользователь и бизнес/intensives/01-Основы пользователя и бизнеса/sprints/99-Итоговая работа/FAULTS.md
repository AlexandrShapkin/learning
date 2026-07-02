# Каталог неисправностей

Every fault is opt-in, bounded, reversible and limited to synthetic research, product, analytics and financial data. Each definition includes affected decision, expected evidence and cleanup.

## Stakeholders and research

1. `buyer-as-user` — buyer preference is treated as daily-user evidence.
2. `missing-affected-role` — support, administrator or external party is omitted.
3. `solution-leading-research` — research question assumes the proposed feature.
4. `future-intent-as-demand` — stated future use replaces behavioral evidence.
5. `convenience-sample-bias` — only champions/active users are sampled.
6. `contradictory-evidence-discarded` — inconvenient cases disappear from synthesis.
7. `research-privacy-overcollection` — unnecessary personal/sensitive data is retained.

## Segments, personas and journeys

8. `decorative-segmentation` — demographic groups do not change decisions.
9. `average-user-collapse` — conflicting jobs/contexts are merged.
10. `invented-persona` — fictional traits and quotes lack evidence.
11. `non-adopter-omitted` — switching barriers and rejection are invisible.
12. `happy-path-journey` — abandonment, failures and recovery are missing.
13. `invented-journey-emotion` — emotional state is asserted without evidence.
14. `frontstage-fix-backstage-cause` — UI change targets a policy/process problem.

## Value, strategy and validation

15. `feature-list-value` — value proposition contains only capabilities.
16. `everyone-target-market` — no segment choice or exclusion.
17. `buyer-user-value-conflict` — organizational benefit shifts burden to users.
18. `output-as-outcome` — shipping/adoption count replaces realized value.
19. `metric-goodhart-harm` — target drives spam, forced usage or quality loss.
20. `roadmap-promise-theater` — uncertain bets become fixed commitments.
21. `prototype-evidence-overreach` — usability evidence is interpreted as demand/viability.

## Processes, rules and requirements

22. `ideal-process-as-is` — documented policy replaces observed work.
23. `exception-path-omitted` — frequent exceptions/manual work are absent.
24. `broken-process-automated` — unnecessary approval/handoff is encoded.
25. `conflicting-rule-precedence` — two authoritative rules disagree.
26. `permanent-manual-override` — exception becomes hidden normal path.
27. `source-of-truth-conflict` — copied/reporting state becomes authoritative accidentally.
28. `outcome-requirement-trace-gap` — system work cannot be linked to user/business result.

## Analytics and experimentation

29. `event-semantic-drift` — event name/property meaning changes silently.
30. `identity-merge-split-error` — user/account/session linkage corrupts metrics.
31. `duplicate-late-event-inflation` — retries/order distort funnel or retention.
32. `funnel-denominator-window-error` — populations and windows are inconsistent.
33. `signup-as-activation` — setup is mistaken for realized value.
34. `experiment-unit-contamination` — treatment leaks across account/team.
35. `post-hoc-metric-peeking` — outcome/stop rule changes after observing results.

## Feedback, economics and pricing

36. `loud-request-overweight` — one customer/channel dominates decision.
37. `support-deflection-false-success` — contacts fall while unresolved failures grow.
38. `revenue-as-profit` — margin and variable cost are ignored.
39. `support-onboarding-cost-omitted` — manual customer cost disappears.
40. `optimistic-ltv-churn` — lifetime assumptions exaggerate value.
41. `average-economics-cross-subsidy` — loss-making segment is hidden.
42. `pricing-metric-misaligned` — price discourages desired behavior or is unpredictable.

## Business case, risk and continuity

43. `implementation-only-tco` — migration, operation and retirement are omitted.
44. `benefit-full-attribution` — all observed improvement is credited immediately.
45. `do-nothing-alternative-omitted` — baseline and opportunity cost are absent.
46. `risk-register-generic-labels` — scenarios have no cause/consequence/owner.
47. `manual-workaround-no-capacity` — continuity plan cannot handle volume.
48. `vendor-exit-impossible` — portability/data/contract exit is undefined.
49. `residual-risk-ownerless` — accepted exposure has no authority or review.

## Rollout, support and portfolio

50. `release-equals-adoption` — availability is treated as realized outcome.
51. `champion-only-pilot` — difficult segments and non-adopters are excluded.
52. `login-as-adoption` — activity replaces workflow success.
53. `shadow-process-hidden` — users maintain old/manual workflow.
54. `support-capacity-shortfall` — expansion overwhelms support/operations.
55. `sunk-cost-continuation` — failed bet continues because of past investment.
56. `sunset-without-migration` — users, data and support obligations are abandoned.

## Combined scenario library

- buyer request + worker burden + forced adoption metric;
- champion-only research + invented persona + roadmap commitment;
- positive survey + observed workaround + non-adopter omission;
- journey pain + unchanged backstage policy + low adoption;
- feature value claim + vanity metric + support-cost growth;
- process automation + conflicting rule + source-of-truth divergence;
- duplicate events + signup activation + misleading retention;
- contaminated experiment + early stopping + segment harm;
- strong demand + negative contribution margin + optimistic LTV;
- usage pricing + unpredictable bills + churn increase;
- favorable ROI + omitted migration/support/vendor exit;
- pilot expansion + shadow process + support overload;
- high average economics + loss-making strategic segment;
- vendor outage + inadequate workaround + unowned residual risk;
- sunk-cost roadmap + failed assumption + missing stop criteria;
- abrupt sunset + data/export gap + support obligation.

## Fault definition contract

Each implementation includes:

```text
name and affected user/business decision
synthetic dataset, segment, process or model preconditions
injected evidence, definition, policy or assumption error
expected product, process, metric, economic or adoption symptom
expected research, query, model and decision evidence
maximum records, participants, exposure, duration and resources
disable/rollback/data-deletion procedure
new validation, guardrail, model or decision correction
```

## Safety contract

Fault tooling must:

- require exact laboratory marker and `--lab`;
- reject real participant, customer, financial or production data;
- operate only on local synthetic datasets and services;
- cap generated records, events, cohorts, experiments and financial scenarios;
- preserve consent/retention/deletion rules for any authorized data;
- never manipulate real users, pricing or essential workflows;
- never rank individual workers or infer sensitive traits;
- redact personal/sensitive fields;
- support `status`, `disable`, `rollback-all` and `cleanup`;
- verify synthetic identities, datasets, containers and temporary exports are removed.
