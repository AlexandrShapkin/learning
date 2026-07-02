# Спринт 08. Приоритизация, value, risk и cost of delay

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Как выбирать next work when value, urgency, risk reduction and effort conflict?

## Результат спринта

После завершения необходимо уметь:

- distinguish urgency, importance, value and risk;
- evaluate cost of delay and time sensitivity;
- prioritize risk reduction and learning alongside feature value;
- account for dependencies and enablement;
- compare scoring methods critically;
- identify false precision and political weighting;
- define explicit trade-offs and decision owner;
- revisit priority as evidence changes;
- avoid permanent expedite lanes.

## Основной маршрут

1. Build a synthetic candidate set of 12 changes.
2. Evaluate value, urgency, risk, learning and effort ranges.
3. Compare simple ordering, WSJF-like score and portfolio constraints.
4. Reprioritize after a new incident/dependency signal.

## Лабораторная работа

Создать `work/prioritization/`.

### Requirements

- each item links to problem/outcome or risk;
- time sensitivity and cost of delay are explicit where relevant;
- mandatory/regulatory work is distinguished from discretionary work;
- uncertainty and confidence are visible;
- score is not used without qualitative review;
- enablement work has a named dependent outcome;
- expedite policy has entry/exit limits;
- reprioritization records changed evidence and displaced work.

### Failure scenarios

1. Highest stakeholder rank overrides all evidence.
2. Every item is “critical”.
3. Scoring uses precise numbers with no basis.
4. Technical debt has no linked risk/outcome.
5. Expedite becomes normal flow.
6. Priority changes without acknowledging interrupted work.

## Результат для базы знаний

- **Engineering work prioritization**.
- **Cost of delay and time-critical work**.
- **Risk-reduction and learning value**.
- **Prioritization scoring limitations**.

## Когда переходить дальше

Можно переходить, когда selected work and displaced alternatives can be explained through explicit value, urgency, risk and evidence.