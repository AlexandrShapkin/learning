# Каталог неисправностей

Every fault is opt-in, bounded, reversible and restricted to synthetic laboratory environments. Each definition includes expected evidence, maximum scope, rollback and cleanup verification.

## Build and dependencies

1. `undeclared-build-input` — untracked/local file changes artifact.
2. `toolchain-drift` — compiler/generator version differs between builders.
3. `mutable-dependency` — tag/proxy/base reference resolves to changed content.
4. `timestamp-path-nondeterminism` — time/workspace path changes bytes.
5. `generated-source-drift` — generated file differs from generator/source state.
6. `offline-build-failure` — release build depends on unavailable public registry.
7. `cache-poison` — restored cache injects stale/untrusted object.
8. `cross-platform-mislabel` — artifact is published under wrong platform metadata.
9. `post-signature-mutation` — artifact changes after checksum/signature.
10. `artifact-source-mismatch` — release metadata points to wrong commit/workflow.

## CI and quality gates

11. `pr-secret-exposure` — untrusted PR receives privileged token/secret.
12. `mutable-action` — third-party workflow action changes under tag.
13. `runner-persistence` — self-hosted runner leaks workspace/token between jobs.
14. `stale-branch-check` — old approval/check is reused after new changes.
15. `merge-integration-break` — independently green branches break combined main.
16. `flaky-retry-green` — retry hides deterministic/intermittent product defect.
17. `false-quality-gate` — gate passes artifact/source different from release target.
18. `pipeline-race` — older run publishes/deploys after newer run.
19. `artifact-retention-loss` — required release/debug artifact expires too early.
20. `release-tag-overwrite` — mutable release alias points to new bytes.

## Environments, configuration and secrets

21. `environment-rebuild` — staging/production rebuild artifact independently.
22. `environment-drift` — manual change differs from desired configuration.
23. `preview-shared-state` — ephemeral environment uses shared database/credentials.
24. `config-precedence` — hidden override changes effective behavior.
25. `config-schema-mismatch` — artifact and configuration versions are incompatible.
26. `partial-config-reload` — dynamic update applies only part of configuration.
27. `secret-log-leak` — secret appears in logs/artifact/cache/process args.
28. `secret-rotation-gap` — old credential revoked before consumers converge.
29. `secret-stale-session` — revocation does not terminate cached sessions.
30. `expired-certificate-token` — unmonitored credential expiry breaks service.

## Deployments and releases

31. `readiness-false-positive` — candidate receives traffic before true readiness.
32. `rolling-capacity` — surge/unavailable settings exceed capacity or drop service.
33. `termination-loss` — active requests/jobs are killed without drain.
34. `bluegreen-dual-worker` — both environments execute non-idempotent background work.
35. `routing-wrong-revision` — cutover points to unintended artifact/config.
36. `canary-unrepresentative` — candidate sees synthetic/easy traffic only.
37. `canary-noisy-metric` — analysis aborts/promotes from shared/noisy signal.
38. `shadow-side-effect` — shadow/canary duplicates irreversible external action.
39. `flag-inconsistent-target` — instances/users evaluate flag differently.
40. `flag-permanent-debt` — expired flag and dead branches remain.

## Migrations and recovery

41. `schema-old-writer-break` — schema becomes incompatible with old writer.
42. `migration-lock` — release migration blocks critical table/path.
43. `backfill-concurrent-gap` — changes during backfill are missed.
44. `dual-write-divergence` — old/new stores differ without reconciliation.
45. `event-enum-break` — old consumer crashes on new enum/semantic field.
46. `unsafe-code-rollback` — old artifact cannot read current data/schema.
47. `queue-version-mismatch` — old/new workers cannot process same jobs/messages.
48. `external-effect-rollback` — rollback repeats or cannot undo external action.
49. `gitops-stale-revision` — reconciler applies older desired state.
50. `emergency-drift-revert` — controller undoes active incident mitigation.

## Operations, recovery and incidents

51. `capacity-hidden-bottleneck` — app scales while database/queue limit dominates.
52. `backup-incomplete` — backup omits object/config/key/dependency state.
53. `backup-corrupt` — job succeeds but archive cannot restore.
54. `restore-wrong-target` — recovery overwrites active environment.
55. `dr-dual-writer` — old and recovered systems accept writes.
56. `incident-command-conflict` — multiple responders mutate without coordination.
57. `evidence-destroyed` — restart/cleanup removes useful diagnostic state.
58. `status-miscommunication` — resolved/ETA/root cause is communicated without evidence.
59. `postmortem-action-theater` — vague action closes without outcome verification.
60. `metric-gaming` — delivery/SLO metric drives behavior that worsens actual reliability.

## Combined scenario library

- mutable action + poisoned cache + valid signature over wrong artifact;
- stale merge validation + old pipeline publishes overwritten release tag;
- same source rebuilt per environment + hidden config override;
- secret rotation + old worker + queue backlog;
- rolling surge + database connection saturation + false readiness;
- canary noisy global metric + severe tenant-specific failure;
- feature flag + schema transition + inconsistent cohort evaluation;
- backfill concurrency gap + unsafe rollback + old event consumer;
- stale GitOps revision + emergency manual mitigation + controller revert;
- incomplete backup + missing key + DNS points to old primary;
- incident command conflict + evidence-destroying restart + false resolved update;
- metric target pressure + reduced quality gates + increased escaped failures.

## Fault definition contract

Each implementation includes:

```text
name and layer
preconditions and exact synthetic target
injected change or runtime behavior
expected user, pipeline and operational symptom
expected commit/workflow/artifact/deployment/runtime evidence
maximum requests, rows, jobs, duration and affected environment
disable/rollback/forward-repair procedure
cleanup and baseline verification
new gate, policy, runbook or detection proving repair
```

## Safety contract

Fault tooling must:

- require repository marker, environment label and explicit `--lab`;
- reject unknown repositories, clusters, databases and external endpoints;
- print target, scope and planned effect before activation;
- cap rows, traffic, replicas, jobs, retries and duration;
- use synthetic users/data/communications only;
- preserve release/state/backup evidence before destructive cases;
- never print secret values or private keys;
- avoid privileged workflow execution from untrusted refs;
- support `status`, `disable`, `rollback-all` and `cleanup`;
- verify registry objects, environments, migrations, jobs, flags, backups and temporary credentials after cleanup.
