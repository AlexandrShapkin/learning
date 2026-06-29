# Основы инфраструктуры и платформ

Основной интенсив раздела «Инфраструктура и платформы». Его цель — научиться проектировать и эксплуатировать воспроизводимую вычислительную платформу: от физического ресурса и виртуальной машины до контейнеров, облачной инфраструктуры, Terraform, Kubernetes и self-service capabilities.

Практика выполняется в изолированном Linux-окружении. Основной маршрут использует KVM/libvirt, Docker or Podman, Terraform, Ansible, kind/k3d/k3s and a provider-neutral cloud model. One real cloud sandbox is optional but strongly recommended for network/IAM/managed-service evidence under strict budget and automatic cleanup.

## Результат прохождения

После завершения необходимо уметь самостоятельно:

- моделировать compute, memory, network, storage and failure domains;
- выбирать bare metal, VM, container, Kubernetes workload or managed service;
- объяснять CPU/memory/device virtualization and hypervisor boundaries;
- проектировать VM networks, disks, snapshots, images and cloud-init bootstrapping;
- объяснять Linux namespaces, cgroups, capabilities, seccomp and rootless containers;
- создавать minimal reproducible OCI images and multi-stage builds;
- понимать image layers, registries, digests, signatures and runtime lifecycle;
- проектировать container bridge/overlay networking, DNS, port publishing and volumes;
- собирать multi-service local environments through Compose;
- понимать public/private/hybrid cloud models and shared responsibility;
- проектировать region/AZ placement, virtual networks, routing, NAT and load balancing;
- выбирать block, file, object and managed data services by guarantees;
- применять cloud IAM, workload identity, secrets, quotas and isolation;
- оценивать capacity, utilization, cost allocation and failure blast radius;
- описывать infrastructure declaratively with Terraform;
- управлять providers, dependency graph, state, locking, modules and workspaces/environments;
- импортировать existing resources and выполнять safe state/config migrations;
- использовать cloud-init, image building and configuration management proportionally;
- проверять infrastructure plans, policies, drift and destructive changes;
- объяснять Kubernetes control plane, API objects, controllers and reconciliation;
- выбирать Deployment, StatefulSet, DaemonSet, Job and CronJob;
- проектировать Services, DNS, ingress/gateway, CNI and NetworkPolicy;
- работать with PV/PVC/StorageClass/CSI and stateful workload constraints;
- применять ConfigMap, Secret, ServiceAccount, RBAC, admission and quotas;
- задавать requests, limits, scheduling, affinity, taints, disruption and autoscaling;
- выполнять cluster upgrade, backup, restore and node lifecycle;
- проектировать internal platform products, golden paths and self-service APIs;
- диагностировать infrastructure failures from physical capacity to platform control loops.

Целевой уровень: 3 по всему разделу и 4 по container mechanisms, Terraform state/evolution, Kubernetes workload/resource model, platform boundaries and infrastructure diagnostics.

## Границы

Интенсив не заменяет:

- сертификационный курс конкретного cloud provider;
- глубокое изучение Linux kernel or hypervisor source code;
- полный курс network engineering;
- production SRE/on-call program;
- specialization in distributed databases;
- security-engineering specialization;
- vendor-specific Kubernetes administration handbook;
- enterprise procurement, datacenter construction or hardware maintenance course.

Смежные темы включаются настолько, насколько они нужны для выбора и проверки инфраструктурных решений.

## Предварительные знания

Рекомендуется завершить основные интенсивы по вычислительным системам, Linux, сетям and data stores.

Минимально необходимы:

- Linux shell, processes, filesystems, permissions and systemd basics;
- IP addressing, routing, DNS, TCP and TLS basics;
- Git and YAML/JSON;
- basic Go or Python for helper tooling;
- basic SQL and application deployment concepts;
- ability to read logs and run diagnostic commands;
- technical English.

## Лабораторное окружение

Default laboratory:

- Linux host or VM with nested virtualization where available;
- KVM/QEMU/libvirt;
- Docker or Podman and Compose;
- Terraform CLI; OpenTofu may be used as compatible alternative;
- Ansible;
- kind or k3d for fast Kubernetes experiments;
- k3s multi-node VMs for lifecycle and failure exercises;
- local OCI registry;
- PostgreSQL, MinIO and NATS/another small broker as platform workloads;
- optional short-lived real cloud sandbox.

