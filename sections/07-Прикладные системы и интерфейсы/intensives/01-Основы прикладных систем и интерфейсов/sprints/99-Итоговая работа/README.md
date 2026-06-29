# Спринт 99. Итоговая работа

Ориентировочный объём: 50–75 часов.

## Задача

Создать `application-lab-platform` — воспроизводимую full-stack application laboratory, связывающую accessible browser interface, Go backend, versioned APIs, identity, authorization, background processing, integrations, notifications, testing, performance and diagnostics.

Проект не является production SaaS or universal frontend/backend framework. Его задача — позволить пройти и доказать complete user journey, воспроизвести bounded failures at every application boundary and restore one correct user-visible outcome.

## Domain

Synthetic multi-tenant work/order platform:

- tenants, users and memberships;
- items/orders/tasks with statuses and comments;
- attachments and generated exports;
- background validation/processing jobs;
- external payment/shipping/document-analysis sandbox integration;
- webhook subscriptions;
- email and in-app notifications;
- audit events;
- real-time status updates.

No real users, destinations, credentials or third-party accounts are used.

## Архитектура

```text
browser client (TypeScript + React)
├── accessible routes/forms/components
├── session/BFF authentication
├── REST/OpenAPI client
└── SSE status channel
            |
         Go application
├── HTTP/REST API and BFF
├── optional gRPC internal adapter
├── bounded GraphQL read adapter
├── application use cases and authorization
├── PostgreSQL source of truth
├── Redis cache/session support
├── object storage for attachments
├── transactional outbox
└── workers/schedulers
        |
        +---- message broker
        +---- external API sandbox
        +---- webhook receiver/sender
        +---- local SMTP capture
        +---- search/read projection optional

local identity provider (OAuth/OIDC)
OpenTelemetry collector and local metrics/traces
```

## Структура проекта

```text
work/application-lab-platform/
├── cmd/
│   ├── app-server/
│   ├── worker/
│   ├── integration-sandbox/
│   └── apptriage/
├── internal/
│   ├── domain/
│   ├── application/
│   ├── authorization/
│   ├── httpapi/
│   ├── grpcapi/
│   ├── graphqlapi/
│   ├── identity/
│   ├── postgres/
│   ├── cache/
│   ├── objects/
│   ├── jobs/
│   ├── integrations/
│   ├── notifications/
│   ├── observability/
│   └── faults/
├── web/
│   ├── src/
│   ├── public/
│   └── tests/
├── api/
│   ├── openapi/
│   ├── proto/
│   └── schemas/
├── migrations/
├── fixtures/
├── compose/
├── scripts/
├── reports/
├── docs/
├── Makefile
├── go.mod
└── README.md
```

## Документы итоговой работы

- [`IMPLEMENTATION.md`](IMPLEMENTATION.md) — mandatory components, guarantees and implementation stages.
- [`FAULTS.md`](FAULTS.md) — catalogue of 50 bounded and reversible application faults.
- [`ASSESSMENT.md`](ASSESSMENT.md) — blind incidents, final defense and delayed assessment.

## Обязательные пользовательские сценарии

1. Anonymous user opens landing/search page.
2. User authenticates through local OIDC provider and receives application session.
3. Member lists/searches tenant resources with URL-backed filters.
4. Member creates a resource with validation and idempotency.
5. Member edits with optimistic concurrency and conflict recovery.
6. Member uploads an attachment and observes background processing progress.
7. Manager changes status and triggers outbox event.
8. Worker invokes external sandbox and handles ambiguous/retry result.
9. Signed webhook updates status idempotently and out-of-order safely.
10. User receives in-app/email notification according to preference.
11. Browser receives SSE update and reconciles authoritative state.
12. Tenant admin performs privileged action with audit.
13. User logs out or session is revoked.
14. Operator diagnoses a cross-component failure through `apptriage`.

## Основные результаты

Готовая система должна включать:

- semantic, keyboard-accessible and responsive interface;
- explicit loading, empty, stale, conflict, permission and failure states;
- TypeScript strict mode and runtime payload validation;
- stable routing, URL state and browser history;
- Go HTTP server with limits, cancellation and graceful shutdown;
- transport-independent application use cases;
- PostgreSQL transactions and tenant-safe data access;
- OpenAPI contract, typed errors, pagination, idempotency and compatibility tests;
- gRPC/protobuf and bounded GraphQL comparison adapters;
- SSE with event IDs, reconnect and slow-consumer controls;
- secure server-side sessions and CSRF defense;
- local OAuth/OIDC flow and validated service tokens;
- RBAC/ABAC/ownership authorization across UI/API/jobs/files/realtime;
- durable background jobs, schedules and file-processing lifecycle;
- resilient external API and signed webhook integration;
- notification preferences, localization and deduplication;
- safe configuration, feature flags, caching and audit;
- application security controls for XSS, injection, CORS, CSP, files and SSRF;
- unit, integration, contract, component and browser tests;
- end-to-end performance budgets and traces;
- read-only `apptriage` and controlled fault injection.

## Порядок выполнения

1. Define user journeys, contracts, threat/authorization boundaries and observability IDs.
2. Build accessible browser shell and typed client core.
3. Implement Go application core, PostgreSQL schema and REST/OpenAPI.
4. Add validation, pagination, idempotency and compatibility tests.
5. Add sessions, OIDC and complete authorization matrix.
6. Add file/object workflow, jobs, outbox and SSE updates.
7. Add external sandbox, webhooks and notifications.
8. Add configuration, localization, caching, audit and security controls.
9. Add gRPC/GraphQL comparison adapters.
10. Complete test portfolio and representative load/performance report.
11. Implement diagnostics, fault catalogue and blind incidents.
12. Run clean rebuild, final defense and delayed assessment.

## Обязательные артефакты

Коммитить:

- source, schemas and tests;
- module/package lockfiles;
- OpenAPI, protobuf and JSON schemas;
- database migrations and small synthetic fixtures;
- local container configuration without secrets;
- accessibility/browser-support notes;
- threat and authorization matrices;
- background/integration state diagrams;
- concise traces/performance/accessibility reports;
- fault definitions and incident cards;
- commands to regenerate large reports/artifacts;
- links to `knowledge` notes.

Не коммитить:

- real accounts, personal data or third-party API keys;
- cookies, tokens, client secrets, certificates or signing keys;
- database, broker, object or identity-provider volumes;
- `node_modules`, browser binaries and compiled outputs;
- raw browser videos/traces from every run;
- generated uploads and large exports;
- full logs containing request bodies or sensitive fields;
- unbounded load/fault scripts.

## Safety

- all services bind locally on explicit non-default ports;
- OIDC/webhook redirects and origins are local allowlists;
- browser automation uses synthetic accounts only;
- notifications terminate in local capture/fake providers;
- external integrations use local sandbox servers;
- upload and SSRF tests use isolated synthetic targets;
- workload generators cap users, requests, bytes, duration and concurrency;
- faults require repository marker and explicit lab mode;
- destructive data changes target disposable tenant/database;
- cleanup verifies sessions, workers, listeners, browser processes, objects and temporary files.

## Результат для базы знаний

Итоговая работа должна завершить или исправить заметки по browser platform, accessibility, frontend state, HTTP servers, application use cases, API styles/contracts, identity, authorization, background work, webhooks, notifications, configuration, localization, application security, testing, performance and diagnostics.

Source code, contracts, fixtures, screenshots, traces and incident evidence remain in `learning`; generalized mechanisms move to `knowledge`.
