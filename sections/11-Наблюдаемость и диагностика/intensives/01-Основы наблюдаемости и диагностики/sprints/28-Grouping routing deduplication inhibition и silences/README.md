# Спринт 28. Grouping, routing, deduplication, inhibition и silences

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Как превратить множество одновременно сработавших правил в небольшой набор корректно маршрутизированных notifications without hiding independent failures?

## Результат спринта

После завершения необходимо уметь:

- понимать alert instance, group and notification lifecycle;
- design grouping keys and timing;
- route by service, environment, severity and ownership;
- deduplicate HA/rule duplicates;
- use inhibition for dependent downstream symptoms;
- create scoped, expiring silences;
- distinguish maintenance suppression from disabled detection;
- handle resolve/reopen and flapping;
- preserve one primary symptom while retaining diagnostic children;
- test routing and receivers;
- prevent notification loops and storms;
- audit configuration and manual suppressions.

## Основной маршрут

1. Generate database outage causing API, worker and resource alerts.
2. Configure grouping and primary/downstream inhibition.
3. Route page, ticket and informational notifications to synthetic receivers.
4. Add maintenance silence with owner/expiry.
5. Reproduce flapping and HA duplicate notifications.

## Ресурсы

- Alertmanager grouping, routing, inhibition and silence docs.
- incident-notification design references.

## Лабораторная работа

Создать `work/alert-routing/`.

### Requirements

- grouping keys preserve independent service/environment incidents;
- group wait/interval/repeat are justified;
- routing tree has default receiver and ownership fallback;
- HA duplicate alerts result in one logical notification;
- inhibition suppresses downstream noise only while source alert is active;
- silences require matcher scope, owner, reason and expiry;
- maintenance does not suppress unrelated user-impact alert;
- flapping is reduced through rule/window design, not infinite repeat interval;
- routing tests cover labels, missing owner and receiver failure;
- synthetic receiver delivery is observed;
- configuration and active silences are auditable.

### Failure scenarios

1. Group by alert name splits one incident into hundreds of notifications.
2. Group without environment merges unrelated failures.
3. Inhibition hides an independent downstream outage.
4. Silence uses broad regex and never expires.
5. Missing team label drops notification.
6. Receiver outage is invisible.
7. HA Alertmanagers send duplicate pages.
8. Flapping generates repeated resolved/firing notifications.
9. Maintenance suppresses real customer impact.

## Самопроверка

1. Alert instance, group and notification?
2. Grouping keys/timers?
3. Routing tree and fallback?
4. Deduplication?
5. Inhibition versus silence?
6. Scoped silence requirements?
7. Receiver failure handling?
8. Flapping mitigation?
9. Maintenance suppression risks?
10. How test routing?

## Результат для базы знаний

- **Alert grouping, routing and notification lifecycle**.
- **Alert deduplication and HA notifications**.
- **Alert inhibition for dependent symptoms**.
- **Scoped silences and maintenance suppression**.
- **Alert flapping and receiver monitoring**.

## Когда переходить дальше

Можно переходить, когда a dependency outage produces one actionable notification, independent incidents remain separate, and every suppression is scoped, owned and expiring.