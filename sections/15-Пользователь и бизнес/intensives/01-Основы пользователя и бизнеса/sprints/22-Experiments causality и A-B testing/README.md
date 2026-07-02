# Спринт 22. Experiments, causality и A-B testing

Ориентировочный объём: 21–31 час.

## Центральный вопрос

Как определить, caused ли intervention the observed change, and which populations, guardrails and assumptions limit the result?

## Результат спринта

После завершения необходимо уметь:

- distinguish correlation, prediction and causal effect;
- define treatment, control, unit and outcome;
- choose randomization unit and avoid interference;
- predefine primary, secondary and guardrail metrics;
- estimate sample/duration assumptions conceptually;
- handle novelty, seasonality and peeking;
- interpret confidence intervals and practical significance;
- analyze heterogeneous effects cautiously;
- use quasi-experiments when randomization is impossible;
- avoid unethical or harmful experiments;
- decide ship, iterate, stop or gather more evidence.

## Основной маршрут

1. Design one synthetic workflow/onboarding experiment.
2. Define assignment, exposure, outcomes and guardrails.
3. Simulate treatment and control datasets.
4. Analyze bias, uncertainty and decision.

## Лабораторная работа

Создать `work/experimentation/`.

### Requirements

- hypothesis and decision are written before analysis;
- randomization unit matches product interaction and avoids contamination;
- sample includes eligible population and exposure rules;
- primary outcome is not replaced after results;
- guardrails include errors, support, accessibility and harm;
- duration accounts for business cycles where relevant;
- analysis reports effect range and practical importance;
- peeking/multiple comparisons are controlled or disclosed;
- segment analysis is predeclared or exploratory;
- negative/null result can stop or redirect investment.

### Failure scenarios

1. Users in one account receive mixed treatment and contaminate behavior.
2. Metric is selected after finding significance.
3. Experiment stops at first favorable day.
4. Small statistical effect has no practical value.
5. Harmed subgroup is hidden by average.
6. Seasonal change is attributed to treatment.
7. Essential workflow is degraded without safeguard.

## Результат для базы знаний

- **Causal product experiments and randomization**.
- **Experiment units, exposure and interference**.
- **Primary outcomes, guardrails and predefinition**.
- **Statistical versus practical significance**.
- **Quasi-experiments and causal limitations**.

## Когда переходить дальше

Можно переходить, когда the decision remains defensible after assignment, contamination, peeking, uncertainty and guardrail checks.