# Спринт 17. Business, user и system requirements

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как связать business outcome, user need and system behavior without losing traceability or prematurely fixing implementation?

## Результат спринта

После завершения необходимо уметь:

- distinguish business, stakeholder, user and system requirements;
- trace requirements to process, rule and outcome;
- write observable user/system behavior;
- include quality, data, reporting and operational constraints;
- define acceptance and decision evidence;
- manage conflicts and priorities;
- represent assumptions and dependencies;
- analyze solution options and impacts;
- prevent requirement duplication and solution leakage;
- handle change and scope decisions.

## Основной маршрут

1. Derive requirements from one to-be process and product outcome.
2. Organize by business/user/system level.
3. Add data, exception and operational requirements.
4. Compare solution alternatives and impacts.

## Лабораторная работа

Создать `work/business-requirements/`.

### Requirements

- every business requirement links to outcome/constraint;
- user requirements identify role, context and needed capability;
- system requirements are observable and testable;
- rules and exceptions reference authoritative definitions;
- analytics/reporting requirements define decision use;
- quality constraints include context and threshold;
- conflicts and trade-offs are explicit;
- traceability uses links/IDs without copying text;
- changed requirement identifies process, data and adoption impact.

### Failure scenarios

1. Stakeholder request is copied as mandatory system feature.
2. User requirement is only a UI screen description.
3. Business outcome cannot be traced to acceptance evidence.
4. Reporting requirement has no decision owner.
5. Exception and migration requirements are absent.
6. Duplicate documents drift.

## Результат для базы знаний

- **Business, stakeholder, user and system requirements**.
- **Outcome-to-requirement traceability**.
- **Solution analysis and requirement trade-offs**.
- **Data, reporting and operational requirements**.

## Когда переходить дальше

Можно переходить, когда a business outcome can be traced through user needs to observable system behavior and acceptance evidence.