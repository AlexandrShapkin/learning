# Спринт 21. Уведомления и многоканальная доставка

Ориентировочный объём: 16–23 часа.

## Центральный вопрос

Как доставлять user-facing notifications through email, in-app and other channels, respecting preferences, deduplication, localization, privacy and provider failures?

## Результат спринта

После завершения необходимо уметь:

- различать domain event, notification intent, rendered message and provider delivery;
- проектировать notification preference model;
- учитывать mandatory transactional versus optional marketing/product messages;
- выбирать channels by urgency and user context;
- создавать template and localization boundaries;
- избегать storing sensitive data in provider payload/templates unnecessarily;
- создавать stable notification/deduplication key;
- применять background delivery and retry taxonomy;
- понимать provider accepted versus delivered/read state;
- обрабатывать bounce, complaint and invalid destination;
- проектировать rate limits, digest and quiet hours;
- сохранять in-app notification read state;
- связывать deep link with authorization/current resource state;
- выполнять template preview and accessibility checks;
- управлять provider secret/sender configuration;
- наблюдать intent, attempt, provider result and user-visible status;
- тестировать fake/local providers without sending real messages.

## Основной маршрут

### Шаг 1. Notification intent

Store semantic intent:

```text
recipient/tenant
notification type
resource reference
locale/time zone
priority/channel policy
deduplication key
created/expiry time
```

Do not persist final translated text as sole source unless audit/immutability requires it.

### Шаг 2. Preferences and policy

Resolve user preferences, mandatory category, verified destinations, quiet hours and rate limits. Authorization is rechecked when the deep link/resource is opened.

### Шаг 3. Rendering and delivery

Render plain text + HTML email where needed, localize with explicit placeholders, enqueue provider attempt, classify result and retry safely.

### Шаг 4. Status and reconciliation

Provider acceptance is not final delivery. Capture webhooks when available, deduplicate them and expose only appropriate status to users/operators.

## Ресурсы

- local SMTP capture service documentation.
- email message/HTML accessibility guidance.
- provider sandbox/webhook docs for chosen example.
- localization/ICU message-format references.
- background jobs and webhook material from previous sprints.

## Практические задания

1. Build notification intents from domain events.
2. Implement email and in-app adapters.
3. Add preferences, quiet hours and digest mode.
4. Localize templates for two locales/time zones.
5. Reproduce provider timeout, duplicate accepted response and bounce webhook.
6. Add rate limit and deduplication.
7. Test deep links after permission/resource state changes.

## Лабораторная работа

Создать `work/notification-lab/`.

### Notification types

- account/security alert;
- background export ready;
- item/order status change;
- failed integration requiring action;
- optional activity digest.

### Requirements

- intent stored separately from provider attempt;
- stable dedup key prevents repeated logical notification;
- mandatory/optional categories explicit;
- unverified destination not used for sensitive notifications;
- locale and time zone resolved deterministically;
- templates escape untrusted values;
- HTML email has meaningful plain-text alternative;
- links use application URL and require normal authorization;
- provider credentials and recipient addresses redacted from logs;
- retry bounded and does not create duplicate in-app entries;
- bounce/complaint disables or flags destination according to policy;
- quiet hours/digest scheduling is restartable;
- status distinguishes queued, attempted, accepted, failed, bounced and read where available;
- local capture provider only in tests.

### Failure scenarios

1. Domain transaction directly sends email and blocks/rolls back ambiguously.
2. Retry creates duplicate email/in-app record.
3. User preference ignored for optional category.
4. Security notification suppressed by general marketing opt-out.
5. Template injects unescaped user HTML.
6. Link grants access solely because recipient knows URL.
7. Provider “accepted” is displayed as delivered/read.
8. Locale/time zone changes produce wrong schedule/date.
9. Bounce webhook duplicated or forged.
10. Digest grows without bound.
11. Sensitive payload/address appears in logs.

## Самопроверка

1. Event versus notification intent?
2. Mandatory versus optional notification?
3. Provider accepted versus delivered?
4. How deduplication key is chosen?
5. Why rendering is separated from event?
6. How preferences/quiet hours apply?
7. Why deep link still needs authorization?
8. How localization affects templates?
9. Bounce/complaint handling?
10. Which statuses are actually knowable?

## Результат для базы знаний

- **Notification intent and delivery attempt**.
- **Notification channels, preferences and mandatory categories**.
- **Notification deduplication and retry**.
- **Localized and accessible message templates**.
- **Provider acceptance, delivery and bounce states**.
- **In-app notification state and secure deep links**.
- **Notification rate limiting, quiet hours and digests**.

## Когда переходить дальше

Можно переходить, когда duplicate/provider/locale/preference failures preserve one logical notification and no delivery status or link grants more certainty/access than the system can prove.