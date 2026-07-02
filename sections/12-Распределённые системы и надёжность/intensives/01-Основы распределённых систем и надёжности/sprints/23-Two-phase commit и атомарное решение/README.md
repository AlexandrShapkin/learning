# Спринт 23. Two-phase commit и атомарное решение

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как несколько участников принимают одно commit/abort decision, и почему coordinator failure can block progress?

## Результат спринта

После завершения необходимо уметь:

- различать local transaction and distributed atomic commit;
- понимать prepare and commit/abort phases;
- identify coordinator and participant durable state;
- explain blocking under uncertain decision;
- handle duplicate prepare/commit/abort messages idempotently;
- distinguish 2PC from consensus;
- understand presumed abort/commit concepts at overview level;
- model heuristic/manual recovery risks;
- account for locks/resource retention during prepare;
- decide when 2PC is justified versus workflow/saga;
- instrument transaction ID, participant state and decision log.

## Основной маршрут

1. Implement educational coordinator with two participants.
2. Crash coordinator before and after durable decision.
3. Drop commit message to one participant.
4. Restart participants/coordinator from logs.
5. Compare blocking and operator recovery.

## Лабораторная работа

Создать `work/two-phase-commit/`.

### Requirements

- transaction IDs and participant sets are stable;
- prepare records are durable before vote-yes;
- coordinator decision is durable before notification;
- repeated messages are idempotent;
- participant in prepared state does not guess conflicting outcome;
- recovery reads authoritative decision log where available;
- timeouts trigger uncertainty/escalation, not unilateral unsafe commit;
- locks/resources held during prepare are measured;
- one scenario demonstrates why consensus-backed coordinator improves availability but does not remove 2PC semantics;
- suitability decision compares local transaction, 2PC and saga.

### Failure scenarios

1. Participant votes yes before durable prepare.
2. Coordinator tells one commit and another abort.
3. Commit decision is lost after acknowledgement.
4. Prepared participant times out and aborts while another commits.
5. Duplicate commit applies effect twice.
6. Coordinator becomes a single failure domain.
7. Long prepare blocks resources and propagates outage.

## Результат для базы знаний

- **Distributed atomic commit and two-phase commit**.
- **2PC coordinator and participant recovery**.
- **Prepared-state blocking and uncertainty**.
- **2PC versus consensus**.
- **Distributed transaction IDs and idempotent decisions**.

## Когда переходить дальше

Можно переходить, когда every crash point reconstructs one durable decision or explicit blocked uncertainty without conflicting participant outcomes.