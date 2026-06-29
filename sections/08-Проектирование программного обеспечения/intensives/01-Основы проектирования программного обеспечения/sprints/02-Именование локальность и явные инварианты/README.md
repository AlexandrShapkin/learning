# Спринт 02. Именование, локальность и явные инварианты

Ориентировочный объём: 14–20 часов.

## Центральный вопрос

Как names, nearby context and executable invariants reduce the amount of hidden knowledge required to change code safely?

## Результат спринта

После завершения необходимо уметь:

- выбирать names by domain meaning and responsibility;
- различать generic and precise vocabulary;
- избегать misleading, encoded and historical names;
- использовать one term for one concept within a context;
- проектировать small scopes and local reasoning;
- располагать related decisions and data close together;
- делать preconditions, postconditions and invariants explicit;
- использовать types and constructors to prevent invalid states;
- выбирать validation boundary intentionally;
- устранять boolean blindness and primitive obsession;
- понимать comments as explanation of why/constraint, not restatement;
- поддерживать symmetry and consistent conventions;
- сохранять error context without leaking internals;
- различать temporary readability cleanup and structural redesign;
- оценивать naming through future change and communication.

## Основной маршрут

### Шаг 1. Vocabulary map

Для baseline system составить таблицу concepts and names:

```text
business concept
current names in code/API/database
meaning and lifecycle
ambiguous synonyms/homonyms
context where term is valid
```

Исправить только terms, whose ambiguity changes behavior or spreads misunderstanding.

### Шаг 2. Locality

Найти функции, где понимание requires jumping across unrelated files/globals. Bring together:

- input normalization;
- invariant checks;
- state transition;
- error construction;
- relevant policy.

Do not centralize everything into one giant function.

### Шаг 3. Invalid states

Replace selected primitives/booleans with explicit types and constructors:

- `Money`, `TenantID`, `OrderID`;
- status transition command;
- optional/required address/contact;
- result state instead of `ok`, `failed`, `pending` booleans.

### Шаг 4. Comments and errors

Remove comments that duplicate syntax. Add only rationale, external constraint, non-obvious trade-off and compatibility note. Errors must state operation and safe identifiers.

## Ресурсы

- *A Philosophy of Software Design*, information hiding and complexity symptoms.
- *Code Complete*, naming and defensive programming chapters.
- Go naming/API conventions and standard library examples.
- Domain vocabulary material from DDD references.

## Практические задания

1. Rename a misleading concept across code/tests/schema boundary with compatibility plan.
2. Replace a boolean-parameter function with explicit operation/type.
3. Convert one primitive-heavy structure into validated values.
4. Move one invariant from comment/caller convention into constructor or transition method.
5. Reduce navigation needed to understand one use case.
6. Write an error chain preserving operation and root cause.

## Лабораторная работа

Создать `work/local-reasoning/` based on sprint 01.

### Requirements

- vocabulary document covers at least 15 domain/technical terms;
- renamed concepts remain compatible at external boundaries or include migration;
- public names describe responsibility rather than implementation detail;
- no single flag changes unrelated behavior invisibly;
- invalid identifiers/money/status cannot enter core model through ordinary constructors;
- state transitions enforce their own invariants;
- validation is not duplicated inconsistently across handlers/repositories;
- global mutable configuration is removed from at least one path;
- errors include operation and safe entity context;
- comments explain rationale/constraint only;
- tests prove invalid states and boundary compatibility.

### Failure scenarios

1. Rename changes code but not API/schema/log vocabulary.
2. Generic names `data`, `manager`, `helper`, `process` hide responsibility.
3. One term means different things inside the same module.
4. Primitive aliases add names but no validation/behavior.
5. Constructor validates, but zero value silently bypasses it.
6. Invariant exists only in UI/handler.
7. Locality cleanup creates giant function/module.
8. Comment describes outdated implementation.
9. Error loses root cause or logs secret/full payload.
10. Name becomes long because responsibility remains mixed.

## Самопроверка

1. What makes a name precise?
2. Ubiquitous term versus implementation term?
3. What is primitive obsession?
4. Boolean blindness?
5. Precondition, postcondition and invariant?
6. How types make invalid state harder?
7. Where should validation happen?
8. Locality versus oversized component?
9. What belongs in comments?
10. What context should errors preserve?

## Результат для базы знаний

- **Names as part of software design**.
- **Local reasoning and locality of related decisions**.
- **Primitive obsession and boolean blindness**.
- **Explicit preconditions, postconditions and invariants**.
- **Validated value types and constructors**.
- **Comments as rationale and constraint**.
- **Contextual error design**.

## Когда переходить дальше

Можно переходить, когда one core scenario can be understood with substantially fewer jumps and conventions, and invalid states are rejected by the model rather than remembered by callers.