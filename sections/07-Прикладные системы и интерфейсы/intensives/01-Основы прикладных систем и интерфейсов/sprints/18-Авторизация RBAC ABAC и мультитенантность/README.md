# Спринт 18. Авторизация, RBAC, ABAC и мультитенантность

Ориентировочный объём: 19–27 часов.

## Центральный вопрос

Как решить, может ли конкретный subject выполнить action над конкретным resource в текущем context, и доказать отсутствие cross-tenant and object-level access leaks?

## Результат спринта

После завершения необходимо уметь:

- различать authentication and authorization;
- моделировать subject, action, resource and context;
- применять ownership and relationship checks;
- проектировать RBAC roles and permissions;
- понимать role explosion and limitations;
- проектировать ABAC/policy conditions;
- комбинировать RBAC with ownership/tenant rules;
- определять tenant boundary in IDs, queries, caches and events;
- проверять object-level and field-level access;
- применять deny-by-default and least privilege;
- различать UI capability display and server enforcement;
- избегать trusting tenant/resource ID from token/client alone;
- проектировать delegated/admin/support access with audit;
- применять policy decision/enforcement points conceptually;
- тестировать authorization matrix and negative paths;
- учитывать background jobs, exports, webhooks and real-time subscriptions;
- безопасно cache authorization decisions only with complete context/version;
- диагностировать privilege drift and policy mismatches.

## Основной маршрут

### Шаг 1. Permission model

Create matrix:

```text
subjects/roles
resources and ownership
actions
conditions: tenant, status, time, relationship
explicit denials/exceptions
audit requirements
```

### Шаг 2. Enforcement path

Authentication extracts identity. Application loads authoritative tenant/resource and asks policy. Database query also includes tenant boundary; UI hides unavailable actions but cannot grant them.

### Шаг 3. RBAC and ABAC

Use RBAC for stable job functions, ownership for object relation and ABAC for context. Avoid encoding every entity state combination as a role.

### Шаг 4. Cross-channel consistency

Apply same authorization to REST, GraphQL fields, gRPC, background job execution, file download, webhook configuration and SSE/WebSocket subscription.

## Ресурсы

- OWASP Authorization Cheat Sheet and API Security material.
- NIST RBAC/ABAC conceptual references.
- PostgreSQL tenant/RLS material from data-storage intensive.
- OPA/Cedar-like policy language docs only as optional comparison.

## Практические задания

1. Define permission matrix for member, manager, tenant admin, support and service worker.
2. Implement code-based policy over subject/action/resource.
3. Reproduce IDOR/BOLA through guessed resource ID.
4. Add tenant-safe repository queries and cache keys.
5. Test GraphQL nested field and file download authorization.
6. Add time-limited support impersonation with explicit audit.
7. Compare application policy and PostgreSQL RLS defense-in-depth.

## Лабораторная работа

Создать `work/authorization-lab/`.

### Resources

- tenants and memberships;
- items/orders;
- attachments;
- comments/private fields;
- jobs/exports;
- webhook subscriptions;
- audit records.

### Requirements

- deny by default;
- every operation names action and resource type;
- resource tenant/ownership loaded from authoritative store;
- query/update/delete include tenant/resource constraints;
- list filtering cannot reveal counts/existence across tenants;
- field-level sensitive data omitted according to policy;
- signed URLs/download tokens still bind to authorized subject/scope/expiry where required;
- background worker revalidates durable authorization/business preconditions when appropriate;
- real-time subscriptions scoped and revoked on membership change;
- support/admin elevation requires reason, expiry and audit;
- policy tests cover all matrix cells and unexpected role/tenant/resource combinations;
- UI capability checks are derived from, but not replacement for, server rules.

### Failure scenarios

1. Authenticated user guesses another tenant’s ID.
2. List endpoint filters after loading/leaks total count.
3. Update query checks resource ID but not tenant.
4. GraphQL nested resolver skips field authorization.
5. Attachment object key is public/guessable.
6. Cached authorization omits role/resource version.
7. User removed from tenant keeps active SSE/WebSocket subscription.
8. Background job runs under stale user permission without explicit policy.
9. Admin/support impersonation lacks reason/expiry/audit.
10. Role claim from token is treated as permanent application truth.
11. UI hides button but direct API call succeeds.

## Самопроверка

1. Authentication versus authorization?
2. Subject, action, resource and context?
3. RBAC strength and role explosion?
4. ABAC use cases?
5. Ownership versus role?
6. Why tenant ID from request/token is insufficient?
7. What is object-level authorization?
8. Field-level authorization?
9. Policy decision versus enforcement point?
10. How background/realtime channels preserve authorization?
11. Why deny-by-default matters?

## Результат для базы знаний

- **Subject-action-resource-context authorization model**.
- **RBAC, ownership and ABAC**.
- **Object and field-level authorization**.
- **Multi-tenant authorization boundaries**.
- **Authorization across APIs, jobs, files and real-time channels**.
- **Deny by default and least privilege**.
- **Privileged support access and audit**.
- **Authorization-matrix testing**.

## Когда переходить дальше

Можно переходить, когда every operation/channel is covered by one policy model, negative cross-tenant tests pass, and privileged/delegated access is bounded and auditable.