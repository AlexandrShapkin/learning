# Спринт 17. Ownership, maintainership и merge flow

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Как распределить ответственность за код и решения так, чтобы review and maintenance did not depend on one bottleneck or become ownerless?

## Результат спринта

После завершения необходимо уметь:

- distinguish ownership, authorship, review authority and operational responsibility;
- define CODEOWNERS-like routing critically;
- manage primary and secondary maintainers;
- design merge queue and required-review policy;
- handle unavailable experts and escalation;
- rotate ownership and spread knowledge;
- identify orphaned and over-owned areas;
- balance autonomy and consistency;
- measure review concentration and bus-factor risk.

## Основной маршрут

1. Map ownership for the synthetic product.
2. Add review routing and fallback maintainers.
3. Simulate one overloaded maintainer and one orphaned module.
4. Introduce merge queue/integration policy.

## Лабораторная работа

Создать `work/ownership-merge-flow/`.

### Requirements

- every critical area has accountable maintainer and backup;
- ownership scope and decision rights are explicit;
- CODEOWNERS routing does not imply full accountability automatically;
- required reviews reflect risk, not blanket count;
- emergency path has limits and later review;
- merge queue verifies latest combined state;
- review load and concentration are visible;
- ownership transfer includes context and evidence;
- orphaned code has retirement or adoption decision.

### Failure scenarios

1. One expert blocks all reviews.
2. CODEOWNERS file is stale and routes incorrectly.
3. Two approvals are required regardless of risk.
4. Everyone owns everything, so no one decides.
5. Merge queue tests stale base or skips integration checks.
6. Emergency bypass becomes normal.
7. Ownership transfer is only a name change.

## Результат для базы знаний

- **Code ownership and maintainership**.
- **Review routing and fallback ownership**.
- **Merge queues and combined-state verification**.
- **Bus factor and review concentration**.

## Когда переходить дальше

Можно переходить, когда critical code has resilient ownership and merge flow no longer depends on one person or stale approval state.