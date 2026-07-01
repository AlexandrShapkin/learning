# Спринт 99. Итоговая работа

Ориентировочный объём: 65–95 часов.

## Задача

Создать `delivery-operations-lab` — воспроизводимую laboratory system demonstrating the full path from source change to reliable operation: build, test, artifact verification, environment promotion, progressive deployment, compatible migrations, configuration and secret lifecycle, backup/restore, disaster recovery, incident command, postmortem learning and SLO-driven release decisions.

Проект не является универсальной enterprise delivery platform. Его задача — доказать механизмами и измерениями, что one synthetic service can be built once, promoted safely, recovered under failure and improved after incidents without hidden mutable state.

## Reference service

Synthetic work-management API:

- Go HTTP API;
- PostgreSQL database and versioned migrations;
- background worker and queue/table-backed jobs;
- object storage integration;
- external provider sandbox;
- one release feature flag;
- readiness, graceful shutdown and build metadata;
- user-facing and background-work SLIs;
- synthetic users/data only.

## Target delivery system

```text
source repository
├── pull-request validation
├── protected main and merge queue
├── reproducible build
├── tests and quality gates
├── SBOM, provenance and signature
└── immutable release manifest
            |
       OCI/artifact repository
            |
 deployment-state repository or controlled promotion
├── development
├── staging
└── production-like
    ├── progressive rollout
    ├── feature flags
    ├── config/secret revisions
    ├── schema/backfill state
    ├── backup/restore
    ├── SLO and release evidence
    └── incident/recovery procedures
```

## Repository structure

```text
work/delivery-operations-lab/
├── app/
├── build/
├── .github/workflows/
├── release/
├── deploy/
│   ├── base/
│   ├── dev/
│   ├── staging/
│   └── production/
├── gitops/
├── migrations/
├── feature-flags/
├── backup/
├── runbooks/
├── slo/
├── incidents/
├── faults/
├── scripts/
├── fixtures/
├── reports/
├── Makefile
└── README.md
```

## Документы итоговой работы

- [`IMPLEMENTATION.md`](IMPLEMENTATION.md) — mandatory capabilities, implementation stages and evidence.
- [`FAULTS.md`](FAULTS.md) — catalogue of 60 controlled delivery/operations faults.
- [`ASSESSMENT.md`](ASSESSMENT.md) — blind releases/incidents, clean reconstruction and final defense.

## Mandatory capabilities

1. Explicit change/value-stream and ownership map.
2. Pinned source, dependency, toolchain and generated inputs.
3. Reproducible binary and OCI image builds.
4. Immutable artifact repository, release manifest, SBOM, provenance and signatures.
5. Pull-request, main and release workflows with distinct trust boundaries.
6. Unit, integration, contract, migration and risk-oriented quality gates.
7. Protected main, current-main validation and merge safety.
8. Dev, staging and production-like environments using the same artifact digest.
9. Versioned configuration and short-lived/scoped secrets.
10. Rolling/blue-green baseline and canary progressive delivery.
11. Feature-flag activation, failure and complete removal.
12. Expand/backfill/switch/contract database/API migration.
13. Rollback and roll-forward exercises with irreversible effects.
14. GitOps or equivalent desired-state reconciliation.
15. Production-readiness review and operational contract.
16. Runbooks for release, maintenance, secret rotation and recovery.
17. Capacity, upgrade, deprecation and retirement evidence.
18. Backup, point-in-time restore and fresh-environment disaster recovery.
19. Incident command, communication, stabilization and evidence preservation.
20. Postmortem with verified corrective actions.
21. SLI/SLO/error-budget release policy.
22. Delivery-flow/change-risk metrics with anti-gaming rules.
23. Read-only `deliverytriage` and fault catalogue.

## Mandatory scenarios

