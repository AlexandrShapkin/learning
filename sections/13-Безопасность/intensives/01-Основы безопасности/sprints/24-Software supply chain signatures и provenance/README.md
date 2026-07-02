# Спринт 24. Software supply chain, signatures и provenance

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как доказать, что artifact was built from intended source and process, and prevent substitution across source, build, registry and deployment boundaries?

## Результат спринта

После завершения необходимо уметь:

- map source-to-build-to-artifact-to-deploy trust chain;
- distinguish digest, checksum, signature, attestation and provenance;
- sign OCI artifacts and verify identity/policy;
- generate SBOM and provenance for exact artifact;
- understand keyless versus key-based signing trade-offs;
- pin actions/builders/images by immutable identity;
- protect build isolation and untrusted pull-request boundaries;
- enforce artifact promotion rather than rebuild;
- detect mutable tags and registry substitution;
- define verification at admission/deployment.

## Основной маршрут

1. Build one immutable OCI artifact.
2. Generate SBOM and provenance attestation.
3. Sign artifact with local/keyless simulation.
4. Verify digest, signer identity and predicate.
5. Substitute tag/artifact and demonstrate policy rejection.

## Лабораторная работа

Создать `work/supply-chain/`.

### Requirements

- build inputs and builder identity are recorded;
- artifact, SBOM and provenance share exact digest;
- signing identity and trust root are explicit;
- verification checks artifact digest, signer and expected repository/workflow context;
- mutable tags are not accepted as deployment identity;
- pull-request code cannot access production signing/deploy credentials;
- dependencies/actions/build images are pinned and reviewed;
- promotion reuses artifact rather than rebuilding;
- admission/deploy policy rejects unsigned, mismatched or unknown provenance;
- key/signing compromise response is documented.

### Failure scenarios

1. Signature is valid but signer/repository context is not checked.
2. SBOM/provenance belongs to another digest.
3. Mutable tag is changed after approval.
4. PR workflow receives signing/deployment secret.
5. Build action/image changes through mutable reference.
6. Artifact is rebuilt separately per environment.
7. Compromised signing key remains trusted indefinitely.

## Результат для базы знаний

- **Software supply-chain trust boundaries**.
- **Artifact digests, signatures and attestations**.
- **Build provenance and SBOM linkage**.
- **Immutable artifact promotion**.
- **Supply-chain verification and admission policy**.

## Когда переходить дальше

Можно переходить, когда substituted artifacts, mismatched attestations and untrusted build identities are rejected before deployment.