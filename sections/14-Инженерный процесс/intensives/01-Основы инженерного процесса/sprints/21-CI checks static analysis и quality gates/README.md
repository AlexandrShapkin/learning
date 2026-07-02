# Спринт 21. CI checks, static analysis и quality gates

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Какие автоматические проверки должны блокировать integration, какие давать advisory feedback, and how keep feedback fast and trustworthy?

## Результат спринта

После завершения необходимо уметь:

- design CI stages by feedback speed and risk;
- distinguish blocking and advisory checks;
- use formatting, linting, static analysis, tests, race and vulnerability checks;
- cache safely and preserve reproducibility;
- parallelize without hiding dependencies;
- handle flaky/infra failures separately from product failures;
- set timeouts and artifact retention;
- manage exceptions and temporary waivers;
- prevent gate proliferation and local/CI mismatch;
- measure queue and execution time.

## Основной маршрут

1. Build a local/GitHub-style CI workflow.
2. Order fast checks before expensive ones.
3. Inject flaky, slow and infrastructure failures.
4. Tune blocking/advisory policy and exception flow.

## Лабораторная работа

Создать `work/ci-quality-gates/`.

### Requirements

- local and CI commands share one source of truth;
- formatting/lint/static/test checks are deterministic;
- critical integration/security checks block; experimental checks report only;
- failures distinguish code, test, environment and infrastructure causes;
- caches cannot reuse incompatible/untrusted outputs;
- jobs have timeout and bounded artifact/log retention;
- flaky tests are quarantined with owner and repair deadline, not ignored;
- exception has scope, owner, reason and expiry;
- pipeline duration and queue time are measured;
- obsolete/duplicate gate is removed.

### Failure scenarios

1. CI passes a different command than developers run.
2. Every new tool becomes a blocking gate.
3. Flaky test is rerun until green.
4. Cache hides dependency/configuration change.
5. Pipeline failure reason is ambiguous.
6. Waiver is permanent.
7. Slow check blocks all feedback although it could run later.

## Результат для базы знаний

- **CI feedback stages and quality gates**.
- **Blocking versus advisory checks**.
- **CI flakiness and failure classification**.
- **CI caching, timeouts and reproducibility**.

## Когда переходить дальше

Можно переходить, когда CI provides fast reliable risk-based feedback and exceptions/flaky checks cannot silently weaken the gate.