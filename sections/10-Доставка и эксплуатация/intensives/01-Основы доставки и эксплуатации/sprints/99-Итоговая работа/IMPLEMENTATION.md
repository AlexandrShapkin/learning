# Реализация итоговой работы

## 1. Reference application and baseline

Create a runnable Go application with:

- HTTP API and background worker;
- PostgreSQL schema and realistic synthetic fixtures;
- object/provider integration sandbox;
- version/build metadata endpoint;
- graceful shutdown and readiness;
- one configurable and one flag-controlled behavior;
- basic user-facing and background-work indicators;
- known intentionally injectable release faults.

Map one feature, defect and database change from commit to runtime before improving the delivery path.

## 2. Build inputs and reproducibility

Required:

- pinned Go toolchain and module state;
- controlled generators and base images;
- clean isolated builders;
- network-independent build after controlled dependency preparation;
- normalized timestamps, paths and archive metadata;
- two-builder byte comparison or documented variance;
- binary and OCI digest manifests;
- source/toolchain/dependency/build metadata;
- no secret/untracked-host dependency.

## 3. Artifact supply and release manifest

Publish final binary/archive and OCI image.

Required metadata:

```text
release version
source commit and repository
workflow/builder identity
binary/image digests
platform variants
SBOM references
provenance attestation
signature and trust policy
migration/config compatibility
retention and support state
```

Release candidate and final release use identical bytes. Artifact quarantine/revocation and safe retention are tested.

## 4. CI architecture

Implement:

- pull-request workflow with minimal read permissions;
- main workflow producing releasable artifacts;
- release workflow publishing immutable release manifest;
- reusable workflow contracts;
- current-main/merge-queue validation;
- concurrency cancellation for superseded branch runs;
- serialized environment mutation;
- bounded artifacts/log retention;
- pinned third-party actions;
- short-lived deploy credentials or faithful local simulation.

Untrusted changes cannot access release/deployment secrets or persistent self-hosted runner state.

## 5. Quality gates

Required checks:

- formatting and static analysis;
- unit and component tests;
- integration tests with PostgreSQL/provider sandbox;
- API/provider contract tests;
- migration compatibility tests with realistic existing data;
- race detector and one fuzz/property test;
- artifact/image inspection;
- dependency/SBOM policy checks;
- release smoke tests against exact artifact.

Each gate names the failure class it detects and what it cannot prove. Flakes are diagnosed or explicitly quarantined with owner/expiry.

## 6. Environment and promotion model

Create dev, staging and production-like environments.

Requirements:

- one artifact digest is promoted through all environments;
- artifact, config, secret, schema and deployment revisions are visible separately;
- credentials and persistent state are isolated;
- staging uses the same critical deployment mechanism/contracts;
- preview environments have TTL and automatic cleanup;
- synthetic data reset is deterministic;
- drift is detected and reconciled;
- promotion/approval references exact release manifest.

## 7. Configuration and secrets

Configuration:

- versioned schema and validation;
- explicit precedence/default/deprecation;
- startup versus dynamic-reload semantics;
- effective nonsecret revision endpoint;
- compatibility tests across artifact/config revisions.

Secrets:

- separate build, deployment and runtime identities;
- short-lived/scoped credentials;
- references rather than committed values;
- rotation with overlap and consumer convergence;
- revocation and expiration monitoring;
- break-glass procedure;
- no leakage into logs, images, artifacts, cache or process arguments.

## 8. Deployment and progressive release

Implement at least:

- rolling deployment with capacity and graceful draining;
- blue-green or equivalent controlled traffic cutover;
- canary stages with representative cohort;
- baseline/candidate analysis;
- automatic pause/continue/abort;
- user-facing error/latency plus correctness signal;
- observation windows/sample requirements;
- background-job/external-effect safety;
- post-deploy user-path verification.

Controller success and Git synchronization are not accepted as service-health proof.

## 9. Feature flags

Implement release and operational flags.

Requirements:

- registry with owner, default, type and expiry;
- deterministic cohort targeting;
- provider outage/stale-cache behavior;
- state/data compatibility across states;
- audited changes;
- emergency kill switch;
- metrics by cohort;
- complete removal after release;
- flags do not replace authorization.

## 10. Compatible migrations

Perform one full expand-and-contract migration:

```text
expand schema/contract
→ deploy compatible readers/writers
→ bounded restartable backfill
→ capture/reconcile concurrent changes
→ switch reads/writes
→ verify old-path usage is zero
→ enforce constraint/contract
→ remove compatibility state
```

Test old/new applications, workers, clients and messages. State irreversible points and forward-repair plan.

## 11. Recovery decisions

Implement exercises for:

- code-only rollback;
- config rollback;
- traffic switch;
- feature disable;
- unsafe rollback after schema/data/external effect;
- forward patch;
- queue/in-flight work recovery;
- emergency-state reconciliation.

Release metadata contains rollback compatibility. Recovery verifies user path, data invariants and one desired revision.

## 12. Continuous delivery and GitOps

