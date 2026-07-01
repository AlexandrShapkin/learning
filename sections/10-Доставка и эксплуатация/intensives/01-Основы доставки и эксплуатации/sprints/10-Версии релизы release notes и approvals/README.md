# Спринт 10. Версии, релизы, release notes и approvals

Ориентировочный объём: 16–23 часа.

## Центральный вопрос

Как form a release from verified artifacts and changes so that version meaning, compatibility, approvals, notes and support state remain traceable?

## Результат спринта

После завершения необходимо уметь:

- distinguish artifact version, release version and deployment revision;
- choose semantic, calendar or commit-derived versioning;
- define compatibility and deprecation metadata;
- generate release notes from change records while preserving editorial meaning;
- identify release contents by artifact digests;
- use release candidates and promotion channels;
- design approvals after evidence and before mutation;
- separate technical approval from product/business release decision;
- record known risks, migrations and rollback/repair limits;
- manage hotfix and patch release lineage;
- sign/attest release manifest;
- deprecate and retire supported versions.

## Основной маршрут

1. Create release manifest for one version.
2. Generate and edit release notes from merged changes.
3. Promote release candidate without rebuilding.
4. Produce one patch/hotfix and preserve lineage.
5. Retire an old version after usage/rollback checks.

## Лабораторная работа

Создать `work/release-management/`.

### Requirements

- release manifest lists binaries/images, digests, SBOM/provenance/signatures;
- version policy states compatibility meaning and exceptions;
- release notes separate user-visible changes, operator actions, migrations and known issues;
- approval references exact release manifest and evidence;
- release candidate and final release use identical artifact bytes;
- hotfix starts from known supported source/artifact line and is merged back;
- deprecation includes usage evidence, date/trigger and migration path;
- unsupported/revoked releases cannot be newly deployed;
- release metadata is immutable or superseded with audit history;
- no approval is granted to a mutable tag or unspecified artifact.

### Failure scenarios

1. Version tag points to different artifact later.
2. Release notes list commits but omit operator migration.
3. Approval happens before final artifacts/tests exist.
4. RC is rebuilt for final release.
5. Hotfix is not reconciled into main.
6. Semantic major/minor/patch meaning does not match compatibility policy.
7. Old release is deleted while rollback/support still needs it.
8. “Approved” does not name approver scope or evidence.

## Результат для базы знаний

- **Software release manifests and artifact sets**.
- **Release versioning and compatibility meaning**.
- **Release candidates and immutable promotion**.
- **Release notes for users and operators**.
- **Release approvals, hotfixes and deprecation**.

## Когда переходить дальше

Можно переходить, когда a release is an immutable signed set of artifacts and metadata, with evidence-based approval, operator instructions and clear support/deprecation state.