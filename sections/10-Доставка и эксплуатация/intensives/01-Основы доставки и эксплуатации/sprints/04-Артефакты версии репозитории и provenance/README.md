# Спринт 04. Артефакты, версии, репозитории и provenance

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Как store, identify, verify, promote and retire release artifacts so that mutable names, registry state and metadata cannot silently change what is deployed?

## Результат спринта

После завершения необходимо уметь:

- различать source version, artifact version and deployment revision;
- use semantic/calendar/commit-derived versions appropriately;
- understand tags, digests, immutable repositories and promotion;
- design artifact repository namespaces and retention;
- generate SBOM and provenance attestations;
- sign and verify artifacts with scoped identity/key model;
- understand signature, provenance and trust-policy limits;
- attach release metadata without mutating artifact;
- promote by reference/copy while preserving digest;
- prevent rebuild-per-environment;
- handle revocation/quarantine and compromised artifact;
- clean safely without deleting referenced releases.

## Основной маршрут

1. Publish binary/archive and OCI image to local repositories.
2. Assign human-readable version and immutable digest.
3. Generate SBOM, provenance and signature.
4. Promote one digest through dev/staging/production-like channels.
5. Retag a mutable name and demonstrate why deployment verification must use digest.

## Ресурсы

- OCI Distribution specification and registry docs.
- SLSA, SPDX/CycloneDX and Sigstore/Cosign docs.
- semantic versioning and repository retention references.

## Лабораторная работа

Создать `work/artifact-management/`.

### Requirements

- artifact names include product/version/platform and immutable digest;
- registry/repository rejects or detects mutable release-tag overwrite;
- build once and promote the same digest;
- SBOM references exact artifact digest;
- provenance includes source, builder/workflow and declared inputs;
- signature verification uses trusted identity/key policy;
- release metadata/changelog is stored separately from immutable bytes;
- quarantine/revocation prevents new deployment while retaining evidence;
- retention preserves currently deployed and rollback-needed artifacts;
- cleanup checks references before deletion;
- repository credentials are scoped and not embedded in artifacts.

### Failure scenarios

1. Release tag is overwritten after staging approval.
2. Each environment rebuilds from same source but receives different bytes.
3. SBOM belongs to source tree, not final artifact.
4. Signature is valid but signer identity/workflow is untrusted.
5. Provenance references wrong commit or reusable workflow.
6. Registry garbage collection removes rollback artifact.
7. Vulnerable/compromised artifact remains deployable by mutable alias.
8. Release notes are embedded by rebuilding image.

## Самопроверка

1. Source, artifact and deployment versions?
2. Tag versus digest?
3. Artifact promotion versus rebuild?
4. SBOM provides what?
5. Provenance provides what?
6. Signature proves what and not what?
7. Trust policy role?
8. Quarantine/revocation?
9. Retention versus rollback needs?
10. How prevent unsafe garbage collection?

## Результат для базы знаний

- **Software artifact versions and immutable identifiers**.
- **Artifact repositories and promotion**.
- **SBOM and artifact provenance**.
- **Artifact signatures and trust policy**.
- **Artifact quarantine, retention and garbage collection**.

## Когда переходить дальше

Можно переходить, когда the exact artifact approved in staging is verifiably the one deployed later, with immutable digest, SBOM, provenance, signature and retention ownership.