Use Argo CD/Flux or a small faithful desired-state reconciler.

Requirements:

- artifact and deployment-state repositories are separate concerns;
- desired state references immutable digest;
- controller permissions are environment-scoped;
- signature/provenance policy is enforced;
- synced and healthy statuses differ;
- drift is detected/corrected or intentionally adopted;
- emergency changes have expiry and reconciliation;
- CI and controller do not form commit/status loops;
- progressive-delivery controller ownership is explicit.

## 13. Production readiness and runbooks

Readiness review covers:

- ownership/support/escalation;
- dependency failure/timeouts/quotas;
- artifact/config/schema observability;
- probes/shutdown/degraded behavior;
- capacity and one-failure headroom;
- state/backup/restore;
- secret/certificate expiry;
- release/recovery/maintenance procedures;
- accepted risks and review triggers.

Runbooks are exercised by a second operator and include exact target checks, prerequisites, stop criteria, verification and cleanup.

## 14. Capacity and lifecycle

Measure:

- request/job throughput and concurrency;
- CPU/memory/storage/connection saturation;
- rollout/maintenance/failure headroom;
- first bottleneck and scale response.

Perform one staged runtime/base-image/dependency upgrade and one service/interface retirement. Remove residual traffic, jobs, credentials, routes, storage and cost.

## 15. Backup and recovery

Implement:

- authoritative/derived state inventory;
- logical/physical/PITR strategy as appropriate;
- encrypted and isolated backup copy;
- backup failure/corruption detection;
- isolated restore with configuration/key/dependency reconstruction;
- business-invariant verification;
- measured RPO and end-to-end RTO;
- retention and restore-drill ownership.

## 16. Disaster recovery

Recover from loss of the production-like environment into a fresh isolated target.

Required:

- recovery dependency/order map;
- trusted artifacts, infrastructure/config and bootstrap identities;
- data restore and minimum capacity;
- DNS/traffic/certificate/provider recovery;
- one authoritative writer/source;
- failback or new-primary decision;
- measured objective and deviations;
- corrective actions verified in a second drill.

## 17. Incident response

Run at least two full simulations:

- failed release with migration/queue impact;
- infrastructure/dependency loss requiring restore/failover.

Required artifacts:

- declaration and severity;
- incident commander/technical/comms/scribe roles;
- objective, workstreams and update cadence;
- internal/public synthetic communications;
- evidence and decision timeline;
- mitigations, stabilization window and data verification;
- emergency-change reconciliation;
- resolved communication with residual follow-up.

## 18. Postmortem and actions

Postmortems include:

- quantified impact;
- evidence-based timeline;
- trigger and contributing conditions;
- uncertainty/missing evidence;
- explanation of local decisions;
- prevention/detection/mitigation/recovery actions;
- owners and verification criteria;
- rejected low-value actions;
- incident replay after completed actions.

## 19. SLO and error-budget policy

Define at least:

- API success/latency SLI;
- background-job freshness/completion SLI;
- one correctness/durability indicator;
- valid/good events, windows and exclusions;
- SLO rationale and error budget;
- fast/slow burn scenarios;
- release actions under healthy, warning and exhausted states;
- exception authority for reliability fixes/emergency changes.

## 20. Delivery improvement

Calculate and version definitions for:

- deployment frequency;
- commit/change lead time with waiting segments;
- change failure rate;
- recovery time;
- flaky-gate burden and rework;
- release batch size.

Run one constraint-focused improvement experiment with reliability/quality/responder guardrails. Do not rank individuals or teams.

## 21. Diagnostics

`deliverytriage` is read-only and supports:

```text
change
workflow
artifact
release
environment
rollout
configuration
secret-version
migration
incident
path
```

It correlates immutable identifiers, states and bounded evidence. It never reruns workflows, deploys, changes flags, rolls back or prints secret values.

## 22. Verification commands

```text
make check
make build-reproducible
make test
make test-integration
make test-contracts
make test-migrations
make release
make verify-artifact
make deploy-dev
make promote-staging
make promote-production
make test-rollout
make test-feature-flags
make test-rollback-forward
make test-backup-restore
make test-dr
make incident-drill
make slo-report
make delivery-report
make fault-smoke
make cleanup
```

## 23. Implementation stages

### Stage 1. Build and CI

Reference app, inputs, reproducibility, artifacts, gates and merge safety.

### Stage 2. Release and environments

Release manifests, immutable promotion, configuration and secrets.

### Stage 3. Deployment and migration

Rolling/blue-green/canary, flags, compatibility and recovery choices.

### Stage 4. Continuous operation

GitOps, readiness, runbooks, capacity and lifecycle.

### Stage 5. Recovery

Backup, point-in-time restore and disaster recovery.

### Stage 6. Incident learning

Incident command, stabilization, postmortems and corrective actions.

### Stage 7. Reliability and improvement

SLO/error budgets, delivery metrics and constraint experiment.

### Stage 8. Assessment

`deliverytriage`, fault catalogue, blind exercises, clean reconstruction and delayed assessment.
