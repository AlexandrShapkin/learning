# Спринт 16. Декларативная инфраструктура и Terraform

Ориентировочный объём: 17–24 часа.

## Центральный вопрос

Как declarative configuration, desired state and provider reconciliation differ from imperative scripts, and what guarantees Terraform can and cannot provide?

## Результат спринта

После завершения необходимо уметь:

- различать imperative, declarative and idempotent automation;
- понимать configuration, state, provider and real infrastructure;
- объяснять refresh, plan and apply lifecycle;
- понимать desired/known/remote state differences;
- различать resource, data source, variable, local and output;
- читать plan actions: create, update, replace and destroy;
- понимать dependency graph and unknown values;
- использовать provider lock file and version constraints;
- определять lifecycle ownership of resources;
- избегать secrets in configuration/state/output;
- понимать convergence limitations and provider API eventual consistency;
- выполнять safe init/plan/apply/destroy;
- отличать reproducibility from guaranteed identical runtime outcome;
- проектировать isolated environment and cleanup.

## Основной маршрут

1. Provision local files/containers/libvirt resources through Terraform.
2. Compare equivalent Bash script and declarative configuration under repeated runs.
3. Modify one property in place and one requiring replacement.
4. Inspect graph, state and plan unknowns.
5. Delete/change remote resource and observe refresh/plan.

## Ресурсы

- Terraform language, CLI, state and provider docs.
- selected provider docs.
- OpenTofu docs as compatible alternative.

## Лабораторная работа

Создать `work/terraform-foundation/`.

### Requirements

- pinned Terraform/provider constraints and lock file;
- isolated backend/state path excluded from Git;
- variables validated and sensitive values not exposed;
- resources tagged/labeled with owner and expiry;
- plan is saved only as ephemeral sensitive artifact;
- repeated apply is convergent;
- replacement/destruction is reviewed explicitly;
- remote drift is observed and classified;
- outputs expose only stable useful values;
- destroy removes all owned resources and verifies no orphan;
- comparison states where imperative scripting remains appropriate.

### Failure scenarios

1. State is treated as cache and deleted casually.
2. Secret appears in state despite `sensitive` output hiding CLI display.
3. Provider upgrade changes plan unexpectedly.
4. Resource rename causes destroy/create instead of state/config migration.
5. Generated timestamp/random input creates perpetual diff.
6. External automation changes resource and Terraform reverts it unexpectedly.
7. Apply partially succeeds and state/remote reality differ.
8. `-target` is used as normal workflow and hides dependencies.

## Самопроверка

1. Declarative versus imperative?
2. Idempotence versus convergence?
3. Configuration, state and remote infrastructure?
4. Refresh/plan/apply?
5. Unknown values in plan?
6. Resource versus data source?
7. What causes replacement?
8. Why provider lock matters?
9. Why sensitive state remains sensitive?
10. Terraform guarantees and limitations?

## Результат для базы знаний

- **Declarative infrastructure and convergence**.
- **Terraform configuration, state and providers**.
- **Terraform plan and resource replacement**.
- **Provider dependency locking**.
- **Terraform drift and partial apply**.
- **Sensitive values in Terraform state**.

## Когда переходить дальше

Можно переходить, когда a resource set converges from clean configuration, plan actions are explainable before apply, and state/drift/cleanup are treated as owned operational data.