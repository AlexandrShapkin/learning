# Спринт 14. As-is и to-be business processes

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как устроена работа сейчас, где возникают ожидание, ошибки и обходы, and what exactly changes in the target process?

## Результат спринта

После завершения необходимо уметь:

- define process scope, trigger, outcome and owner;
- model as-is actors, activities, events, decisions and handoffs;
- distinguish value-adding, control, wait and rework steps;
- represent exceptions and alternative paths;
- use BPMN/value-stream/service-blueprint concepts appropriately;
- identify bottlenecks and policy constraints;
- design to-be process with explicit assumptions;
- compare automation, simplification and elimination;
- avoid automating a broken process unchanged.

## Основной маршрут

1. Observe/model request-to-completion as-is flow.
2. Measure handoffs, wait, rework and exceptions.
3. Identify causes and constraints.
4. Design two to-be alternatives.
5. Compare transition and risk.

## Лабораторная работа

Создать `work/business-processes/`.

### Requirements

- process has clear start, end, customer and owner;
- model includes manual/offline work and exceptions;
- wait/rework/handoffs are visible;
- data and decision points are linked to sources;
- metrics distinguish touch time and total elapsed time;
- to-be removes or simplifies at least one step before automating;
- roles and controls change explicitly;
- transition risks and coexistence period are documented.

### Failure scenarios

1. Process map shows only system screens.
2. Ideal policy is modeled instead of actual work.
3. Exceptions are omitted as rare.
4. Automation preserves unnecessary approvals.
5. To-be removes a control without understanding its purpose.
6. Process owner and outcome are undefined.

## Результат для базы знаний

- **As-is and to-be business-process modeling**.
- **Process triggers, outcomes and ownership**.
- **Handoffs, wait, rework and exceptions**.
- **Process simplification versus automation**.

## Когда переходить дальше

Можно переходить, когда actual and target work are distinguishable, exceptions and controls are visible, and every proposed change has an outcome and transition risk.