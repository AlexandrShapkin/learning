# Спринт 09. Оценки, uncertainty и forecasting

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как прогнозировать completion under uncertainty without presenting estimates as deterministic promises?

## Результат спринта

После завершения необходимо уметь:

- distinguish estimate, forecast, target and commitment;
- use ranges and confidence levels;
- identify known and unknown uncertainty;
- decompose only enough to improve decision quality;
- use historical throughput/cycle-time data;
- perform simple Monte Carlo forecasting conceptually/practically;
- communicate assumptions and update forecasts;
- avoid point-estimate aggregation and padding games;
- compare relative sizing, expert judgment and historical methods.

## Основной маршрут

1. Estimate a synthetic change using three methods.
2. Generate historical completion data.
3. Forecast completion probability/date range.
4. Reforecast after scope and throughput changes.

## Лабораторная работа

Создать `work/forecasting/`.

### Requirements

- forecast names scope, data window and confidence;
- item definitions are consistent enough for history use;
- blocked/canceled intervals are handled explicitly;
- range includes integration and verification, not coding only;
- assumptions and dependencies are visible;
- new evidence updates forecast rather than being hidden;
- target date and forecast are shown separately;
- no individual performance inference is made.

### Failure scenarios

1. Single number is treated as certainty.
2. Estimates exclude review, test and integration.
3. Historical data mixes incomparable work silently.
4. Scope grows but forecast is unchanged.
5. Padding becomes hidden negotiation.
6. Team is evaluated against forecast misses.

## Результат для базы знаний

- **Engineering estimates, forecasts and commitments**.
- **Range and confidence-based forecasting**.
- **Historical throughput and cycle-time forecasting**.
- **Monte Carlo delivery forecasting**.

## Когда переходить дальше

Можно переходить, когда a forecast is expressed probabilistically, updates with evidence and remains separate from target/commitment decisions.