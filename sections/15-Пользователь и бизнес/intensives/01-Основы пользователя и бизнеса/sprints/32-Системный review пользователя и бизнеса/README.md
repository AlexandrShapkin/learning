# Спринт 32. Системный review пользователя и бизнеса

Ориентировочный объём: 21–31 час.

## Центральный вопрос

Как проверить, что product/business system coherently links user evidence, process, strategy, analytics, economics, risk and adoption?

## Результат спринта

После завершения необходимо уметь:

- reconstruct evidence from user problem to business result;
- trace assumptions through strategy, requirements and metrics;
- identify contradictions between research, analytics and economics;
- compare stated process with actual behavior;
- detect metric, incentive and selection biases;
- analyze who benefits, pays and bears risk;
- locate first weak link in value realization;
- distinguish product failure from rollout/process/measurement failure;
- rank uncertainties and decisions by consequence;
- design a bounded evidence-improvement portfolio;
- use read-only `biztriage`.

## Diagnostic loop

```text
state user and business outcome
→ identify affected segments and stakeholders
→ trace research evidence and assumptions
→ inspect journey, process, rules and requirements
→ validate event/metric definitions and causal claims
→ inspect economics, risk and adoption constraints
→ locate first contradiction or unsupported link
→ choose one discriminating research/analysis
→ make continue, adapt, scale or stop decision
```

## Лабораторная работа

Создать `work/product-business-review/`.

### `biztriage`

Read-only commands:

```text
biztriage stakeholder --role ROLE
biztriage evidence --hypothesis ID
biztriage journey --segment ID
biztriage process --id ID
biztriage rule --id ID
biztriage requirement --id ID
biztriage metric --name NAME
biztriage experiment --id ID
biztriage economics --segment ID
biztriage risk --id ID
biztriage rollout --cohort ID
biztriage decision --id ID
```

### Requirements

- tool reads only local synthetic/approved data;
- output links claims to evidence and definitions;
- unsupported assumptions and contradictions are visible;
- segment, cohort and time scope are explicit;
- metric lineage and experiment exposure are inspectable;
- economics show assumptions and sensitivity;
- risk and adoption evidence are included;
- at least one attractive narrative is falsified;
- no more than three evidence/decision actions are proposed;
- output contains no personal or sensitive data.

### Combined examples

- loud buyer request + worker harm + weak adoption;
- successful funnel + poor retention + high support cost;
- positive experiment + wrong randomization unit + rollout failure;
- strong demand + negative unit economics + vendor concentration;
- process automation + unchanged policy bottleneck;
- high login adoption + shadow process + no business outcome;
- profitable average + loss-making strategic segment;
- roadmap commitment + failed assumption + sunk-cost continuation.

## Результат для базы знаний

- **Systemic product and business review**.
- **Evidence traceability from user problem to business outcome**.
- **Contradictions across research, analytics and economics**.
- **Product, process, rollout and measurement failure diagnosis**.
- **Safe read-only product/business triage tooling**.

## Когда переходить дальше

Можно переходить к итоговой работе, когда an unfamiliar product claim can be reconstructed, challenged and converted into a bounded evidence-based decision.