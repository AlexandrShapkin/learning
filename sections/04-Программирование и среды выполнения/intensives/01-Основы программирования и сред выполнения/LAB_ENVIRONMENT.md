# Лабораторное окружение

## Базовая система

Рекомендуется отдельная Linux VM или development environment:

```text
programming-lab
├── 4 vCPU
├── 8 GiB RAM
├── 40 GiB disk
├── current stable Linux distribution
└── network access for package/module downloads
```

Для memory pressure, crash, core dump, process/signal и resource-limit experiments предпочтительна VM. Не запускать intentional OOM, fork storms или file descriptor exhaustion на основной рабочей системе.

## Основной toolchain

Обязательно:

- актуальная поддерживаемая Go toolchain;
- Git;
- Make;
- C compiler and binutils;
- GDB и Delve;
- `strace`, `ltrace`, `file`, `readelf`, `objdump`, `nm`;
- `perf` или эквивалент, если kernel позволяет;
- Python 3 для fixtures/comparison;
- shellcheck.

По мере необходимости:

- Node.js и TypeScript compiler;
- current LTS JDK;
- Rust stable toolchain;
- Clang sanitizers;
- Valgrind;
- protobuf compiler;
- Docker/Podman только для isolated runtime comparison, не как основной способ запуска.

## Debian-like installation example

```bash
sudo apt update
sudo apt install \
  build-essential clang binutils gdb lldb make cmake pkg-config \
  git curl ca-certificates jq tree file \
  strace ltrace linux-perf valgrind \
  python3 python3-venv python3-pip \
  shellcheck graphviz sqlite3
```

Package names differ by distribution. Go and optional runtimes should be installed through official or distribution-supported mechanisms. Do not pin an obsolete version only to match screenshots.

## Workspace

Each sprint creates `work/` only when practice begins:

```text
sprints/<NN-topic>/
└── work/
    ├── cmd/
    ├── internal/
    ├── testdata/
    ├── scripts/
    ├── profiles/
    └── README.md
```

Use one Go workspace/module per laboratory unless the sprint explicitly studies multi-module behavior.

## Environment capture

For reproducibility record commands, not long machine dumps:

```bash
go version
go env GOOS GOARCH GOVERSION CGO_ENABLED
uname -a
cc --version
ld --version
python3 --version
node --version      # when used
java -version       # when used
rustc --version     # when used
```

Do not commit usernames, home paths, tokens, proxy credentials or full environment variables.

## Safety limits

- CPU stress has explicit duration and process count.
- Memory allocation experiments run under cgroup/systemd scope or VM memory limit.
- Descriptor/process-limit experiments use low per-process `ulimit` and cleanup.
- Race/deadlock examples run as test binaries with timeout.
- Fuzzing has bounded time/corpus size.
- Network servers bind to loopback or isolated namespace by default.
- Subprocess tests use disposable directories and synthetic inputs.
- Core dumps, heap profiles and traces may contain data; sanitize or regenerate rather than commit raw large files.

## Generated artifacts

Commit:

- source and tests;
- small fixtures;
- Makefile/scripts;
- benchmark summaries;
- selected textual compiler/debugger output;
- commands to regenerate profiles/traces;
- concise conclusions.

Do not commit:

- compiled binaries;
- module/download caches;
- vendor directory unless explicitly studied;
- private registry credentials;
- large coverage, trace, profile or core files;
- generated keys and secrets;
- full third-party source trees.

## Go defaults

All Go projects should normally pass:

```bash
gofmt -w .
go test ./...
go test -race ./...        # where supported and relevant
go vet ./...
```

Additional linters are optional and must not replace compiler/tests. Benchmark results include hardware/runtime context and multiple runs.

## Comparative languages

Comparative tasks are intentionally small. A typical comparison directory:

```text
compare/
├── go/
├── python/
├── node/
├── java/
├── rust/
└── c/
```

Implement the same narrow behavior, not an entire application in every language. Compare semantics, runtime evidence and failure modes rather than syntax length.