# Спринт 28. Security review, SAST, DAST и fuzzing

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как сочетать ручной review and automated testing so that findings are relevant, reproducible and safely validated?

## Результат спринта

После завершения необходимо уметь:

- scope a defensive security review and authorization;
- review trust boundaries, authentication, authorization and data handling;
- use SAST/semantic rules and understand false positives;
- use DAST/passive/baseline scans against local targets;
- design fuzz targets and security properties;
- triage findings by exploit path and impact;
- create minimal safe reproduction cases;
- avoid destructive or uncontrolled active scanning;
- verify remediation and add regression tests;
- measure tool coverage and blind spots;
- document unresolved uncertainty.

## Основной маршрут

1. Review one feature from threat model to code/configuration.
2. Run Semgrep/gosec/`govulncheck` and triage results.
3. Run ZAP baseline against exact local routes.
4. Add Go fuzz targets for parser/authorization/file boundaries.
5. Remediate and create regression tests.

## Лабораторная работа

Создать `work/security-testing/`.

### Requirements

- target, routes, ports, rates and prohibited actions are allowlisted;
- manual review checks design and trust assumptions, not only syntax;
- SAST rules are versioned and tuned with evidence;
- DAST uses synthetic accounts/data and bounded concurrency;
- fuzz targets have time/memory/corpus limits;
- crashes and invariant violations preserve minimal inputs;
- findings distinguish confirmed, likely, false positive and unverified;
- remediation includes regression test and deployed verification;
- tool failures/timeouts are not interpreted as clean result;
- report excludes weaponized payload automation and sensitive data.

### Failure scenarios

1. Scanner runs against public or shared target.
2. High scanner count is reported as risk without triage.
3. SAST rule suppresses a whole class after one false positive.
4. DAST misses object authorization due single user.
5. Fuzzer exhausts host or creates uncontrolled files.
6. Fix changes error text but not vulnerable control.
7. Security review ignores architecture/configuration/supply chain.

## Результат для базы знаний

- **Security review scope and methodology**.
- **Static application security testing**.
- **Dynamic application security testing**.
- **Security fuzzing and invariant targets**.
- **Security finding validation and regression tests**.

## Когда переходить дальше

Можно переходить, когда manual and automated review find, validate and permanently regress-test at least one meaningful security defect within bounded scope.