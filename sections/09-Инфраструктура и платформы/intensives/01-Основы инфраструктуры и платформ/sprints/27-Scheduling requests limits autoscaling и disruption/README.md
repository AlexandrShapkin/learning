# Спринт 27. Scheduling, requests, limits, autoscaling и disruption

Ориентировочный объём: 20–29 часов.

## Центральный вопрос

Как Kubernetes scheduler and autoscalers use resource requests, topology and policy, and how to preserve service during pressure, maintenance and uneven demand?

## Результат спринта

После завершения необходимо уметь:

- понимать scheduler filtering/scoring and binding conceptually;
- задавать CPU/memory requests and limits from measurements;
- понимать QoS classes and eviction under node pressure;
- диагностировать Pending due resources/constraints;
- использовать node selectors, affinity/anti-affinity and topology spread;
- применять taints and tolerations;
- понимать priority and preemption risks;
- использовать HPA with meaningful metrics and stabilization;
- понимать VPA and Cluster Autoscaler concepts/trade-offs;
- проектировать PodDisruptionBudget and node drain;
- учитывать daemon/system overhead and allocatable resources;
- понимать CPU throttling and memory OOM behavior;
- планировать bin packing versus failure-domain spread;
- тестировать node pressure, drain and scale-out lag;
- избегать requests=limits as automatic rule.

## Основной маршрут

1. Measure workload CPU/memory and set initial requests/limits.
2. Saturate nodes and inspect scheduling/QoS/eviction.
3. Apply affinity, anti-affinity, topology spread, taints and tolerations.
4. Configure HPA and generate burst/slow growth.
5. Drain/fail node under PDB and capacity constraints.

## Ресурсы

- Kubernetes scheduler, resource management, QoS, HPA and disruption docs.
- metrics-server and selected autoscaler docs.
- capacity planning material from earlier sprints.

## Лабораторная работа

Создать `work/kubernetes-scheduling/`.

### Requirements

- requests come from measured steady/peak behavior and include overhead/headroom;
- limits are justified separately for CPU and memory;
- replicas spread across nodes/zones/hosts where failure requirement exists;
- affinity/taints do not create unschedulable dead ends;
- HPA metric, target, min/max and stabilization are explicit;
- startup time and pending capacity are included in scale test;
- PDB plus available capacity permits planned drain;
- node allocatable reserves system/daemon overhead;
- pressure/eviction/throttling/OOM evidence is collected;
- priority/preemption is bounded and does not starve critical dependencies;
- capacity report includes normal, maintenance and failure states;
- cleanup resets labels, taints and autoscalers.

### Failure scenarios

1. Missing requests causes poor scheduling and BestEffort eviction.
2. CPU limit creates throttling while node has idle capacity.
3. Memory limit causes OOM; memory request is mistaken as reservation guarantee under all conditions.
4. Anti-affinity/topology rules make replicas unschedulable.
5. Taint without matching toleration blocks system/workload unexpectedly.
6. HPA scales on CPU while requests are wrong.
7. HPA and rollout both surge beyond cluster capacity.
8. PDB prevents drain or provides false availability with insufficient replicas.
9. Cluster autoscaler cannot add compatible node due quota/template constraints.
10. Priority preempts dependency and worsens outage.

## Самопроверка

1. Requests versus limits?
2. CPU throttling versus memory OOM?
3. QoS classes and eviction?
4. Node allocatable?
5. Affinity versus topology spread?
6. Taints/tolerations?
7. HPA inputs and stabilization?
8. VPA/Cluster Autoscaler roles?
9. PDB and drain?
10. Bin packing versus failure spread?

## Результат для базы знаний

- **Kubernetes scheduler and resource requests**.
- **Kubernetes CPU limits, memory limits and QoS**.
- **Kubernetes affinity, topology spread and taints**.
- **Kubernetes HPA, VPA and cluster autoscaling**.
- **Kubernetes disruption budgets and node drain**.
- **Kubernetes node pressure, eviction and preemption**.

## Когда переходить дальше

Можно переходить, когда scheduling/autoscaling decisions are based on measured demand and the platform survives planned drain, burst and one-node loss without unschedulable or unbounded workloads.