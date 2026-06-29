# Спринт 30. Системная диагностика инфраструктуры и платформы

Ориентировочный объём: 21–31 час.

## Центральный вопрос

Как from an unavailable or degraded workload locate the first failing infrastructure boundary across host, VM, container, cloud API, Terraform, Kubernetes control plane, network, storage and identity without destroying evidence?

## Результат спринта

После завершения необходимо уметь:

- формулировать exact symptom, scope, timeline and expected path;
- distinguish control-plane, data-plane and workload failures;
- reconstruct resource ownership and desired/observed state;
- trace compute, network, storage, identity and configuration paths;
- diagnose capacity, quota, saturation and placement failures;
- distinguish DNS, route, policy, listener and application failures;
- diagnose volume provisioning, attachment, mount and application consistency;
- inspect Terraform configuration/state/plan/remote drift;
- inspect Kubernetes objects, events, controllers, nodes and runtime;
- correlate host/VM/container/Kubernetes/cloud identifiers;
- preserve evidence before restart, force-delete, state edit or broad policy opening;
- rank falsifiable hypotheses and run one discriminating test;
- apply minimal reversible repair;
- verify user path, source state and resource baseline;
- add policy, test, runbook or platform status improvement;
- use read-only bounded collection tooling.

## Diagnostic loop

```text
state impact and expected resource path
→ preserve versions, events, state, routes, capacity and identifiers
→ identify desired/authoritative state and responsible reconciler
→ locate first non-converged or saturated boundary
→ classify compute/network/storage/identity/config/control-plane issue
→ rank hypotheses and run one discriminating observation
→ repair minimally
→ verify workload, platform and cleanup baseline
→ add prevention/detection
```

## Evidence map

- Host/VM: CPU steal/throttle, memory/OOM, disks, routes, services, hypervisor state.
- Containers: image digest, namespace/cgroup, mounts, DNS, logs and runtime events.
- Cloud: account/region/AZ, API operation, quotas, routes, policies, service health and cost ownership.
- Terraform: commit, lockfile, backend/lock, state lineage, plan and remote drift.
- Kubernetes: object generation/status/conditions/events, endpoints, scheduling, nodes, runtime, CNI/CSI/controllers.
- Platform: user contract, generated resources, ownership, policy decisions and capability status.

## Лабораторная работа

Создать `work/platform-diagnostics/`.

### `platformtriage`

Read-only commands:

```text
platformtriage path --workload NAME
platformtriage host --node NAME
platformtriage vm --name NAME
platformtriage container --id ID
platformtriage terraform --root PATH
platformtriage kubernetes --namespace NS --workload NAME
platformtriage network --source A --destination B
platformtriage storage --claim NAME
platformtriage identity --subject SUBJECT --action ACTION
platformtriage capacity --scope SCOPE
```

It redacts credentials and never mutates infrastructure.

### Incident catalogue

Solve at least 24, including six combined incidents:

1. host CPU saturation/steal;
2. cgroup throttling/OOM/PID limit;
3. VM disk/thin pool full;
4. wrong bridge/NAT/MTU;
5. mutable image/tag or bad bootstrap;
6. cloud quota/zone capacity failure;
7. route/security/DNS/private-endpoint failure;
8. IAM trust/permission/secret rotation failure;
9. Terraform lock/state drift/partial apply/orphan;
10. Kubernetes unschedulable Pod;
11. probe/restart/rollout failure;
12. Service selector/EndpointSlice/DNS failure;
13. NetworkPolicy/CNI failure;
14. PVC provision/attach/mount/topology failure;
15. quota/admission/RBAC rejection;
16. HPA/PDB/drain/autoscaler deadlock;
17. control-plane/add-on/version skew problem;
18. backup restore missing dependency;
19. platform contract/render/status failure;
20. cost/ownership orphan;
21. multiple simultaneous faults.

### Combined examples

- wrong requests + HPA + cluster quota;
- Terraform drift + rotated image + failed rollout;
- CNI policy + DNS + ingress health check;
- PVC topology + node drain + PDB;
- cloud IAM rotation + Kubernetes projected identity + external secret;
- VM host disk full + registry pull failure + node NotReady;
- control-plane outage + running workloads + expired certificate;
- platform contract upgrade + admission policy + old generated resources.

## Критерии прохождения

- `platformtriage` is read-only, bounded and redacted;
- at least 24 incidents and six combined cases are solved;
- every case names authoritative state and responsible reconciler/owner;
- broad restart, force-delete, state edit or policy opening is not accepted as unexplained final fix;
- identifiers correlate across host, cloud, Terraform and Kubernetes;
- repair verification includes workload path, persistent state and resource cleanup;
- each repair adds a policy/test/status/runbook improvement where appropriate;
- at least 10 of 12 self-check answers are mechanism-based.

## Самопроверка

1. Control plane versus data plane symptom?
2. Desired versus observed/authoritative state?
3. First non-converged boundary?
4. Capacity, quota and saturation differences?
5. Network diagnosis order?
6. Storage diagnosis order?
7. Terraform drift/partial apply evidence?
8. Kubernetes controller/object evidence?
9. Why force-delete/restart/state edit may destroy evidence?
10. What makes a discriminating test?
11. How verify complete repair?
12. What prevention belongs after infrastructure incident?

## Результат для базы знаний

- **Systematic infrastructure and platform diagnostics**.
- **Desired state, observed state and responsible reconciler**.
- **Cross-layer compute, network, storage and identity diagnosis**.
- **Terraform and Kubernetes diagnostic evidence**.
- **Infrastructure first-divergence and minimal repair**.
- **Platform recovery verification and prevention**.

## Когда переходить дальше

Можно переходить к итоговой работе, когда unfamiliar cross-layer failures are localized through bounded evidence and repairs restore both workload behavior and infrastructure ownership/state without residual resources.