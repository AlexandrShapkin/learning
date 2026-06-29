# Реализация итоговой работы

## 1. Domain and package design

- named types and explicit invariants;
- commands/events/jobs with version and ID;
- concrete types by default;
- small consumer-defined interfaces at file/network/process/time boundaries;
- generics only for reusable type-safe containers/algorithms;
- no mutable global state;
- exported API minimized and tested by external consumer package.

## 2. Module and build

- one primary Go module;
- dependency graph documented by generated command output;
- standard library preferred;
- no accidental local `replace`;
- version/build/module info exposed;
- `go build -x`, compiler diagnostics, ELF/symbol/disassembly inspection scripts;
- pure-Go build mandatory, optional cgo helper comparison;
- clean checkout build/test.

## 3. CLI and configuration

`runtimelab` commands:

```text
submit
status
stream
validate
compact
inspect-build
collect-profile
inject-fault
rollback-fault
```

Configuration precedence:

```text
defaults → config file → environment → flags
```

Requirements:

- JSON and text output;
- stable exit codes;
- secrets redacted;
- complete validation before side effects;
- source metadata for effective config;
- version/help;
- subprocess tests.

## 4. Journal and serialization

- append-only versioned journal;
- JSONL and framed-binary codecs;
- bounded streaming decode/encode;
- checksum and schema version;
- precision/Unicode policy;
- atomic compaction/replacement;
- recovery policy for truncated final record;
- faulting reader/writer tests;
- fuzz decoder.

## 5. Processing pipeline

```text
source → decode → validate → transform → execute → encode → journal/result
```

- bounded queue and workers;
- explicit ownership of channels/goroutines;
- optional order preservation;
- cancellation and first/aggregate error policy;
- backpressure/admission control;
- worker panic boundary only if state remains valid;
- no goroutine/item fan-out without limit;
- progress metrics cannot block processing.

## 6. Shared state and synchronization

- concurrent job state store;
- at least one mutex-protected invariant;
- one immutable/atomic snapshot or owner-goroutine component;
- race detector clean;
- consistency semantics documented;
- no external callbacks under internal locks;
- mutex/block profiles collected under load.

## 7. Process integration

- subprocess transform adapter using argv, not shell concatenation;
- explicit cwd/environment;
- bounded stdout/stderr;
- timeout and process-group cleanup;
- exit code/signal/start failure classification;
- pipes drained without deadlock;
- helper subprocess tests.

## 8. Network interfaces

- TCP framed protocol;
- UDP diagnostic/probe endpoint;
- HTTP API with request IDs;
- local TLS optional but recommended;
- client phase timeouts and connection reuse;
- bounded headers/bodies/concurrency;
- retry policy tied to idempotency;
- response bodies/resources closed;
- graceful server shutdown;
- loopback default.

## 9. Lifecycle

```text
load/merge/validate config
→ initialize journal/store/listeners/workers
→ ready
→ serve/process
→ drain
→ close resources in reverse ownership order
→ exit
```

- partial startup rollback;
- SIGINT/SIGTERM handling;
- readiness/liveness/status;
- bounded shutdown and second-signal force policy;
- optional systemd unit example;
- no self-daemonization.

## 10. Minilang or transform extension

Optional integration of sprint 09:

- AST or bytecode transformation rules;
- execution/instruction/memory limit;
- host function allowlist;
- panic/error containment;
- versioned bytecode;
- deterministic tests.

A simpler typed transform registry is acceptable if minilang would make project disproportionately large.

## 11. Verification

Mandatory commands:

```text
make fmt
make test
make test-race
make test-integration
make fuzz-smoke
make benchmark
make build
make inspect-build
make verify
make cleanup
```

Coverage includes:

- table/unit tests;
- external API consumer;
- property/model tests for journal/store;
- fuzz codecs/config parser;
- concurrency stress/race;
- CLI subprocess;
- network integration;
- process lifecycle;
- end-to-end restart/recovery;
- fault rollback baseline.

## 12. Diagnostics

- panic stack and controlled goroutine dump;
- CPU, heap, alloc, goroutine, block and mutex profiles;
- runtime trace;
- selected `strace`, `perf`, `/proc` and `lsof` evidence;
- read-only bounded `progtriage` collector;
- profile endpoint loopback/restricted;
- build/version/config checksums in bundle;
- commands to regenerate large artifacts.

## 13. Comparative runtime exercise

Implement codec/transform workload in:

- Python;
- TypeScript/Node;
- Rust or Java.

Use identical fixtures/checksum and record build/runtime/dependency/startup/error/concurrency observations. The comparison is evidence for constraints, not a ranking.

## 14. Implementation stages

### Stage 1. Contracts

Define CLI, config, domain, serialization and failure semantics through examples/tests.

### Stage 2. Sequential correctness

Implement journal/codecs/store/pipeline sequentially and verify invariants.

### Stage 3. Concurrency

Add bounded workers, synchronization, cancellation and backpressure. Run race/stress tests.

### Stage 4. Adapters

Add files, subprocesses and network APIs with limits/timeouts.

### Stage 5. Lifecycle

Add startup/readiness/signals/drain/cleanup and full process tests.

### Stage 6. Diagnostics

Add profiles/trace/triage and establish baseline.

### Stage 7. Faults

Implement `FAULTS.md` named faults with safety/rollback.

### Stage 8. Assessment

Complete blind incidents, final defense, clean rebuild and delayed assessment.