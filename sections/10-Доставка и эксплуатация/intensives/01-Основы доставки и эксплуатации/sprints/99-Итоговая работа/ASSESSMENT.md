# Итоговая проверка

## Blind release and incident exercise

Solve at least 22 hidden exercises:

- four build/CI/artifact cases;
- four environment/deployment/migration cases;
- four operation/recovery cases;
- four incident/SLO/metric cases;
- six combined cases.

For each exercise:

```text
User/release symptom and impact
Affected commit, workflow, artifact, release and environment
Expected path and authoritative desired state
Preserved logs, state, revisions, events and data evidence
First divergence or irreversible effect
Ranked hypotheses and discriminating check
Root cause, trigger and contributing conditions
Minimal mitigation and recovery decision
User-path, data and desired-state verification
Gate, policy, runbook or corrective-action update
```

## Clean reconstruction

From clean checkout and empty laboratory state:

1. verify tools, repository and environment safety markers;
2. restore dependencies and build in two isolated builders;
3. compare digests and produce SBOM/provenance/signatures;
4. run pull-request/main/release quality workflows;
5. publish immutable release manifest and artifacts;
6. create/reset dev, staging and production-like environments;
7. promote one digest through all environments;
8. apply config, secret and compatible schema revisions;
9. run rolling/blue-green and canary verification;
10. activate/remove feature flag;
11. reconcile desired state through GitOps/equivalent;
12. run readiness and maintenance checks;
13. perform backup/restore and DR exercise;
14. run incident drill, postmortem action replay and SLO report;
15. destroy/clean all temporary environments and artifacts safely.

## Complete failed-release exercise

Perform one scenario:

1. two changes pass branch checks but conflict in merge queue;
2. repaired main produces signed release artifact;
3. staging promotion uses wrong hidden config and is rejected;
4. production-like rollout begins with schema expansion;
5. canary shows a tenant-specific regression hidden by global average;
6. feature flag/traffic mitigation limits impact;
7. background worker and backfill expose mixed-version incompatibility;
8. rollback is judged unsafe because of irreversible state;
9. roll-forward repair restores data/user path;
10. GitOps desired state and emergency changes are reconciled;
11. incident is communicated and stabilized;
12. postmortem actions are implemented and scenario replayed.

## Complete recovery exercise

1. backup job reports success but one dependency is missing;
2. production-like environment is declared lost;
3. recovery begins in isolated target;
4. missing dependency/key/config is identified from restore evidence;
5. trusted artifact, schema, data and configuration are restored;
6. DNS/traffic is switched while preventing dual writers;
7. minimum capacity and user SLIs are verified;
8. RTO/RPO are measured honestly;
9. failback or new-primary decision is recorded;
10. remaining old resources and credentials are cleaned.

## Final defense

Answer using project evidence:

1. How is the full delivery value stream mapped and measured?
2. What are complete build inputs and hidden dependencies?
3. Deterministic versus reproducible build?
4. What do digest, SBOM, provenance and signature prove?
5. Cache, workflow artifact and release repository differences?
6. Which tests/checks belong before merge and release?
7. How are untrusted and privileged CI paths separated?
8. How do merge queue and main-branch releasability work?
9. How is one immutable artifact promoted through environments?
10. What are meaningful environment parity and isolation?
11. How are release versions, manifests, notes and approvals organized?
12. How are configuration and secrets versioned, rotated and revoked?
13. How are recreate, rolling and blue-green strategies selected?
14. How are canary evidence, windows, samples and stop criteria defined?
15. How do feature flags separate deploy from release and get removed?
16. How do expand-and-contract and restartable backfills work?
17. When is rollback unsafe and roll forward required?
18. Continuous delivery versus deployment and GitOps?
19. What does production readiness require?
20. How are runbooks and maintenance procedures made executable?
21. How are capacity, upgrades, deprecation and retirement managed?
22. Backup, snapshot, replica and restore differences?
23. How are RTO, RPO and point-in-time recovery measured?
24. High availability versus disaster recovery?
25. How are severity and incident roles established?
26. How do incident command, escalation and communication work?
27. How are service stabilization and evidence preservation balanced?
28. How is a useful postmortem written and actions verified?
29. How are SLI, SLO, SLA, error budgets and burn rates used?
30. How are delivery metrics defined without gaming or ranking people?
31. How does `deliverytriage` locate first divergence?
32. Which evidence proves the delivery system is safer and faster rather than merely more automated?

Every answer references a commit, workflow, artifact digest, release manifest, environment revision, rollout/migration result, restore result, incident timeline, SLO calculation or improvement experiment.

## Completion criteria

The intensive is complete when:

- clean checkout reproduces the same release artifact in two builders;
- complete source/toolchain/dependency inputs are controlled;
- artifact is immutable, signed and linked to SBOM/provenance;
- PR/main/release trust and permissions are separated;
- quality gates detect named injected defects;
- protected current main remains releasable;
- exact digest is promoted through three isolated environments;
- config and secret changes are independent, observable and recoverable;
- rolling/blue-green/canary and feature-flag lifecycles are exercised;
- migration survives mixed versions, interruption and concurrent changes;
- rollback and roll-forward decisions preserve data/external effects;
- GitOps/desired-state reconciliation handles drift and emergency changes;
- readiness/runbook/capacity/upgrade/retirement evidence exists;
- isolated restore and DR recovery meet measured RTO/RPO or document gaps;
- at least two full incidents are commanded, communicated and reviewed;
- postmortem actions improve replay outcome;
- SLO/error budget changes a release decision coherently;
- one delivery bottleneck improves without worsening guardrails;
- `deliverytriage` is read-only and redacted;
- all 60 faults are reproducible or have documented equivalent substitute;
- at least 22 blind exercises and six combined cases are solved;
- all 32 defense answers are evidence-based;
- cleanup finds no unintended environment, artifact, flag, job, backup or credential;
- generalized knowledge is transferred to `knowledge`.

## Delayed assessment

After 7–14 days without rereading:

1. rebuild, sign and verify one release from clean source;
2. answer the 32 defense questions;
3. diagnose four random faults including one combined case;
4. promote one digest and perform a safe canary;
5. execute one interrupted expand-and-contract migration;
6. decide and perform rollback or roll forward under hidden state;
7. restore service/data to isolated target and measure objectives;
8. command one short incident with communication and evidence preservation;
9. write one postmortem action and prove it through replay;
10. calculate an SLO/error-budget and make one release decision;
11. identify one metric/pipeline guard that is too strict, weak or gameable and correct it;
12. explain which remaining work belongs to observability, distributed systems, security, engineering process or product management.

После delayed assessment уровень 3–4 можно считать закреплённым.
