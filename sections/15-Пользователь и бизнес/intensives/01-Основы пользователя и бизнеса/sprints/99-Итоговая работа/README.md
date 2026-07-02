# Спринт 99. Итоговая работа

Ориентировочный объём: 75–110 часов.

## Задача

Создать `product-business-lab` — complete synthetic product and business case for improving a field-service workflow, from stakeholder/user research through strategy, process modeling, requirements, analytics, economics, pilot and scale/pivot/stop decision.

Проект не является набором презентаций или вымышленным startup pitch. Его задача — доказать через research evidence, process models, product behavior, event data, experiments and financial/risk analysis, что решение создаёт ценность для конкретных пользователей и организации в обозначенных границах.

## Reference domain

Synthetic B2B field-service product:

- customer/requester submits service request;
- dispatcher validates, schedules and assigns work;
- field worker executes and records outcome;
- manager monitors service, cost and capacity;
- support handles failures and exceptions;
- buyer/owner evaluates economics and renewal;
- finance/procurement and privacy/security roles review constraints.

## Target evidence system

```text
stakeholders and user research
        |
segments / jobs / personas / journeys
        |
value proposition / strategy / roadmap
        |
as-is and to-be process / rules / requirements
        |
Go product prototype and PostgreSQL
        |
event taxonomy / funnels / cohorts / experiments
        |
unit economics / TCO / pricing / risk
        |
pilot / rollout / support / adoption
        |
scale / pivot / sunset / stop decision
        |
read-only biztriage
```

## Repository structure

```text
work/product-business-lab/
├── product/
├── research/
├── stakeholders/
├── segments/
├── journeys/
├── processes/
├── rules/
├── requirements/
├── strategy/
├── analytics/
├── experiments/
├── economics/
├── risks/
├── rollout/
├── support/
├── decisions/
├── faults/
├── scripts/
├── Makefile
└── README.md
```

## Документы итоговой работы

- [`IMPLEMENTATION.md`](IMPLEMENTATION.md) — mandatory stages, artifacts and evidence.
- [`FAULTS.md`](FAULTS.md) — catalogue of 56 bounded product/business faults.
- [`ASSESSMENT.md`](ASSESSMENT.md) — blind cases, clean reconstruction and final defense.

## Mandatory capabilities

1. Stakeholder, user, buyer, process-owner and decision-right map.
2. Ethical mixed-method research plan and synthetic evidence.
3. Actionable segmentation, jobs and problem hypotheses.
4. Evidence-based personas, scenarios, customer journey and service blueprint.
5. Value proposition, positioning, product vision and strategic choices.
6. Outcome metric tree, guardrails and decision thresholds.
7. Outcome-oriented roadmap, exclusions and uncertainty-reduction plan.
8. Prototype/MVP/pilot validation with continue/adapt/stop criteria.
9. As-is/to-be process, business rules and exception handling.
10. Domain glossary, events, states and authoritative data map.
11. Business/user/system requirements and change-impact analysis.
12. Versioned product event taxonomy and data-quality/reconciliation tests.
13. Funnels, activation, retention, cohorts and segment analysis.
14. One controlled experiment or pilot causal analysis.
15. Support/research/analytics triangulation.
16. Revenue, unit economics, TCO and business-case model.
17. Pricing/packaging hypothesis and sensitivity.
18. Business risk, privacy/compliance assumptions and continuity analysis.
19. Rollout, training, support, adoption and customer-success plan.
20. Scale, pivot, sunset or stop decision.
21. Read-only `biztriage` and systemic product/business review.

## Mandatory scenarios

1. Distinguish buyer request from dispatcher/worker/customer needs.
2. Reject one attractive solution hypothesis after research.
3. Show claimed versus observed behavior and sample limitations.
4. Identify one actionable segment and one non-adopter segment.
5. Trace a journey pain to a backstage process/policy cause.
6. Resolve buyer value versus user workload conflict.
7. Reject one vanity metric and add guardrails.
8. Reorder or stop one roadmap bet after new evidence.
9. Use a bounded prototype/pilot to test the highest-risk assumption.
10. Simplify one process step before automation.
11. Resolve one conflicting business rule and data authority.
12. Trace business outcome through user/system requirements to acceptance.
13. Detect duplicate/late/identity event corruption.
14. Correct one misleading funnel/cohort interpretation.
15. Run one experiment with treatment/control or documented quasi-experimental limits.
16. Reject one loud support request through triangulated evidence.
17. Reveal one loss-making segment hidden by average economics.
18. Compare build, buy, process-only and do-nothing alternatives.
19. Stress-test pricing, churn, support and continuity assumptions.
20. Pause or revise rollout after adoption/support guardrail failure.
21. Design one respectful sunset or stop decision.
22. Use `biztriage` to reconstruct a combined user, process, metric and economics contradiction.

## Main results

The completed laboratory includes:

- research plan, synthetic transcripts/observations and survey evidence;
- stakeholder, segment, persona, journey and blueprint artifacts;
- product strategy, metric tree, roadmap and validation decision;
- process, rule, glossary, data-authority and requirement models;
- Go/PostgreSQL prototype and versioned event stream;
- funnel, cohort, experiment and support analyses;
- unit economics, TCO, pricing and risk models;
- pilot, rollout, adoption and customer-success evidence;
- portfolio scale/pivot/stop decision;
- `biztriage` output and systemic review;
- 56 reproducible product/business faults.

## Execution order

1. Build reference product and synthetic domain data.
2. Map stakeholders and conduct mixed-method discovery.
3. Create segmentation, journeys and service blueprint.
4. Define value, goals, strategy and validation bet.
5. Model processes, rules, data and requirements.
6. Implement/instrument the prototype.
7. Analyze funnels, cohorts, experiment and feedback.
8. Build economics, pricing, risk and continuity case.
9. Run pilot/rollout/adoption simulation.
10. Make portfolio decision and complete systemic review.

## Artifacts to commit

- synthetic research plans and redacted evidence;
- segment, journey, process and rule models;
- requirements, strategy and decision artifacts;
- product source and synthetic data generators;
- event schemas, queries and data-quality tests;
- experiment/pilot configurations and reports;
- financial model inputs, formulas and sensitivity reports;
- rollout, support and adoption plans;
- read-only diagnostic tooling;
- links to generalized `knowledge` notes.

Do not commit:

- real participant/customer/company data;
- recordings, contacts or unredacted transcripts;
- real financial, sales or support exports;
- credentials or analytics tokens;
- proprietary reports copied in full;
- deceptive research or dark-pattern material;
- large generated datasets or binary dashboards;
- legal/accounting claims presented as professional advice.

## Safety and ethics

- all participants, organizations and events are synthetic or explicitly authorized;
- research purpose, consent, retention and deletion are explicit;
- personal/sensitive data is minimized and redacted;
- experiments have exposure, duration and harm guardrails;
- no essential service is withheld for experimentation;
- no manipulative pricing, forced adoption or dark patterns;
- financial/legal/privacy assumptions are labeled for specialist verification;
- metrics are never used to rank individual workers;
- cleanup removes synthetic identities, datasets, recordings, containers and temporary financial exports.

## Результат для базы знаний

Итоговая работа должна завершить или исправить заметки по stakeholders, research, segmentation, journeys, service design, value, strategy, processes, rules, requirements, analytics, experiments, economics, pricing, risk, rollout, customer success and portfolio decisions.

Synthetic research, product data and models remain in `learning`; generalized mechanisms move to `knowledge`.
