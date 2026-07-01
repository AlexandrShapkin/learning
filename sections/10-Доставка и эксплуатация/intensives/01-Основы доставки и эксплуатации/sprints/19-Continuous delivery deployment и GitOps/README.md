# Спринт 19. Continuous delivery, deployment и GitOps

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как автоматизировать promotion and reconciliation while keeping the distinction between a releasable artifact, an approved desired state and an actually healthy runtime?

## Результат спринта

После завершения необходимо уметь:

- distinguish continuous integration, delivery and deployment;
- define promotion policy and environment gates;
- separate artifact repository from deployment-state repository;
- understand push-based and pull/GitOps delivery;
- design desired-state ownership and reconciliation;
- verify artifact signatures/policies before deployment;
- manage GitOps credentials and cluster scope;
- understand drift correction and emergency changes;
- prevent feedback loops between CI and reconciler;
- handle progressive delivery under GitOps;
- reconcile failed/partial deployment state;
- audit who changed artifact, config and desired environment revision.

## Основной маршрут

1. Implement continuous delivery that produces a deployable release after main checks.
2. Add manual/automatic promotion policy to staging.
3. Deploy production-like state through Argo CD/Flux or a minimal reconciler.
4. Introduce manual cluster drift and observe correction.
5. Perform emergency runtime change and reconcile it back into desired state.

## Лабораторная работа

Создать `work/continuous-delivery-gitops/`.

### Requirements

- build repository/artifact repository/deployment repository responsibilities are explicit;
- desired state references immutable artifact digest;
- GitOps controller has least required repository/cluster access;
- promotion changes desired release reference without rebuilding;
- signature/provenance policy is checked before apply;
- reconciliation status distinguishes synced from healthy;
- manual drift is detected and corrected or intentionally adopted;
- emergency change has bounded expiry and source reconciliation;
- CI does not loop on controller-generated commits/status;
- progressive rollout/controller ownership is unambiguous;
- rollback/forward fix changes desired state and verifies runtime.

### Failure scenarios

1. “Synced” is treated as healthy service.
2. Git tag/image tag is mutable.
3. GitOps controller has cluster-admin across unrelated environments.
4. Manual hotfix is silently reverted during incident.
5. CI and controller continuously overwrite each other.
6. Deployment repository contains secret values.
7. Old Git commit reconciles after newer release due race.
8. Controller applies migration without compatibility/recovery gate.

## Результат для базы знаний

- **Continuous integration, delivery and deployment**.
- **Push delivery and GitOps reconciliation**.
- **Deployment desired state and runtime health**.
- **GitOps drift and emergency-change reconciliation**.
- **Artifact verification in deployment control loops**.

## Когда переходить дальше

Можно переходить, когда a verified release becomes desired state through a traceable promotion and the reconciler can recover drift without confusing synchronization with service health.