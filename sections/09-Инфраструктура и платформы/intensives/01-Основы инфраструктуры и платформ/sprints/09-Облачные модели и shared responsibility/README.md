# Спринт 09. Облачные модели и shared responsibility

Ориентировочный объём: 15–22 часа.

## Центральный вопрос

Какие capabilities and responsibilities change when infrastructure is consumed as cloud services, and what remains the customer’s responsibility at each service model?

## Результат спринта

После завершения необходимо уметь:

- различать public, private, hybrid and multi-cloud contexts;
- понимать IaaS, PaaS, SaaS and managed service boundaries;
- объяснять elasticity, on-demand provisioning and measured service;
- различать control plane/API and resource data plane;
- понимать account/project/subscription hierarchy;
- моделировать shared responsibility for compute, network, storage, identity and data;
- учитывать provider quotas, regional availability and service limits;
- понимать provider API eventual consistency and asynchronous operations;
- различать service availability claim and application availability;
- выбирать managed service by control, operations, portability and lock-in;
- проектировать account/environment/resource ownership;
- использовать tags/labels for ownership, cost and lifecycle;
- избегать production trust in laboratory accounts;
- понимать cloud API as programmable infrastructure boundary.

## Основной маршрут

1. Map one workload to self-managed VM, managed container platform and managed application/data services.
2. Build responsibility matrix for OS patching, encryption, backups, IAM, network policy and recovery.
3. Inspect one provider’s resource hierarchy, quotas, API operations and regional service catalog.
4. Create a no-cost local simulation plus optional minimal cloud resource with immediate cleanup.

## Ресурсы

- NIST cloud definitions.
- selected provider shared-responsibility and resource-hierarchy docs.
- provider service quotas and regional availability docs.

## Лабораторная работа

Создать `work/cloud-models/`.

### Requirements

- provider-neutral service-model comparison;
- one concrete provider mapping with exact account/project hierarchy;
- responsibility matrix for three deployment options;
- quota, region and service dependency inventory;
- resource naming/tagging/lifecycle policy;
- one API operation traced from request to asynchronous state convergence;
- optional real resource is tagged, budgeted and destroyed automatically;
- no production credentials or shared networks;
- recommendation states control lost/gained and operational work transferred/retained.

### Failure scenarios

1. Managed database is assumed to own schema/query/data correctness.
2. Provider availability number is treated as end-to-end application guarantee.
3. Resource exists in console but API operation is still converging.
4. Lab account shares credentials or network with production.
5. Service limit blocks scale or deployment unexpectedly.
6. Multi-cloud is selected before identifying portability or concentration requirement.
7. Tags are optional and orphan resources cannot be attributed.
8. Managed service backup exists but restore ownership is undefined.

## Самопроверка

1. IaaS, PaaS, SaaS and managed service?
2. Elasticity versus scalability?
3. Shared responsibility changes by service how?
4. Provider control plane versus data plane?
5. Account/project hierarchy purpose?
6. Quotas versus capacity?
7. Service availability versus application availability?
8. Managed service lock-in dimensions?
9. Why provider APIs are eventually convergent?
10. What must resource ownership metadata contain?

## Результат для базы знаний

- **Cloud deployment and service models**.
- **Cloud shared-responsibility model**.
- **Cloud resource hierarchy and ownership**.
- **Cloud control-plane APIs and convergence**.
- **Cloud quotas, regions and service availability**.
- **Managed-service control and portability trade-offs**.

## Когда переходить дальше

Можно переходить, когда one workload can be mapped across service models with explicit retained/transferred responsibilities, quotas, failure boundaries and cleanup ownership.