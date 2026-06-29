# Спринт 26. Наблюдаемость и системная диагностика приложения

Ориентировочный объём: 20–30 часов.

## Центральный вопрос

Как from a user-visible symptom locate the first failing boundary across browser, API, identity, database, background work and external integrations without destroying evidence?

## Результат спринта

После завершения необходимо уметь:

- формулировать exact user impact, scope and timeline;
- различать symptom, trigger, root cause and secondary effect;
- использовать correlation/request/trace IDs end-to-end;
- создавать structured logs with safe fields;
- проектировать low-cardinality metrics;
- использовать distributed traces and span links for async work;
- связывать browser errors/timing with server trace;
- отличать client validation/rendering from API failures;
- различать authentication, authorization and session failures;
- диагностировать queue delay, retry loop and poison job;
- диагностировать external timeout, rate limit and ambiguous outcome;
- находить contract/version mismatch;
- различать server execution, pool wait and downstream latency;
- проверять source state versus cache/realtime/client state;
- собирать bounded evidence before restart/cache flush/retry-all;
- ранжировать falsifiable hypotheses;
- выполнять one discriminating test;
- применять minimal reversible repair;
- проверять complete user journey after repair;
- добавлять regression, reconciliation or alert improvement.

## Diagnostic loop

```text
state symptom and affected journey
→ preserve browser/request/version/config evidence
→ identify expected contract and source of truth
→ trace first divergence across boundaries
→ classify client/transport/auth/app/data/job/integration issue
→ rank hypotheses
→ run one discriminating observation
→ repair minimally
→ verify user outcome and resource baseline
→ add prevention/detection
```

Do not begin with restart, cache flush, session deletion, queue replay or increased timeout unless it is a controlled diagnostic step with preserved evidence.

## Evidence map

### Browser

- URL/route and user action;
- console/runtime error;
- network request/response/timing;
- accessibility/focus state;
- client state/request ID/version;
- browser/build/locale/time zone.

### Server

- structured request log;
- route/status/error code;
- trace spans and dependency timing;
- active requests/concurrency/pool wait;
- application version/config/feature flags.

### Identity and authorization

- session/token issuer, audience and expiry metadata without secret;
- subject/tenant/membership version;
- authorization decision input/result;
- CSRF/origin/redirect validation result.

### Async and integrations

- job/event ID, state, attempts, lease and age;
- provider request/event ID;
- webhook signature/dedup/order status;
- notification/object/search/cache reconciliation state.

## Лабораторная работа

Создать `work/application-diagnostics/`.

### `apptriage`

Read-only bounded collector:

```text
apptriage journey --request-id ID
apptriage browser --trace FILE
apptriage request --id ID
apptriage identity --session-safe-id ID
apptriage job --id ID
apptriage integration --operation-id ID
apptriage compare-state --resource TYPE --id ID
```

It redacts tokens, cookies, personal values and full request bodies.

### Incident catalogue

Solve at least 20, including five combined incidents:

1. stale client response overwrites current state;
2. inaccessible focus/error blocks workflow;
3. OpenAPI/client/server version mismatch;
4. handler timeout or ignored cancellation;
5. database pool wait disguised as slow query;
6. duplicate idempotency result mismatch;
7. session expired/fixated/not revoked;
8. CSRF/origin rejection;
9. wrong token issuer/audience/key;
10. object/tenant authorization leak;
11. background job stuck/retried/poisoned;
12. file processing temporary leak;
13. webhook signature/duplicate/order problem;
14. external API timeout/rate-limit/ambiguous outcome;
15. notification preference/bounce/dedup issue;
16. cache key misses tenant/locale/permission;
17. SSE/WebSocket missed event or slow consumer;
18. feature/config mismatch between instances;
19. browser long task plus server latency;
20. memory/goroutine/connection leak;
21. security header/CORS/CSP regression;
22. multiple simultaneous faults.

### Combined examples

- stale client cache + delayed old API response;
- auth refresh loop + server rate limit;
- pool saturation + retry storm + background backlog;
- out-of-order webhook + stale SSE event;
- feature flag mismatch + API schema change;
- file upload retry + duplicate job + orphan object;
- CSP deployment + inaccessible error fallback;
- provider timeout + ambiguous result + duplicate notification.

## Incident artifact

```text
User-visible symptom and impact
Affected journey, users/tenants and timeline
Versions/config/feature flags
Expected contract and source of truth
Preserved browser/server/async evidence
First divergence
Ranked hypotheses and discriminating test
Root cause, trigger and secondary effects
Minimal repair
End-to-end verification
Prevention/detection/regression
```

One screen plus linked evidence is sufficient.

## Самопроверка

1. Symptom versus root cause?
2. How request/trace IDs cross async work?
3. Which client evidence is essential?
4. Authentication versus authorization symptom?
5. How pool wait differs from handler/query time?
6. Stale client/cache/event versus source corruption?
7. Ambiguous external result means what?
8. Why broad restart/cache flush destroys evidence?
9. What is first divergence?
10. How low-cardinality metrics differ from logs/traces?
11. What proves end-to-end repair?
12. Which prevention belongs after incident?

## Критерии прохождения

- `apptriage` is read-only, bounded and redacted;
- at least 20 incidents and five combined cases are solved;
- every case identifies expected contract/source and first divergence;
- no restart/timeout increase/cache flush is accepted as unexplained final fix;
- browser, server and async evidence correlate by stable identifiers;
- repair verification includes the complete user journey;
- cleanup returns sessions, jobs, connections, objects and services to baseline;
- each repair adds regression/reconciliation/alert where appropriate;
- at least 10 of 12 answers are mechanism-based.

## Результат для базы знаний

- **Systematic application diagnostics**.
- **User journey, contract and first divergence**.
- **Application logs, metrics and traces**.
- **Browser-to-server correlation**.
- **Identity and authorization diagnostics**.
- **Background-job and integration diagnostics**.
- **Source versus client/cache/realtime state comparison**.
- **End-to-end repair verification**.

## Когда переходить дальше

Можно переходить к итоговой работе, когда unknown UI, API, identity, async and integration failures are localized from bounded evidence and repairs are verified through complete user journeys.