# Спринт 01. Моделирование и представление данных

Ориентировочный объём: 13–19 часов.

## Центральный вопрос

Как превратить факты, события и правила предметной области в устойчивую модель данных, которая сохраняет смысл при хранении, передаче и изменении схемы?

## Результат спринта

После завершения необходимо уметь:

- различать conceptual, logical and physical models;
- выделять entities, value objects, relationships and events;
- выбирать natural, surrogate and composite identifiers;
- формулировать invariants, cardinality, optionality and ownership;
- различать current state, history and event representation;
- моделировать time, money, units, enums and nullable/unknown values;
- выбирать row/document/event representation;
- понимать schema-on-write and schema-on-read;
- использовать JSON, CSV and binary formats с explicit schema;
- различать serialization, encoding and compression;
- проектировать backward/forward-compatible format evolution;
- учитывать duplication, derivation and source of truth;
- определять retention, deletion and audit requirements;
- выявлять ambiguous semantics before storage choice;
- создавать synthetic fixtures and validation rules.

## Основной маршрут

### Шаг 1. Domain facts and identity

Для каждого concept определить:

```text
what is identified
which attributes define identity
which facts may change
which facts are historical
which relationships are owned/referenced
which invariants cross records
```

Не выбирать UUID, database or document shape до определения semantics.

### Шаг 2. Logical representation

Сравнить normalized relations, nested document, key-value record, append-only event, graph nodes/edges and analytical fact/dimension model.

### Шаг 3. Types and missing values

Разобрать absent versus null versus zero, decimal money, timestamps/time zones, units, enum evolution, opaque IDs and Unicode normalization.

### Шаг 4. Serialization and evolution

Создать versioned schema и проверить add/rename/deprecate/widen/split changes на старых и новых consumers.

## Ресурсы

### Обязательный маршрут

- DDIA chapters on data models and encoding/evolution.
- Database textbook ER/logical-model sections.
- JSON RFC and Protocol Buffers schema-evolution overview.
- PostgreSQL data types documentation for concrete comparison.

### Углубление

- temporal/bitemporal modeling;
- event sourcing;
- schema registries;
- data contracts and governance.

## Практические задания

1. Model order, payment, inventory and shipment without choosing storage.
2. Identify invariants that fit one record versus cross-record transaction.
3. Compare state snapshot and event history for the same lifecycle.
4. Design JSON v1/v2/v3 and compatibility tests.
5. Find ambiguity in null/zero/absent, time zone and money examples.

## Лабораторная работа

Создать `work/data-contract/`.

### Domain

Synthetic multi-tenant order-processing data: tenant, customer, product, order, line, payment, shipment, status transition and audit event.

### Requirements

- conceptual diagram and relational/document/event logical variants;
- Go typed model and validators;
- deterministic fixture generator;
- identity and uniqueness explicit;
- money stored with currency and exact units;
- timestamps define time-zone semantics;
- unknown/missing/null policy tested;
- derived fields identify source and recomputation rule;
- tenant ownership cannot be ambiguous;
- versioned payloads decode old fixtures;
- invalid combinations rejected;
- lifecycle/retention matrix included.

### Failure scenarios

1. Mutable natural key used as immutable identity.
2. Money represented by float.
3. Local timestamp lacks zone semantics.
4. Optional field breaks old consumer.
5. Required field added without migration/default.
6. Derived total diverges from line items.
7. Deletion leaves unclear audit/retention behavior.
8. Nested document duplicates facts with no update policy.
9. Null means several different states.

## Самопроверка

1. Conceptual versus logical versus physical model?
2. Identity versus attributes?
3. Natural versus surrogate key?
4. State versus event?
5. Null/absent/zero difference?
6. Schema-on-write versus schema-on-read?
7. Serialization versus encoding?
8. Backward versus forward compatibility?
9. What is source of truth?
10. How retention affects model?

## Результат для базы знаний

- **Conceptual, logical and physical data models**.
- **Entity identity and identifiers**.
- **Data invariants and cardinality**.
- **State, history and events**.
- **Missing/null/zero semantics**.
- **Data types for money and time**.
- **Serialization schema evolution**.
- **Source of truth and derived data**.

## Когда переходить дальше

Можно переходить, когда domain invariants and identity are explicit, old/new payload compatibility is tested, and storage choice is still separable from logical meaning.