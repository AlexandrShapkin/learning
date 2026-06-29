# Прикладные системы и интерфейсы

Практическое изучение пользовательских приложений, браузерных интерфейсов, серверных сценариев, API, управления доступом, фоновых процессов и интеграций.

Раздел соответствует области [«Прикладные системы и интерфейсы»](https://github.com/AlexandrShapkin/knowledge/tree/main/content/Прикладные%20системы%20и%20интерфейсы) базы знаний.

## Основной интенсив

### [01. Основы прикладных систем и интерфейсов](intensives/01-Основы%20прикладных%20систем%20и%20интерфейсов/)

Основной маршрут строится вокруг браузерного клиента на HTML, CSS and TypeScript и серверного приложения на Go. PostgreSQL используется как source of truth; Redis, object storage, message broker, local identity provider and mail service подключаются только там, где они нужны конкретному пользовательскому сценарию.

После прохождения необходимо уметь:

- прослеживать пользовательское действие от интерфейса до данных и обратно;
- создавать семантические, доступные и адаптивные веб-интерфейсы;
- управлять клиентским состоянием, маршрутизацией, формами и ошибками;
- строить Go HTTP applications with explicit use cases and resource lifecycles;
- проектировать REST, RPC, gRPC, GraphQL, SSE and WebSocket interfaces;
- развивать API без нарушения существующих клиентов;
- применять sessions, cookies, OAuth 2.0, OpenID Connect and service authentication;
- реализовывать RBAC, ABAC and tenant-aware authorization;
- выполнять задачи синхронно или в фоне с доказуемой delivery/idempotency model;
- проектировать webhooks and external integrations under partial failure;
- обрабатывать файлы, уведомления, localization and configuration;
- тестировать browser UI, API contracts, components and complete user journeys;
- измерять end-to-end latency and diagnose application incidents;
- обеспечивать auditability, validation and application security boundaries.

Ориентировочный объём: 230–330 часов.

## Планируемые тематические углубления

После основного интенсива могут быть добавлены:

- **Frontend engineering and accessibility**;
- **Go backend application engineering**;
- **API and integration design**;
- **Identity, sessions and authorization**;
- **Real-time applications**;
- **Mobile and desktop clients**;
- **Applied web security**;
- **Application testing and performance**;
- **Workflow and background-processing systems**.

Каждое углубление будет самостоятельным маршрутом.

## Связи с другими разделами

- Language/runtime mechanisms — [«Программирование и среды выполнения»](../04-Программирование%20и%20среды%20выполнения/).
- HTTP, TLS and network behavior — [«Сети и протоколы»](../03-Сети%20и%20протоколы/).
- Databases, caches, object storage and streams — [«Данные и хранилища»](../06-Данные%20и%20хранилища/).
- Architectural boundaries and domain modeling — [«Проектирование программного обеспечения»](../08-Проектирование%20программного%20обеспечения/).
- Deployment and runtime delivery — [«Доставка и эксплуатация»](../10-Доставка%20и%20эксплуатация/).
- Metrics, logs and traces — [«Наблюдаемость и диагностика»](../11-Наблюдаемость%20и%20диагностика/).
- Distributed failure models — [«Распределённые системы и надёжность»](../12-Распределённые%20системы%20и%20надёжность/).
- Threat modeling and security controls — [«Безопасность»](../13-Безопасность/).
- Requirements and product value — [«Пользователь и бизнес»](../15-Пользователь%20и%20бизнес/).
