# Итоговая проверка

## Blind incident exercise

Решить минимум 18 hidden incidents:

- four browser/client/accessibility cases;
- four HTTP/API/identity/authorization cases;
- four background/integration/notification/security cases;
- two performance/testing/configuration cases;
- four combined incidents.

Combined examples:

- stale client response + incomplete tenant cache key;
- session revoked but active SSE subscription remains;
- idempotency race + provider ambiguous outcome + duplicate notification;
- upload retry + duplicate job + orphan temporary object;
- GraphQL N+1 + nested authorization gap;
- API schema rollout + old client + feature-flag mismatch;
- retry storm + pool saturation + ignored cancellation;
- CSP/CORS change + inaccessible error fallback;
- webhook reordering + stale SSE event + optimistic client state;
- route reload + expired session + lost form context.

For each incident:

```text
User-visible symptom and impact
Affected journey, users/tenants and timeline
Versions, config and feature flags
Initial safety/evidence-preservation action
Expected contract and authoritative state
Browser/network/server/async evidence
First divergence
Ranked hypotheses and discriminating test
Root cause, trigger and secondary effects
Minimal repair
End-to-end, authorization and resource verification
Regression, reconciliation or detection improvement
```

## Clean build and environment reconstruction

From clean checkout and empty local volumes:

1. verify Go/Node/browser/container environment;
2. install locked dependencies;
3. start PostgreSQL, Redis, broker, object storage, SMTP capture, OIDC provider and observability stack;
4. apply migrations and provider/client configuration;
5. generate deterministic synthetic tenants/users/resources;
6. run unit, integration, contract, component, security and browser suites;
7. build frontend and Go binaries;
8. execute the 14 mandatory user journeys;
9. verify accessibility, authorization and audit evidence;
10. run load smoke, graceful shutdown and cleanup checks.

## End-to-end failure exercise

Perform one complete scenario:

1. user signs in and starts an attachment-backed operation;
2. API transaction commits source state and durable job/outbox intent;
3. worker calls external sandbox;
4. provider response becomes ambiguous;
5. webhook is duplicated and delivered out of order;
6. browser disconnects and later reconnects to SSE;
7. one notification attempt fails and retries;
8. support operator investigates through `apptriage`;
9. system reconciles one authoritative result;
10. user sees correct status and audit trail without duplicate effect.

The exercise must prove idempotency, ordering/version, session/authorization, queue bounds, user-visible recovery and resource cleanup.

## Accessibility and browser exercise

Without changing application code during the run:

- complete critical journey by keyboard;
- run with narrow viewport and 200% zoom;
- run with long alternate locale strings;
- enable reduced motion;
- test Chromium and Firefox;
- force validation, conflict, permission and network errors;
- verify focus, accessible names and retained user input;
- inspect automated accessibility results and manually verify gaps.

## Final defense

Answer using project evidence:

1. How does one user action travel through client, API, application core and data?
2. How do semantic HTML, accessibility tree, keyboard and focus management interact?
3. How are responsive layout and complete visual states designed?
4. How are local, URL, derived and server client states separated?
5. Why does TypeScript not replace runtime validation?
6. How do cancellation, stale responses and optimistic updates converge?
7. How does Go HTTP server bound requests and shut down safely?
8. Where do transport validation, business rules and transaction boundaries live?
9. How are HTTP resources, methods, statuses and representations chosen?
10. How do error, pagination, idempotency and compatibility contracts work?
11. When are REST, gRPC, GraphQL, SSE or WebSocket appropriate?
12. How do sessions, cookies and CSRF defenses work together?
13. How do OAuth 2.0, OpenID Connect and application sessions differ?
14. How are RBAC, ABAC, ownership and tenant isolation combined?
15. How does a durable background job survive crash, retry and cancellation?
16. How are external ambiguous outcomes and webhooks reconciled?
17. How are notification preferences, localization and delivery state modeled?
18. How do configuration, feature flags, caching and audit remain safe?
19. Which controls protect XSS, injection, CORS, files and SSRF boundaries?
20. How is the testing portfolio chosen by risk and realism?
21. How is complete user-journey performance measured and decomposed?
22. How are logs, metrics, traces and first divergence used in diagnostics?
23. Which evidence proves authorization across UI, API, jobs, files and realtime?
24. Which evidence proves one recovered user-visible outcome after partial failure?

Every answer references at least one implementation, test, trace, browser result, audit event, state transition or incident.

## Completion criteria

Интенсив завершён, когда:

- clean checkout recreates the full local environment;
- browser application is semantic, responsive and keyboard-accessible;
- typed client rejects malformed runtime data and handles all required states;
- Go server limits/cancellation/shutdown pass real connection tests;
- application business rules remain transport-independent;
- PostgreSQL transactions, constraints and tenant boundaries pass concurrency tests;
- REST/OpenAPI errors, pagination, idempotency and compatibility are verified;
- protobuf/gRPC and GraphQL comparison paths remain bounded and equivalent where intended;
- sessions, CSRF, OIDC and token validation negative tests pass;
- authorization matrix covers UI, API, jobs, attachments, GraphQL and SSE;
- background jobs/files survive crash, retry, cancel and duplicate execution;
- external/webhook integration handles timeout, ambiguity, duplication and reordering;
- notifications obey preference, localization and deduplication rules;
- configuration, cache and audit cannot leak secrets or cross context;
- application security regression suite passes;
- unit, integration, contract, component and browser suites are deterministic;
- performance report decomposes at least three critical journeys and preserves correctness;
- `apptriage` is read-only, bounded and redacted;
- all 50 faults are safe/reproducible or have a documented equivalent substitute;
- at least 18 blind incidents and four combined incidents are solved;
- all 24 defense answers are supported by evidence;
- generalized knowledge is transferred to `knowledge`.

## Delayed assessment

Через 7–14 дней без перечитывания:

1. reconstruct one complete user journey and all trust/state boundaries;
2. answer the 24 defense questions;
3. rebuild environment and execute one critical browser journey;
4. diagnose four random faults including one combined case;
5. design a compatible API change and prove old-client behavior;
6. implement one authorization rule and negative matrix;
7. recover one failed background/integration operation idempotently;
8. interpret one browser trace and one distributed trace;
9. identify one accessibility, security or performance risk not covered initially;
10. explain which parts belong in a later architecture/security/platform intensive.

После delayed assessment уровень 3–4 можно считать закреплённым.
