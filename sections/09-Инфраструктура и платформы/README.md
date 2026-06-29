# Инфраструктура и платформы

Практическое изучение вычислительных ресурсов, виртуализации, контейнеров, облачных платформ, Infrastructure as Code, Kubernetes и внутренних платформ для команд разработки.

Раздел соответствует области [«Инфраструктура и платформы»](https://github.com/AlexandrShapkin/knowledge/tree/main/content/Инфраструктура%20и%20платформы) базы знаний.

## Основной интенсив

### [01. Основы инфраструктуры и платформ](intensives/01-Основы%20инфраструктуры%20и%20платформ/)

Маршрут строится от физического ресурса и виртуальной машины к контейнерам, облаку, Terraform, Kubernetes и внутренней платформе. Практика выполняется в локальном лабораторном контуре с ограниченными ресурсами, воспроизводимыми конфигурациями, отказными сценариями и обязательной очисткой.

После прохождения необходимо уметь:

- выбирать между bare metal, VM, container and managed service;
- объяснять механизмы виртуализации и контейнерной изоляции;
- создавать, проверять, распространять и запускать OCI-образы;
- проектировать container networking, storage and Compose environments;
- понимать region, availability zone, virtual network, load balancer and managed service contracts;
- оценивать shared responsibility, capacity, quotas and cloud cost;
- описывать инфраструктуру декларативно через Terraform;
- управлять state, locking, modules, imports and migrations;
- применять configuration management and immutable-image approaches;
- проверять IaC через plan, tests, policies and drift detection;
- объяснять architecture and reconciliation model of Kubernetes;
- выбирать workload controllers, services, storage and scheduling constraints;
- применять RBAC, service accounts, quotas, requests and limits;
- выполнять cluster upgrades, backup, restore and capacity planning;
- проектировать self-service platform capabilities and golden paths;
- диагностировать failures across compute, network, storage, control plane and workload boundaries.

Ориентировочный объём: 300–420 часов.

## Планируемые тематические углубления

- **Виртуализация и программно-определяемые ЦОД**;
- **Контейнерные runtime и безопасность изоляции**;
- **Terraform и управление крупной инфраструктурой**;
- **Kubernetes internals и операторы**;
- **Kubernetes networking and storage**;
- **Облачная архитектура конкретного провайдера**;
- **Platform engineering and developer portals**;
- **Capacity, FinOps and infrastructure economics**;
- **Multi-cluster and hybrid infrastructure**.

Каждое углубление будет самостоятельным маршрутом.

## Связи с другими разделами

- Аппаратные ресурсы и устройство компьютера — [«Вычислительные системы»](../01-Вычислительные%20системы/).
- Linux, процессы, cgroups and namespaces — [«Операционные системы»](../02-Операционные%20системы/).
- IP, routing, DNS and transport protocols — [«Сети и протоколы»](../03-Сети%20и%20протоколы/).
- Build, CI/CD, rollout and production operations — [«Доставка и эксплуатация»](../10-Доставка%20и%20эксплуатация/).
- Metrics, logs, traces and incident diagnosis — [«Наблюдаемость и диагностика»](../11-Наблюдаемость%20и%20диагностика/).
- Consensus, replication and distributed reliability — [«Распределённые системы и надёжность»](../12-Распределённые%20системы%20и%20надёжность/).
- Infrastructure hardening and threat models — [«Безопасность»](../13-Безопасность/).
