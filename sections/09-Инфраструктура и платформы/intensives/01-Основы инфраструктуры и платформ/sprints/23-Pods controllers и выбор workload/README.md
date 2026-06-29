# Спринт 23. Pods, controllers и выбор workload

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как выбрать Kubernetes workload/controller by identity, restart, ordering, placement and completion semantics rather than by copying a Deployment manifest?

## Результат спринта

После завершения необходимо уметь:

- понимать Pod as scheduling/runtime unit;
- проектировать multiple containers only for tightly coupled lifecycle;
- различать init, sidecar and application containers;
- выбирать Deployment/ReplicaSet for replaceable replicas;
- выбирать StatefulSet for stable identity/storage/ordering when required;
- выбирать DaemonSet for node-local capability;
- выбирать Job/CronJob for completion/schedule semantics;
- понимать restart policy and container lifecycle hooks;
- применять startup, readiness and liveness probes correctly;
- задавать termination grace and preStop cautiously;
- понимать rollout strategy, revision and rollback limits;
- использовать PodDisruptionBudget with realistic capacity;
- диагностировать CrashLoopBackOff, Pending, ImagePull and rollout stalls;
- учитывать generated jobs and history/cleanup.

## Основной маршрут

1. Deploy the same application as naked Pod and Deployment; delete containers/Pods/nodes.
2. Implement Job/CronJob and observe retries/concurrency policies.
3. Build StatefulSet with stable names and storage claim templates.
4. Reproduce startup/readiness/liveness misconfiguration.
5. Run rolling update with slow termination and failed readiness.

## Ресурсы

- Kubernetes Pods, workloads, probes and rollout docs.
- graceful termination and disruption docs.

## Лабораторная работа

Создать `work/kubernetes-workloads/`.

### Requirements

- stateless API uses Deployment with immutable image digest;
- worker/job uses Job or Deployment according to completion semantics;
- node agent/log helper example uses DaemonSet only if node-local need exists;
- stateful example justifies StatefulSet identity/ordering/storage;
- probes test distinct startup/readiness/liveness conditions;
- graceful termination drains active work;
- rollout has max surge/unavailable consistent with capacity;
- PDB does not block all maintenance;
- CronJob concurrency, missed runs and history limits are explicit;
- logs/events/status expose failure reason;
- no naked production-like Pod as desired state.

### Failure scenarios

1. Liveness checks external dependency and creates restart storm.
2. Readiness becomes true before application can serve safely.
3. Probe timeout/period is shorter than startup behavior.
4. Deployment used for finite task repeats work indefinitely.
5. CronJob overlaps and duplicates non-idempotent operation.
6. StatefulSet selected only because application has database connection.
7. PDB plus replica count blocks node drain.
8. Rollback restores manifest but not database/schema compatibility.
9. Sidecar prevents Pod termination.

## Самопроверка

1. Pod as scheduling unit?
2. When containers belong in one Pod?
3. Deployment versus StatefulSet?
4. DaemonSet use cases?
5. Job versus CronJob?
6. Startup/readiness/liveness probes?
7. Restart policy versus controller recreation?
8. Rolling update controls?
9. PDB protects what?
10. Rollback limitations?

## Результат для базы знаний

- **Kubernetes Pod lifecycle and multi-container patterns**.
- **Deployment, StatefulSet, DaemonSet, Job and CronJob**.
- **Kubernetes startup, readiness and liveness probes**.
- **Kubernetes rollout, termination and disruption**.
- **Kubernetes workload failure states**.

## Когда переходить дальше

Можно переходить, когда workload type, probes, retries, identity and disruption behavior are selected from actual lifecycle semantics and verified under restart, update and node loss.