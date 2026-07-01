# Спринт 06. Pipeline as code, runners, caches и concurrency

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как design CI pipeline execution so that events, permissions, runners, caches, artifacts, parallelism and retries remain secure, observable and deterministic?

## Результат спринта

После завершения необходимо уметь:

- define pipeline triggers and event trust boundaries;
- design jobs, steps, dependencies and reusable workflows;
- separate untrusted PR validation from privileged release/deploy jobs;
- scope workflow token permissions;
- use OIDC/short-lived credentials where available;
- choose hosted versus self-hosted runners;
- understand runner isolation and persistence risks;
- design cache keys and restore behavior;
- distinguish cache, artifact and release repository;
- use matrices and parallelism without multiplying unsafe load;
- configure concurrency/cancellation for branches and environments;
- handle retries and transient infrastructure failures deliberately;
- retain logs/artifacts for diagnosis without leaking secrets;
- pin actions/tools by trusted immutable revision.

## Основной маршрут

1. Implement PR, main and release workflows.
2. Extract reusable build/test workflow with explicit inputs/outputs.
3. Add dependency/build caches and demonstrate stale/poisoned cache behavior.
4. Configure concurrency for branch validation and environment deployments.
5. Compare hosted and local/self-hosted runner threat/lifecycle model.

## Ресурсы

- GitHub Actions official docs for events, permissions, environments, reusable workflows, artifacts, caches and concurrency.
- OIDC and runner security docs.

## Лабораторная работа

Создать `work/pipeline-architecture/`.

### Requirements

- pull-request workflow has read-only/minimal token and no deployment secrets;
- release workflow runs only from trusted ref/artifact;
- third-party actions are pinned by immutable commit and reviewed;
- reusable workflow contracts declare inputs, outputs, secrets and permissions;
- caches are keyed by platform/toolchain/lock state and never treated as trusted artifact;
- cache restore is safe under untrusted branches;
- artifacts have checksums and bounded retention;
- branch runs cancel superseded work where safe;
- environment deployments serialize/conflict-protect;
- matrix size and external calls are bounded;
- retry policy distinguishes infrastructure/transient from product failure;
- logs redact secrets and retain enough failure evidence.

### Failure scenarios

1. Fork PR executes code with repository/environment secret.
2. Workflow token has write permissions unnecessarily.
3. Mutable action tag changes executed code.
4. Self-hosted runner retains workspace/token between untrusted jobs.
5. Cache poisoning changes build/test result.
6. Two deployment jobs race against the same environment.
7. New commit is deployed after older slower pipeline completes later.
8. Retry hides deterministic failure or repeats non-idempotent publish.
9. Artifact from one matrix platform is mislabeled as another.

## Самопроверка

1. Workflow event trust boundary?
2. Job/step/reusable workflow responsibilities?
3. Token permission scoping?
4. OIDC advantage?
5. Hosted versus self-hosted runner risks?
6. Cache versus artifact?
7. Cache key/restore design?
8. Concurrency groups and cancellation?
9. Retry policy?
10. Why pin actions immutably?

## Результат для базы знаний

- **CI pipeline as code and workflow composition**.
- **CI event and permission trust boundaries**.
- **Hosted and self-hosted runner isolation**.
- **CI caches, artifacts and retention**.
- **Pipeline concurrency, cancellation and retries**.
- **Immutable third-party CI actions**.

## Когда переходить дальше

Можно переходить, когда untrusted changes cannot access privileged delivery paths, caches cannot define correctness, and concurrent runs cannot deploy stale or conflicting revisions.