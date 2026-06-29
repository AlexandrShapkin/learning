# Спринт 17. Terraform configuration, graph, providers и modules

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как structure Terraform configuration and modules around resource ownership and stable contracts without hiding provider semantics in generic wrappers?

## Результат спринта

После завершения необходимо уметь:

- проектировать root and child modules;
- определять module input/output contract;
- использовать `for_each`, `count` and dynamic blocks deliberately;
- понимать expression evaluation and dependency inference;
- применять explicit `depends_on` only when hidden dependency exists;
- управлять provider configurations and aliases;
- понимать provider inheritance/passing to modules;
- выбирать module granularity by lifecycle/ownership;
- избегать mega-module and thin wrapper modules;
- создавать stable resource addresses and keys;
- валидировать variables/preconditions/postconditions/checks where supported;
- version and consume modules;
- test multiple module instances/environments;
- document destructive and provider-specific limitations.

## Основной маршрут

1. Refactor flat configuration into network, compute and platform modules.
2. Instantiate multiple environments through stable maps/keys.
3. Use two provider aliases/regions or local equivalents.
4. Rename/rekey resources and observe address consequences.
5. Compare one generic module with capability-specific modules.

## Ресурсы

- Terraform module, expression, dependency and provider docs.
- selected provider schema/docs.
- module design and testing guidance.

## Лабораторная работа

Создать `work/terraform-modules/`.

### Requirements

- root module owns composition and environment-specific values;
- child modules own coherent resource lifecycle;
- inputs express intent, not every provider attribute;
- outputs expose stable integration contract;
- stable `for_each` keys prevent index-based replacement;
- provider aliases are passed explicitly where needed;
- hidden dependencies are documented and minimized;
- validation rejects invalid CIDRs/sizes/combinations before provider call;
- module versions are pinned for external consumption;
- examples/tests cover at least two configurations;
- no universal “resource factory” or provider-agnostic abstraction that loses guarantees;
- graph and plan remain understandable.

### Failure scenarios

1. `count` index shift replaces unrelated resources.
2. Module exposes every provider field and hides nothing.
3. Mega-module couples network, compute, data and application lifecycle.
4. Tiny modules only rename one resource and add indirection.
5. Provider alias is not passed and resource lands in wrong region/account.
6. Explicit `depends_on` creates broad unnecessary ordering.
7. Output exposes secret or unstable internal resource detail.
8. Module upgrade causes destructive address/schema change without migration.

## Самопроверка

1. Root versus child module?
2. Module boundary by what?
3. `count` versus `for_each`?
4. Implicit versus explicit dependency?
5. Provider aliases and module passing?
6. Stable resource address?
7. Module input/output contract?
8. Mega-module and thin-wrapper smells?
9. Variable/precondition validation?
10. Module versioning and migration?

## Результат для базы знаний

- **Terraform root and child modules**.
- **Terraform dependency graph and explicit dependencies**.
- **Terraform count, for_each and stable keys**.
- **Terraform provider aliases and module providers**.
- **Terraform module contracts and granularity**.
- **Terraform validation and module versioning**.

## Когда переходить дальше

Можно переходить, когда multiple environments instantiate coherent modules with stable addresses/provider placement and a module upgrade can be planned without accidental broad replacement.