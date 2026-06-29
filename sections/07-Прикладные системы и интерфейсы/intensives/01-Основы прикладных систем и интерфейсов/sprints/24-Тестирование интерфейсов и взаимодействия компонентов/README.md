# Спринт 24. Тестирование интерфейсов и взаимодействия компонентов

Ориентировочный объём: 20–29 часов.

## Центральный вопрос

Как получить достаточную уверенность в user-visible behavior and component contracts without replacing real integration paths brittle mocks or enormous end-to-end suites?

## Результат спринта

После завершения необходимо уметь:

- выбирать test level by failure type and feedback cost;
- писать pure unit tests for rules/transformations;
- использовать Go handler/application/integration tests;
- тестировать frontend components by accessible behavior;
- создавать browser end-to-end journeys;
- использовать real PostgreSQL/broker/object/OIDC dependencies in bounded tests;
- различать mock, fake, stub, spy and emulator;
- применять contract tests for OpenAPI/protobuf/webhooks;
- тестировать backward compatibility with old clients/payloads;
- создавать deterministic fixtures and factories;
- контролировать clock, randomness and IDs;
- тестировать concurrency, retries and idempotency;
- применять property/fuzz tests at parsers/contracts;
- избегать flaky sleeps and global shared state;
- использовать test isolation and cleanup;
- сохранять traces/screenshots only on failure;
- измерять coverage as signal, not goal;
- проектировать test portfolio by critical journeys and risks.

## Основной маршрут

### Шаг 1. Test map

For each risk choose lowest realistic test that can expose it:

```text
pure rule → unit
SQL/transaction → database integration
HTTP/protobuf schema → contract/integration
component semantics → component/browser
complete login/order/job/webhook → end-to-end
failure timing/concurrency → controlled integration/system
```

### Шаг 2. Test data and isolation

Use per-test schema/tenant or disposable dependency. Seed only required data. Avoid order-dependent shared environment.

### Шаг 3. Contracts

Validate provider/consumer examples, old clients, generated schemas and webhooks. Contract passing does not prove authorization/business semantics, so combine with scenario tests.

### Шаг 4. Browser journeys

Use accessible selectors, network/control hooks and deterministic fake/sandbox external systems. Wait for observable states, not arbitrary sleeps.

## Ресурсы

- Go testing, fuzzing, race detector and `httptest` docs.
- Playwright official docs.
- Testing Library principles.
- OpenAPI/JSON Schema/protobuf validation tools.
- Testcontainers/Compose docs for real dependencies.

## Практические задания

1. Build a risk-to-test-level matrix for the application.
2. Replace over-mocked use case with real database integration.
3. Write component tests using role/name and keyboard behavior.
4. Write E2E login-create-upload-job-webhook journey.
5. Remove sleeps from flaky test using observable synchronization.
6. Add old-client and webhook contract suites.
7. Fuzz one parser/decoder and property-test one state transition.
8. Run tests in parallel and detect hidden shared state.

## Лабораторная работа

Создать `work/application-test-system/`.

### Required suites

- domain/use-case unit tests;
- repository/transaction integration tests;
- REST/OpenAPI contract tests;
- protobuf compatibility and gRPC tests;
- GraphQL query-limit/N+1 tests;
- React component/accessibility tests;
- Playwright user journeys;
- OIDC/session/authorization negative tests;
- background job and webhook retry tests;
- file/object workflow tests;
- security regression tests;
- load-smoke and graceful-shutdown tests.

### Requirements

- one command starts isolated dependencies and runs suites;
- tests use synthetic credentials/data only;
- clock/ID/random sources controlled where needed;
- no test depends on execution order;
- no arbitrary sleep as correctness synchronization;
- browser tests wait on accessible/contract state;
- network/provider failures are named and deterministic;
- cleanup verifies DB rows, objects, messages, sessions and processes;
- traces/screenshots/videos retained only on failure or representative docs;
- flaky test is treated as defect, not retried until green without analysis;
- critical journeys mapped to at least one complete test;
- test duration and parallelism reported.

### Failure scenarios

1. Mock returns behavior real provider/database cannot produce.
2. Unit coverage high but authorization/data wiring broken.
3. E2E suite tests every edge and becomes slow/brittle.
4. Browser selector depends on CSS/generated DOM structure.
5. Fixed sleep passes locally and fails under load.
6. Tests share tenant/session/queue and interfere.
7. Transaction rolled back but external object/message persists.
8. Contract test validates shape but not semantic compatibility.
9. Snapshot test accepts unintended inaccessible UI.
10. Automatic test retries hide deterministic race.
11. Test logs leak tokens/credentials.

## Самопроверка

1. Which failure belongs to which test level?
2. Mock versus fake versus real dependency?
3. Why accessible selectors are preferable?
4. Contract test proves what and not what?
5. How control time/random/IDs?
6. Why sleeps create flaky tests?
7. How isolate stateful integration tests?
8. What belongs in end-to-end suite?
9. Coverage means what?
10. How test retries/idempotency/concurrency?
11. What cleanup must verify?

## Результат для базы знаний

- **Application test portfolio by risk**.
- **Unit, integration, contract, component and end-to-end tests**.
- **Mocks, fakes and real dependency boundaries**.
- **Deterministic test data, time and identity**.
- **Accessible browser test selectors**.
- **API/provider compatibility contract tests**.
- **Flaky-test causes and observable synchronization**.
- **Stateful test isolation and cleanup**.

## Когда переходить дальше

Можно переходить, когда critical journeys and boundary failures have realistic tests, suites are deterministic/isolated, and mocks no longer provide false confidence about persistence, identity or integration behavior.