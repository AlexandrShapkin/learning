# Спринт 33. Governance, policies, audit, compliance и privacy

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как превратить security expectations into owned policies, evidence and decisions without confusing compliance with actual protection?

## Результат спринта

После завершения необходимо уметь:

- distinguish governance, risk, compliance and assurance;
- write policy, standard, procedure and guideline with correct scope;
- assign control owners and evidence sources;
- map controls to risks and frameworks;
- design exception and risk-acceptance process;
- collect audit evidence without creating shadow sensitive stores;
- manage third-party and data-processing risk;
- define privacy roles, purposes, retention and rights assumptions;
- evaluate training and human-process controls;
- handle policy lifecycle, review and deprecation;
- identify paper controls and evidence gaps;
- communicate control effectiveness and residual risk.

## Основной маршрут

1. Create synthetic organization/security charter and policy hierarchy.
2. Map selected NIST CSF/SSDF/CIS-style requirements to actual controls.
3. Build evidence catalogue from IAM, CI/CD, platform and incident systems.
4. Run a mock audit and exception review.
5. Evaluate one third party and one privacy/data-processing flow.

## Лабораторная работа

Создать `work/security-governance/`.

### Requirements

- every policy has purpose, scope, owner, review date and enforcement path;
- standards specify testable requirements rather than vague intent;
- controls map to risks, assets and evidence;
- evidence is reproducible, time-bounded and access-controlled;
- exception includes risk, compensating controls, approver and expiry;
- framework mapping avoids duplicate fictional controls;
- third-party review covers data, access, dependencies, incidents and exit;
- privacy inventory covers purpose, minimization, retention and processors;
- audit finding distinguishes design, implementation and operating effectiveness;
- one compliant-looking but ineffective control is identified and corrected.

### Failure scenarios

1. Policy states “use strong security” without measurable standard.
2. Evidence is a screenshot with no identity/time/source.
3. Control owner and operator are undefined.
4. Exception is permanent or lacks compensating control.
5. Framework mapping claims control that is not deployed.
6. Third party retains access/data after relationship ends.
7. Audit repository contains excessive secrets/personal data.
8. Training completion is treated as proof of behavior/change.

## Результат для базы знаний

- **Security governance and policy hierarchy**.
- **Security control ownership and evidence**.
- **Risk acceptance and security exceptions**.
- **Security audit design and operating effectiveness**.
- **Third-party risk and privacy governance**.

## Когда переходить дальше

Можно переходить, когда policies and framework mappings are backed by owned, reproducible control evidence and explicit residual risk.