Подробности: [`LAB_ENVIRONMENT.md`](LAB_ENVIRONMENT.md).

Проверка:

```bash
bash scripts/check-environment.sh
```

## Принципы прохождения

1. Every resource has owner, lifecycle, capacity limit and failure mode.
2. Declarative desired state is not a guarantee; reconciliation and provider behavior must be observed.
3. Isolation is measured separately for naming, permissions, resources and failure blast radius.
4. Mutable infrastructure state must have source of truth, locking and recovery procedure.
5. Containers do not remove kernel and host dependencies.
6. Kubernetes is used only after workload and failure requirements are explicit.
7. Managed service removes some operational work but changes control, portability and failure contracts.
8. Every cloud exercise has budget, quota and automatic destroy.
9. Requests, limits and autoscaling are capacity decisions, not arbitrary YAML fields.
10. Platform abstractions expose a supported contract and hide only decisions the platform can actually own.
11. Upgrade, backup, restore and cleanup are part of initial design.
12. General mechanisms move to `knowledge`; manifests, plans, state experiments and incident evidence remain in `learning`.

## Основной стек

- Linux, Bash, systemd and standard diagnostic utilities;
- KVM/QEMU/libvirt, cloud-init and optional Packer;
- Docker or Podman, BuildKit-compatible builds and Compose;
- OCI images, local registry and containerd/CRI concepts;
- Terraform; OpenTofu as optional compatible implementation;
- Ansible for configuration-management comparison;
- kind/k3d for fast clusters and k3s for multi-node labs;
- `kubectl`, Helm and Kustomize as packaging/customization tools;
- CNI/CSI/Ingress/Gateway implementations selected per lab;
- Prometheus-compatible metrics and basic logs/events for evidence;
- optional one cloud provider sandbox.

## Порядок спринтов

1. [Ресурсы, уровни абстракции и домены отказа](sprints/01-Ресурсы%20уровни%20абстракции%20и%20домены%20отказа/)
2. [Серверы, стойки, питание и планирование ёмкости](sprints/02-Серверы%20стойки%20питание%20и%20планирование%20ёмкости/)
3. [Гипервизоры и виртуальные машины](sprints/03-Гипервизоры%20и%20виртуальные%20машины/)
4. [Виртуальные сети, диски, snapshots и образы](sprints/04-Виртуальные%20сети%20диски%20snapshots%20и%20образы/)
5. [Namespaces, cgroups и изоляция контейнеров](sprints/05-Namespaces%20cgroups%20и%20изоляция%20контейнеров/)
6. [OCI-образы, слои и воспроизводимые сборки](sprints/06-OCI-образы%20слои%20и%20воспроизводимые%20сборки/)
7. [Container runtime, Docker, сети и volumes](sprints/07-Container%20runtime%20Docker%20сети%20и%20volumes/)
8. [Проверка виртуализации и контейнеров](sprints/08-Проверка%20виртуализации%20и%20контейнеров/)
9. [Облачные модели и shared responsibility](sprints/09-Облачные%20модели%20и%20shared%20responsibility/)
10. [Регионы, зоны, compute и балансировка](sprints/10-Регионы%20зоны%20compute%20и%20балансировка/)
11. [Облачные сети, маршрутизация и connectivity](sprints/11-Облачные%20сети%20маршрутизация%20и%20connectivity/)
12. [Block, file, object и managed data services](sprints/12-Block%20file%20object%20и%20managed%20data%20services/)
13. [IAM, workload identity, secrets и quotas](sprints/13-IAM%20workload%20identity%20secrets%20и%20quotas/)
14. [Стоимость, ёмкость и устойчивость облачной платформы](sprints/14-Стоимость%20ёмкость%20и%20устойчивость%20облачной%20платформы/)
15. [Проверка облачной инфраструктуры](sprints/15-Проверка%20облачной%20инфраструктуры/)
16. [Декларативная инфраструктура и Terraform](sprints/16-Декларативная%20инфраструктура%20и%20Terraform/)
17. [Terraform configuration, graph, providers и modules](sprints/17-Terraform%20configuration%20graph%20providers%20и%20modules/)
18. [State, backends, locking, import и migrations](sprints/18-State%20backends%20locking%20import%20и%20migrations/)
19. [Cloud-init, images и configuration management](sprints/19-Cloud-init%20images%20и%20configuration%20management/)
20. [Проверка, policy, drift и доставка IaC](sprints/20-Проверка%20policy%20drift%20и%20доставка%20IaC/)
21. [Проверка Infrastructure as Code](sprints/21-Проверка%20Infrastructure%20as%20Code/)
22. [Архитектура Kubernetes и reconciliation](sprints/22-Архитектура%20Kubernetes%20и%20reconciliation/)
23. [Pods, controllers и выбор workload](sprints/23-Pods%20controllers%20и%20выбор%20workload/)
24. [Services, DNS, ingress, Gateway и NetworkPolicy](sprints/24-Services%20DNS%20ingress%20Gateway%20и%20NetworkPolicy/)
25. [Persistent storage и stateful workloads](sprints/25-Persistent%20storage%20и%20stateful%20workloads/)
26. [Config, Secrets, ServiceAccounts, RBAC и quotas](sprints/26-Config%20Secrets%20ServiceAccounts%20RBAC%20и%20quotas/)
27. [Scheduling, requests, limits, autoscaling и disruption](sprints/27-Scheduling%20requests%20limits%20autoscaling%20и%20disruption/)
28. [Cluster lifecycle, upgrades, backup и multi-cluster](sprints/28-Cluster%20lifecycle%20upgrades%20backup%20и%20multi-cluster/)
29. [Platform engineering, self-service и golden paths](sprints/29-Platform%20engineering%20self-service%20и%20golden%20paths/)
30. [Системная диагностика инфраструктуры и платформы](sprints/30-Системная%20диагностика%20инфраструктуры%20и%20платформы/)
99. [Итоговая работа](sprints/99-Итоговая%20работа/)

