# Каталог неисправностей

Каждый fault включается только в explicit laboratory mode, имеет bounded effect, expected evidence, disable/rollback path and post-check. Fault tooling never targets non-laboratory hosts, accounts or data.

## Browser, accessibility and client state

1. `stale-search-response` — delayed old response overwrites current query.
2. `incomplete-cache-key` — tenant/filter/locale omitted from client query key.
3. `unstable-list-key` — item state moves after reorder because index key is used.
4. `route-state-loss` — reload/back-forward loses selected filters or workflow context.
5. `focus-loss` — route/dialog/error transition leaves focus missing or behind modal.
6. `keyboard-gap` — clickable custom element is unavailable by keyboard.
7. `error-context-loss` — generic toast removes field/action correction context.
8. `optimistic-divergence` — rejected/conflicting mutation remains visible without reconciliation.

## HTTP server, application core and API

9. `unbounded-body` — request/multipart/decompression exceeds resource limits.
10. `ignored-cancellation` — handler/dependency continues work after client cancellation.
11. `shutdown-order` — dependency closes before in-flight request/job drains.
12. `transport-business-duplication` — handler and use case enforce different rule.
13. `partial-transaction` — source change commits without task/outbox/related invariant.
14. `error-leak` — SQL/stack/provider internals reach API response or logs.
15. `cursor-scope` — cursor/order lacks tenant/filter/unique tie and leaks/misorders data.
16. `idempotency-race` — concurrent same-key requests create two logical results.
17. `idempotency-fingerprint` — same key with different request returns cached success.
18. `api-version-drift` — OpenAPI/client/server or old-client semantics diverge.

## Alternate interfaces and realtime

19. `protobuf-field-reuse` — old field number is reused with incompatible meaning.
20. `grpc-deadline-loss` — deadline/cancellation is not propagated to application/data call.
21. `graphql-n-plus-one` — resolver performs per-row dependency query.
22. `graphql-auth-gap` — nested field/resource bypasses authorization.
23. `graphql-complexity` — deep/aliased/large query escapes limits.
24. `realtime-stale-event` — older event/version overwrites authoritative newer state.
25. `realtime-slow-consumer` — per-connection queue/goroutine grows unbounded.
26. `realtime-tenant-leak` — subscription receives another tenant’s event.

## Sessions, OAuth and authorization

27. `session-fixation` — pre-auth session identifier survives sign-in.
28. `session-revocation-gap` — logout/password reset/account disable leaves session usable.
29. `csrf-gap` — unsafe cookie-authenticated endpoint accepts cross-site request.
30. `oauth-state-pkce` — login transaction fails to verify state or PKCE binding.
31. `token-trust` — resource server accepts wrong issuer, audience, key or token type.
32. `token-storage-leak` — bearer/refresh/session credential reaches URL, logs or browser persistent storage.
33. `object-authorization` — authenticated user accesses guessed resource ID.
34. `tenant-query-gap` — repository update/list omits tenant/resource constraint.
35. `field-authorization` — sensitive nested/response field bypasses policy.
36. `privileged-audit-gap` — support/admin impersonation lacks reason, expiry or original actor.

## Background work, files, integrations and notifications

37. `nondurable-accepted-job` — API returns accepted before job intent is durable.
38. `lease-double-effect` — expired lease plus slow worker produces duplicate final effect.
39. `poison-retry-loop` — permanent job/webhook failure retries without bound.
40. `file-staging-residue` — failed/canceled upload leaves temporary object/parts.
41. `file-trust` — extension/content type/user filename controls execution or storage path.
42. `external-ambiguous-outcome` — connection loss after provider commit is treated as definite failure.
43. `external-retry-storm` — outage/rate-limit triggers unbounded retries and queues.
44. `webhook-signature-replay` — signature checked incorrectly or old signed event is replayed.
45. `webhook-order-duplicate` — duplicate/older webhook repeats or regresses business state.
46. `notification-duplicate` — retry/event duplication sends multiple logical notifications.
47. `notification-preference` — optional/mandatory/quiet-hour rules are applied incorrectly.

## Configuration, cache, security, testing and performance

48. `cross-context-cache` — user/tenant/locale/permission omitted from server/cache key.
49. `security-boundary` — one of XSS, CORS, redirect, SSRF or upload limits is deliberately misconfigured.
50. `false-confidence` — brittle mock/flaky sleep/missing trace causes tests or diagnostics to accept a broken complete journey.

## Combined scenario library

Assessment may combine faults, for example:

- stale search response + incomplete cache key;
- route-state loss + inaccessible error focus;
- ignored cancellation + pool saturation + retry storm;
- idempotency race + external ambiguous outcome;
- GraphQL N+1 + missing tenant authorization;
- session revocation gap + active SSE subscription;
- upload retry + duplicate job + staging residue;
- webhook reorder + stale real-time event + duplicate notification;
- feature/config mismatch + API version drift;
- cross-context cache + privileged audit gap;
- CSP/CORS change + client error-context loss;
- performance regression + flaky test retry hiding it.

## Fault definition contract

Each implementation includes:

```text
name and category
preconditions and synthetic target
exact injected behavior
expected user-visible symptom
expected browser/network/log/metric/trace/state evidence
maximum requests, bytes, duration, workers and queue depth
disable or rollback steps
baseline verification
regression proving repair
```

## Safety contract

Fault tooling must:

- require repository marker, expected local hostnames and explicit `--lab` flag;
- reject public/non-local endpoints and real identity/provider configuration;
- print target, limits and planned effect before activation;
- cap users, requests, files, bytes, retries, workers, connections and duration;
- use synthetic tenants, users, destinations and objects only;
- preserve recoverable source state before destructive workflow tests;
- isolate browser sessions and clear them after each scenario;
- never output cookies, tokens, client secrets, personal payloads or signing keys;
- support `status`, `disable`, `rollback-all` and `cleanup`;
- verify DB state, sessions, queues, jobs, objects, browser processes and listeners after cleanup;
- retain only minimal sanitized failing evidence in Git.
