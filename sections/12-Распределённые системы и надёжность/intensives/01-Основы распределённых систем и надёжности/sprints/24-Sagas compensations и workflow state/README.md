# Спринт 24. Sagas, compensations и workflow state

Ориентировочный объём: 20–29 часов.

## Центральный вопрос

Как координировать длительный бизнес-процесс между сервисами, если единая атомарная транзакция невозможна или нежелательна?

## Результат спринта

После завершения необходимо уметь:

- различать choreography and orchestration;
- моделировать saga as durable state machine;
- определять forward and compensation steps;
- понимать compensation is not rollback;
- design idempotent commands/events for every step;
- handle duplicate, delayed and out-of-order callbacks;
- persist workflow state and attempt history;
- define timeout, retry, escalation and manual-intervention states;
- preserve business invariants through reservations and confirmations;
- recover stuck workflows;
- distinguish semantic failure from transport failure;
- expose user-visible process status.

## Основной маршрут

1. Implement order → reserve → charge → fulfill workflow.
2. Create orchestration and choreography variants.
3. Fail each step before/after effect and response.
4. Add compensations and one irreversible effect.
5. Recover an abandoned/stuck workflow after restart.

## Лабораторная работа

Создать `work/sagas/`.

### Requirements

- workflow state machine and terminal/intermediate states are explicit;
- every step/compensation has operation and attempt identity;
- state transition is durable before/with command publication;
- reservations have expiry and ownership;
- compensation is idempotent and may itself fail/retry;
- irreversible step changes recovery policy;
- old/duplicate callback cannot move workflow backward incorrectly;
- manual intervention has evidence, owner and reconciliation path;
- user status distinguishes pending, failed, compensating and completed;
- workflow history supports replay/diagnosis without re-executing effects.

### Failure scenarios

1. Charge succeeds but response is lost.
2. Compensation runs twice.
3. Late success arrives after compensation.
4. Reservation expires while later step completes.
5. Orchestrator crashes after state change but before command publication.
6. Choreography forms an invisible event cycle.
7. Manual fix leaves workflow state inconsistent.
8. Compensation cannot undo external shipment/notification.

## Результат для базы знаний

- **Distributed sagas and long-running workflows**.
- **Saga orchestration and choreography**.
- **Compensating actions versus rollback**.
- **Durable workflow state and recovery**.
- **Reservations, irreversible steps and manual intervention**.

## Когда переходить дальше

Можно переходить, когда every step can be retried/recovered and the workflow reaches a valid terminal or explicit intervention state under crashes and late callbacks.