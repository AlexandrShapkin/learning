# Лабораторное окружение

## Базовая система

Recommended workstation or VM:

```text
delivery-operations-lab
├── 6–10 CPU threads
├── 16–24 GiB RAM
├── 120+ GiB SSD
├── current supported Linux distribution
└── isolated local network and synthetic data
```

Reduced resources are acceptable with fewer cluster replicas and shorter retention. Record deviations.

## Required tools

- Git, Bash, Make, curl, jq and yq;
- Go toolchain;
- Docker or Podman and Compose;
- BuildKit-compatible image builder;
- local OCI registry;
- GitHub CLI optional but useful;
- GitHub Actions repository access;
- `kubectl` plus kind/k3d/k3s cluster;
- Helm and Kustomize;
- PostgreSQL client/server or container;
- migration tool or versioned SQL scripts;
- Cosign;
- SBOM generator such as Syft and scanner such as Trivy/Grype;
- checksums, OpenSSL and SSH tools;
- `git bisect`, `diff`, `time`, `ps`, `ss` and `lsof`.

Recommended:

- Argo CD or Flux;
- progressive-delivery controller such as Argo Rollouts or Flagger;
- OpenFeature-compatible feature-flag provider or a small local implementation;
- Prometheus-compatible metrics;
- MinIO or another S3-compatible store for artifacts/backups;
- a synthetic status-page/chat/mail receiver;
- `act` or another local workflow runner for selected jobs;
- database backup and restore utilities;
- policy tool for artifact/deployment verification.

## Default topology

```text
GitHub repository
├── pull-request and main workflows
├── release workflow
└── environment approvals/credentials

local host
├── OCI registry
├── PostgreSQL
├── object storage
├── dev cluster/namespace
├── staging cluster/namespace
├── production-like cluster/namespace
├── GitOps controller optional
└── metrics and incident simulation endpoints
```

Environments may share one cluster only when namespaces, credentials and state remain clearly isolated. The final project should document the reduced failure isolation.

## Reference application

A synthetic Go service containing:

- HTTP API;
- background worker;
- PostgreSQL schema and migrations;
- one external-provider sandbox;
- configurable feature;
- readiness and graceful shutdown;
- version/build metadata endpoint;
- minimal release metrics;
- backup/restore fixtures;
- intentionally injectable release and runtime faults.

## Workspace

```text
sprints/<NN-topic>/work/
├── app/
├── build/
├── workflows/
├── deploy/
│   ├── base/
│   └── environments/
├── migrations/
├── release/
├── runbooks/
├── incidents/
├── faults/
├── scripts/
├── reports/
└── README.md
```

Create only directories used by the sprint.

## GitHub Actions safety

- workflows run only against this repository and synthetic environments;
- pull-request workflows receive no privileged deployment credentials;
- environment credentials are scoped and short-lived;
- untrusted forks do not execute privileged reusable workflows;
- concurrency prevents conflicting deployment jobs;
- artifacts/logs have bounded retention;
- caches are treated as untrusted optimization, not authoritative artifacts;
- production-like deployment requires exact artifact digest and environment check;
- destructive workflows require manual dispatch input plus environment protection.

## Data and secrets

Use only synthetic users, records, events and incident messages. Do not commit:

- repository/environment secrets;
- cloud or cluster credentials;
- kubeconfig or service-account tokens;
- private signing keys;
- production logs, incidents or database dumps;
- unredacted CI logs containing tokens;
- backup archives or generated release artifacts;
- real email/chat endpoints.

Public test keys/certificates may be generated per run and excluded from Git.

## Reproducibility evidence

Record:

- source commit and dirty-tree status;
- Go/tool/dependency versions;
- base-image digest and builder version;
- workflow revision and runner image;
- artifact digest, signature, SBOM and provenance references;
- migration versions and compatibility window;
- environment config revision and secret version identifier, not value;
- deployment manifest/GitOps revision;
- rollout thresholds and observation window;
- backup identifier, restore target and measured RTO/RPO;
- incident timeline and evidence references;
- cleanup result.

## Safety limits

- all workloads and faults are labeled with repository and expiry;
- load tests cap concurrency, requests and duration;
- deployment faults affect one synthetic namespace/environment at a time;
- database faults use disposable schemas and bounded rows;
- secret rotation uses generated laboratory credentials;
- backup/restore uses synthetic data and isolated targets;
- rollback scripts verify exact environment and artifact revision;
- GitOps experiments do not watch unrelated repositories/clusters;
- incident communication targets local/synthetic receivers;
- cleanup verifies workflows, releases, registry tags, namespaces, jobs, feature flags, backups and temporary credentials.

## Commit policy

Commit:

- workflow and reusable-action definitions;
- build scripts and dependency locks;
- deployment manifests and overlays;
- migration code and compatibility tests;
- release metadata templates;
- runbooks and production-readiness checklists;
- backup/restore and incident exercise scripts;
- small synthetic fixtures;
- concise release, recovery and incident reports;
- commands to regenerate artifacts/evidence.

Do not commit:

- binaries, images, CI archives or caches;
- secrets, tokens and private keys;
- database/container volumes;
- raw large logs/traces/metrics exports;
- backup archives;
- real incident/customer data;
- generated vendor bundles without source/customization record.
