# Спринт 23. Языки, runtimes и выбор технологии

Ориентировочный объём: 15–22 часа.

## Центральный вопрос

Какие свойства языка, runtime и ecosystem materially affect correctness, delivery, performance and maintenance, и как выбрать technology from constraints instead of preference?

## Результат спринта

После завершения необходимо уметь:

- separate language syntax, type system, runtime, standard library, toolchain and ecosystem;
- compare static/dynamic typing and compile-time/runtime checks;
- compare native AOT, interpreter, bytecode VM and JIT;
- compare GC, ownership and manual memory;
- compare threads/goroutines/event loops/async tasks;
- assess startup, steady-state performance, memory and deployment model;
- assess FFI/native dependency and portability constraints;
- evaluate package/dependency maturity and supply-chain surface;
- evaluate debugging, profiling, testing and operational tooling;
- distinguish language suitability from team familiarity and ecosystem constraints;
- choose Go, Python, Java, JavaScript/TypeScript, Rust, Bash or C for bounded scenarios;
- identify when multiple languages are justified and when they create integration cost;
- write explicit decision based on constraints, risks and exit strategy;
- avoid benchmark-driven or popularity-driven universal conclusions;
- keep Go as default for this learning path unless task constraints justify otherwise.

## Основной маршрут

### Шаг 1. Comparison dimensions

For each technology inspect:

```text
execution model
type checks
memory/lifetime
concurrency/async
standard library and ecosystem
build/package/deployment
startup/steady-state/resource profile
FFI/platform access
testing/debugging/profiling
compatibility/versioning
team/operational constraints
```

### Шаг 2. Language profiles

#### Go

Native AOT, static types, GC, goroutines, simple deployment, strong networking/infra standard library. Constraints: GC/runtime trade-offs, limited language dynamism, cgo boundary.

#### Python

Dynamic runtime, rapid scripting/prototyping, broad automation/data ecosystem. Constraints: packaging/environment complexity, runtime type failures, CPU concurrency model and startup/resource costs depending workload.

#### Java/JVM

Static types, bytecode/JIT, mature runtime/tooling/ecosystem, strong server workloads. Constraints: VM lifecycle/memory, packaging/operational complexity and ecosystem scale.

#### JavaScript/TypeScript/Node.js

Ubiquitous web ecosystem, event-loop async model, TypeScript static tooling over dynamic runtime. Constraints: dependency surface, event-loop blocking, runtime validation still required.

#### Rust

Native AOT, ownership/borrowing, no tracing GC by default, strong low-level safety. Constraints: learning/compile complexity, ecosystem/task fit and async/ownership design burden.

#### Bash

Shell orchestration and composition. Constraints: data structures, error semantics, portability, quoting and large-program maintainability.

#### C

Minimal runtime/ABI control and broad systems interop. Constraints: manual memory/undefined behavior and high verification burden.

These are starting hypotheses, not rankings; verify against task and current ecosystem.

### Шаг 3. Decision process

Start with constraints:

- latency/throughput/resource limits;
- memory safety;
- platform/browser/embedded requirements;
- available libraries/protocols;
- deployment target;
- startup/lifetime;
- team skills/maintenance horizon;
- interoperability;
- security/compliance;
- observability/support.

Then prototype highest-risk assumption rather than benchmarking trivial loops.

## Ресурсы

### Обязательный маршрут

- official language references and runtime docs listed in `RESOURCES.md`;
- comparative artifacts from sprints 09, 12 and 18;
- language package/build/debug documentation;
- technology-radar/benchmark sources only as hypothesis inputs.

### Альтернативные объяснения

- *Programming Language Pragmatics* comparative chapters.
- language implementation case studies.

### Углубление

- language/platform governance;
- long-term compatibility;
- FFI/IPC boundaries;
- polyglot architecture;
- WASM as portability boundary;
- domain-specific languages.

## Практические задания

### 1. One workload, multiple implementations

Implement a bounded record-transform service/CLI in:

- Go mandatory;
- Python mandatory;
- TypeScript/Node mandatory;
- one of Java or Rust mandatory;
- C/Bash only for narrow relevant parts.

Same input/output/error contract and dataset.

### 2. Evidence collection

Measure/inspect:

- clean build/setup commands;
- artifact/runtime dependencies;
- startup time;
- idle memory;
- throughput/latency under one representative workload;
- type errors caught before run;
- malformed input behavior;
- concurrency behavior;
- profiling/debugging experience;
- package/dependency graph;
- deployment artifact size.

Measurements include versions/hardware and are not universal rankings.

### 3. Scenario decisions

Choose stack for:

- small Linux automation;
- long-running infrastructure API;
- browser application;
- enterprise JVM integration;
- low-level high-safety agent;
- embedded C ABI library;
- data-science prototype;
- high-concurrency network proxy;
- one-off shell glue;
- cross-platform desktop/mobile component.

For each state mandatory constraints, decision, rejected alternatives and trigger to revisit.

### 4. Polyglot boundary

Compare in-process FFI, subprocess/CLI and network RPC for integrating one Rust/C/Python component into Go application. Evaluate failure isolation, deployment, type/schema and observability.

## Лабораторная работа

Create `work/runtime-comparison/`.

### Common contract

```text
transform INPUT OUTPUT --workers N --format jsonl
```

Workload validates, transforms, hashes and aggregates records with deterministic checksum.

### Required directories

```text
implementations/
├── go/
├── python/
├── node/
├── java-or-rust/
└── optional-c-bash/
fixtures/
scripts/
report/
```

### Requirements

- common fixtures and expected checksum;
- equivalent validation/error semantics;
- bounded concurrency and memory;
- build/run/test/profile commands;
- dependency manifests;
- no framework chosen solely to equalize code;
- one representative I/O-heavy and one CPU-heavy workload;
- cold/warm distinction for VM/JIT runtimes;
- failure cases: malformed input, cancellation, dependency missing, resource limit;
- generated report rather than manually maintained scoring spreadsheet.

### Decision artifact

Write `decision.md` for a hypothetical production constraint set. Maximum two pages:

```text
Context and constraints
Critical risks
Chosen language/runtime
Evidence from prototype
Rejected alternatives
Operational implications
Revisit triggers
```

## Дополнительный эксперимент

Compile one implementation to WebAssembly or native image where toolchain supports it and compare portability/startup/runtime restrictions.

## Самопроверка

1. Language versus runtime versus ecosystem?
2. Static typing guarantees what and not what?
3. AOT versus VM/JIT trade-offs?
4. GC versus ownership/manual memory?
5. Event loop versus goroutines/threads?
6. Why microbenchmarks insufficient for stack choice?
7. When Bash becomes wrong tool?
8. When Rust/C complexity is justified?
9. Why TypeScript does not remove runtime validation?
10. What deployment/observability costs matter?
11. When polyglot boundary should be process/RPC rather than FFI?
12. What triggers technology decision revision?

Практическая проверка: receive constraints for new component, identify unknown/high-risk assumption and design smallest prototype that resolves it.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Language, runtime, toolchain and ecosystem**.
- **Static and dynamic type-system trade-offs**.
- **AOT, interpreter, VM and JIT comparison**.
- **GC, ownership and manual memory comparison**.
- **Concurrency models across runtimes**.
- **Technology selection by constraints**.
- **Polyglot integration boundaries**.
- **Go, Python, JVM, Node, Rust, Bash and C applicability**.

## Когда переходить дальше

Можно переходить, когда implementations satisfy one contract, evidence is reproducible, and technology decision follows explicit constraints instead of a universal ranking.