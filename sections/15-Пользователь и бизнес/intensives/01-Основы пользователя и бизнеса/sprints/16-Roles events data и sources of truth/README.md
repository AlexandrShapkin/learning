# Спринт 16. Roles, events, data и sources of truth

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Какие роли, события и данные формируют процесс, and which system or authority owns each business fact?

## Результат спринта

После завершения необходимо уметь:

- define domain vocabulary with business participants;
- distinguish role, actor, organization and permission;
- identify business events and state transitions;
- map data creation, use, correction and retirement;
- determine authoritative source versus copied view;
- identify conflicting identifiers and definitions;
- model responsibility for data quality;
- distinguish event time, processing time and effective time;
- document reconciliation and correction paths;
- avoid “single source of truth” slogans without scope.

## Основной маршрут

1. Create glossary for the field-service domain.
2. Map roles, events and state transitions.
3. Inventory critical data elements and authorities.
4. Reconcile one conflicting status/identifier definition.

## Лабораторная работа

Создать `work/domain-data-authority/`.

### Requirements

- glossary terms have business meaning and examples;
- events name completed facts, actor/context and effective time;
- state transitions include invalid and recovery paths;
- each critical datum has creator, steward and authoritative source;
- copies/views have freshness and reconciliation rules;
- identifiers and matching logic are explicit;
- corrections preserve history where required;
- analytics definitions use the same or mapped vocabulary.

### Failure scenarios

1. “Customer”, “job” or “completed” means different things to teams.
2. Reporting database becomes authority unintentionally.
3. Copied status is stale with no reconciliation.
4. Event timestamp reflects processing, not actual occurrence.
5. Data-quality issue has no owner.
6. Correction overwrites history needed for audit/analysis.

## Результат для базы знаний

- **Business domain vocabulary and shared definitions**.
- **Business events and state transitions**.
- **Authoritative data sources and derived views**.
- **Data stewardship, correction and reconciliation**.

## Когда переходить дальше

Можно переходить, когда critical facts and states have consistent definitions, owners and reconciliation paths across process, system and analytics.