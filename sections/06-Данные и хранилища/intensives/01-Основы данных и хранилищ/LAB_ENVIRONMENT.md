# Лабораторное окружение

## Базовая система

Рекомендуется disposable Linux VM:

```text
storage-lab
├── 6–8 vCPU
├── 16 GiB RAM
├── 120 GiB SSD disk
├── current supported Linux distribution
└── container runtime with Compose support
```

Минимально достаточно 4 vCPU, 8 GiB RAM и 60 GiB disk, если запускать дополнительные хранилища по одному. Не размещать intentional corruption, disk-full, replication or recovery experiments на рабочей production-like машине.

## Обязательные инструменты

- PostgreSQL server/client utilities;
- Go toolchain;
- Git, Make, Bash, jq;
- Docker/Podman and Compose or equivalent;
- SQLite CLI;
- `curl`, `openssl`, `nc`;
- `pgbench`;
- `ps`, `ss`, `lsof`, `strace`, `/usr/bin/time`;
- Python 3 for small generators/verification;
- Graphviz optional for schemas/plans.

Recommended PostgreSQL tools/extensions when available:

- `pg_stat_statements`;
- `auto_explain`;
- `pg_buffercache`;
- `pageinspect`;
- `amcheck`;
- `pg_freespacemap`;
- `pg_visibility`;
- `pg_repack` only as optional operational comparison;
- `pgBadger` or equivalent log analyzer optional.

Auxiliary services are started per sprint:

- Redis;
- document database;
- OpenSearch/Elasticsearch-compatible engine;
- MinIO/S3-compatible object storage;
- NATS JetStream, Redpanda/Kafka or equivalent;
- analytical/time-series store optional.

## Workspace

Each sprint creates `work/` only when practice begins:

```text
sprints/<NN-topic>/work/
├── schema/
├── migrations/
├── queries/
├── cmd/
├── internal/
├── fixtures/
├── scripts/
├── configs/
├── reports/
└── README.md
```

Large datasets, base backups, WAL archives and search indexes are generated outside Git and reproduced by scripts.

## PostgreSQL laboratory layout

Use separate directories or containers for:

```text
primary/
replica/
archive/
backups/
tmp/
```

Every destructive script must verify:

- laboratory marker file;
- expected data directory/container name;
- non-production port/host;
- disposable path prefix;
- explicit confirmation flag.

## Data policy

Only synthetic or deliberately public small datasets are used. Do not commit:

- production dumps;
- personal data;
- credentials, connection strings or private keys;
- WAL files/base backups;
- object-storage access keys;
- search snapshots;
- full logs containing query parameters/data.

Use `.env.example`; actual `.env` remains ignored.

## Baseline commands

```bash
psql --version
pg_config --version
pgbench --version
go version
sqlite3 --version
docker compose version   # or podman compose
```

For Go components:

```bash
gofmt -w .
go test ./...
go test -race ./...
go vet ./...
```

## Reproducibility

Record:

- database/product versions;
- configuration differences from defaults;
- schema migration version;
- dataset generator seed/size/distribution;
- workload command and client concurrency;
- relevant hardware/VM resources;
- plan with `ANALYZE` only on safe synthetic queries;
- buffer/cache warm/cold conditions where relevant.

Do not claim universal performance from one VM.

## Safety limits

- workload generators cap rows, bytes, clients and duration;
- disk-fill tests use isolated filesystem/file-backed loop device or container volume with quota;
- process kills and corruption simulations operate only on disposable clusters;
- backup/restore tests use separate target cluster;
- replication failures preserve primary recovery path;
- data-deletion tests use synthetic tenant IDs;
- search/broker/object services bind locally by default;
- public endpoints and default credentials are forbidden.

## Committed artifacts

Commit:

- schema and migrations;
- synthetic data generators;
- queries and tests;
- Compose/config examples without secrets;
- short plans and reports;
- verification and restore scripts;
- incident cards;
- diagrams;
- commands to regenerate large artifacts.

Do not commit:

- database volumes;
- large dumps/WAL/snapshots;
- generated object data;
- binaries/module caches;
- raw long logs/plans containing sensitive values;
- credentials or certificates.