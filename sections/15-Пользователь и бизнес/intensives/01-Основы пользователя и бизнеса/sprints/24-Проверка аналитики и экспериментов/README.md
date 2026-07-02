# Спринт 24. Проверка аналитики и экспериментов

Ориентировочный объём: 15–22 часа.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 20–23.

## Исходная задача

Создать `work/analytics-experiment-checkpoint/` — trustworthy event instrumentation, funnel/cohort analysis, controlled experiment and triangulated support/research decision.

## Required artifacts

- analytics questions and event taxonomy;
- identity and schema-version model;
- data-quality/reconciliation checks;
- funnel, activation and cohort definitions;
- retention/churn analysis by segment;
- experiment plan, synthetic assignment and analysis;
- support/feedback taxonomy;
- triangulated decision and uncertainty.

## Mandatory failure cases

1. Event meaning differs across clients.
2. Identity merge/split corrupts metrics.
3. Duplicate or late events inflate conversion.
4. Funnel denominator/window is inconsistent.
5. Signup is treated as activation.
6. Recent cohorts are compared unfairly.
7. Account and user retention are mixed.
8. Randomization unit allows contamination.
9. Metric is selected after results.
10. Experiment peeks/stops early.
11. Support volume overrides severity/context.
12. Contradictory evidence is hidden.

## Defense

1. Which decision requires each event?
2. How are identities and duplicates handled?
3. How does analytics reconcile with process truth?
4. What defines funnel eligibility and activation?
5. Which cohort/retention unit is appropriate?
6. What biases affect segment conclusions?
7. What is the treatment and randomization unit?
8. Which primary and guardrail outcomes are predeclared?
9. What effect range and practical significance matter?
10. What does the experiment not prove?
11. How are support and research biases handled?
12. Why does the combined evidence support the decision?

## Критерии прохождения

- event data is versioned, quality-checked and reconcilable;
- funnel/cohort definitions survive denominator and identity checks;
- experiment design addresses contamination, peeking and guardrails;
- qualitative/support evidence is classified and privacy-safe;
- all twelve failure cases are identified or corrected;
- at least 10 of 12 defense answers cite queries, schemas or evidence;
- decision may validly be null, stop or gather-more-evidence.

## Результат для базы знаний

Checkpoint-specific note не требуется. Update analytics/funnel/experiment/triangulation notes where the exercise changed assumptions.