# Спринт 20. Проверка, policy, drift и доставка IaC

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

How to review and deliver infrastructure changes so that syntax, semantics, policy, cost, destructive actions and post-apply convergence are checked before and after mutation?

## Результат спринта

После завершения необходимо уметь:

- строить IaC validation pipeline;
- различать format, validate, lint, static policy, unit/module test and integration test;
- анализировать plan as change artifact;
- обнаруживать replacement/destruction and sensitive changes;
- применять policy-as-code for enforceable invariants;
- использовать cost estimation as decision input;
- управлять plan/apply identity and approval;
- понимать stale plan and provider drift;
- выполнять post-apply verification;
- проектировать scheduled drift detection;
- различать intentional emergency change and unmanaged drift;
- импортировать or revert out-of-band changes deliberately;
- ограничивать concurrency and blast radius;
- хранить artifacts/logs without secrets;
- выполнять rollback/forward repair for infrastructure changes;
- избегать blind auto-apply to broad production scope.

## Основной маршрут

1. Add format/validate/lint/security/policy checks.
2. Test modules through plan or native test framework.
3. Generate machine-readable plan and detect destructive actions.
4. Apply through separate least-privilege identity and post-check.
5. Create out-of-band drift, detect it and choose adopt/revert/ignore.

## Ресурсы

- Terraform testing and plan JSON docs.
- selected policy engine docs.
- provider/IaC delivery and drift references.
- cost estimation tool docs optional.

## Лабораторная работа

Создать `work/iac-pipeline/`.

### Requirements

- pipeline runs format, validation, lint and tests;
- policy denies public exposure, missing ownership/expiry and unencrypted stateful resource;
- plan summary highlights creates/updates/replacements/destroys;
- saved plan is tied to commit/config/provider lock and expires quickly;
- plan and apply use distinct least-privilege identities where practical;
- apply requires review for destructive/high-cost changes;
- post-apply probes verify actual service/network/storage behavior;
- scheduled drift report classifies configuration, provider-default and emergency changes;
- emergency change has reconciliation path back into code/state;
- state/plan/log artifacts are access-controlled and redacted;
- failure/partial apply produces explicit reconciliation or forward-fix procedure.

### Failure scenarios

1. `terraform validate` is treated as full infrastructure test.
2. Approved plan becomes stale before apply.
3. Plan hides replacement inside large output.
4. Policy blocks syntax shape but misses actual semantic exposure.
5. Auto-apply destroys broad shared state.
6. Emergency console fix is silently reverted or remains undocumented.
7. Post-apply succeeds while application path is broken.
8. Drift scanner modifies state/resources instead of reporting.
9. CI artifact leaks plan/state secrets.

## Самопроверка

1. IaC test levels?
2. Plan as artifact contains what?
3. Stale plan risk?
4. Policy-as-code appropriate for what?
5. Plan/apply identity separation?
6. Post-apply verification?
7. Drift types and responses?
8. Emergency change reconciliation?
9. Rollback versus forward repair in infrastructure?
10. Why broad auto-apply is risky?

## Результат для базы знаний

- **Infrastructure as Code validation pipeline**.
- **Terraform plan review and destructive-change detection**.
- **Infrastructure policy as code**.
- **Infrastructure drift detection and reconciliation**.
- **IaC plan/apply identity and approval**.
- **Post-apply infrastructure verification**.

## Когда переходить дальше

Можно переходить, когда every infrastructure mutation has reviewed plan, enforceable safety policy, bounded identity/scope, post-apply evidence and a path for drift or partial failure.