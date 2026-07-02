# Спринт 25. Проверка координации и распределённых операций

Ориентировочный объём: 15–22 часа.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 21–24.

## Исходная задача

Создать `work/coordination-checkpoint/` — coordinated subsystem with leases/fencing, educational consensus, one atomic-commit case and one saga workflow.

## Required capabilities

- lease acquisition/renewal/expiry;
- fencing at protected resource;
- leader terms/log/commit evidence;
- durable 2PC coordinator/participant state;
- durable saga state machine and compensations;
- operation/attempt/epoch identities;
- randomized fault schedule and invariant checker.

## Mandatory fault cases

1. Lease holder pauses past expiration and resumes.
2. Old holder attempts write with stale fencing token.
3. Two leader candidates appear under partition.
4. Old leader has divergent uncommitted log.
5. Node loses vote/term state on restart.
6. 2PC coordinator crashes before durable decision.
7. Participant remains prepared after timeout.
8. Duplicate commit/abort message arrives.
9. Saga step succeeds but response/event is lost.
10. Compensation fails or is duplicated.
11. Late success arrives after compensation.
12. Manual intervention diverges from workflow state.

## Defense

1. Lock versus lease?
2. Why is fencing required?
3. Leader election versus consensus?
4. Committed versus appended log entry?
5. Majority and minority behavior?
6. 2PC durable states and blocking?
7. 2PC versus consensus?
8. Saga versus atomic commit?
9. Compensation versus rollback?
10. How are late/duplicate callbacks handled?
11. Which invariants require coordination?
12. Where can coordination be removed?

## Критерии прохождения

- stale lease holders and leaders cannot mutate authoritative state;
- consensus simulation preserves committed-log safety;
- 2PC crash points produce one decision or explicit blocked uncertainty;
- saga reaches valid terminal/intervention state under late/duplicate events;
- all twelve faults are reproduced and diagnosed;
- invariants are checked over randomized schedules;
- at least 10 of 12 defense answers cite terms, tokens, logs or workflow histories;
- cleanup removes leases, coordinators, topics and test state.

## Результат для базы знаний

Checkpoint-specific note не требуется. Update coordination notes where implementation evidence clarified safety or liveness limits.