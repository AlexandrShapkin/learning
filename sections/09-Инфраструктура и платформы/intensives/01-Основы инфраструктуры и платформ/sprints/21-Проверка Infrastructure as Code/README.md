# Спринт 21. Проверка Infrastructure as Code

Ориентировочный объём: 14–21 час.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 16–20.

## Исходная задача

Создать `work/iac-checkpoint/` — Terraform-managed VM/container/cloud-like foundation with remote state, modules, configuration management, policy and drift workflow.

## Required components

- network module;
- compute/VM module;
- storage module;
- image/bootstrap/configuration path;
- environment composition;
- remote versioned state and lock;
- CI-like plan/policy/test workflow;
- post-apply probes;
- destroy/orphan verification.

## Required changes

1. Rename/reorganize a resource/module without recreation.
2. Import an existing resource.
3. Split one state ownership boundary.
4. Rotate/upgrade an image or provider safely.
5. Add a second environment or region/provider alias.
6. Adopt or revert an emergency out-of-band change.

## Mandatory fault cases

1. Concurrent apply.
2. State/backend permission loss.
3. Secret appears in plan/state.
4. Stale approved plan.
5. Provider upgrade changes behavior.
6. `count` reindex replaces unrelated resource.
7. Partial apply creates orphan.
8. Import configuration mismatch.
9. Moved resource is omitted and replacement appears.
10. cloud-init/config management fails midway.
11. Policy misses destructive/public exposure case.
12. Destroy leaves disk/IP/snapshot or targets wrong environment and is refused.

## Defense

1. What is authoritative: code, state or remote API?
2. How does Terraform graph dependencies?
3. What makes module boundary useful?
4. How are provider versions/aliases controlled?
5. How are state and locking protected?
6. How are imports and moved resources handled?
7. What belongs in image, bootstrap and config management?
8. What does plan review prove and not prove?
9. How are policies and tests layered?
10. How is drift reconciled?
11. How is partial apply recovered?
12. How does cleanup prove ownership and completeness?

## Критерии прохождения

- clean init/plan/apply recreates the foundation;
- module contracts and stable resource addresses are explicit;
- state is encrypted/versioned/locked and excluded from Git;
- all six required changes avoid unintended replacement or document it;
- plan/policy/test/post-check pipeline catches named unsafe changes;
- all twelve faults are diagnosed and recovered;
- destroy refuses wrong target and finds no orphan;
- at least 10 of 12 defense answers use state/plan/provider evidence.

## Результат для базы знаний

Checkpoint-specific note не требуется. Update notes where state migration, provider behavior or drift evidence changed prior assumptions.