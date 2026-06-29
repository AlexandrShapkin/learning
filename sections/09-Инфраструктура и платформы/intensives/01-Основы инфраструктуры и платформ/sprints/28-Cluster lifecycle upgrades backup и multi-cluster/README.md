# Спринт 28. Cluster lifecycle, upgrades, backup и multi-cluster

Ориентировочный объём: 20–30 часов.

## Центральный вопрос

How to provision, upgrade, replace, back up and restore a Kubernetes cluster without treating the cluster API or worker nodes as permanent and without confusing application backup with cluster-state backup?

## Результат спринта

После завершения необходимо уметь:

- различать cluster bootstrap, control-plane and node lifecycle;
- понимать version skew and upgrade ordering;
- планировать CNI/CSI/ingress/add-on compatibility;
- выполнять cordon, drain, node replacement and rejoin;
- понимать etcd/control-plane backup scope;
- различать cluster state, persistent application data and external dependencies;
- выполнять restore to separate cluster where possible;
- проектировать certificate/token rotation and expiry awareness;
- учитывать API deprecations and manifest compatibility;
- планировать multi-cluster only for named failure/ownership needs;
- различать active/passive, fleet and environment separation patterns;
- управлять kubeconfig/context safely;
- проектировать disaster-recovery runbook and regular exercise;
- понимать hosted control plane versus self-managed responsibilities;
- оценивать upgrade and backup RTO/RPO.

## Основной маршрут

1. Provision multi-node k3s cluster from VMs/automation.
2. Back up control-plane/etcd state and application data separately.
3. Upgrade one minor step following version/add-on compatibility.
4. Replace/drain one agent and one server/control-plane node.
5. Restore to fresh cluster or isolated topology.
6. Compare one-cluster multi-namespace, separate environment clusters and multi-region/fleet options.

## Ресурсы

- Kubernetes version-skew and deprecation docs.
- k3s and etcd backup/restore/upgrade docs.
- selected CNI/CSI/ingress upgrade docs.
- multi-cluster architecture references.

## Лабораторная работа

Создать `work/kubernetes-lifecycle/`.

### Requirements

- cluster nodes are provisioned from code/image/configuration;
- versions of control plane, kubelet/runtime/CNI/CSI/add-ons are inventoried;
- pre-upgrade API/deprecation and capacity checks exist;
- workloads tolerate planned node drain according to PDB/capacity;
- backups separately cover cluster state, manifests/secrets source and application data;
- restore occurs on isolated fresh cluster and verifies application paths;
- certificate/token expiry and rotation are tested/documented;
- failed upgrade has rollback or forward-repair path;
- node replacement does not depend on manual snowflake changes;
- multi-cluster recommendation names identity, networking, data and operations cost;
- kubeconfig/context commands avoid wrong-cluster mutation;
- cleanup removes old nodes, snapshots and credentials intentionally.

### Failure scenarios

1. Upgrade jumps unsupported versions or violates skew.
2. CNI/CSI/ingress is incompatible with target version.
3. Drain is blocked by PDB/local data/unmanaged Pod.
4. etcd backup exists but application PV/database data is absent.
5. Application data backup exists but cluster secrets/config/cert dependencies are missing.
6. Restore overwrites live cluster or uses stale identity endpoints.
7. Deprecated API objects disappear after upgrade.
8. Node certificate/token expires unexpectedly.
9. Multi-cluster duplicates complexity without data/failover design.
10. Operator runs command against wrong kube-context.

## Самопроверка

1. Kubernetes upgrade order/version skew?
2. Node cordon/drain/replacement?
3. What does etcd backup contain?
4. Cluster-state versus application-data backup?
5. Why restore to fresh cluster?
6. Add-on compatibility?
7. API deprecation handling?
8. Certificate/token lifecycle?
9. When multi-cluster is justified?
10. Hosted versus self-managed control-plane responsibility?

## Результат для базы знаний

- **Kubernetes cluster and node lifecycle**.
- **Kubernetes version skew and upgrade planning**.
- **Kubernetes control-plane and application backup scopes**.
- **Kubernetes restore and disaster recovery**.
- **Kubernetes API deprecation and add-on compatibility**.
- **Kubernetes multi-cluster trade-offs**.

## Когда переходить дальше

Можно переходить, когда cluster and application recovery are independently proven on a fresh target, one upgrade/node replacement succeeds from code, and multi-cluster is treated as a costed requirement rather than default maturity step.