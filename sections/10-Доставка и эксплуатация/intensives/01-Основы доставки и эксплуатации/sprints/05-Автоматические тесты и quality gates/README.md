# Спринт 05. Автоматические тесты и quality gates

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Какие automated checks provide fast, credible evidence for a change, and how to prevent slow, flaky or ceremonial gates from either blocking flow or allowing unsafe releases?

## Результат спринта

После завершения необходимо уметь:

- map failure classes to unit, component, integration, contract, end-to-end and migration tests;
- design a test portfolio by risk and feedback time;
- separate deterministic checks from environment-sensitive checks;
- handle flaky tests without normalizing retries;
- use coverage as a diagnostic, not quality target;
- define merge and release gates separately;
- run static analysis, formatting and dependency checks;
- understand mutation/fuzz/property testing roles;
- test migrations, compatibility and rollback paths;
- quarantine unstable tests with owner and deadline;
- use test artifacts and failure diagnostics effectively;
- avoid one giant end-to-end gate.

## Основной маршрут

1. Build a risk matrix for the reference service.
2. Assign each risk to the cheapest credible check.
3. Measure duration, determinism and failure diagnostic quality.
4. Inject defects and verify which gate catches them.
5. Remove or redesign redundant/noisy checks.

## Ресурсы

- Go testing, fuzzing, race detector and coverage docs.
- contract and integration testing references.
- CI test strategy material from Continuous Delivery.

## Лабораторная работа

Создать `work/quality-gates/`.

### Requirements

- pull-request suite completes within a stated feedback budget;
- release suite adds environment/migration/security checks;
- tests are grouped by failure class, not tool name only;
- race, fuzz or property test covers one meaningful risk;
- contract tests cover provider/API compatibility;
- migration tests run old/new application and schema combinations;
- flaky behavior is reproduced, root-caused and fixed or explicitly quarantined;
- retry is not used to hide deterministic failure;
- failure artifacts contain enough context without secrets;
- coverage threshold, if any, is justified and cannot replace assertions;
- at least five injected defects map to expected gates.

### Failure scenarios

1. Unit tests pass while API/provider contract breaks.
2. End-to-end suite is slow and flaky, blocking every merge.
3. Test retry turns intermittent product defect green.
4. Coverage rises while important branch has weak assertions.
5. Migration is tested only on empty database.
6. Tests share mutable external state and interfere.
7. Release gate runs different binary/source than artifact being released.
8. Static analysis warning is ignored globally rather than scoped/fixed.

## Самопроверка

1. Unit, component, integration, contract and E2E roles?
2. Test portfolio by risk?
3. Flaky test policy?
4. Coverage limitations?
5. Merge versus release gate?
6. Migration compatibility testing?
7. Race/fuzz/property testing value?
8. Why retries are dangerous?
9. What makes failure diagnostic useful?
10. How validate a quality gate itself?

## Результат для базы знаний

- **Software delivery test portfolio**.
- **Merge and release quality gates**.
- **Flaky-test diagnosis and quarantine**.
- **Coverage as a diagnostic metric**.
- **Compatibility and migration testing in delivery pipelines**.

## Когда переходить дальше

Можно переходить, когда each major change risk has the cheapest credible deterministic check, the PR feedback budget is measured, and injected defects demonstrate gate effectiveness.