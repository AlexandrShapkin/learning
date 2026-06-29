# Лабораторное окружение

## Базовая система

Рекомендуется disposable Linux VM or workstation profile:

```text
software-design-lab
├── 4–8 vCPU
├── 8–16 GiB RAM
├── 80 GiB SSD
├── current supported Linux distribution
└── container runtime with Compose support
```

Большинство спринтов не требуют тяжёлой инфраструктуры. PostgreSQL, message broker and auxiliary services запускаются только для архитектурных экспериментов, где boundaries and failure modes должны быть реальными.

## Обязательные инструменты

- Go toolchain;
- Git, Make, Bash, jq and curl;
- Docker/Podman and Compose;
- PostgreSQL client/server or container;
- Graphviz `dot` recommended;
- `go test`, race detector, fuzzing and benchmarks;
- `go vet`;
- staticcheck or equivalent static analysis;
- `go list` and package/dependency inspection tools;
- `diff`, `grep`, `awk`, `sed`, `find`;
- `/usr/bin/time`, `ps`, `lsof`, `ss`.

Recommended:

- Mermaid-compatible renderer or Markdown preview;
- `go-callvis`, `godepgraph` or equivalent dependency visualization;
- `golangci-lint` as a configured aggregator, not a substitute for judgment;
- `govulncheck` for dependency/security awareness;
- mutation-testing tool for selected experiments;
- code-clone/complexity tools as optional signals;
- architecture test helpers or custom `go/packages` checks;
- SQLite for small persistence comparisons;
- NATS JetStream or equivalent broker for event-boundary labs.

## Workspace

Each sprint creates `work/` only when practice begins:

```text
sprints/<NN-topic>/work/
├── cmd/
├── internal/
│   ├── domain/
│   ├── application/
│   ├── adapters/
│   └── architecture/
├── migrations/
├── fixtures/
├── diagrams/
├── adr/
├── scripts/
├── reports/
├── go.mod
└── README.md
```

Large generated graphs, profiles and temporary dependency reports should be ignored and regenerated through scripts.

## Reference system

The main evolving system is a synthetic work-management and fulfillment application with:

- organizations and memberships;
- work orders and status transitions;
- catalog and inventory concepts;
- billing/settlement placeholder;
- attachments;
- notifications and integrations;
- background processing;
- reporting/read models.

It starts as one intentionally tangled package/application. The same observable behavior is preserved while structure evolves. No production or personal data is used.

## Baseline commands

```bash
go version
git --version
docker compose version
psql --version
dot -V
```

Code checks:

```bash
gofmt -w .
go test ./...
go test -race ./...
go vet ./...
staticcheck ./...
go list -deps ./...
```

Exact optional tools may differ. Core checks must be reproducible without proprietary services.

## Architecture evidence

For every major redesign record:

- change scenario and expected outcome;
- code/version before and after;
- packages/modules/files touched;
- dependency graph delta;
- tests and observable behavior;
- runtime/resource effect where relevant;
- rejected alternatives;
- migration/compatibility path;
- remaining risks and debt.

Metrics such as complexity score, line count or package count are supporting signals only. They do not replace change-based evidence.

## Reproducibility

Record:

- Go and service versions;
- module dependencies and build tags;
- test dataset seed and size;
- benchmark/load parameters;
- architecture rule configuration;
- generated diagram command;
- migration and feature-flag state;
- commit or baseline identifier;
- operating-system/container limits where runtime comparisons matter.

## Data and secrets policy

Use only synthetic organizations, users, orders, documents and integration payloads. Do not commit:

- production/customer repositories or source extracts;
- proprietary code copied for exercises;
- real credentials, tokens or signing keys;
- real database dumps;
- private ADRs/incident documents from employers;
- generated dependency reports containing sensitive filesystem paths;
- third-party licensed examples beyond permitted short references.

## Safety limits

- fault and migration scripts require laboratory marker and explicit flag;
- service extraction experiments bind locally and use synthetic data;
- workload generators cap requests, rows, duration and concurrency;
- event/retry experiments cap queue depth and attempts;
- legacy fixtures are generated or written specifically for this repository;
- refactoring scripts never run against unrelated repositories;
- destructive database migrations use disposable database/tenant;
- cleanup verifies processes, ports, containers, temporary files and schemas.

## Committed artifacts

Commit:

- source and tests;
- small synthetic fixtures;
- architecture rules;
- stable C4-like and sequence diagrams;
- concise ADRs and quality scenarios;
- change-impact and evaluation summaries;
- migration scripts and compatibility tests;
- fault definitions and incident cards;
- commands to regenerate large graphs/reports.

Do not commit:

- binaries and caches;
- database/container volumes;
- full raw profiles and dependency graphs from every run;
- proprietary code or data;
- large generated diagrams when source can recreate them;
- secrets or real infrastructure addresses;
- unbounded migration/fault scripts.
