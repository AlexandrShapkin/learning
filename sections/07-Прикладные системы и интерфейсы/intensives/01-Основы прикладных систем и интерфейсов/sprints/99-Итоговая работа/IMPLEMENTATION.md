# Реализация итоговой работы

## 1. User journeys and contracts

Define at least 14 journeys from the capstone README. Each records:

```text
actor and tenant
preconditions
user actions
visible states
API/application operations
persistent and external effects
cancellation/timeout/duplicate paths
authorization decisions
correlation and audit IDs
success and failure evidence
```

The same journeys drive UI, API, tests, performance and incident exercises.

## 2. Browser client

Required:

- semantic HTML landmarks/headings/forms;
- keyboard navigation and focus management;
- responsive layouts for narrow/medium/wide viewports;
- reduced-motion and long-localization support;
- TypeScript strict mode;
- runtime validation of unknown server payloads;
- typed route, query and mutation states;
- URL-backed filters and stable history;
- accessible loading, empty, stale, error, conflict and permission states;
- request cancellation/deduplication;
- optimistic updates only with rollback/reconciliation;
- browser-level user timing markers.

React is the primary component framework, but business/API state contracts remain framework-independent.

## 3. Go server lifecycle

- explicit `http.Server` and timeouts;
- request body/multipart/concurrency limits;
- request/trace ID propagation;
- context cancellation into database/external adapters;
- ordered middleware for recovery, logging, security, identity and metrics;
- liveness and readiness endpoints;
- bounded graceful shutdown;
- no global mutable application state;
- structured logs with redaction.

## 4. Application core

Use cases include:

- create/read/list/update resource;
- status transition;
- attachment upload/finalization;
- background job creation/cancel;
- webhook subscription;
- notification preference;
- privileged tenant/admin operation.

Requirements:

- transport-independent commands/results/errors;
- explicit transaction boundary;
- narrow repository/gateway interfaces;
- injectable clock/IDs/external clients;
- business invariants independent from HTTP/GraphQL/gRPC;
- authorization input includes subject, action, resource and context;
- outbox/task intent committed with source state where required.

## 5. PostgreSQL and data access

- tenant-safe schema and constraints;
- explicit migrations;
- transactional repositories;
- stable pagination indexes/order;
- idempotency records;
- session and membership state;
- job/outbox/inbox records;
- audit records;
- integration operation state;
- object metadata and notification intent;
- real integration tests for transactions/constraints/concurrency.

## 6. REST and OpenAPI

- resource-oriented endpoints;
- correct method/status/header semantics;
- Problem Details-style error contract;
- request/response JSON schemas;
- field/domain/auth/conflict/rate-limit/internal error codes;
- cursor pagination and bounded filters/sorts;
- conditional update/version conflict;
- idempotency key and request fingerprint;
- asynchronous job resources;
- compatibility/deprecation policy;
- executable OpenAPI examples and client/server conformance tests.

## 7. gRPC and GraphQL adapters

### gRPC

- protobuf packages/messages/services;
- field-number/presence compatibility tests;
- deadlines/cancellation;
- domain/status mapping;
- one unary and one streaming operation;
- no generated type leakage into business core.

### GraphQL

- bounded read schema and selected mutations only if justified;
- per-resource/field authorization;
- batching/set-based loading;
- query depth/complexity/result/time limits;
- no resolver N+1 at representative scale;
- stable error redaction.

## 8. Sessions and OIDC

- local OAuth/OIDC provider;
- Authorization Code with PKCE;
- strict redirect URIs and state/nonce validation;
- backend session with secure cookie;
- session rotation after authentication/privilege change;
- idle/absolute expiry and server-side revocation;
- CSRF protection for unsafe cookie-authenticated requests;
- access-token issuer/audience/signature/time validation for resource/service path;
- no real tokens/secrets in Git/logs/browser persistent storage;
- sign-out and provider-session limitations documented.

## 9. Authorization

- permission matrix for member, manager, tenant admin, support and worker;
- RBAC plus ownership/tenant/context rules;
- deny-by-default;
- tenant constraints in query/update/delete paths;
- object and field-level authorization;
- protected attachments/downloads;
- GraphQL nested-field checks;
- job, webhook and real-time subscription authorization;
- privileged support access with reason/expiry/audit;
- exhaustive negative authorization tests.

## 10. Background work and files

- durable job state machine;
- atomic claim/lease and recovery;
- attempts, backoff, next-run and poison state;
- idempotent effects;
- progress and cancellation;
- bounded concurrency by resource class;
- scheduled cleanup with duplicate-safe behavior;
- attachment upload intent, staging, size/type/checksum validation;
- isolated background processing;
- finalization and temporary/orphan cleanup;
- status endpoint and SSE progress.

## 11. Real-time interface

