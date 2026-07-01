# Спринт 29. SLO burn-rate alerts и alert tuning

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как превратить user-facing SLI and error budget into fast and slow burn alerts that detect meaningful reliability loss without paging on harmless noise?

## Результат спринта

После завершения необходимо уметь:

- derive error ratio from valid and bad events;
- calculate error-budget consumption and burn rate;
- understand short/long windows and multi-window rules;
- distinguish fast severe and slow persistent burn;
- handle low traffic and missing SLI data;
- map page/ticket severity to exhaustion horizon;
- tune alerts from replayed incidents;
- avoid averaging away segment-specific failure;
- combine SLO alerts with resource-risk alerts;
- measure detection delay, precision and responder burden;
- revise rules without changing SLO history silently;
- separate SLO policy from alert implementation.

## Основной маршрут

1. Use API availability/latency and job freshness SLIs.
2. Calculate budget and burn rates from synthetic history.
3. Implement fast and slow multi-window alerts.
4. Replay short outage, slow degradation and low-traffic failure.
5. Tune and compare with simple threshold alerts.

## Ресурсы

- Google SRE SLO/error-budget and burn-rate material.
- Prometheus rule examples and testing docs.

## Лабораторная работа

Создать `work/slo-alerting/`.

### Requirements

- SLI event definitions and exclusions are versioned;
- burn expressions use consistent valid/bad event scope;
- fast page predicts rapid budget exhaustion;
- slow burn routes as actionable ticket/notification;
- short and long windows must both meet the intended condition;
- low-traffic strategy is documented and tested;
- route/tenant segmentation reveals severe localized failure without uncontrolled cardinality;
- missing SLI data creates separate telemetry/target condition;
- historical/synthetic replay measures detection/clear times and false pages;
- alert annotations show burn, window, budget and user journey;
- rule changes preserve audit history.

### Failure scenarios

1. Numerator/denominator use different route/status windows.
2. One short spike pages despite negligible budget impact.
3. Slow degradation never crosses static threshold.
4. Global SLI hides one critical route/tenant.
5. Low traffic produces extreme unstable ratio.
6. Missing data appears as perfect SLI.
7. Burn alert and resource alert page independently without grouping.
8. Rule tuning changes SLO definition retroactively.
9. Error budget is used as permission to ignore user-impact details.

## Самопроверка

1. Error ratio and error budget?
2. Burn rate meaning?
3. Fast versus slow burn?
4. Multi-window/multi-burn logic?
5. Low-traffic handling?
6. Segmented SLI trade-offs?
7. Missing-data behavior?
8. Page versus ticket mapping?
9. Replay-based tuning?
10. SLO policy versus alert implementation?

## Результат для базы знаний

- **SLO burn-rate alerting**.
- **Multi-window fast and slow burn alerts**.
- **Low-traffic and segmented SLO alerts**.
- **SLO alert replay and tuning**.
- **Error-budget alerts and responder burden**.

## Когда переходить дальше

Можно переходить, когда fast and slow budget consumption trigger at intended horizons, while short harmless spikes and missing telemetry do not masquerade as service failure or health.