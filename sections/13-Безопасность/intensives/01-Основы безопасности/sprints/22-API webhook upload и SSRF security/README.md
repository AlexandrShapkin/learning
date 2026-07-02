# Спринт 22. API, webhook, upload и SSRF security

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как защищать machine-facing interfaces, где identifiers, URLs, uploads and callbacks can cross authorization and network boundaries?

## Результат спринта

После завершения необходимо уметь:

- enforce function- and object-level authorization;
- validate resource identifiers and tenant ownership;
- apply request size, rate, concurrency and cost limits;
- protect outbound requests from SSRF and internal-network reachability;
- validate webhook signatures, timestamps and replay windows;
- secure file upload type, size, storage and serving behavior;
- handle pagination/filter/search complexity safely;
- avoid mass assignment and over-posting;
- version and deprecate API contracts securely;
- prevent sensitive-data overexposure;
- distinguish authentication, authorization and abuse controls.

## Основной маршрут

1. Build authorization tests for every API operation.
2. Add bounded query/body/rate/cost controls.
3. Implement a safe outbound-fetch/webhook path.
4. Harden upload storage and download serving.
5. Add signed webhook verification and replay protection.

## Лабораторная работа

Создать `work/api-security/`.

### Requirements

- every object/action is authorized server-side;
- client-controlled role/tenant/owner fields are ignored or validated;
- filters/pagination/export have cost and result limits;
- outbound URL resolution blocks loopback, metadata, private and redirect escapes unless explicitly allowed;
- webhooks verify exact signed bytes, timestamp and event ID;
- duplicate webhook events are idempotent;
- uploads are stored outside executable/static roots with generated names;
- content/type checks do not rely on extension alone;
- downloads use authorization and safe content disposition;
- error and response schemas expose only necessary fields.

### Failure scenarios

1. Changing resource ID accesses another user/tenant.
2. JSON mass assignment grants privilege.
3. Export/search query exhausts database or returns excessive data.
4. Outbound fetch reaches metadata/internal admin endpoint.
5. Redirect or DNS change bypasses SSRF allowlist.
6. Webhook signature ignores raw-body canonicalization or replay.
7. Uploaded file is served as executable/active content.
8. API response exposes internal/sensitive fields by default.

## Результат для базы знаний

- **API object- and function-level authorization**.
- **API abuse, rate and cost controls**.
- **SSRF prevention and outbound-request policy**.
- **Webhook authentication and replay protection**.
- **Secure file upload and download handling**.

## Когда переходить дальше

Можно переходить, когда identifiers, URLs, callbacks and files cannot cross user, tenant, network or execution boundaries without explicit policy.