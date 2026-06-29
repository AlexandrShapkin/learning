# Спринт 29. Platform engineering, self-service и golden paths

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Which infrastructure capabilities should be offered as a supported internal product so application teams can self-serve safely without learning every provider/Kubernetes implementation detail?

## Результат спринта

После завершения необходимо уметь:

- различать infrastructure team, platform team and product mindset;
- определять platform users and jobs-to-be-done;
- создавать supported golden path and escape hatch;
- проектировать self-service contract through API/schema/template/module;
- выбирать abstraction level without lowest-common-denominator platform;
- понимать paved road versus mandatory policy;
- создавать service/workload catalog metadata;
- проектировать environment creation, identity, network, secrets and observability capabilities;
- использовать templates/generators without generated-code lock-in;
- определять ownership, support, lifecycle and deprecation of platform capability;
- измерять adoption, lead time, failure rate and user friction;
- управлять quotas, policy and cost guardrails;
- избегать ticket-driven portal façade over manual operations;
- учитывать platform API versioning and migration;
- проектировать build-versus-buy and integration boundaries.

## Основной маршрут

1. Interview/model two synthetic users: application team and platform operator.
2. Choose one workload golden path and list what platform owns versus exposes.
3. Define declarative `Workload` or `Environment` contract with schema/validation.
4. Implement renderer/controller/pipeline creating Terraform/Kubernetes resources.
5. Add status, errors, ownership, cost and deprecation metadata.
6. Test escape hatch and unsupported use case.

## Ресурсы

- platform engineering and CNCF platform maturity references.
- Team Topologies interaction modes as context.
- Backstage or alternative portal docs optional.
- API/schema and Terraform/Kubernetes extension docs.

## Лабораторная работа

Создать `work/internal-platform/`.

### Platform capability

A team submits a small contract containing:

```text
service identity and owner
container image digest
resource class and replicas
network exposure
configuration/secret references
storage class/size if needed
SLO/support tier
expiry/environment
```

Platform produces validated namespace, identity, policy, workload, service, DNS/route, dashboards/alerts references and cost ownership metadata.

### Requirements

- platform contract is versioned and validated;
- supported defaults are explicit and override surface is limited;
- users receive status and actionable errors, not hidden ticket queue;
- identities, quotas, network policies and resource classes are automatic;
- secrets remain references, not values in platform input/output;
- generated resources have owner, source and lifecycle labels;
- platform exposes implementation-independent intent where it can own mapping;
- escape hatch has clear support boundary and policy;
- deprecation/migration works for one contract field/version;
- adoption and time-to-first-deploy are measured;
- platform failure does not silently mutate existing workload beyond contract;
- portal UI, if used, is a client of the platform API rather than source of truth.

### Failure scenarios

1. Platform is only a portal creating manual tickets.
2. Golden path exposes every Kubernetes/Terraform field.
3. Abstraction hides storage/network guarantee it cannot enforce.
4. Generated manifests are copied and diverge from platform ownership.
5. Platform becomes mandatory for unsupported workload with no escape path.
6. Template update changes existing services unexpectedly.
7. No ownership/deprecation/support contract exists.
8. Cost and quota are hidden from users.
9. Success metric is number of portal features, not user outcome.

## Самопроверка

1. Platform as product means what?
2. Golden/paved path versus policy?
3. Self-service contract should hide/expose what?
4. Portal versus platform API?
5. Templates versus controllers/modules?
6. Escape hatch purpose?
7. Platform ownership/status/lifecycle?
8. How version/deprecate platform contract?
9. Useful platform success metrics?
10. When not to abstract provider/Kubernetes detail?

## Результат для базы знаний

- **Internal developer platform as product**.
- **Platform users, golden paths and escape hatches**.
- **Self-service platform contracts and status**.
- **Platform guardrails for identity, policy, quota and cost**.
- **Platform templates, controllers and source of truth**.
- **Platform capability versioning and adoption metrics**.

## Когда переходить дальше

Можно переходить, когда one application team can provision a supported workload through a versioned contract, receive actionable status and operate within automatic identity/network/resource/cost guardrails.