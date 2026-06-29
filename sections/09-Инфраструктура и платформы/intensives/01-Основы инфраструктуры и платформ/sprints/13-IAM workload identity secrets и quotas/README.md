# Спринт 13. IAM, workload identity, secrets и quotas

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как grant humans and workloads only the actions they need, isolate environments/tenants and keep credentials short-lived, attributable and recoverable?

## Результат спринта

После завершения необходимо уметь:

- различать human identity, workload identity, role and policy;
- понимать authentication versus authorization at cloud control plane;
- проектировать least privilege from actions/resources/conditions;
- использовать role assumption/federation and short-lived credentials;
- избегать long-lived access keys in code/CI;
- понимать service accounts/managed identities/workload federation;
- разделять accounts/projects/subscriptions and environments;
- применять organization policies and permission boundaries conceptually;
- управлять secrets separately from ordinary configuration;
- понимать secret encryption, access, rotation and audit;
- проектировать break-glass access;
- использовать quotas and service limits as both safety and capacity constraints;
- диагностировать denied access without broadening policy blindly;
- учитывать identity propagation and policy evaluation delay.

## Основной маршрут

1. Build subject-action-resource-condition matrix for operator, CI, workload and auditor.
2. Create short-lived role/workload identity flow locally or in sandbox.
3. Store and rotate one application secret through a secrets service or local equivalent.
4. Trigger access denial and diagnose principal, policy, resource and condition.
5. Set/request low quotas for laboratory safety.

## Ресурсы

- selected provider IAM and policy evaluation docs;
- workload identity/federation docs;
- secrets management and audit docs;
- cloud organization/quota docs.

## Лабораторная работа

Создать `work/cloud-identity/`.

### Requirements

- separate identities for human admin, read-only auditor, IaC runner and application;
- no shared static credentials;
- role/session duration and trust policy explicit;
- policy grants named resources/actions and required conditions;
- secrets are fetched at runtime through workload identity;
- rotation overlaps safely and old version is retired;
- break-glass role requires strong authentication, reason and audit;
- environment/account boundaries prevent accidental production access;
- denied-action troubleshooting uses evaluation evidence;
- quotas limit expensive/high-risk resources;
- credentials, tokens and secret values are never committed/logged.

### Failure scenarios

1. One administrator access key is used by humans, CI and workloads.
2. Wildcard policy is added to fix one denial.
3. Workload obtains node/instance role broader than required.
4. Secret is encrypted but broadly readable/logged.
5. Rotation removes old secret before consumers reload.
6. Break-glass role becomes normal access path.
7. Cross-account trust accepts unintended principals.
8. Quota exhaustion blocks recovery or autoscaling unexpectedly.

## Самопроверка

1. Identity, role and policy?
2. Human versus workload identity?
3. Short-lived credential advantage?
4. Trust policy versus permission policy?
5. Actions/resources/conditions?
6. Federation/workload identity?
7. Secret encryption versus access control?
8. Rotation overlap?
9. Break-glass requirements?
10. Quota as safety and capacity boundary?

## Результат для базы знаний

- **Cloud IAM identities, roles and policies**.
- **Short-lived and federated workload credentials**.
- **Cloud least privilege and policy conditions**.
- **Cloud account/environment isolation**.
- **Secrets lifecycle and rotation**.
- **Break-glass access and audit**.
- **Cloud quotas and service limits**.

## Когда переходить дальше

Можно переходить, когда humans, automation and workloads use distinct short-lived identities, secret rotation is tested, and access denials are diagnosed without broad wildcard permissions.