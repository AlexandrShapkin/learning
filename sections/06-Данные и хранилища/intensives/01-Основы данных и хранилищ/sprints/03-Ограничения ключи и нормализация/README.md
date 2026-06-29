# Спринт 03. Ограничения, ключи и нормализация

Ориентировочный объём: 15–22 часа.

## Центральный вопрос

Какие facts should be stored once, какие invariants must be enforced by database, и когда deliberate denormalization is justified?

## Результат спринта

После завершения необходимо уметь:

- identify candidate, primary, alternate, foreign and composite keys;
- использовать `NOT NULL`, `UNIQUE`, `CHECK`, FK and exclusion constraints;
- понимать immediate/deferred constraint checking;
- выбирать cascade/restrict/set-null actions;
- выявлять functional dependencies;
- приводить schema к 1NF, 2NF, 3NF and BCNF at practical level;
- распознавать insert/update/delete anomalies;
- моделировать many-to-many and subtype relationships;
- проектировать tenant isolation in keys;
- денормализовать only with explicit consistency mechanism;
- тестировать constraints as executable specification;
- понимать why application validation does not replace database constraints;
- оценивать migration impact of adding constraints.

## Основной маршрут

### Шаг 1. Keys and identity

List all candidate keys before selecting primary. Surrogate key does not remove need for business uniqueness.

### Шаг 2. Constraints

Push persisted invariants into database when they can be expressed reliably. Application validation remains useful for UX, but it does not close concurrent races.

### Шаг 3. Normal forms

Use functional dependencies to separate facts and remove update anomalies.

### Шаг 4. Denormalization

For every duplicate store define source of truth, update mechanism, consistency window, repair and verification query.

## Ресурсы

### Обязательный маршрут

- PostgreSQL constraints and DDL docs.
- Database textbook normalization chapters.
- SQL and Relational Theory selected sections.
- PostgreSQL exclusion/deferred constraints docs.

## Практические задания

1. Find all candidate keys in the order domain.
2. Normalize a duplicated spreadsheet-like table.
3. Create constraints for values, state and uniqueness.
4. Model tenant-safe composite references.
5. Add a denormalized total with verifier/repair.

## Лабораторная работа

Создать `work/schema-invariants/`.

### Requirements

- schema v1 intentionally contains anomalies;
- migration to normalized v2;
- primary/alternate/composite keys;
- foreign keys with reasoned actions;
- checks for state/value rules;
- deferred constraint experiment;
- exclusion constraint for reservation case;
- tenant cannot reference another tenant's records;
- concurrent duplicate insert demonstrates database uniqueness;
- denormalized read model has refresh and consistency checker;
- Go tests assert SQLSTATE categories.

### Failure scenarios

1. Surrogate ID exists but duplicate business entity allowed.
2. Nullable FK creates ambiguous ownership.
3. Cascade removes audit/history unexpectedly.
4. Check constraint assumes NULL behaves false.
5. Application-only uniqueness races.
6. Composite tenant key omitted from FK.
7. Denormalized total becomes stale.
8. Constraint added before dirty data repair.
9. Cyclic FK lacks deliberate load strategy.

## Самопроверка

1. Candidate versus primary key?
2. Why alternate uniqueness matters?
3. What is functional dependency?
4. What anomalies does normalization remove?
5. 3NF versus BCNF practically?
6. When FK should cascade?
7. Immediate versus deferred constraint?
8. Why app validation is insufficient?
9. When denormalization is valid?
10. What must repair duplicated data?

## Результат для базы знаний

- **Candidate, primary, alternate and foreign keys**.
- **Database constraints as persisted invariants**.
- **Functional dependency and normalization**.
- **Insert, update and delete anomalies**.
- **Composite keys and tenant isolation**.
- **Deferred and exclusion constraints**.
- **Denormalization consistency contract**.

## Когда переходить дальше

Можно переходить, когда invalid states are rejected under concurrency, normalization choices are linked to dependencies, and every duplicate value has a repairable consistency mechanism.