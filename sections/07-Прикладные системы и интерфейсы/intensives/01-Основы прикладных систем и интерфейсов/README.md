# Основы прикладных систем и интерфейсов

Основной интенсив раздела «Прикладные системы и интерфейсы». Его цель — связать пользовательское действие, browser interface, application use case, API contract, data access, background processing and external integration в один наблюдаемый и проверяемый путь.

Основная реализация: Go backend, TypeScript frontend and browser platform standards. React используется как representative component framework после освоения DOM, events and forms. Product-specific mechanisms вводятся только после явного contract and failure model.

## Результат прохождения

После завершения необходимо уметь самостоятельно:

- описывать end-to-end user journey and system boundary;
- выбирать web, CLI, mobile or desktop interface according to interaction constraints;
- понимать browser navigation, rendering, DOM, events, forms and storage;
- создавать semantic HTML and accessible keyboard/screen-reader flows;
- строить responsive CSS layouts and complete visual states;
- использовать TypeScript for client contracts and state transitions;
- проектировать components, routing and client-side state;
- выполнять data fetching with cancellation, retries and cache semantics;
- создавать Go HTTP server with middleware, timeouts and graceful shutdown;
- отделять transport, application scenario, business rules and data adapters;
- проектировать HTTP/REST resources, methods, status codes and representations;
- определять validation, error, pagination, filtering, idempotency and versioning contracts;
- выбирать REST, GraphQL, gRPC/RPC, SSE or WebSocket by interaction model;
- использовать OpenAPI and Protocol Buffers as executable contracts;
- реализовывать sessions, cookies, CSRF protection and logout/revocation;
- понимать OAuth 2.0 and OpenID Connect roles and flows;
- применять RBAC, ABAC, ownership and multi-tenant authorization;
- организовывать background jobs, schedules, file processing and progress reporting;
- реализовывать webhooks, external API adapters and reconciliation;
- отправлять notifications with preferences, deduplication and delivery status;
- проектировать configuration, localization, cache and audit behavior;
- применять secure input/output handling and browser security controls;
- строить unit, integration, contract, component and end-to-end tests;
- измерять complete user journey performance and resource use;
- использовать logs, metrics and traces for application diagnostics;
- локализовать partial failures across client, server, dependency and data layers.

Целевой уровень: 3 по всему разделу и 4 по HTTP applications, API contracts, authentication/authorization, background processing, integration reliability, testing and end-to-end diagnostics.

## Границы

Интенсив не заменяет:

- глубокий курс browser engine internals;
- полный frontend framework curriculum;
- нативную mobile/desktop specialization;
- полный курс software architecture;
- отдельный курс application security;
- platform engineering and production deployment curriculum;
- enterprise IAM administration;
- product design and UX research;
- полное изучение каждого API style or integration product.

Смежные темы включаются только настолько, насколько они необходимы для построения и проверки прикладной системы.

## Предварительные знания

Рекомендуется завершить основные интенсивы по сетям, программированию, данным и операционным системам.

Минимально необходимы:

- Go, modules, tests, concurrency and context;
- HTML/CSS/JavaScript at introductory level or readiness to learn from browser standards;
- HTTP, DNS, TLS and sockets conceptually;
- SQL and PostgreSQL basics;
- Linux shell, Git and containers;
- технический английский.

## Лабораторное окружение

Эталонная среда — disposable Linux VM or workstation profile with local browser and container runtime.

Основной набор:

- Go toolchain;
- Node.js current supported release and package manager;
- TypeScript and browser build tool;
- Chromium and Firefox; WebKit through Playwright where supported;
- PostgreSQL and Redis;
- S3-compatible object storage;
- local message broker;
- local OIDC provider;
- local SMTP capture service;
- Playwright and accessibility tooling;
- OpenTelemetry-compatible local observability stack.

Подробности: [`LAB_ENVIRONMENT.md`](LAB_ENVIRONMENT.md).

Проверка:

```bash
bash scripts/check-environment.sh
```

## Принципы прохождения

1. Начинать с пользовательского сценария, actor, expected result and failure states.
2. Сначала использовать browser and HTTP platform capabilities; framework adds organization, not replacement of fundamentals.
3. Business rule проверяется независимо от transport and UI.
4. API contract defines observable behavior before handler implementation.
5. Authentication does not imply authorization; every protected operation checks subject, action and resource.
6. Background task has durable state, idempotency and cancellation/retry semantics.
7. External integration assumes timeout, duplication, reordering and partial failure.
8. UI includes loading, empty, error, offline/slow and permission-denied states.
9. Accessibility and localization are design inputs, not final polish.
10. Performance измеряется по complete journey, not isolated handler only.
11. Test double cannot replace at least one real integration path.
12. General mechanisms move to `knowledge`; implementation-specific code and evidence remain in `learning`.

## Основной стек

- Go standard library and selected small libraries — backend and workers;
- HTML, CSS, browser Web APIs and TypeScript — client foundation;
- React — representative component framework for the main client;
- PostgreSQL — source of truth;
- Redis — cache/session/rate-limit comparison where justified;
- OpenAPI — HTTP API contract;
- Protocol Buffers and gRPC — RPC comparison;
- local OIDC provider — authentication laboratory;
- NATS JetStream or equivalent — background/event delivery;
- MinIO or equivalent — file/object workflows;
- Mailpit or equivalent — notification capture;
- Playwright — browser end-to-end tests;
- OpenTelemetry — traces and correlation.

A concrete framework or product may be substituted when the same browser/protocol/application guarantees remain observable and documented.

## Порядок спринтов

