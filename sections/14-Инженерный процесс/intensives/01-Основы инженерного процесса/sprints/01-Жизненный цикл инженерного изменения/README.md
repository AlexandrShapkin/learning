# Спринт 01. Жизненный цикл инженерного изменения

Ориентировочный объём: 15–22 часа.

## Центральный вопрос

Какие состояния проходит изменение от наблюдаемой проблемы до эксплуатации и последующего улучшения?

## Результат спринта

После завершения необходимо уметь:

- описывать discovery, decision, implementation, verification, release, operation and learning;
- различать product lifecycle and change lifecycle;
- определять входы, выходы и evidence каждого этапа;
- понимать feedback loops and handoffs;
- различать status from actual system state;
- находить queues, rework and waiting;
- определять completion beyond “code merged”.

## Основной маршрут

1. Trace one existing feature from request to operation.
2. Draw its change-state model.
3. Mark decisions, evidence, queues and feedback loops.
4. Identify one missing closure step.

## Лабораторная работа

Создать `work/change-lifecycle/`.

### Requirements

- lifecycle begins with observable need/problem;
- every state has entry/exit evidence;
- implementation, integration, release and adoption are separate;
- rejected/canceled/rolled-back paths are represented;
- operational feedback returns to discovery;
- one handoff and one queue are measured;
- “done” includes verification and context update.

### Failure scenarios

1. Work starts from solution with no problem statement.
2. Merge is treated as delivery.
3. Release has no adoption/impact verification.
4. Canceled work remains active indefinitely.
5. Feedback is collected but not routed to a decision.
6. Ownership disappears after implementation.

## Результат для базы знаний

- **Engineering change lifecycle**.
- **Discovery, delivery and operation feedback loops**.
- **Change states and completion evidence**.
- **Handoffs, queues and rework**.

## Когда переходить дальше

Можно переходить, когда one change can be reconstructed end to end through states, decisions and evidence rather than ticket labels.