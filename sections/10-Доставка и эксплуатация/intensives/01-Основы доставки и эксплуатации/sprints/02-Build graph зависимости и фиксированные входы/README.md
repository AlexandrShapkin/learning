# Спринт 02. Build graph, зависимости и фиксированные входы

Ориентировочный объём: 16–23 часа.

## Центральный вопрос

Какие явные и скрытые входы определяют build result, и как сделать dependency graph, toolchain, environment and generated inputs controlled and reviewable?

## Результат спринта

После завершения необходимо уметь:

- определять complete build input set;
- читать Go module/dependency graph;
- различать direct, indirect, build-time and runtime dependencies;
- фиксировать toolchain and module versions;
- понимать lock/checksum files and proxy/cache roles;
- контролировать code generation inputs and outputs;
- исключать network/time/locale/path nondeterminism;
- понимать vendoring and dependency mirrors trade-offs;
- проверять dependency integrity and source;
- проектировать offline or degraded-registry build path;
- различать build cache from authoritative dependency/artifact storage;
- находить undeclared host dependencies.

## Основной маршрут

1. Inventory source, modules, compiler, base images, generators, OS packages and environment variables.
2. Build in clean container/VM and compare with workstation build.
3. Disable network after dependency preparation and reproduce build.
4. Change locale, time zone, path and user to expose hidden inputs.

## Ресурсы

- Go modules, checksum database, proxy and toolchain docs.
- BuildKit build context/cache docs.
- dependency integrity and lock-file documentation.

## Лабораторная работа

Создать `work/build-inputs/`.

### Requirements

- machine-readable inventory of all build inputs;
- `go.mod`, `go.sum`, toolchain and generator versions are controlled;
- generated code/assets have source and deterministic regeneration command;
- build does not depend on developer home directory or untracked files;
- locale/timezone/path/user changes do not alter semantics;
- clean build works after controlled dependency fetch with network disabled;
- cache deletion changes speed, not result;
- dependency update produces reviewable graph and artifact change;
- fallback/mirror behavior and failure ownership are documented;
- no credentials are embedded in dependency configuration.

### Failure scenarios

1. Build imports untracked local file.
2. Generator version changes output silently.
3. Dependency tag moves or proxy serves different content.
4. System compiler/package version differs from CI.
5. Time/hostname/path is embedded in artifact unexpectedly.
6. Cache corruption is mistaken for source failure.
7. Build requires public registry/network during release outage.
8. Vendored dependency diverges from declared module state.

## Самопроверка

1. What counts as build input?
2. Direct versus indirect dependency?
3. Lock/checksum file purpose?
4. Build cache versus artifact repository?
5. Toolchain pinning?
6. Code generation reproducibility?
7. Offline build value?
8. Undeclared host dependency?
9. Vendoring trade-offs?
10. How verify dependency source/integrity?

## Результат для базы знаний

- **Software build inputs and dependency graph**.
- **Go module integrity and version control**.
- **Build toolchain pinning**.
- **Deterministic code generation**.
- **Build cache versus dependency/artifact storage**.
- **Offline and degraded-registry builds**.

## Когда переходить дальше

Можно переходить, когда a clean isolated environment can reproduce the build from an explicit input inventory and cache/network availability no longer defines correctness.