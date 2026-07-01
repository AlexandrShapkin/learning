# Спринт 01. Путь изменения, delivery value stream и риски

Ориентировочный объём: 14–20 часов.

## Центральный вопрос

Как программное изменение проходит от идеи и commit до работающего поведения, и где на этом пути возникают очереди, ручные передачи, необратимые действия и риски отказа?

## Результат спринта

После завершения необходимо уметь:

- различать change, build, artifact, release, deployment and operation;
- строить delivery value-stream map;
- измерять active time, waiting time and lead time;
- определять source of truth at each stage;
- находить handoffs, queues, batch sizes and approval delays;
- классифицировать change risk by code, data, configuration and infrastructure;
- различать reversible and irreversible changes;
- определять feedback loop and detection latency;
- связывать ownership with build, artifact, environment and runtime state;
- понимать why deployment frequency alone is insufficient;
- формулировать completion evidence for every stage;
- проектировать one traceable change identifier through the whole path.

## Основной маршрут

1. Take one synthetic feature and map every state from branch to production-like behavior.
2. Record actor, input, output, waiting time, automation and rollback/repair option.
3. Mark where the artifact or configuration can change without source revision.
4. Repeat for a database migration and urgent defect fix.

## Ресурсы

- Continuous Delivery introductory chapters.
- value-stream and flow material from Accelerate/DORA.
- GitHub Actions and deployment-environment concepts.

## Лабораторная работа

Создать `work/change-flow/`.

### Requirements

- one end-to-end map for feature, defect and data change;
- each stage names source, owner, evidence and retention;
- one change ID appears in commit, build metadata, artifact and deployment;
- active/waiting time and queue causes are measured;
- manual steps are classified as useful control or accidental handoff;
- irreversible state changes are identified;
- three highest risks receive an experiment or guard proposal;
- baseline lead time is reproducible from synthetic workflow.

### Failure scenarios

1. Build output cannot be traced to exact source and dependency state.
2. Environment is changed manually after deployment.
3. Approval occurs before the actual artifact is known.
4. Database migration is treated as ordinary reversible code deployment.
5. Hotfix bypasses provenance and remains unreconciled.
6. Waiting time is hidden because only pipeline runtime is measured.
7. “Done” means merged although artifact was never deployed or verified.
8. Multiple teams/tools own the same state ambiguously.

## Самопроверка

1. Change, release and deployment differences?
2. Active time versus lead time?
3. What is a delivery handoff?
4. Why batch size matters?
5. Reversible versus irreversible change?
6. Source of truth at each stage?
7. Feedback-loop latency?
8. What makes a change traceable?
9. Why deployment frequency is not enough?
10. What evidence marks stage completion?

## Результат для базы знаний

- **Software delivery value stream**.
- **Change, release and deployment**.
- **Delivery queues, handoffs and batch size**.
- **Reversible and irreversible software changes**.
- **End-to-end change traceability**.

## Когда переходить дальше

Можно переходить, когда one change is traceable through source, build, artifact, environment and runtime, and the main waiting/risk points are measured rather than assumed.