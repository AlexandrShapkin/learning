# Ресурсы интенсива

Это общая библиография. Внутри каждого спринта указан обязательный minimum route. Не требуется читать всё последовательно.

## Build and artifacts

- Go modules, build, test and reproducibility documentation.
- OCI Image and Distribution specifications.
- Docker/BuildKit documentation.
- SLSA specification and provenance concepts.
- SPDX and CycloneDX specifications.
- Cosign/Sigstore documentation.
- package and container registry documentation.
- semantic versioning and conventional changelog references used critically.

## CI and pipeline design

- GitHub Actions official documentation: events, permissions, environments, reusable workflows, artifacts, caches, concurrency and OIDC.
- CI provider-neutral pipeline concepts.
- testing, static analysis and coverage documentation for selected tools.
- supply-chain and dependency-scanning docs where used.
- *Continuous Integration*, Paul Duvall et al., as historical model checked against current systems.

## Continuous delivery and release engineering

- *Continuous Delivery*, Jez Humble and David Farley.
- *Release It!*, Michael Nygard.
- *Accelerate*, Nicole Forsgren, Jez Humble and Gene Kim, used with metric limitations.
- Kubernetes rollout and deployment documentation.
- Argo Rollouts/Flagger and Argo CD/Flux official documentation.
- OpenFeature and selected feature-management documentation.
- database migration and backward-compatibility references.

## Configuration and secrets

- twelve-factor configuration principles used critically.
- Kubernetes ConfigMap/Secret and external secret-provider documentation.
- selected secret manager and workload identity docs.
- certificate/token rotation references.
- configuration-schema and validation tooling docs.

## Operations and recovery

- Google SRE books: service levels, incident response, on-call, postmortems and error budgets.
- backup and restore documentation for PostgreSQL/object storage/Kubernetes components.
- disaster recovery and business-continuity references.
- vendor/runtime maintenance and upgrade docs.
- runbook and production-readiness review references.

## Incident management

- Google SRE incident-response and postmortem chapters.
- PagerDuty Incident Response documentation and similar public incident-command references.
- public status-page and incident-communication guidance.
- *The Field Guide to Understanding Human Error*, Sidney Dekker, optional for systems thinking.
- public incident reports only when sanitized and legally accessible.

## Delivery and reliability metrics

- Google SRE material on SLI, SLO, SLA and error budgets.
- DORA/Accelerate research and current metric definitions.
- SPACE framework as a warning against single-metric productivity evaluation.
- queueing and flow concepts for lead time and work in process.

## Rules for sources

1. Official specifications and tool documentation define version-specific behavior.
2. Books provide mental models and trade-offs, not immutable recipes.
3. A pipeline check must name the failure class it detects and what it cannot prove.
4. A deployment strategy is evaluated under actual workload, compatibility and recovery constraints.
5. Reliability targets require a measured user-facing indicator and time window.
6. Incident examples use public or synthetic data only.
7. Current CI, Kubernetes and GitOps behavior is verified against installed versions.
8. Provider or vendor recommendations are compared with simpler alternatives and ownership cost.
9. Do not copy paid course content, proprietary runbooks or private postmortems.
