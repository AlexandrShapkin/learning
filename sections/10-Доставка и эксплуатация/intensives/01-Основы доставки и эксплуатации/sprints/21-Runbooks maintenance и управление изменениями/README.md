# Спринт 21. Runbooks, maintenance и управление изменениями

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Как превратить повторяемые operational tasks and risky changes into executable procedures with preconditions, verification and recovery rather than tribal knowledge?

## Результат спринта

После завершения необходимо уметь:

- distinguish runbook, playbook, checklist and automation;
- write preconditions, permissions, commands, expected results and stop criteria;
- include rollback/forward-repair and cleanup;
- design routine maintenance windows and communication;
- classify standard, normal and emergency changes pragmatically;
- use peer review and dry runs for risky procedures;
- automate stable steps without hiding decision points;
- keep runbooks close to code/versioned systems;
- verify responder access and tool availability;
- retire obsolete procedures;
- record execution evidence and deviations;
- avoid copy-paste commands against wrong environment.

## Основной маршрут

1. Choose certificate rotation, dependency upgrade, node maintenance and data cleanup tasks.
2. Write first runbooks from observed execution.
3. Execute by another operator without oral guidance.
4. Automate deterministic steps and preserve decision gates.
5. Introduce wrong-environment and partial-failure cases.

## Лабораторная работа

Создать `work/operational-runbooks/`.

### Requirements

- each runbook names scope, owner, risk, prerequisites and exact target verification;
- commands are idempotent or state expected repeated behavior;
- checkpoints define continue/stop/recover criteria;
- required permissions/tools are tested before mutation;
- maintenance communication and service impact are included;
- emergency path records deviations and reconciliation;
- automated scripts require environment marker and dry-run where possible;
- post-check verifies user path, state and cleanup;
- execution produces concise timestamped evidence;
- stale runbook is detected by version/dependency checks.

### Failure scenarios

1. Operator runs correct command against wrong environment.
2. Procedure assumes access/tool not available during incident.
3. Partial step is repeated and duplicates/destructively changes state.
4. Rollback section says only “restore backup” without target/procedure.
5. Automation hides an unsafe decision.
6. Maintenance completes but service verification is absent.
7. Emergency change remains outside desired state.
8. Obsolete runbook references removed API/resource.

## Результат для базы знаний

- **Operational runbooks, playbooks and checklists**.
- **Maintenance windows and change procedures**.
- **Runbook preconditions, stop criteria and verification**.
- **Emergency changes and source reconciliation**.
- **Operational automation and decision boundaries**.

## Когда переходить дальше

Можно переходить, когда another operator can execute and recover a risky maintenance task using only the versioned procedure and available evidence.