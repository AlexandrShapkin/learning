# Каталог неисправностей

Every fault is opt-in, bounded, reversible and restricted to the labeled laboratory. It defines expected evidence, maximum scope and cleanup verification.

## Physical resources and VMs

1. `host-cpu-saturation` — host CPU saturation/steal affects colocated VMs.
2. `host-memory-pressure` — overcommit/swap causes guest latency or OOM.
3. `host-disk-full` — thin pool/backing filesystem fills.
4. `host-network-loss` — bridge/uplink path disappears.
5. `vm-vcpu-throttle` — VM receives insufficient scheduled CPU.
6. `vm-boot-cloudinit` — image or cloud-init prevents clean boot.
7. `vm-disk-detach` — persistent disk missing/read-only/wrong device.
8. `vm-snapshot-inconsistent` — online snapshot restores inconsistent application state.
9. `vm-identity-clone` — cloned machine reuses identity/keys.
10. `shared-failure-domain` — replicas share one host/network/storage domain.

## Containers and images

11. `container-memory-oom` — cgroup memory limit kills workload.
12. `container-cpu-throttle` — CPU quota creates latency.
13. `container-pid-limit` — process/thread creation fails.
14. `container-uid-volume` — UID/GID mapping blocks volume access.
15. `container-dns-network` — wrong network/alias breaks discovery.
16. `container-signal` — PID 1/graceful shutdown fails.
17. `container-privileged-host` — excessive capability/mount/socket exposes host control.
18. `image-mutable-tag` — deployment content changes under same tag.
19. `image-secret-layer` — build secret persists in layer/history.
20. `registry-storage-full` — registry cannot accept/pull image due storage/GC issue.

## Cloud infrastructure

21. `cloud-zone-capacity` — target zone/instance shape unavailable.
22. `cloud-quota-exhaustion` — quota blocks deploy, scale or recovery.
23. `cloud-route-nat` — private egress/inbound route is incomplete.
24. `cloud-dns-private-endpoint` — name resolves wrong/public path.
25. `cloud-policy-exposure` — broad security rule exposes service.
26. `cloud-iam-trust` — wrong principal/trust condition obtains or loses access.
27. `cloud-secret-rotation` — consumers fail during credential rotation.
28. `cloud-storage-limit` — volume/database/object quota or I/O limit is reached.
29. `cloud-backup-dependency` — restore lacks key, permission, network or identity.
30. `cloud-cost-orphan` — detached disk/IP/snapshot/NAT/logging creates unowned cost.

## Terraform and configuration

31. `tf-lock-contention` — concurrent apply is attempted.
32. `tf-backend-access` — state backend permission/availability fails.
33. `tf-secret-state` — sensitive value is exposed in state/plan/log.
34. `tf-stale-plan` — approved plan no longer matches current configuration/state.
35. `tf-provider-upgrade` — provider/schema/default change alters plan.
36. `tf-address-replacement` — rename/reindex causes unintended replacement.
37. `tf-import-mismatch` — imported resource configuration causes destructive next plan.
38. `tf-partial-orphan` — provider creates resource but state update fails.
39. `tf-drift-conflict` — out-of-band change conflicts with desired state.
40. `bootstrap-partial` — cloud-init/Ansible/image configuration fails midway.

## Kubernetes control and workloads

41. `k8s-controlplane-loss` — API/control plane unavailable while workload state differs.
42. `k8s-unschedulable` — resources/affinity/taint/topology prevent scheduling.
43. `k8s-probe-loop` — incorrect probe causes restart/unready rollout.
44. `k8s-rollout-capacity` — surge/PDB/resources stall rollout.
45. `k8s-service-no-endpoints` — selector/readiness/port removes endpoints.
46. `k8s-dns-failure` — CoreDNS/search/policy breaks discovery.
47. `k8s-networkpolicy` — policy/CNI blocks required flow or fails to enforce deny.
48. `k8s-ingress-tls` — route/controller/class/certificate mismatch.
49. `k8s-pvc-pending` — StorageClass/topology/capacity prevents binding.
50. `k8s-volume-attach` — node/zone/driver/permission prevents mount.

## Kubernetes identity, capacity and lifecycle

51. `k8s-rbac-deny` — workload/operator lacks required API action.
52. `k8s-rbac-excess` — default/broad binding grants unintended cluster access.
53. `k8s-secret-stale` — Secret rotates but workload keeps old value.
54. `k8s-quota-admission` — quota/LimitRange/policy rejects workload unexpectedly.
55. `k8s-hpa-bad-signal` — wrong requests/metric creates scale failure.
56. `k8s-node-pressure` — disk/memory/PID pressure evicts workloads.
57. `k8s-drain-pdb` — PDB/local data/unmanaged Pod blocks maintenance.
58. `k8s-upgrade-skew` — version/add-on/API incompatibility breaks upgrade.
59. `k8s-backup-scope` — cluster or application backup is incomplete.
60. `platform-contract-drift` — self-service contract, generated resources and platform status diverge.

## Combined scenario library

- host disk full + registry pull failure + node NotReady;
- mutable image tag + Terraform drift + failed Kubernetes rollout;
- wrong requests + HPA + cloud/cluster quota exhaustion;
- DNS + NetworkPolicy + ingress health-check mismatch;
- PVC topology + node drain + PDB deadlock;
- IAM secret rotation + projected workload identity + external secret failure;
- control-plane outage + running workloads + expired certificate;
- state restore + imported resources + wrong-target cleanup refusal;
- platform contract upgrade + admission policy + old generated resources;
- zone failure + insufficient headroom + autoscaler quota block;
- backup restore + missing encryption key + stale DNS endpoint;
- cloud cost orphan + missing tags + failed destroy.

## Fault definition contract

Each fault includes:

```text
name and layer
preconditions and labeled target
exact injected behavior
expected workload/platform symptom
expected host/cloud/Terraform/Kubernetes evidence
maximum duration, replicas, bytes, requests and cost
disable/rollback procedure
cleanup and baseline verification
regression or policy preventing recurrence
```

## Safety contract

Fault tooling must:

- require repository marker and `--lab`;
- validate exact local cluster/state/account/project target;
- reject public/production endpoints and unknown credentials;
- print scope and limits before activation;
- cap duration, resources, retries, replicas and cloud spend;
- use synthetic data and labeled resources;
- preserve state/backup before destructive exercises;
- never display secret values or private keys;
- support `status`, `disable`, `rollback-all` and `cleanup`;
- verify VMs, networks, containers, volumes, clusters, state locks and cloud resources after cleanup.
