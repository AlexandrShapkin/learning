# Спринт 08. Проверка сборки и CI

Ориентировочный объём: 14–21 час.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 01–07.

## Исходная задача

Создать `work/build-ci-checkpoint/` — complete build and CI route for the reference service from clean source checkout to immutable verified release artifact.

## Required stages

- source/dependency/toolchain validation;
- deterministic binary and OCI builds;
- unit, integration, contract and migration checks;
- static/race/fuzz or equivalent risk checks;
- SBOM, provenance, signature and checksum;
- immutable artifact publication;
- pull-request, main and release workflows;
- protected merge and stale-branch validation;
- retention and cleanup.

## Required experiments

1. Build twice on two isolated builders.
2. Corrupt or poison cache and prove result remains trustworthy.
3. Change one indirect dependency and trace artifact/SBOM difference.
4. Attempt privileged action from untrusted PR.
5. Race two releases/deploy publications.
6. Merge two independently green but incompatible branches.

## Mandatory fault cases

1. Untracked/generated input changes build.
2. Mutable base/action/dependency tag changes result.
3. Timestamp/path introduces byte difference.
4. Test retry hides deterministic defect.
5. Cache contains stale or malicious object.
6. PR workflow receives privileged secret/token.
7. Artifact is modified after checksum/signature.
8. Release tag is overwritten.
9. Old slower workflow publishes after newer commit.
10. Stale branch approval/check is reused.
11. Registry retention removes needed artifact.
12. Release artifact cannot be mapped to exact source/workflow.

## Defense

1. What are complete build inputs?
2. Deterministic versus reproducible build?
3. Cache, workflow artifact and release repository differences?
4. What do digest, SBOM, provenance and signature prove?
5. Which gates belong before merge versus release?
6. How are untrusted and privileged workflows separated?
7. Why immutable action/tool revisions matter?
8. How is stale merge/release prevented?
9. How are retries and flakes handled?
10. What proves build-once promotion readiness?
11. How is artifact retention determined?
12. How is the entire change traceable?

## Критерии прохождения

- two isolated builders produce identical or fully explained outputs;
- exact artifact is signed, published and immutable;
- PR/main/release workflows have distinct trust and permission boundaries;
- quality gates map to named failure classes;
- merge queue/latest-main validation catches combined defect;
- all twelve faults are reproduced or prevented with evidence;
- cache deletion/poisoning affects speed, not trustworthy result;
- cleanup preserves referenced artifacts and removes temporary data;
- at least 10 of 12 defense answers are evidence-based.

## Результат для базы знаний

Checkpoint-specific note не требуется. Update existing notes where implementation evidence changes assumptions about reproducibility, CI trust or artifact verification.