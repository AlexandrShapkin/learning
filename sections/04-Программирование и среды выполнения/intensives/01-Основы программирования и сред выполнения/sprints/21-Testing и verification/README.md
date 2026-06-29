# Спринт 21. Testing и verification

Ориентировочный объём: 16–23 часа.

## Центральный вопрос

Как получить evidence that components and whole program satisfy contracts, including boundaries, concurrency and failures, without turning tests into fragile copies of implementation?

## Результат спринта

После завершения необходимо уметь:

- distinguish unit, integration, component, contract, system and end-to-end tests;
- choose test boundary based on risk/contract;
- write table-driven tests and clear failure messages;
- use test helpers, fixtures, `testdata` and golden files carefully;
- use fakes/stubs/spies only where they model observable collaborator behavior;
- avoid mocking implementation details;
- control time, randomness, environment, filesystem and network;
- run parallel tests safely;
- use coverage as gap signal, not quality score;
- write benchmarks that avoid dead-code/setup distortion;
- use property-based/randomized invariant checks;
- fuzz parsers/protocols and preserve regression corpus;
- test concurrency, cancellation and failure injection;
- use subprocess tests for process/CLI/panic/deadlock behavior;
- understand race detector and sanitizer roles;
- create reproducible test suites with bounded duration;
- diagnose flaky tests and distinguish product bug from test bug.

## Основной маршрут

### Шаг 1. Test taxonomy and contracts

Map each requirement to cheapest reliable test layer. Not every behavior needs end-to-end test; not every risk is visible in unit test.

### Шаг 2. Determinism and dependencies

Inject clock/random/ID/filesystem/network boundaries where variation matters. Prefer real simple values over broad mocking frameworks.

### Шаг 3. Fuzz/property testing

Use Go fuzzing for decoders/parsers and randomized model-based checks for stores/state machines. Define invariants and resource limits.

### Шаг 4. Integration/system tests

Use temporary directories, loopback dynamic ports, helper subprocesses and isolated fixtures. Ensure cleanup even on failure.

## Ресурсы

### Обязательный маршрут

- Go `testing` package and `go test` command docs.
- Go fuzzing docs.
- Race detector docs.
- `httptest`, `testing/fstest`, `iotest` docs.

### Альтернативные объяснения

- xUnit Test Patterns selected chapters.
- Property-based testing/QuickCheck introductions.

### Углубление

- mutation testing;
- model checking;
- deterministic concurrency testing;
- consumer-driven contracts;
- test impact analysis;
- hermetic integration environments.

## Практические задания

### 1. Test pyramid by risk

For one existing lab classify requirements and add missing unit/integration/system tests. Justify every expensive test.

### 2. Flake catalogue

Reproduce and fix:

- time-dependent assertion;
- fixed port collision;
- map-order golden output;
- shared global state;
- parallel subtest capture;
- goroutine not awaited;
- test depending on local timezone/locale/environment;
- sleep-based readiness.

### 3. Property model

Test store/event log against simple reference model over random operation sequences. Save failing seed/case.

### 4. Fuzzing

Fuzz binary/JSON decoder with invariants: no panic, bounded allocation, round-trip for valid data, rejected invalid version/checksum.

## Лабораторная работа

Create `work/verification-suite/` integrating selected previous projects.

### Required layers

- unit tests for types/functions;
- component tests for storage/pipeline;
- I/O fault tests;
- concurrent/race tests;
- CLI subprocess tests;
- network integration tests;
- end-to-end app lifecycle test;
- property/model test;
- fuzz targets;
- benchmarks;
- coverage report.

### Test command

```text
make test
make test-race
make test-integration
make fuzz-smoke
make bench
make verify-clean
```

### Requirements

- default suite bounded and fast enough for frequent use;
- integration tags/commands explicit;
- tests independent of execution order;
- no real external services/network;
- temp files/ports/processes cleaned;
- fixtures synthetic and small;
- golden updates require explicit command/review;
- failures print reproduction seed/command;
- benchmark setup excluded and result validated;
- coverage exclusions/limitations explained;
- intentional race/deadlock fixtures isolated from normal suite.

### Failure scenarios

1. Test passes alone, fails in suite.
2. Test fails under `-race`/parallel.
3. Fixed port collision.
4. Fuzz input causes memory explosion.
5. Mock permits impossible behavior.
6. Golden file silently updated incorrectly.
7. Coverage high while error path untested.
8. Benchmark optimized away.
9. Integration process leaks.
10. Timeout hides goroutine dump/root cause.
11. Flaky clock/random/environment.
12. Test asserts private implementation and blocks refactor.

## Дополнительный эксперимент

Use mutation testing tool or manual mutations on critical functions. Measure whether tests detect changed comparison/error/cleanup logic; do not optimize for mutation score alone.

## Самопроверка

1. Unit versus integration versus E2E?
2. What should a test double model?
3. Why can mocks create false confidence?
4. What makes test deterministic?
5. Coverage proves what?
6. What is property/invariant test?
7. What does fuzzing discover?
8. Why save regression corpus?
9. How to test CLI/process failures?
10. Why parallel tests race?
11. What makes benchmark valid?
12. How to diagnose flake?

Практическая проверка: receive flaky suite, reproduce under repetition/race/shuffle, identify shared state/time/ordering/resource cause and add regression test.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Test levels and boundaries**.
- **Table-driven tests in Go**.
- **Test doubles and contract risks**.
- **Deterministic tests and dependency control**.
- **Property-based and model testing**.
- **Fuzz testing**.
- **Concurrency and subprocess testing**.
- **Code coverage limitations**.
- **Benchmark correctness**.
- **Flaky test diagnosis**.

## Когда переходить дальше

Можно переходить, когда suite is deterministic under repetition/shuffle/race, fuzz targets are bounded, and tests cover contracts/failures rather than implementation shape.