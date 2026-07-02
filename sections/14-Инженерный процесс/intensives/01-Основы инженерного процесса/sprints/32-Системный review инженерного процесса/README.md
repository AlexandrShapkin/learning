# Спринт 32. Системный review инженерного процесса

Ориентировочный объём: 21–31 час.

## Центральный вопрос

Как диагностировать engineering process as a socio-technical system and locate the first structural cause of delay, rework or weak decisions?

## Результат спринта

После завершения необходимо уметь:

- reconstruct a change from problem to operation;
- correlate requirements, commits, reviews, tests, decisions and outcomes;
- identify queues, handoffs, rework and decision latency;
- distinguish local symptoms from system constraints;
- detect ownership and knowledge concentration;
- evaluate quality gates, docs and metrics as feedback mechanisms;
- identify conflicting incentives and metric gaming;
- map policy to actual behavior;
- rank improvements by leverage and cost;
- use read-only `engtriage` evidence;
- design bounded improvement portfolio.

## Diagnostic loop

```text
state outcome or failure precisely
→ reconstruct change states and evidence
→ locate waiting, rework and decision points
→ map dependencies, ownership and feedback loops
→ compare stated policy with observed behavior
→ identify bottleneck and contributing conditions
→ choose one discriminating analysis
→ propose smallest high-leverage experiment
→ define balancing evidence and review date
```

## Лабораторная работа

Создать `work/engineering-review/`.

### `engtriage`

Read-only commands:

```text
engtriage change --id ID
engtriage requirement --id ID
engtriage dependency --id ID
engtriage review --id ID
engtriage test --change ID
engtriage decision --id ID
engtriage ownership --path PATH
engtriage flow --from DATE --to DATE
engtriage defect --id ID
engtriage experiment --id ID
```

### Requirements

- tool is read-only, bounded and uses synthetic/approved data;
- one change links problem, requirement, slices, commits, reviews, tests, release and outcome;
- queue/wait/rework intervals are reproducible;
- policy and actual behavior are compared explicitly;
- ownership/review concentration is visible without individual scoring;
- metrics include flow, quality and reliability balance;
- at least one leading explanation is falsified;
- recommendations identify mechanism, expected benefit and trade-off;
- no more than three improvement experiments are proposed;
- review distinguishes immediate fix, process change and architectural constraint.

### Combined examples

- vague requirement + large PR + review churn;
- long-lived branch + late contract mismatch + release delay;
- overloaded owner + stale CODEOWNERS + review queue;
- flaky CI + rerun policy + hidden defect;
- metric target + status gaming + growing actual WIP;
- missing ADR + repeated disagreement + rework;
- documentation gap + onboarding dependency + slow incident response;
- urgent work + no displacement + silent quality erosion.

## Результат для базы знаний

- **Systemic engineering-process review**.
- **Change traceability across engineering evidence**.
- **Process bottlenecks, feedback loops and policy gaps**.
- **High-leverage improvement portfolios**.
- **Safe read-only engineering triage tooling**.

## Когда переходить дальше

Можно переходить к итоговой работе, когда unfamiliar process problems are reconstructed from evidence and converted into a small testable improvement portfolio.