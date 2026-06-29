# Спринт 01. Ресурсы, уровни абстракции и домены отказа

Ориентировочный объём: 14–20 часов.

## Центральный вопрос

Какие ресурсы и гарантии реально получает workload на каждом уровне — hardware, VM, container, cluster, cloud service — и где находятся shared dependencies and failure boundaries?

## Результат спринта

После завершения необходимо уметь:

- моделировать CPU, memory, network, storage and identity as bounded resources;
- различать allocation, reservation, limit, utilization and saturation;
- понимать control plane and data plane;
- определять failure domain and blast radius;
- различать redundancy, isolation and independence;
- строить dependency/resource map for a workload;
- понимать overcommit and noisy-neighbor risk;
- формулировать infrastructure SLO-like requirements without replacing later SRE work;
- выбирать abstraction by required control, portability and operational ownership;
- понимать shared fate across host, rack, zone, cluster and provider;
- определять source of truth and reconciliation owner;
- учитывать lifecycle: provision, configure, use, update, retire and recover;
- создавать bounded experiments rather than trusting platform labels.

## Основной маршрут

1. Draw one application path from user request to CPU, memory, NIC, disk and managed dependencies.
2. For each layer record owner, quota, scheduler, state source, failure signal and recovery action.
3. Create failure-domain map: process → container → VM → host → rack/network → zone → region/provider.
4. Compare bare metal, VM, container, Kubernetes and managed service for the same synthetic workload.

## Ресурсы

- *The Datacenter as a Computer*, introductory chapters.
- Linux resource and cgroups documentation.
- NIST cloud definitions.
- selected cloud/Kubernetes architecture overviews.

## Лабораторная работа

Создать `work/resource-model/`.

### Workload

Synthetic HTTP service with PostgreSQL, object storage and background worker.

### Requirements

- one resource/dependency graph;
- one failure-domain matrix;
- one lifecycle table for each resource;
- CPU/memory/disk/network limits measured locally;
- one saturation experiment for every resource class;
- evidence distinguishing allocation from actual utilization;
- recovery owner and source of truth named for each layer;
- five deployment alternatives compared through control, cost, isolation and recovery;
- no conclusion based only on marketing names.

### Failure scenarios

1. Two replicas share one host/disk/network dependency and are called highly available.
2. CPU average is low while one core/thread is saturated.
3. Memory limit exists but page cache/overhead is ignored.
4. Storage capacity is available but IOPS/latency is saturated.
5. Container is treated as independent failure domain from host kernel.
6. Managed service is assumed to remove all operational responsibility.
7. Control-plane availability is confused with workload availability.
8. Recovery procedure has no authoritative state.

## Самопроверка

1. Allocation, reservation, limit and utilization?
2. Saturation versus high utilization?
3. Failure domain versus blast radius?
4. Isolation versus redundancy?
5. Control plane versus data plane?
6. What is overcommit?
7. Why replicas may share fate?
8. What defines infrastructure lifecycle ownership?
9. What does managed service transfer and retain?
10. How to validate an abstraction’s guarantee?

## Результат для базы знаний

- **Infrastructure resources and saturation**.
- **Control plane and data plane**.
- **Failure domains and blast radius**.
- **Isolation, redundancy and shared fate**.
- **Infrastructure lifecycle and source of truth**.
- **Bare metal, VM, container and managed-service trade-offs**.

## Когда переходить дальше

Можно переходить, когда one workload can be traced to bounded physical/logical resources and every claimed isolation or resilience property names its shared dependencies and failure evidence.