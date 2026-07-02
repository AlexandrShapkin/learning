# Спринт 25. CI-CD, IaC, policy и secret scanning

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как защитить pipeline and infrastructure definitions from untrusted code, overprivileged tokens, leaked secrets and unsafe configuration changes?

## Результат спринта

После завершения необходимо уметь:

- map CI/CD trust boundaries and event types;
- distinguish trusted branch, pull request and fork contexts;
- scope workflow permissions and short-lived deployment credentials;
- protect caches, artifacts and self-hosted runners;
- scan source/history for secrets without exposing them;
- validate IaC and manifests with policy-as-code;
- separate plan, approval and apply;
- prevent unsafe interpolation and command injection in pipelines;
- pin actions/tools and verify downloads;
- manage environment protections and break-glass deployment;
- generate auditable policy exceptions.

## Основной маршрут

1. Draw workflow trust and credential map.
2. Reduce token permissions and replace static cloud key with OIDC/local equivalent.
3. Add Gitleaks and secret-response workflow.
4. Add IaC/Kubernetes policy checks through OPA/Conftest.
5. Test untrusted PR, cache poisoning and unsafe manifest cases.

## Лабораторная работа

Создать `work/cicd-iac-security/`.

### Requirements

- untrusted code cannot access protected secrets or deployment identity;
- workflow token permissions are explicit and minimal;
- deployment credentials are short-lived and environment-scoped;
- self-hosted runner persistence/cleanup risk is addressed or runner is disposable;
- caches/artifacts have trusted keys and cannot overwrite protected outputs;
- action/tool/image references are immutable;
- secret scanner covers current tree and controlled history review;
- detected secret is revoked, not only removed;
- IaC policy rejects public storage, privileged workloads, broad IAM and missing encryption/logging;
- exceptions have owner, reason and expiry;
- apply requires trusted artifact, review and environment policy.

### Failure scenarios

1. Pull-request workflow prints protected secret.
2. Workflow token can write repository/releases unnecessarily.
3. Cache from untrusted branch poisons trusted build.
4. Self-hosted runner retains credentials/workspace.
5. Secret is deleted from file but not revoked/history-reviewed.
6. IaC scanner finding is ignored without context or exception.
7. Pipeline input is interpolated into shell unsafely.
8. Emergency deployment bypass becomes normal path.

## Результат для базы знаний

- **CI/CD trust boundaries and workflow permissions**.
- **Short-lived deployment identity**.
- **CI cache, artifact and runner security**.
- **Secret scanning and leak response**.
- **Infrastructure policy as code and exceptions**.

## Когда переходить дальше

Можно переходить, когда untrusted changes cannot obtain deployment authority and unsafe infrastructure/artifacts are blocked by tested policy.