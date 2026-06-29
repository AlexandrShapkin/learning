# Спринт 25. Legacy-системы, seams и characterization tests

Ориентировочный объём: 20–29 часов.

## Центральный вопрос

Как изменить poorly understood and tightly coupled code safely when tests are missing, dependencies are hard-wired and current behavior itself is partly undocumented?

## Результат спринта

После завершения необходимо уметь:

- определять legacy code operationally as hard-to-change code;
- находить characterization-test boundary;
- различать desired behavior and current observed behavior;
- использовать seams to substitute dependency/decision;
- применять sprout method/class/module and wrap method/class patterns;
- break static/global/time/network/database dependencies;
- создавать approval/golden tests cautiously;
- выбирать narrow end-to-end safety net and focused unit tests;
- фиксировать nondeterminism before refactoring;
- использовать change-point analysis;
- создавать dependency-breaking sequence;
- избегать broad cleanup before understanding behavior;
- оборачивать vendor/framework code behind local boundary;
- вводить tests at likely change points;
- работать с bugs preserved by characterization deliberately;
- использовать Git history and production-like traces as evidence;
- планировать gradual retirement of legacy paths.

## Основной маршрут

### Шаг 1. Change point

Choose one required feature/fix. Trace from entry point to effect and identify minimum code that must change plus hard-wired dependencies.

### Шаг 2. Characterization

Capture current behavior at stable observable boundary. Tests may initially preserve surprising behavior; label it and decide separately whether to keep/fix.

### Шаг 3. Seams

Introduce minimal seam through function parameter, interface, wrapper, package variable replacement, adapter or extracted pure function. Avoid redesigning entire system first.

### Шаг 4. Incremental improvement

Add new behavior beside old path, verify, route/cut over and retire legacy code in small commits.

## Ресурсы

- *Working Effectively with Legacy Code*.
- *Refactoring*.
- Git history/bisect documentation.
- Approval/golden testing references used cautiously.

## Практические задания

1. Characterize undocumented endpoint/CLI output.
2. Replace hard-coded time/random/provider through a seam.
3. Wrap a vendor/client dependency behind local adapter.
4. Use sprout method/module for one feature.
5. Stabilize nondeterministic test fixture.
6. Identify and intentionally fix one characterized bug.
7. Retire one legacy path after parallel verification.

## Лабораторная работа

Создать `work/legacy-rescue/`.

### Legacy traits

- one package with globals;
- direct SQL and HTTP calls;
- mixed parsing/rules/persistence/output;
- nondeterministic time/IDs;
- provider DTOs throughout;
- no unit tests and few integration tests;
- duplicated status rules;
- hidden side effects.

### Requirements

- change request and observable behavior boundary are stated first;
- characterization tests capture success/failure/edge behavior;
- flaky/nondeterministic sources are controlled;
- seams are minimal and tied to change point;
- no giant test harness that requires understanding every internal detail;
- current bug behavior is labeled, then changed through explicit test/decision;
- external/provider dependency is wrapped locally;
- each commit compiles/tests and is reversible;
- new structure enables focused tests around changed policy;
- old path is measured/compared before retirement;
- remaining legacy risks and next change seams are documented;
- no proprietary/real legacy code is used.

### Failure scenarios

1. “Legacy” is equated with old language/version rather than change risk.
2. Full rewrite begins before behavior/migration understanding.
3. Characterization test asserts private implementation details.
4. Golden file is huge and reviewed blindly.
5. Nondeterminism causes flaky baseline.
6. Characterized bug becomes permanent accidentally.
7. Seam is global mutable hook and introduces races.
8. Vendor types remain spread after wrapper is added.
9. Cleanup touches unrelated code and obscures feature/fix.
10. Old path is deleted before comparison/rollback window.
11. Tests pass but real dependency contract remains untested.

## Самопроверка

1. What makes code legacy?
2. Characterization test proves what?
3. Desired versus observed behavior?
4. What is a seam?
5. Sprout versus wrap techniques?
6. How to handle characterized bug?
7. Golden/approval test risks?
8. Why start from change point?
9. How break global/time/network dependencies?
10. What proves old path can retire?

## Результат для базы знаний

- **Legacy code as change difficulty**.
- **Characterization tests and observed behavior**.
- **Software seams and dependency breaking**.
- **Sprout and wrap legacy-change techniques**.
- **Nondeterminism control in legacy tests**.
- **Golden/approval test limitations**.
- **Legacy bug characterization and intentional correction**.
- **Incremental legacy-path retirement**.

## Когда переходить дальше

Можно переходить, когда an unknown legacy path can be changed under characterization evidence, hard dependencies have targeted seams, and old behavior is retired only after explicit comparison and rollback window.