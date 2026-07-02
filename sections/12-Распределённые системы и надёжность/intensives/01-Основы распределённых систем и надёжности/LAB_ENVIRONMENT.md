# Лабораторное окружение

## Базовая система

Recommended workstation or VM:

```text
distributed-reliability-lab
├── 8–12 CPU threads
├── 24–32 GiB RAM
├── 180+ GiB SSD
├── current supported Linux distribution
└── isolated local network and synthetic data
```

Reduced topology can use 16 GiB RAM with fewer replicas and no concurrent observability/chaos stack. Record all reductions because quorum, placement and overload experiments depend on topology.

## Required tools

- Git, Bash, Make, curl, jq and yq;
- Go toolchain;
- Docker or Podman and Compose;
- `kubectl` plus kind/k3d/k3s;
- PostgreSQL client/server or container;
- NATS JetStream or Kafka-compatible local broker;
- Toxiproxy or custom Go fault proxy;
- `tc`, `ss`, `tcpdump`, `dig`, `iptables`/`nftables`;
- k6 or Vegeta;
- Prometheus-compatible metrics and structured logs;
- checksums and standard process/system utilities.

Recommended:

- etcd for lease/consensus experiments;
- Redis/Valkey for cache/lease comparison;
- Redpanda/Kafka CLI and NATS CLI;
- OpenTelemetry Collector and Grafana;
- `stress-ng`, `fio`, `toxiproxy-cli`;
- TLA+/PlusCal tools;
- a deterministic event-loop/model harness written in Go;
- `chaos-mesh` or Litmus only inside isolated local cluster;
- MinIO for replicated object/state experiments.

## Default topology

```text
clients/load generator
          |
          v
API replicas ── discovery/load balancer
    |
    ├── replicated state service (3 nodes)
    ├── PostgreSQL local transactional state
    ├── durable event log (3 nodes or reduced local topology)
    ├── partitioned worker group
    ├── coordinator/lease service
    └── provider simulator

fault control
├── Toxiproxy / custom proxy
├── tc netem / network namespaces
├── process pause/kill/restart
├── disk/CPU/memory pressure
└── deterministic scheduler/model runner
```

## Failure-domain labels

Every node/process/resource must expose:

- service and instance ID;
- zone/site label;
- replica/shard/partition ID;
- epoch/term/generation where relevant;
- release/config/schema version;
- message/event/operation ID;
- broker offset/sequence where relevant.

Do not use unstable container names alone as identity.

## Workspace

```text
sprints/<NN-topic>/work/
├── services/
├── protocols/
├── broker/
├── replication/
├── partitions/
├── coordination/
├── faults/
├── models/
├── load/
├── observability/
├── reports/
└── README.md
```

Create only directories used by the sprint.

## Network and process faults

Allowed only against isolated laboratory targets:

- latency, jitter and bounded packet loss;
- duplication and reordering through proxy/harness;
- one-way/asymmetric partition where tooling permits;
- connection reset and half-open behavior;
- process crash, pause, slow disk and CPU starvation;
- clock offset inside containers/process simulations;
- stale DNS/discovery records;
- broker/replica unavailability;
- bounded storage exhaustion.

Do not apply `tc`, firewall or kill commands to the host default route, SSH path or unrelated namespaces.

## Safety limits

- every fault requires exact service/node/namespace target and `--lab`;
- load tests cap arrival rate, concurrency, duration and generated records;
- network faults have automatic expiry and rollback;
- partitions preserve one management path;
- disk faults use dedicated bounded volumes;
- clock experiments do not modify the host clock;
- message replays use synthetic topics/streams;
- multi-region simulation uses local zones/namespaces only;
- chaos controllers cannot access unrelated clusters/namespaces;
- cleanup verifies proxies, qdiscs, firewall rules, processes, topics, volumes and leases.

## Reproducibility evidence

Record:

- host OS/kernel/architecture;
- Go, broker, database, cluster and proxy versions;
- topology and failure-domain map;
- service/container image digests;
- protocol/config/schema versions;
- replica term/epoch/version/offset state;
- fault parameters and exact timeline;
- load shape and random seed;
- expected invariant and observed violation/non-violation;
- recovery/failback result;
- cleanup result.

## Commit policy

Commit:

- service and protocol source;
- deterministic simulation/model code;
- broker/database/topology configuration;
- bounded fault definitions;
- invariant/property tests;
- load scenarios;
- small synthetic histories;
- concise reports and diagrams;
- commands to regenerate traces/captures;
- sanitized diagnostic evidence.

Do not commit:

- database/broker volumes;
- large logs, traces or packet captures;
- credentials, certificates or private keys;
- real production topology or incident data;
- unbounded stress/chaos scripts;
- generated binaries/images;
- state snapshots containing secrets or personal data.
