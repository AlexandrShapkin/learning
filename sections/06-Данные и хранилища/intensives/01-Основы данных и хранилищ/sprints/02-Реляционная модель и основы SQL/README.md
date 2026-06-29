# Спринт 02. Реляционная модель и основы SQL

Ориентировочный объём: 15–22 часа.

## Центральный вопрос

Как представить данные как relations and constraints и выразить требуемый результат декларативным SQL без зависимости от конкретного execution algorithm?

## Результат спринта

После завершения необходимо уметь:

- понимать relation, tuple, attribute, domain and key;
- отличать table implementation from mathematical relation;
- создавать schemas, tables and basic constraints;
- выбирать PostgreSQL data types;
- использовать `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`, `DISTINCT`;
- выполнять `INSERT`, `UPDATE`, `DELETE`, `RETURNING`;
- понимать SQL three-valued logic and NULL;
- использовать inner/outer/cross joins;
- применять grouping and aggregates;
- объяснять logical query processing order;
- понимать duplicate/bag semantics of SQL;
- безопасно parameterize queries from Go;
- различать query result order from physical row order;
- создавать reproducible SQL tests;
- читать errors from type/constraint violations.

## Основной маршрут

### Шаг 1. Relational foundations

Изучить relation, projection, selection, product, join and grouping. SQL uses multisets and NULL, so it is not identical to pure relational algebra.

### Шаг 2. DDL and data types

Create schema and tables using exact numeric, text, boolean, date/time, UUID and constrained types. Arrays/JSON применяются только при подходящей модели.

### Шаг 3. Querying

Build from single-table filters to joins and aggregates. State expected result before running.

### Шаг 4. Application access

Use Go `database/sql` or pgx with parameters, context and explicit scanning. Never concatenate untrusted values into SQL.

## Ресурсы

### Обязательный маршрут

- PostgreSQL SQL, DDL, DML, queries and type chapters.
- Database textbook relational model and algebra sections.
- Go `database/sql` and pgx basic documentation.

## Практические задания

1. Map data-contract entities into a first relational schema.
2. Write selections, projections, joins and aggregates for 20 questions.
3. Reproduce NULL comparison and outer-join surprises.
4. Compare `NOT IN`, `NOT EXISTS` and NULL behavior.
5. Implement Go query command with parameterized filters.

## Лабораторная работа

Создать `work/relational-basics/`.

### Schema

Tenants, customers, products, orders, order lines, payments, shipments and status events.

### CLI

```text
datastore seed --tenants N --orders N --seed S
datastore query customers|orders|revenue|fulfillment ...
datastore create-order input.json
datastore update-status ...
```

### Requirements

- migrations create/drop isolated schema;
- deterministic fixtures;
- at least 25 SQL query tests;
- explicit ordering when tested;
- NULL behavior covered;
- all Go values parameterized;
- context cancellation and error classification;
- no ORM hides SQL;
- exact money/time types preserved.

### Failure scenarios

1. Query assumes implicit row order.
2. `WHERE column = NULL` used.
3. Outer join filter becomes inner join.
4. Aggregate over empty set misunderstood.
5. Duplicate rows caused by one-to-many join.
6. SQL injection through concatenated filter.
7. Timestamp scanned into wrong semantics.
8. Numeric money converted to float.
9. Update/delete omits tenant predicate.

## Самопроверка

1. Relation versus table?
2. Key and domain?
3. Selection/projection/join?
4. SQL bag semantics?
5. Three-valued logic?
6. INNER versus LEFT JOIN?
7. Logical query order?
8. Why ORDER BY is required?
9. Why parameterization matters?
10. Why money uses exact representation?

## Результат для базы знаний

- **Relational model terminology**.
- **Relational algebra practical operations**.
- **SQL query logical processing**.
- **SQL NULL and three-valued logic**.
- **Join types and duplicate multiplication**.
- **PostgreSQL core data types**.
- **Parameterized SQL from Go**.

## Когда переходить дальше

Можно переходить, когда schema can be rebuilt, query tests cover NULL/duplicates/order, and Go access uses typed parameters without hidden SQL generation.