# Спринт 99. Итоговая работа

Ориентировочный объём: 36–55 часов.

## Задача

Создать `runtime-lab` — воспроизводимый набор Go applications and tools, демонстрирующий путь от typed source and modules до executable, runtime, memory, concurrency, I/O, network service, tests, profiles and incident diagnostics.

Проект не должен превращаться в production framework или большой бизнес-сервис. Его задача — связать механизмы раздела в одной системе, которую можно собрать, запустить, сломать, исследовать и восстановить.

## Архитектура

```text
runtimelab CLI
    ├── validates config/input
    ├── sends jobs by local file/stdin/TCP/HTTP
    └── inspects status/build/profiles

runtimelabd
    ├── typed domain + append-only journal
    ├── streaming decoder/encoder
    ├── bounded concurrent worker pipeline
    ├── optional minilang transform
    ├── subprocess adapter
    ├── HTTP/TCP control and data endpoints
    ├── graceful lifecycle and readiness
    └── diagnostics/fault injection restricted to lab

comparative helpers: Python + TypeScript + Rust or Java
```

## Структура проекта

```text
work/runtime-lab/
├── cmd/
│   ├── runtimelab/
│   └── runtimelabd/
├── internal/
│   ├── app/
│   ├── config/
│   ├── domain/
│   ├── journal/
│   ├── codec/
│   ├── pipeline/
│   ├── network/
│   ├── process/
│   ├── diagnostics/
│   └── faults/
├── compare/
├── testdata/
├── scripts/
├── docs/
├── Makefile
├── go.mod
└── README.md
```

## Документы итоговой работы

- [`IMPLEMENTATION.md`](IMPLEMENTATION.md) — обязательные components and stages.
- [`FAULTS.md`](FAULTS.md) — каталог из 50 bounded/reversible faults.
- [`ASSESSMENT.md`](ASSESSMENT.md) — blind incidents, final defense and delayed assessment.

## Основные требования

Готовый проект должен включать:

- typed domain model and explicit invariants;
- clear package/module boundaries;
- stable CLI/configuration contract;
- streaming I/O and versioned serialization;
- append-only journal with safe compaction;
- subprocess integration;
- TCP/UDP/HTTP application interfaces;
- bounded goroutines, queues and resource limits;
- channels plus one shared-memory synchronization component;
- context cancellation and graceful shutdown;
- unit/integration/property/fuzz/subprocess/network tests;
- race detector and benchmark suite;
- build/ELF/dependency inspection;
- CPU/heap/goroutine/block/mutex profiles and runtime trace;
- read-only `progtriage` bundle;
- controlled fault injection;
- comparative implementation of one narrow workload in other runtimes.

## Порядок выполнения

1. Define contracts, domain invariants and failure boundaries.
2. Implement packages/modules and basic CLI.
3. Add journal, codecs and safe I/O.
4. Add bounded pipeline and synchronization.
5. Add process and network adapters.
6. Add configuration/lifecycle/readiness/shutdown.
7. Build complete verification suite.
8. Add profiles, trace and triage tooling.
9. Implement fault catalogue and rollback.
10. Run blind incidents and delayed assessment.

## Обязательные артефакты

Коммитить:

- source and tests;
- module/build files;
- small fixtures and fuzz seeds;
- scripts to build/inspect/profile/triage;
- sanitized configs;
- short benchmark/profile summaries;
- architecture and execution-path diagrams;
- concise incident cards;
- comparative source implementations;
- links to knowledge notes.

Не коммитить:

- compiled binaries/caches/vendor by default;
- private keys/secrets/full environments;
- large profiles/traces/core dumps;
- external user data/network captures;
- intentionally corrupted system-wide configuration;
- downloaded language runtimes or dependencies.

## Safety

- intentional OOM, deadlock, race, fd/process/goroutine leaks run with limits and timeout;
- network listeners default to loopback;
- fault endpoints require explicit lab mode/token or local-only control;
- subprocesses run synthetic commands/data and are fully cleaned;
- profiling endpoints are not publicly exposed;
- fault rollback and cleanup verify resource baseline.

## Результат для базы знаний

Итоговая работа должна завершить or correct notes on types, functions, interfaces/generics, errors, modules, compilation, VM/runtime, memory, GC, I/O, process integration, concurrency, async, testing, profiling and technology selection.

Raw code-specific evidence remains in `learning`; reusable mechanisms go to `knowledge`.