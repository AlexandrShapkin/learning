# Спринт 04. Acceptance criteria, готовность и traceability

Ориентировочный объём: 16–23 часа.

## Центральный вопрос

Как доказать, что изменение соответствует задаче и готово к безопасному использованию?

## Результат спринта

После завершения необходимо уметь:

- писать example-based acceptance criteria;
- различать acceptance, test cases and implementation tasks;
- определять Definition of Ready/Done only where useful;
- связывать problem, requirement, change, test and evidence;
- фиксировать operational and documentation completion;
- учитывать migration, rollback and observability;
- избегать duplicate traceability bureaucracy;
- manage requirement changes explicitly.

## Основной маршрут

1. Convert requirements into examples and boundary cases.
2. Define evidence for code, behavior, operations and documentation.
3. Create a lightweight trace from outcome to verification.
4. Change one requirement and propagate impact.

## Лабораторная работа

Создать `work/acceptance-traceability/`.

### Requirements

- criteria use concrete scenarios and observable results;
- positive, negative and boundary cases are represented;
- completion includes tests, migration, rollback, docs and monitoring where relevant;
- traceability uses stable identifiers/links without copying text everywhere;
- changed requirement identifies affected code/tests/docs;
- waived criterion has owner, reason and expiry;
- acceptance evidence is reproducible;
- no checklist item exists without decision value.

### Failure scenarios

1. Acceptance criterion is “implement endpoint”.
2. Tests pass but migration/rollback is missing.
3. Requirement changes without test/document impact review.
4. Done means only code merged.
5. Traceability spreadsheet duplicates stale text.
6. Waiver is permanent and unowned.

## Результат для базы знаний

- **Acceptance criteria and specification by example**.
- **Definition of ready and done**.
- **Requirements traceability**.
- **Completion and acceptance evidence**.

## Когда переходить дальше

Можно переходить, когда an independent reviewer can reproduce why the change is accepted and which requirements/tests/docs support it.