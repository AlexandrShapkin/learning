# Спринт 27. Roles, ownership и team interfaces

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как распределить responsibilities and interfaces между ролями и командами так, чтобы решения не терялись между ownership gaps и excessive coordination?

## Результат спринта

После завершения необходимо уметь:

- distinguish responsibility, accountability, consultation and execution;
- define system/component/service ownership;
- map team APIs, dependencies and service expectations;
- choose RACI/DACI-like models only when useful;
- identify unclear and overlapping decision rights;
- reduce handoffs through end-to-end ownership;
- define escalation and exception paths;
- manage shared/platform ownership;
- recognize cognitive-load and coordination costs;
- design ownership changes and decommissioning.

## Основной маршрут

1. Map roles and decisions for the synthetic product.
2. Define interfaces between product, platform, security and operations roles.
3. Resolve one ownership gap and one overlap.
4. Simulate a cross-team change and escalation.

## Лабораторная работа

Создать `work/roles-interfaces/`.

### Requirements

- critical systems/decisions have one accountable owner and backups;
- consumers know how to request/change/escalate through team interface;
- shared responsibilities are decomposed into explicit decisions/tasks;
- handoffs have entry/exit evidence;
- platform/shared team provides self-service where repeated demand justifies it;
- ownership matches capability and cognitive load;
- exception/emergency path is bounded;
- decommissioning transfers/removes access, docs and obligations.

### Failure scenarios

1. Everyone is responsible, so no one decides.
2. Two teams both believe the other owns production behavior.
3. Platform team becomes ticket queue for routine changes.
4. Architecture/security review has veto but no response expectation.
5. Component ownership ignores end-to-end outcome.
6. Ownership transfer leaves access/docs/escalation stale.

## Результат для базы знаний

- **Engineering roles, responsibility and accountability**.
- **Team interfaces and team APIs**.
- **End-to-end ownership and handoffs**.
- **Shared/platform ownership and cognitive load**.

## Когда переходить дальше

Можно переходить, когда one cross-team change has explicit decision rights, service interfaces and escalation without ownerless gaps or redundant approval layers.