# Спринт 18. State, backends, locking, import и migrations

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как protect and evolve Terraform state as a mapping between configuration addresses and remote resources, including concurrent access, imports, refactors and recovery?

## Результат спринта

После завершения необходимо уметь:

- понимать state resource instances, addresses and lineage;
- выбирать local and remote backends;
- использовать locking and versioning;
- защищать state encryption/access/backup;
- понимать workspace limitations and environment isolation alternatives;
- импортировать existing resources;
- использовать moved/import blocks or state operations appropriately;
- переименовывать modules/resources without recreation;
- переносить state between backends/modules;
- восстанавливать from state backup/version carefully;
- понимать refresh-only and state removal risks;
- обрабатывать partial apply and orphaned resources;
- разделять state by lifecycle, blast radius and access;
- избегать manual state editing as routine;
- тестировать migration before production-like cutover.

## Основной маршрут

1. Move local state to versioned remote/local-simulated backend with lock.
2. Trigger concurrent plan/apply and observe locking.
3. Import manually created resources into configuration.
4. Rename/reparent resources with moved/state migration.
5. Split one state into two ownership units and reconnect outputs/data contracts.
6. Corrupt/lose a copy and recover from backend version/backup in isolated clone.

## Ресурсы

- Terraform state, backend, import and refactoring docs.
- backend storage locking/versioning docs.
- provider import limitations.

## Лабораторная работа

Создать `work/terraform-state/`.

### Requirements

- remote backend access uses least privilege and locking;
- state is encrypted, versioned and excluded from Git/logs;
- environments with different permissions/blast radius use separate state;
- import configuration matches remote object before management;
- resource/module renames use explicit migration, not destroy/create;
- state split has output/consumer migration and rollback plan;
- concurrent write is rejected safely;
- partial apply and orphan reconciliation are demonstrated;
- restore is tested against copied/isolated backend, not overwriting active state blindly;
- state commands are scripted/recorded with before/after backups;
- credentials and sensitive values are redacted;
- cleanup leaves no unmanaged imported resource.

### Failure scenarios

1. Two operators apply without lock and overwrite state.
2. State backend is readable by broad user group.
3. Workspace is treated as strong account/security isolation.
4. `state rm` makes resource unmanaged and forgotten.
5. Import succeeds but configuration differs and next plan destroys/changes resource.
6. Resource/module rename triggers recreation.
7. State split breaks hidden dependency/output.
8. Backup is restored over newer valid state without remote comparison.
9. Provider partial success creates orphan not in state.

## Самопроверка

1. What does Terraform state map?
2. Backend versus state?
3. Locking protects what?
4. State versioning/backup purpose?
5. Workspaces limitations?
6. Import does what and not what?
7. Moved block/state move use?
8. How split state safely?
9. Partial apply/orphan recovery?
10. Why state is sensitive operational data?

## Результат для базы знаний

- **Terraform state model and resource addresses**.
- **Terraform remote backends, locking and versioning**.
- **Terraform import and adoption of existing resources**.
- **Terraform moved resources and state migration**.
- **Terraform state splitting and ownership boundaries**.
- **Terraform state recovery and orphan reconciliation**.

## Когда переходить дальше

Можно переходить, когда state is locked/versioned/recoverable, imports and renames avoid unintended replacement, and ownership can be split without losing dependency or rollback evidence.