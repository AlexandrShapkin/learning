# Лабораторное окружение

## Базовая система

Рекомендуется Linux environment:

```text
algorithms-lab
├── 4–8 vCPU
├── 8–16 GiB RAM
├── 50 GiB disk
├── current supported Go toolchain
└── local SSD preferred for external-memory experiments
```

Большинство спринтов работает на обычной development machine. External-memory, high-allocation and parallel experiments должны иметь explicit limits и могут выполняться в disposable VM.

## Обязательные инструменты

- Go toolchain;
- Git, Make, Bash;
- Python 3 для small generators/plots/checks;
- `time`, `/usr/bin/time`, `perf` where available;
- Graphviz;
- jq;
- shellcheck;
- GNU coreutils and sort.

Рекомендуемые:

- `benchstat`;
- `hyperfine`;
- `valgrind`/cachegrind or `perf stat`;
- `gnuplot` or Python matplotlib for generated charts;
- sqlite3 for external-data comparison;
- taskset/numactl where relevant;
- pprof/trace from Go toolchain.

## Workspace

Каждый спринт создаёт `work/` только при фактическом прохождении:

```text
sprints/<NN-topic>/work/
├── cmd/
├── internal/
├── testdata/
├── generators/
├── benchmarks/
├── scripts/
└── README.md
```

Large generated datasets are not committed. Scripts and seeds to reproduce them are committed.

## Baseline commands

```bash
gofmt -w .
go test ./...
go test -race ./...            # для concurrent implementations
go test -run=NONE -bench=. -benchmem ./...
go vet ./...
```

Use multiple benchmark runs and `benchstat` when comparing close results. Record Go version, CPU, OS, dataset size/distribution and command.

## Safety and reproducibility

- Every generator accepts seed and size.
- Every algorithm has input-size and memory limits.
- Exponential algorithms run only on bounded instances.
- External sorting uses a dedicated temporary directory.
- Parallel experiments cap workers and duration.
- Adversarial hashing does not attack external services.
- Benchmarks validate output to prevent dead-code elimination.
- CPU frequency/noise limitations are stated; one timing is not evidence.
- Profiling output may contain data and is regenerated, not blindly committed.

## Artifacts

Commit:

- source and tests;
- small deterministic fixtures;
- generators and seeds;
- benchmark source and concise summaries;
- scripts for profiles/scaling experiments;
- diagrams generated from small examples;
- short conclusions tied to evidence.

Do not commit:

- compiled binaries;
- large datasets;
- raw massive benchmark/profile files;
- copied third-party problem sets/solutions;
- platform credentials;
- generated charts without source data/script.

## Standard library rule

Educational structures are placed under explicit `lab` or `internal/edu` packages. Production-like commands should normally use `slices`, `sort`, `container/heap`, maps and other standard facilities unless the experiment specifically compares a custom implementation.