## Покрытие основных вопросов

| Вопрос | Спринты |
|---|---|
| Когда bare metal, VM, container or managed service? | 01–04, 09–14 |
| Какие механизмы изолируют контейнеры? | 05–08 |
| Как создаются и запускаются container images? | 06–08 |
| Как Kubernetes приводит state к desired state? | 22–23, 30 |
| Как выбрать workload, network and storage in Kubernetes? | 23–27 |
| Как обновлять and scale applications/clusters? | 10, 27–28 |
| Какие гарантии предоставляет cloud platform? | 09–15 |
| Как управлять infrastructure declaratively and statefully? | 16–21 |
| Какие capabilities предоставить through internal platform? | 29 |
| Как изолировать users, workloads and environments? | 05, 11, 13, 24, 26–27 |
| Как оценивать capacity, cost and resilience? | 01–02, 10, 14, 27–30 |
| Как восстанавливать platform after failure/configuration error? | 04, 08, 15, 18–21, 28, 30, 99 |

## Итоговая работа

Финальный проект — `platform-foundation-lab`: локальная platform foundation containing virtualized nodes, container registry, Terraform-managed infrastructure, multi-node k3s cluster, network/storage/identity policies, self-service workload contract, backup/restore and fault-injection catalogue.

Система должна позволять:

- rebuild all resources from clean host prerequisites;
- compare VM/container/managed-style choices;
- verify IaC state and drift recovery;
- deploy stateless and stateful workloads;
- test network, identity, storage and scheduling isolation;
- upgrade and restore cluster/data/control state;
- expose one supported golden path to an application team;
- diagnose failures across host, VM, container, Terraform and Kubernetes layers.

## Вклад в базу знаний

Each sprint names exact recommended notes. General mechanisms move to `knowledge`; manifests, Terraform code, VM definitions, cluster data, failure evidence and platform contracts remain in `learning`.

## Общая библиография

Основные official specifications, documentation and books собраны в [`RESOURCES.md`](RESOURCES.md). Внутри каждого спринта указан обязательный minimum route.
