# Спринт 26. Config, Secrets, ServiceAccounts, RBAC и quotas

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

How to inject configuration and identity into workloads while controlling Kubernetes API access, namespace/resource isolation and policy limits?

## Результат спринта

После завершения необходимо уметь:

- различать ConfigMap, Secret and external secret source;
- понимать environment versus mounted-file update semantics;
- проектировать configuration version/reload/restart behavior;
- понимать Kubernetes Secret storage limitations;
- использовать ServiceAccount and projected short-lived tokens;
- проектировать Role/ClusterRole and bindings;
- диагностировать RBAC authorization with impersonation/can-i/audit evidence;
- применять namespace and cluster scope deliberately;
- использовать ResourceQuota and LimitRange;
- понимать admission control and policy engines conceptually;
- задавать Pod security controls and security contexts;
- различать identity, authorization, resource quota and network isolation;
- ограничивать API discovery/list/watch privileges;
- управлять secret rotation and workload reload;
- избегать default ServiceAccount and broad cluster-admin.

## Основной маршрут

1. Inject config through environment and volume; change it and observe update/restart semantics.
2. Create workload ServiceAccounts with minimal namespaced permissions.
3. Reproduce forbidden action and diagnose RBAC chain.
4. Set ResourceQuota/LimitRange and submit violating workloads.
5. Add admission policy for image/resource/security requirements.

## Ресурсы

- Kubernetes ConfigMap, Secret, ServiceAccount and RBAC docs.
- ResourceQuota, LimitRange and admission docs.
- selected external secrets/policy-engine docs.

## Лабораторная работа

Создать `work/kubernetes-access-config/`.

### Requirements

- application config separates nonsecret and secret values;
- secret values never appear in Git, events or diagnostic output;
- runtime uses dedicated ServiceAccount with automount disabled where unnecessary;
- projected token audience/expiry is explicit where used;
- RBAC grants only named verbs/resources/namespaces;
- platform/tenant/operator roles are separated;
- secret rotation updates consumers through documented reload/restart;
- ResourceQuota and LimitRange prevent unbounded namespace use;
- admission policy requires non-root, resource requests and approved registry/digest policy;
- policy exceptions have owner, scope and expiry;
- API permission tests include positive and negative cases;
- default ServiceAccount cannot access application secrets/workloads broadly.

### Failure scenarios

1. Secret is base64-encoded and called encrypted/protected.
2. Environment-based config is expected to update live.
3. Workload uses default ServiceAccount and broad token mount.
4. Namespaced Role is confused with cluster-scoped resource access.
5. ClusterRoleBinding grants cluster-admin to application.
6. Secret rotation updates object but application keeps old value indefinitely.
7. Quota exists but LimitRange/default requests cause unexpected admission failure.
8. Admission policy blocks recovery/system workloads without scoped exception.
9. Namespace alone is treated as full tenant isolation.

## Самопроверка

1. ConfigMap versus Secret?
2. Env versus mounted config update behavior?
3. Kubernetes Secret limitations?
4. ServiceAccount and projected token?
5. Role/ClusterRole and bindings?
6. Namespace versus cluster scope?
7. ResourceQuota versus LimitRange?
8. Admission controller/policy engine?
9. Secret rotation requires what?
10. Why namespace is not complete isolation?

## Результат для базы знаний

- **Kubernetes configuration injection and reload**.
- **Kubernetes Secrets and external secret management**.
- **Kubernetes ServiceAccounts and projected tokens**.
- **Kubernetes RBAC roles and bindings**.
- **Kubernetes ResourceQuota and LimitRange**.
- **Kubernetes admission and workload policy**.

## Когда переходить дальше

Можно переходить, когда workload identity and API permissions are minimal/tested, secret rotation is observable, and namespace resource/security policy rejects unbounded or unsafe workloads predictably.