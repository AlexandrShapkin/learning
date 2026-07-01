# Спринт 31. Системная диагностика доставки и эксплуатации

Ориентировочный объём: 21–31 час.

## Центральный вопрос

Как from a failed or degraded release locate the first divergence across source, build, pipeline, artifact, environment, configuration, deployment, migration and runtime while preserving evidence and ownership?

## Результат спринта

После завершения необходимо уметь:

- state exact delivery/operation symptom and affected users;
- correlate commit, workflow, artifact digest, release, config, schema and runtime revision;
- distinguish build failure, test failure, pipeline infrastructure failure and product defect;
- diagnose registry/signature/provenance and promotion failures;
- diagnose stale/racing deployments and GitOps drift;
- identify configuration/secret/migration incompatibility;
- separate rollout-controller status from service health;
- inspect queues, backfills and external side effects;
- preserve pipeline logs, events, release state and minimal runtime evidence;
- rank falsifiable hypotheses and run discriminating checks;
- choose mitigation, rollback, roll forward or restore deliberately;
- verify user path, data state, desired state and cleanup;
- add pipeline gate, runbook, policy or detection after repair.

## Diagnostic loop

```text
state user impact and expected release path
→ preserve commit/workflow/artifact/config/schema/deployment/runtime identifiers
→ identify authoritative desired state and current observed state
→ locate first mismatch, failed gate or irreversible effect
→ classify pipeline, artifact, environment, migration or runtime issue
→ rank hypotheses and run one discriminating check
→ mitigate/repair minimally
→ verify user path, data and desired state
→ reconcile emergency changes and add prevention
```

## Лабораторная работа

Создать `work/delivery-diagnostics/`.

### `deliverytriage`

Read-only commands:

```text
deliverytriage change --commit SHA
deliverytriage workflow --run ID
deliverytriage artifact --digest DIGEST
deliverytriage release --version VERSION
deliverytriage environment --name NAME
deliverytriage rollout --name NAME
deliverytriage migration --version VERSION
deliverytriage incident --id ID
deliverytriage path --service NAME
```

It never retries, reruns, deploys, rolls back, changes flags or exposes secrets.

### Incident catalogue

Solve at least 24, including six combined cases:

1. undeclared/nondeterministic build input;
2. cache/action/runner compromise or stale result;
3. flaky/incorrect quality gate;
4. artifact tag/digest/signature/provenance mismatch;
5. environment promotion/revision mismatch;
6. config/secret rotation incompatibility;
7. stale/racing deployment or GitOps drift;
8. readiness/rolling/blue-green failure;
9. noisy/incorrect canary analysis;
10. feature flag inconsistency/debt;
11. migration/backfill/old-worker incompatibility;
12. unsafe rollback/irreversible effect;
13. capacity/upgrade/maintenance failure;
14. incomplete backup/restore/DR dependency;
15. incident command/communication/evidence failure;
16. SLO or delivery-metric misinterpretation;
17. multiple simultaneous faults.

### Combined examples

- mutable action + poisoned cache + valid signature over wrong artifact;
- old artifact + new config + partially applied schema;
- stale GitOps revision + canary abort + manual hotfix drift;
- secret rotation + old worker + queue backlog;
- restore + missing key + DNS points to old primary;
- HPA/capacity shortage + rolling surge + PDB;
- feature flag rollout + noisy SLI + incorrect error-budget decision;
- pipeline retry + duplicate publish + overwritten release tag.

## Критерии прохождения

- `deliverytriage` is read-only, bounded and redacted;
- at least 24 incidents and six combined cases are solved;
- every case identifies first divergence and authoritative state;
- retries, restarts, rollback or flag changes are not accepted as unexplained fixes;
- user, data and desired-state verification follows repair;
- emergency changes are reconciled;
- each repaired class gains a gate, policy, runbook or detection improvement;
- cleanup restores artifact/environment/feature-flag/job state;
- at least 10 of 12 self-check answers are mechanism-based.

## Самопроверка

1. Build failure versus pipeline infrastructure failure?
2. How correlate commit to running revision?
3. First divergence versus final symptom?
4. Artifact verification evidence?
5. Desired versus observed deployment state?
6. Config/schema/worker compatibility diagnosis?
7. Why controller success is not service health?
8. When rollback is unsafe?
9. What evidence must survive incident mitigation?
10. How verify recovery beyond green checks?
11. How reconcile emergency state?
12. Which guard prevents recurrence?

## Результат для базы знаний

- **Systematic software-delivery diagnostics**.
- **Commit, artifact, release and runtime correlation**.
- **Delivery desired state and first divergence**.
- **Pipeline, migration and rollout failure classification**.
- **Release recovery verification and prevention**.

## Когда переходить дальше

Можно переходить к итоговой работе, когда unfamiliar delivery failures are localized through immutable identifiers and minimal evidence, and repairs restore one traceable desired/runtime state.