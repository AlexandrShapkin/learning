# Спринт 20. Unit, integration, contract и end-to-end tests

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как распределить проверки между test levels so that failures are localized, interfaces are verified and user-critical paths remain trustworthy?

## Результат спринта

После завершения необходимо уметь:

- distinguish unit, component, integration, contract and end-to-end tests;
- choose test doubles by boundary and risk;
- verify database, broker and external contracts realistically;
- use consumer/provider contract tests conceptually;
- manage fixtures and test data;
- isolate nondeterminism and time;
- design deterministic integration environments;
- avoid mock-heavy tests that reproduce implementation;
- minimize end-to-end scope while covering critical journeys.

## Основной маршрут

1. Classify the existing test suite by level and risk.
2. Replace one brittle mock-heavy test with stronger boundary verification.
3. Add database and API contract checks.
4. Keep one minimal critical end-to-end journey.

## Лабораторная работа

Создать `work/test-levels/`.

### Requirements

- unit tests cover domain logic without unnecessary infrastructure;
- integration tests use realistic database/protocol boundaries;
- contracts include version/error/compatibility behavior;
- test doubles are owned and validated against real counterpart;
- time/randomness/concurrency are controllable;
- fixtures are small, explicit and isolated;
- end-to-end tests cover only high-value journeys;
- failures identify likely boundary and preserve evidence;
- test environment is reproducible locally and in CI.

### Failure scenarios

1. Mock asserts internal call sequence and blocks refactor.
2. Fake provider diverges from actual contract.
3. Integration tests share mutable state and become order-dependent.
4. End-to-end suite covers every permutation and is too slow.
5. Unit tests require network/database unnecessarily.
6. Clock/randomness creates nondeterministic failures.
7. Contract version/error cases are absent.

## Результат для базы знаний

- **Software test levels and boundaries**.
- **Test doubles and contract validation**.
- **Integration-test environments and data**.
- **Minimal critical end-to-end tests**.

## Когда переходить дальше

Можно переходить, когда each critical behavior is checked at the cheapest faithful level and failures point to a useful boundary.