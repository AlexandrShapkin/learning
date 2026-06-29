# Спринт 25. Persistent storage и stateful workloads

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как Kubernetes requests and attaches persistent storage, and which application-level replication, consistency, backup and recovery responsibilities remain outside PVC abstraction?

## Результат спринта

После завершения необходимо уметь:

- понимать Volume, PV, PVC and StorageClass roles;
- различать static and dynamic provisioning;
- понимать access modes and volume modes;
- использовать CSI architecture conceptually;
- понимать binding, topology and `WaitForFirstConsumer`;
- выбирать reclaim policy and expansion behavior;
- различать ephemeral, local and network persistent volumes;
- учитывать attachment/mount/node affinity constraints;
- проектировать StatefulSet volume claim templates;
- понимать snapshots and CSI snapshot objects conceptually;
- выполнять application-consistent backup/restore;
- диагностировать Pending PVC, attach, mount and permission failures;
- понимать why PVC is not database HA or backup;
- планировать node/zone loss and data relocation.

## Основной маршрут

1. Use local-path and network/CSI-like storage classes in disposable clusters.
2. Create PVC with immediate and delayed binding/topology.
3. Deploy StatefulSet and replace Pods/nodes.
4. Expand volume and verify filesystem/application behavior.
5. Snapshot/backup and restore into separate namespace/cluster target.

## Ресурсы

- Kubernetes storage, PV/PVC/StorageClass and CSI docs.
- selected CSI driver docs.
- application backup/restore references.

## Лабораторная работа

Создать `work/kubernetes-storage/`.

### Requirements

- storage classes document provisioner, topology, reclaim and expansion;
- PVC access/volume modes match workload;
- delayed binding prevents wrong-zone placement where applicable;
- StatefulSet replacement preserves stable storage identity;
- node/zone loss behavior is tested and limitations recorded;
- reclaim policy protects or deletes data intentionally;
- volume expansion and filesystem growth are verified;
- backup is application-consistent and restored separately;
- snapshots are not treated as cross-failure-domain backups;
- security context/UID/GID permissions are tested;
- diagnostics cover provisioner, PVC/PV, attachment, mount and application;
- cleanup confirms retained volumes are intentional.

### Failure scenarios

1. PVC is Pending because no matching class/capacity/topology.
2. Volume binds in wrong zone before Pod scheduling.
3. ReadWriteOnce is assumed to mean one Pod globally without driver semantics.
4. StatefulSet Pod moves but local volume cannot.
5. Reclaim policy deletes needed data or retains unexpected cost.
6. Filesystem does not expand after volume size changes.
7. Restore lacks secret/key/operator prerequisites.
8. Shared filesystem permission/locking behavior breaks application.
9. Database replication/backup is assumed from PVC alone.

## Самопроверка

1. Volume, PV, PVC and StorageClass?
2. Static versus dynamic provisioning?
3. Access modes mean what?
4. CSI components?
5. Immediate versus WaitForFirstConsumer?
6. Reclaim policy?
7. StatefulSet and claim templates?
8. Volume expansion steps?
9. Snapshot versus backup?
10. PVC does not provide which database guarantees?

## Результат для базы знаний

- **Kubernetes volumes, PV, PVC and StorageClass**.
- **Kubernetes CSI provisioning and attachment**.
- **Storage access modes and topology-aware binding**.
- **StatefulSet persistent identity**.
- **Kubernetes reclaim, expansion and storage recovery**.
- **PVC versus application replication and backup**.

## Когда переходить дальше

Можно переходить, когда state survives intended Pod replacement, topology/attachment constraints are explicit, and independent restore proves recovery beyond PVC/snapshot assumptions.