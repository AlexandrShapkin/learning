# Спринт 03. Security architecture, least privilege и zero trust

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Как распределить доверие и защитные меры так, чтобы компрометация одного компонента не давала полный доступ ко всей системе?

## Результат спринта

После завершения необходимо уметь:

- применять least privilege by identity, action, resource, time and context;
- различать defense in depth and duplicated controls;
- понимать zero trust as continuous verification, not product branding;
- определять security zones, choke points and blast radius;
- применять separation of duties and dual control;
- design secure defaults and deny-by-default paths;
- minimize trusted computing base and privileged code;
- distinguish preventive boundary from detection/recovery layer;
- model control bypass and common-mode failure;
- document break-glass and exceptional access.

## Основной маршрут

1. Map privileges and trust assumptions for every component.
2. Replace broad service/admin access with scoped policies.
3. Introduce separation between user, operator, CI and workload identities.
4. Simulate compromise of one component and trace reachable assets.
5. Add or remove controls based on blast-radius evidence.

## Лабораторная работа

Создать `work/security-architecture/`.

### Requirements

- architecture diagram shows trust zones and enforcement points;
- default paths deny unauthorized access;
- every privileged identity has scope, owner and expiry;
- critical operations require separation or additional verification;
- one compromised service cannot read unrelated secrets/data;
- break-glass access is time-bound, logged and reviewed;
- control layers do not share one bypass or credential;
- residual single points of trust are documented.

### Failure scenarios

1. Shared admin credential exists across all components.
2. Internal service can access every database/table.
3. Network location alone grants trust.
4. Break-glass account is permanent and unmonitored.
5. Two controls depend on the same compromised identity provider.
6. Security proxy is bypassed by direct backend access.

## Результат для базы знаний

- **Least privilege in system architecture**.
- **Defense in depth and blast-radius reduction**.
- **Zero-trust architecture principles**.
- **Separation of duties and break-glass access**.
- **Security enforcement points and common-mode failures**.

## Когда переходить дальше

Можно переходить, когда compromise of one ordinary identity/component has a measured and acceptably bounded blast radius.