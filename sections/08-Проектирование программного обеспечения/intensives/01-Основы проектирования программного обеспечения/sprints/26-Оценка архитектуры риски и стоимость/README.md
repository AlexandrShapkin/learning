# Спринт 26. Оценка архитектуры, риски и стоимость

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как оценить candidate or existing architecture через quality scenarios, failure/change risks and total ownership cost rather than subjective preference or diagram aesthetics?

## Результат спринта

После завершения необходимо уметь:

- проводить lightweight architecture review;
- определять scope, stakeholders and decision questions;
- использовать prioritized quality scenarios;
- находить sensitivity, trade-off and risk points;
- различать risk, non-risk, sensitivity and trade-off;
- оценивать coupling and change propagation;
- проводить failure-mode and dependency analysis;
- учитывать build, deploy, test, operate and migration cost;
- считать total cost of ownership qualitatively/quantitatively where possible;
- сравнивать alternatives and do-nothing option;
- учитывать reversibility and option value;
- оценивать organizational/cognitive load without reducing architecture to org chart;
- выявлять architecture debt and erosion;
- создавать risk-reduction experiments;
- фиксировать accepted risks and owners/triggers;
- избегать false precision and scoring theater;
- отличать architectural concern from local implementation issue;
- формулировать recommendation with evidence and uncertainty.

## Основной маршрут

### Шаг 1. Review question

Define exact decision: retain modular monolith, extract service, replace data/integration pattern, or restructure module boundary. Set scope and stakeholders.

### Шаг 2. Scenario walkthrough

Walk through top scenarios and trace affected modules, runtime components, data and teams. Record risk/sensitivity/trade-off points.

### Шаг 3. Cost model

Estimate:

```text
implementation and migration
additional infrastructure/licensing
CI/CD and environments
observability/on-call/security
local development and testing
data duplication/reconciliation
compatibility and deprecation
failure/recovery effort
ongoing cognitive/coordination cost
```

### Шаг 4. Recommendation

Compare at least three options including no change. State evidence, assumptions, irreversible points, experiments and accepted risks.

## Ресурсы

- ATAM overview and *Software Architecture in Practice*.
- *Fundamentals of Software Architecture* trade-off analysis.
- *Designing Software Architectures*.
- Cost/reliability materials from adjacent intensives.

## Практические задания

1. Facilitate a lightweight review using ten quality scenarios.
2. Identify sensitivity and trade-off points.
3. Analyze one failure cascade and one change cascade.
4. Build ownership-cost model for monolith/service alternatives.
5. Compare three options including do-nothing.
6. Run one experiment reducing highest risk.
7. Write accepted-risk record with trigger and owner.

## Лабораторная работа

Создать `work/architecture-evaluation/`.

### Options

- retain/tighten layered monolith;
- modular monolith;
- modular monolith plus extracted worker/service;
- broader service decomposition as intentionally expensive comparison.

### Requirements

- review scope and stakeholders are explicit;
- scenarios come from sprint 22 and are prioritized;
- architecture evidence includes code/import/data/runtime/deployment views;
- risks are linked to scenarios and mechanisms;
- sensitivity/trade-off points are identified;
- total ownership cost includes migration and operations, not only implementation;
- do-nothing option and opportunity cost are included;
- scores, if used, include rationale/uncertainty and do not replace discussion;
- reversible/irreversible decisions are separated;
- highest uncertainty receives spike or measurement;
- recommendation states accepted risks and review triggers;
- final result may recommend no structural change.

### Failure scenarios

1. Review asks “is architecture good?” without decision scope.
2. Diagram/folder style is evaluated without scenarios.
3. Every issue is labeled architectural.
4. Scoring matrix hides arbitrary weights and uncertainty.
5. Benefits are counted but migration/operations costs omitted.
6. Service option assumes perfect independence and no coordination.
7. No-change alternative is omitted.
8. Risk has no owner/trigger or mitigation evidence.
9. Review recommends rewrite without compatibility path.
10. Experiment tests easy detail, not highest uncertainty.
11. Accepted risk is forgotten and architecture drifts silently.

## Самопроверка

1. What is architecture review scope?
2. Risk, non-risk, sensitivity and trade-off point?
3. How scenarios drive evaluation?
4. Failure/change cascade analysis?
5. What belongs in total ownership cost?
6. Why include no-change option?
7. Reversibility and option value?
8. What makes scoring false precision?
9. When issue is local, not architectural?
10. What makes recommendation actionable and honest?

## Результат для базы знаний

- **Lightweight architecture evaluation**.
- **Architecture risk, sensitivity and trade-off points**.
- **Quality-scenario walkthrough**.
- **Failure and change propagation analysis**.
- **Architecture total cost of ownership**.
- **Reversibility and option value**.
- **Architecture alternatives and no-change option**.
- **Accepted risks, owners and review triggers**.

## Когда переходить дальше

Можно переходить, когда architecture recommendation follows from prioritized scenarios, risk and total cost evidence, includes do-nothing/reversibility, and highest uncertainty is measured rather than assumed.