- SSE status/event channel as primary path;
- stable event ID and schema version;
- deduplication and aggregate version;
- reconnect with backoff;
- replay window or snapshot/refetch fallback;
- tenant/resource subscription authorization;
- bounded per-connection queues;
- slow-client policy and metrics;
- graceful shutdown/reconnect behavior;
- optional WebSocket comparison only for a justified bidirectional use case.

## 12. External integration and webhooks

- local provider sandbox with deterministic fault modes;
- dedicated model adapter;
- explicit connection/response/total deadlines;
- retry classifier with backoff/jitter;
- provider idempotency key and local operation ID;
- ambiguous outcome/reconciliation state;
- signed incoming webhook using raw body;
- timestamp/replay protection and secret rotation;
- event-ID deduplication and version/order handling;
- durable receipt before acknowledgement;
- bounded queue/concurrency/circuit behavior;
- redacted integration audit.

## 13. Notifications

- semantic notification intent;
- email and in-app channels;
- mandatory/optional categories and preferences;
- quiet hours/digest scheduling;
- locale/time-zone aware rendering;
- accessible HTML + text email;
- stable deduplication key;
- provider attempt/result/bounce state;
- secure authorized deep links;
- local SMTP capture only;
- no real destinations.

## 14. Configuration, localization, cache and audit

- typed startup configuration with validation;
- separate secret references;
- documented precedence/defaults;
- feature flags with owner/expiry/removal condition;
- two locales and time zones;
- plural/date/number/currency formatting tests;
- private tenant/user/locale/permission-aware cache keys;
- cache invalidation/versioning and outage bypass policy;
- audit actor/effective actor/tenant/action/resource/outcome/correlation;
- restricted audit access and retention;
- no sensitive values in config diagnostics/cache/audit.

## 15. Application security

- threat model for critical journeys;
- parameterized SQL and safe template output;
- XSS negative tests and CSP;
- exact CORS/redirect/origin allowlists;
- secure cookie and CSRF controls;
- body, JSON-depth, multipart, decompression and concurrency limits;
- secure attachment keys and serving headers;
- SSRF restrictions on scheme/host/IP/redirect/response size;
- authorization/BOLA tests;
- global and identity-aware rate/admission limits;
- dependency/security finding triage;
- error/log redaction and security regression suite.

## 16. Testing portfolio

Required commands/suites:

```text
make fmt
make lint
make typecheck
make test-unit
make test-integration
make test-contract
make test-component
make test-e2e
make test-security
make test-race
make test-load-smoke
make verify
make cleanup
```

Suites cover:

- pure rules and state machines;
- PostgreSQL transactions/constraints;
- REST/OpenAPI and old-client compatibility;
- protobuf compatibility/gRPC;
- GraphQL limits/N+1;
- components/accessibility;
- browser journeys in Chromium and Firefox;
- OIDC/session/authorization negatives;
- jobs/files/webhooks/notifications;
- cancellation, shutdown and resource cleanup;
- property/fuzz tests for selected parsers/contracts.

## 17. Performance and observability

- user timing for action-to-feedback and confirmed result;
- browser waterfall, bundle and long-task/layout evidence;
- end-to-end trace IDs from browser/API/job/integration;
- server request, pool, DB, cache and external timing;
- low-cardinality metrics for requests, errors, sessions, jobs, queues and integrations;
- p50/p95/p99, throughput, error rate and saturation;
- representative journey load with think time/data skew;
- correctness checks under load;
- explicit budgets and reproducible report;
- one rejected optimization with evidence.

## 18. Diagnostics

`apptriage` is read-only and supports:

```text
journey
browser
request
identity
job
integration
compare-state
versions
```

It returns bounded evidence, records timestamps/versions and redacts cookies, tokens, secrets and personal payloads. It never applies fixes.

## 19. Fault system

Faults from `FAULTS.md` are opt-in, named, bounded and reversible. Every fault specifies:

- preconditions and synthetic target;
- exact injected behavior;
- expected user-visible symptom;
- expected logs/metrics/traces/state;
- time/resource limits;
- disable/rollback procedure;
- baseline verification;
- regression proving repair.

## 20. Implementation stages

### Stage 1. Journey and interface foundation

Build contracts, accessible client shell, routes, forms and typed state.

### Stage 2. Server and API

Build Go lifecycle, application core, PostgreSQL and REST/OpenAPI.

### Stage 3. Identity and authorization

Add sessions, OIDC, CSRF and cross-channel policy enforcement.

### Stage 4. Async and integration

Add files, jobs, outbox, SSE, external sandbox, webhooks and notifications.

### Stage 5. Cross-cutting quality

Add localization, configuration, cache, audit and security controls.

### Stage 6. Alternate interfaces and test system

Add gRPC/GraphQL comparisons and complete realistic test portfolio.

### Stage 7. Performance and diagnostics

Add traces, budgets, load evidence, `apptriage` and faults.

### Stage 8. Assessment

Run clean rebuild, blind incidents, final defense and delayed assessment.