1. [Пользовательское действие и путь запроса](sprints/01-Пользовательское%20действие%20и%20путь%20запроса/)
2. [Браузер, навигация, DOM и события](sprints/02-Браузер%20навигация%20DOM%20и%20события/)
3. [Семантический HTML, формы и доступность](sprints/03-Семантический%20HTML%20формы%20и%20доступность/)
4. [CSS, адаптивность и визуальные состояния](sprints/04-CSS%20адаптивность%20и%20визуальные%20состояния/)
5. [JavaScript и TypeScript в браузере](sprints/05-JavaScript%20и%20TypeScript%20в%20браузере/)
6. [Компоненты, маршрутизация и клиентское состояние](sprints/06-Компоненты%20маршрутизация%20и%20клиентское%20состояние/)
7. [Получение данных, клиентский кеш и обработка ошибок](sprints/07-Получение%20данных%20клиентский%20кеш%20и%20обработка%20ошибок/)
8. [Проверка пользовательского интерфейса](sprints/08-Проверка%20пользовательского%20интерфейса/)
9. [Go HTTP server и жизненный цикл запроса](sprints/09-Go%20HTTP%20server%20и%20жизненный%20цикл%20запроса/)
10. [Прикладные сценарии, бизнес-правила и доступ к данным](sprints/10-Прикладные%20сценарии%20бизнес-правила%20и%20доступ%20к%20данным/)
11. [REST и проектирование HTTP API](sprints/11-REST%20и%20проектирование%20HTTP%20API/)
12. [Валидация, ошибки, пагинация, идемпотентность и версии](sprints/12-Валидация%20ошибки%20пагинация%20идемпотентность%20и%20версии/)
13. [RPC, gRPC, GraphQL и выбор стиля API](sprints/13-RPC%20gRPC%20GraphQL%20и%20выбор%20стиля%20API/)
14. [SSE, WebSocket и интерфейсы реального времени](sprints/14-SSE%20WebSocket%20и%20интерфейсы%20реального%20времени/)
15. [Проверка серверного приложения и API](sprints/15-Проверка%20серверного%20приложения%20и%20API/)
16. [Сессии, cookies и защита от CSRF](sprints/16-Сессии%20cookies%20и%20защита%20от%20CSRF/)
17. [OAuth 2.0, OpenID Connect, токены и сервисная аутентификация](sprints/17-OAuth%202.0%20OpenID%20Connect%20токены%20и%20сервисная%20аутентификация/)
18. [Авторизация, RBAC, ABAC и мультитенантность](sprints/18-Авторизация%20RBAC%20ABAC%20и%20мультитенантность/)
19. [Фоновые задачи, планировщики и обработка файлов](sprints/19-Фоновые%20задачи%20планировщики%20и%20обработка%20файлов/)
20. [Webhooks и внешние интеграции](sprints/20-Webhooks%20и%20внешние%20интеграции/)
21. [Уведомления и многоканальная доставка](sprints/21-Уведомления%20и%20многоканальная%20доставка/)
22. [Конфигурация, локализация, кеширование и аудит](sprints/22-Конфигурация%20локализация%20кеширование%20и%20аудит/)
23. [Безопасность прикладных границ](sprints/23-Безопасность%20прикладных%20границ/)
24. [Тестирование интерфейсов и взаимодействия компонентов](sprints/24-Тестирование%20интерфейсов%20и%20взаимодействия%20компонентов/)
25. [Производительность пользовательского сценария](sprints/25-Производительность%20пользовательского%20сценария/)
26. [Наблюдаемость и системная диагностика приложения](sprints/26-Наблюдаемость%20и%20системная%20диагностика%20приложения/)
99. [Итоговая работа](sprints/99-Итоговая%20работа/)

## Покрытие основных вопросов

| Вопрос | Спринты |
|---|---|
| Как действие проходит через интерфейс, сервер и данные? | 01–02, 07, 09–12, 25–26 |
| Где находится бизнес-логика? | 09–10, 15, 19–20 |
| Как организовать клиентское и серверное состояние? | 02, 05–07, 09–10, 16, 19 |
| Как выбрать стиль API? | 11–14 |
| Как развивать API без поломки клиентов? | 11–13, 20, 24 |
| Как организовать authentication, sessions and authorization? | 16–18, 23 |
| Когда выполнять операцию в фоне? | 19, 21, 25 |
| Как обеспечить надёжность внешней интеграции? | 19–21, 26 |
| Как валидировать ввод и сохранять контекст ошибки? | 03, 07, 10–12, 23 |
| Какие данные нужны для audit and observability? | 21–22, 26 |
| Как оценивать complete user journey performance? | 07, 09, 19, 25–26 |
| Как тестировать UI, API and components? | 08, 15, 24, 99 |

Таблица является статической картой покрытия и не требует ручного ведения прогресса.

## Итоговая работа

Финальный проект — `application-lab-platform`: full-stack multi-tenant application with accessible browser client, Go API, PostgreSQL source of truth, authentication, background jobs, webhooks, file processing and real-time updates.

Система должна позволять:

- проследить и измерить полный пользовательский сценарий;
- проверить UI semantics, accessibility and error states;
- развивать versioned API contracts;
- воспроизводить session, authorization and token failures;
- выполнять durable background work and retries;
- интегрироваться with external sandbox services and webhooks;
- проверять audit, notifications, localization and caching;
- запускать contract, browser and end-to-end tests;
- диагностировать client, server, database and dependency incidents.

## Вклад в базу знаний

Каждый спринт содержит конкретные рекомендуемые заметки. Отдельный backlog не ведётся. General application mechanisms переносятся в `knowledge`; source code, fixtures, screenshots, test traces and incident evidence остаются в `learning`.

## Общая библиография

Specifications, books, official documentation and courses собраны в [`RESOURCES.md`](RESOURCES.md). Внутри каждого спринта указан обязательный минимальный маршрут.
