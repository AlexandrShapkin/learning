# Спринт 13. Проверка планирования и потока

Ориентировочный объём: 14–21 час.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 08–12.

## Исходная задача

Создать `work/planning-flow-checkpoint/` — prioritized and forecasted change portfolio with dependencies, WIP controls and a replan after injected disruptions.

## Required artifacts

- candidate changes linked to outcomes/risks;
- priority rationale and displaced alternatives;
- range/confidence forecast;
- dependency graph and critical path;
- workflow states, WIP and blocked policy;
- release/change plan and decision checkpoints;
- disruption scenarios and revised plan.

## Mandatory failure cases

1. Every item is critical.
2. Score precision exceeds evidence.
3. Point estimate is presented as commitment.
4. Review/integration time is omitted.
5. Critical dependency remains implicit.
6. Work starts to maximize individual utilization.
7. Review queue grows beyond capacity.
8. Blocked work remains active indefinitely.
9. Expedite bypass becomes permanent.
10. Scope is added without displacement.
11. Forecast changes are hidden.
12. Date is protected by silent quality reduction.

## Defense

1. Why is the first item first?
2. What is its cost of delay/risk reduction?
3. What confidence does the forecast express?
4. Which historical assumptions support it?
5. What lies on the critical path?
6. Which dependency was reduced or tested early?
7. Where is the bottleneck?
8. Why is the WIP limit appropriate?
9. How is blocked/aging work handled?
10. What changed during replanning?
11. Which work was displaced?
12. What outcome or quality constraint remains protected?

## Критерии прохождения

- priority decisions cite value, risk and timing evidence;
- forecast is probabilistic and scope-aware;
- critical dependencies and integration checks are early;
- WIP and queue policies expose bottlenecks;
- disruptions produce explicit trade-offs and a revised plan;
- all twelve failure cases are reproduced or corrected;
- at least 10 of 12 defense answers cite data or artifacts;
- no metric or estimate is used for individual evaluation.

## Результат для базы знаний

Checkpoint-specific note не требуется. Update prioritization/forecasting/flow notes where experiments changed assumptions.