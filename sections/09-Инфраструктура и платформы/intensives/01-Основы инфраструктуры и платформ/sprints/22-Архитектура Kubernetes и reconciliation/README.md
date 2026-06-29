# Спринт 22. Архитектура Kubernetes и reconciliation

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как Kubernetes API, storage, controllers, scheduler and node agents continuously reconcile desired and observed state, and where do failures become visible?

## Результат спринта

После завершения необходимо уметь:

- объяснять API server, etcd, scheduler, controller manager and kubelet roles;
- понимать declarative API objects, metadata, spec and status;
- различать desired, observed and last-applied/managed fields;
- понимать reconciliation loops and eventual convergence;
- использовать labels, selectors, annotations, owner references and finalizers;
- понимать namespaces as organizational/policy boundary, not complete isolation;
- читать events, conditions and object generations;
- понимать watch/list, resource versions and API consistency conceptually;
- использовать server-side apply/field ownership conceptually;
- различать control-plane and node/data-plane failure;
- понимать CRD/controller/operator pattern at overview level;
- диагностировать object accepted but not realized;
- создавать/dispose kind or k3d cluster reproducibly;
- сравнивать Kubernetes with Compose and direct VM management.

## Основной маршрут

1. Create cluster and inspect control-plane components/API discovery.
2. Apply Pod/Deployment/Service and trace objects, events and controller ownership.
3. Modify/delete child objects and observe reconciliation.
4. Stop node/control-plane components and observe behavior.
5. Create a minimal custom controller or study one with an observable loop.

## Ресурсы

- Kubernetes architecture, API conventions and controller docs.
- etcd overview for Kubernetes use.
- kind/k3d docs.

## Лабораторная работа

Создать `work/kubernetes-reconciliation/`.

### Requirements

- disposable cluster definition and pinned node image/version;
- component/resource-flow diagram;
- object manifests use labels/selectors consistently;
- `generation`, `observedGeneration`, conditions and events are inspected;
- deleting a managed Pod demonstrates controller recreation;
- broken scheduling/image/config path is localized through object status/events;
- API server/control-plane interruption is separated from running Pod behavior;
- finalizer/owner-reference lifecycle is demonstrated safely;
- one field-ownership conflict is observed;
- comparison explains when Kubernetes complexity is not justified;
- cleanup removes cluster and local volumes/networks.

### Failure scenarios

1. API accepts object but scheduler cannot place Pod.
2. Controller selector does not match template labels.
3. Finalizer leaves resource stuck in terminating state.
4. Manual child edit is reverted by controller.
5. Control plane is unavailable while workloads continue temporarily.
6. Namespace is treated as security boundary without policies/RBAC.
7. Multiple managers fight over the same field.
8. Events expire and root evidence is lost.

## Самопроверка

1. API server, etcd, scheduler, controller manager and kubelet?
2. Spec versus status?
3. Reconciliation loop?
4. Labels/selectors/owner references?
5. Generation and observed generation?
6. Finalizer purpose?
7. Control plane versus workload data plane?
8. Watch/resource version?
9. CRD/controller/operator?
10. Kubernetes versus Compose/VM management?

## Результат для базы знаний

- **Kubernetes control-plane components**.
- **Kubernetes API spec, status and conditions**.
- **Kubernetes reconciliation loops**.
- **Labels, selectors, ownership and finalizers**.
- **Kubernetes API watches and field ownership**.
- **Kubernetes control-plane and workload failure separation**.

## Когда переходить дальше

Можно переходить, когда any object can be traced from submitted spec to responsible controller/node action, and non-convergence is diagnosed through status, conditions, events and component evidence.