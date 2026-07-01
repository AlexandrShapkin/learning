# Спринт 07. Merge safety, feedback и интеграция изменений

Ориентировочный объём: 16–23 часа.

## Центральный вопрос

Как keep main branch releasable while integrating small changes quickly, preventing stale validation, hidden coupling and long-lived branch divergence?

## Результат спринта

После завершения необходимо уметь:

- distinguish trunk-based development, short-lived branches and release branches;
- understand merge queue and stale-branch validation;
- keep changes small and independently reviewable;
- design required checks and branch protection;
- use merge commit, squash and rebase consciously;
- detect integration conflicts beyond textual merge conflict;
- use feature flags/branch by abstraction for incomplete work;
- separate code integration from release activation;
- manage generated files and dependency updates;
- define ownership and response for broken main;
- prioritize fast repair/revert over accumulating red builds;
- measure PR age, queue time and flaky/false failure burden;
- avoid approval theater and broad bypass paths.

## Основной маршрут

1. Configure protected main with required checks and review rules.
2. Reproduce two independently green branches that fail when combined.
3. Add merge queue or equivalent latest-main validation.
4. Split a large feature into small hidden/inactive increments.
5. Practice broken-main revert and forward repair.

## Ресурсы

- GitHub branch protection and merge queue docs.
- trunk-based development and continuous integration references.
- branch by abstraction and feature-flag material.

## Лабораторная работа

Создать `work/merge-safety/`.

### Requirements

- protected branch rejects stale/unvalidated merge;
- required checks correspond to named risks;
- merge queue serializes/retests combined changes;
- large feature is integrated in at least four releasable increments;
- inactive code has no unintended runtime path;
- generated/dependency updates are reproducible and reviewable;
- broken main triggers explicit owner, alert and repair policy;
- emergency bypass is scoped, audited and reconciled;
- PR wait/validation times are measured;
- one integration defect not visible in branch-only tests is reproduced.

### Failure scenarios

1. Two green branches break main when merged together.
2. Approval/check applies to old commit after new push.
3. Long-lived branch accumulates schema/API conflicts.
4. Main remains red while new merges continue.
5. Feature flag defaults expose incomplete behavior.
6. Squash removes useful change traceability or release metadata assumptions.
7. Generated file differs from source/generator state.
8. Admin bypass becomes normal release path.

## Самопроверка

1. Continuous integration means what operationally?
2. Trunk-based versus release branches?
3. Stale validation problem?
4. Merge queue purpose?
5. Textual versus semantic integration conflict?
6. Small batch value?
7. Branch by abstraction?
8. Broken-main policy?
9. Required check versus approval theater?
10. What delivery metrics reveal queue friction?

## Результат для базы знаний

- **Main-branch releasability and merge safety**.
- **Merge queues and stale validation**.
- **Small delivery batches and short-lived branches**.
- **Branch by abstraction for incremental integration**.
- **Broken-main response and branch-protection bypass**.

## Когда переходить дальше

Можно переходить, когда combined changes are validated against current main, unfinished work integrates without exposure, and a broken branch is repaired/reverted before flow continues.