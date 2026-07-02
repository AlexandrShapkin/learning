# Спринт 34. Secure SDLC, security metrics и системный review

Ориентировочный объём: 20–30 часов.

## Центральный вопрос

Как встроить security decisions and verification into engineering lifecycle and measure whether the program reduces risk rather than only producing findings and gates?

## Результат спринта

После завершения необходимо уметь:

- integrate threat modeling, security requirements and reviews into planning/design;
- define secure coding, dependency and release expectations;
- place automated checks at appropriate feedback points;
- distinguish blocking gates from advisory signals;
- define security champions and escalation paths;
- conduct architecture/security readiness reviews;
- measure lead time to remediate, recurrence, exposure and control coverage;
- avoid vanity metrics such as raw finding counts;
- measure control effectiveness through fault and incident exercises;
- prioritize security debt and roadmap by risk;
- review cross-layer trust, identity, data and recovery assumptions;
- create read-only security triage bundle.

## Основной маршрут

1. Map security activities to idea → design → code → build → deploy → operate → retire.
2. Define risk-tiered review and gate criteria.
3. Create metrics from the previous sprints.
4. Run a cross-layer security review of the reference system.
5. Prioritize a security improvement roadmap.

## Лабораторная работа

Создать `work/secure-sdlc-review/`.

### `sectriage`

Read-only commands:

```text
sectriage identity --subject ID
sectriage access --subject ID --resource R
sectriage secret --name NAME
sectriage artifact --digest DIGEST
sectriage vulnerability --asset ASSET
sectriage policy --control ID
sectriage detection --alert ID
sectriage incident --id ID
sectriage data --class CLASS
sectriage evidence --control ID
```

### Requirements

- security activities are risk-tiered and have owners/inputs/outputs;
- critical changes require threat/control review before implementation;
- automated gates are fast, reproducible and have exception path;
- metrics include exposure time, recurrence, stale privilege, rotation success, detection coverage and recovery validation;
- counts are segmented by asset/risk and not used as personnel targets;
- review follows identities, data, artifacts and administrative paths end to end;
- `sectriage` is read-only, scoped, redacted and evidence-linked;
- at least ten cross-layer gaps are ranked by risk and cost;
- roadmap distinguishes immediate control fixes from architectural redesign;
- retired identities, data, artifacts and dependencies are included.

### Failure scenarios

1. Security review occurs only before release and discovers design flaw too late.
2. Every scanner finding blocks delivery equally.
3. Exception path becomes permanent bypass.
4. Metric rewards closing tickets without runtime verification.
5. Security champion owns all security and product teams disengage.
6. `sectriage` exposes secrets or can mutate access.
7. Roadmap prioritizes tool adoption over critical trust-boundary gap.
8. Decommissioning leaves credentials, data or public endpoints.

## Результат для базы знаний

- **Secure software development lifecycle**.
- **Risk-tiered security reviews and gates**.
- **Security metrics and control-effectiveness measurement**.
- **Cross-layer security architecture review**.
- **Read-only security triage tooling**.

## Когда переходить дальше

Можно переходить к итоговой работе, когда security controls are integrated into lifecycle and prioritized through measured exposure, recurrence and control effectiveness.