# Спринт 15. Business rules, decisions и exceptions

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Какие правила и решения определяют поведение процесса, кто ими владеет и как обрабатывать исключения без скрытой логики?

## Результат спринта

После завершения необходимо уметь:

- distinguish business rule, policy, procedure and implementation;
- identify decision inputs, outputs and authority;
- create decision tables/trees;
- model precedence, conflicts and exceptions;
- define effective dates and versioning;
- trace rules to legal, contractual or operational sources;
- separate configurable policy from stable domain invariant;
- handle manual override and audit;
- test rule combinations and boundaries;
- retire obsolete rules safely.

## Основной маршрут

1. Inventory scheduling, eligibility and pricing rules.
2. Convert ambiguous prose into decision tables.
3. Resolve conflicting sources and precedence.
4. Add exception/override lifecycle and effective dating.

## Лабораторная работа

Создать `work/business-rules/`.

### Requirements

- every rule has owner, source, scope and effective period;
- decision inputs/outputs use shared domain terms;
- tables cover normal, boundary and conflict cases;
- exceptions are explicit and time-bounded;
- manual override records actor, reason and outcome;
- configurable rules are separated from code invariants;
- rule change identifies affected process, requirement and analytics;
- obsolete rule has migration/retirement evidence.

### Failure scenarios

1. Rule exists only in employee memory.
2. Two documents define conflicting precedence.
3. Exception becomes permanent workaround.
4. Manual override is unaudited.
5. Effective date causes old/new cases to mix incorrectly.
6. Rule is hard-coded though business changes frequently.

## Результат для базы знаний

- **Business rules, policies and decisions**.
- **Decision tables, precedence and conflict resolution**.
- **Business-rule ownership and effective dating**.
- **Exceptions, overrides and auditability**.

## Когда переходить дальше

Можно переходить, когда the same inputs produce an explainable decision with known rule version, owner and exception path.