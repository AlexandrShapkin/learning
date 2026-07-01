# Спринт 27. Alert conditions, actionability и false signals

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как создать alert, который reliably indicates user impact or actionable risk and tells a responder what to inspect, without paging on every anomaly?

## Результат спринта

После завершения необходимо уметь:

- distinguish dashboard signal, ticket alert and page alert;
- define symptom-based and cause-based alerts;
- tie page alerts to user impact or imminent exhaustion;
- choose thresholds, windows and `for` duration;
- handle low traffic and missing data;
- include actionable annotations and runbook links;
- understand false positive and false negative trade-offs;
- test rules against historical/synthetic scenarios;
- avoid static thresholds copied across services;
- define owner, severity and response expectation;
- prevent alerts on nonactionable transients;
- measure alert quality.

## Основной маршрут

1. Inventory existing dashboard signals and classify possible response.
2. Create one symptom page, one resource-risk page and one ticket alert.
3. Replay normal spikes and real failures.
4. Tune windows/thresholds/`for` duration.
5. Record false/late/missed alerts.

## Ресурсы

- Prometheus alerting-rule docs.
- Google SRE alerting philosophy.
- Alertmanager annotation/runbook practices.

## Лабораторная работа

Создать `work/alert-design/`.

### Requirements

- every alert names affected service/user symptom or specific risk;
- page versus ticket routing is justified;
- rule handles target/telemetry loss explicitly;
- threshold/window are derived from baseline, capacity or objective;
- annotations include summary, impact, key labels, dashboard and runbook;
- labels are stable and suitable for grouping/routing;
- rule tests cover healthy, transient, sustained, missing-data and recovery cases;
- one copied/static threshold is rejected and replaced;
- response action is possible with available permissions/tools;
- alert precision, detection delay and missed cases are measured.

### Failure scenarios

1. CPU > 80% pages although no saturation or impact exists.
2. One failed request triggers a page.
3. Missing series resolves the alert instead of reporting target loss.
4. Alert has no service/environment/owner context.
5. Threshold is copied from another workload.
6. `for` duration delays fast severe outage excessively.
7. Very low traffic makes ratio alert unstable.
8. Alert fires on every deployment/restart.
9. Responder cannot perform linked runbook action.

## Самопроверка

1. Page versus ticket versus dashboard?
2. Symptom versus cause alert?
3. Actionability?
4. Threshold/window/`for`?
5. Missing-data behavior?
6. Low-traffic handling?
7. Alert labels and annotations?
8. False positive/negative trade-off?
9. Rule testing?
10. Alert-quality metrics?

## Результат для базы знаний

- **Actionable monitoring alerts**.
- **Symptom-based and cause-based alerting**.
- **Alert thresholds, windows and pending duration**.
- **Alert rule testing and missing-data behavior**.
- **Alert precision, detection delay and response ownership**.

## Когда переходить дальше

Можно переходить, когда known sustained failures alert with useful context, normal transients do not page, and every page implies a concrete first response.