1. Clean checkout produces the same release artifact in two builders.
2. One release digest is promoted through all environments.
3. A dependency or base image update changes artifact/SBOM transparently.
4. Untrusted pull request cannot access privileged deployment path.
5. Two conflicting changes are caught before main/release.
6. Configuration and secret revisions change without rebuilding.
7. Healthy rolling/blue-green release completes with graceful draining.
8. Canary stops a known regression and promotes a healthy candidate.
9. Feature is activated by cohort and flag is later removed.
10. Database/API migration survives mixed versions and interruption.
11. Code-only defect is rolled back safely.
12. Irreversible migration/external effect requires roll forward.
13. Manual runtime drift is reconciled to desired state.
14. One production-readiness review blocks a launch until evidence exists.
15. Backup restores to isolated target within measured objectives.
16. Full environment loss is recovered through DR exercise.
17. Incident is declared, commanded, communicated and stabilized.
18. Postmortem actions change replay outcome.
19. Error-budget state changes release decision.
20. One delivery bottleneck improvement preserves reliability guardrails.

## Main results

The completed laboratory includes:

- source-to-runtime traceability for every release;
- reproducibility reports and artifact manifests;
- workflow trust/permission model;
- risk-to-quality-gate map;
- immutable promotion and environment revision records;
- rollout/canary/feature-flag evidence;
- compatibility matrices and migration reports;
- rollback/roll-forward decision records;
- readiness review and runbooks;
- capacity/upgrade/retirement reports;
- backup/restore/DR evidence;
- incident timelines, communications and postmortems;
- SLO/error-budget and delivery-metric definitions;
- `deliverytriage` output and controlled incident catalogue.

## Execution order

1. Build reference application and map the change flow.
2. Pin inputs and establish reproducible builds.
3. Add CI trust boundaries and quality gates.
4. Publish signed immutable artifacts and release manifests.
5. Create isolated environments and promotion path.
6. Add configuration, secret and migration lifecycles.
7. Implement deployment strategies and progressive delivery.
8. Add GitOps/continuous delivery reconciliation.
9. Complete production-readiness and routine runbooks.
10. Implement capacity, backup, restore and DR exercises.
11. Run incident command, stabilization and postmortem cycles.
12. Add SLO/error-budget and delivery improvement decisions.
13. Implement `deliverytriage`, faults and blind assessment.

## Artifacts to commit

- source, tests and dependency locks;
- workflow definitions and reusable scripts;
- deployment manifests/overlays and migration code;
- release manifest templates and verification policy;
- feature-flag schema/lifecycle records;
- runbooks, readiness and recovery procedures;
- SLO and metric definitions;
- sanitized incident/postmortem records;
- fault definitions and concise reports;
- commands to regenerate artifacts and evidence;
- links to generalized `knowledge` notes.

Do not commit:

- binaries, images, workflow artifacts or caches;
- credentials, tokens, private keys or kubeconfig;
- database/container volumes and backup archives;
- unredacted logs, metrics dumps or incident data;
- real user/customer/provider records;
- private postmortems or proprietary release procedures;
- unbounded load/fault/destructive scripts.

## Safety

- all environments, artifacts and faults are labeled with repository and expiry;
- workflows verify exact repository/ref/environment before mutation;
- pull requests never receive privileged secrets;
- load and failure experiments cap requests, rows, duration and concurrency;
- database migrations operate on disposable synthetic data;
- incident messages target local/synthetic endpoints;
- backups/restores use isolated targets;
- rollback/destroy checks exact digest, namespace and database;
- cleanup verifies releases, registry objects, environments, jobs, flags, backups and temporary credentials.

## Результат для базы знаний

Итоговая работа должна завершить или исправить заметки по reproducible builds, artifacts and provenance, CI trust, quality gates, release management, environments, progressive delivery, feature flags, compatible migrations, recovery decisions, GitOps, operational readiness, runbooks, backups, disaster recovery, incident command, postmortems, SLO/error budgets and delivery metrics.

Source, workflows, manifests, release evidence and incident artifacts remain in `learning`; generalized mechanisms move to `knowledge`.
