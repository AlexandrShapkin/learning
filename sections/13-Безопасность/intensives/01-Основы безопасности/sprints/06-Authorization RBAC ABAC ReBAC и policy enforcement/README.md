# Спринт 06. Authorization, RBAC, ABAC, ReBAC и policy enforcement

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как принимать проверяемые решения о доступе к конкретному ресурсу и действию, не полагаясь на UI, сетевое расположение или чрезмерно широкие роли?

## Результат спринта

После завершения необходимо уметь:

- различать authentication and authorization;
- моделировать subject, action, resource and context;
- выбирать RBAC, ABAC and ReBAC appropriately;
- предотвращать horizontal and vertical privilege escalation;
- применять deny-by-default and centralized policy semantics;
- проектировать policy enforcement and decision points;
- учитывать tenant, ownership and resource hierarchy;
- test policy completeness and conflicts;
- handle role/policy change propagation;
- log decisions without leaking sensitive policy internals;
- design emergency and delegated access.

## Основной маршрут

1. Build authorization matrix for users, operators and services.
2. Implement object-level checks in application and OPA policy.
3. Add tenant/owner/context conditions.
4. Test policy conflicts and stale role claims.
5. Add delegated support and break-glass access.

## Лабораторная работа

Создать `work/authorization/`.

### Requirements

- every protected operation checks action and exact resource;
- default behavior denies unknown subjects/actions/resources;
- UI hiding is not counted as control;
- object-level ownership/tenant checks prevent IDOR-like access;
- privileged and support access is scoped and time-bound;
- policy tests cover allow, deny, conflict and missing attribute cases;
- role/policy revocation reaches active sessions/tokens within defined bounds;
- policy decision and enforcement failures are observable;
- one broad role is replaced by narrower permissions;
- policy engine outage has explicit fail-open/fail-closed behavior.

### Failure scenarios

1. Route checks role but not object ownership.
2. Client-supplied tenant ID determines access.
3. Admin role includes unrelated destructive actions.
4. Deny rule is shadowed by broad allow.
5. Policy cache keeps revoked permission too long.
6. Authorization engine outage silently allows access.
7. Background worker bypasses application policy.

## Результат для базы знаний

- **Authorization subjects, actions, resources and context**.
- **RBAC, ABAC and relationship-based access control**.
- **Object-level authorization and tenant isolation**.
- **Policy decision and enforcement points**.
- **Authorization policy testing and revocation**.

## Когда переходить дальше

Можно переходить, когда every sensitive operation is denied by default and tested against cross-user, cross-tenant and stale-privilege cases.