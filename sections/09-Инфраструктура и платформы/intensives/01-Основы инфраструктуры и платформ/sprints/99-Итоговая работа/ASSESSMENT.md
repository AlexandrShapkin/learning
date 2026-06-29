# Итоговая проверка

## Blind incident exercise

Solve at least 20 hidden incidents:

- four VM/container/image cases;
- four cloud/IAM/storage/cost cases;
- four Terraform/configuration cases;
- four Kubernetes/platform cases;
- four combined incidents.

For each incident:

```text
User/platform symptom and impact
Affected resource scope and timeline
Expected path, desired state and authoritative source
Preserved versions, events, state, routes, capacity and ownership
First non-converged or saturated boundary
Ranked hypotheses and discriminating observation
Root cause, trigger and secondary effects
Minimal reversible repair
Workload, persistent-state and cleanup verification
Policy, test, runbook or platform-status improvement
```

## Clean reconstruction

From clean checkout and empty labeled lab resources:

1. verify host capacity, tools and safety marker;
2. build/pin VM and OCI images;
3. initialize locked/versioned Terraform state;
4. provision networks, VMs and disks;
5. configure infra services and local registry;
6. bootstrap multi-node k3s;
7. install networking, ingress, storage, metrics and policy capabilities;
8. create namespaces, identities, RBAC, quotas and secrets path;
9. deploy stateless, stateful and background workloads;
10. run network/storage/access/scheduling tests;
11. run backup, restore, node replacement and upgrade tests;
12. provision through self-service platform contract;
13. run fault smoke, verify and complete destroy/cleanup check.

## Complete failure exercise

Perform one scenario:

1. Terraform apply is interrupted after partial VM/disk creation;
2. reconcile state/orphan and finish cluster bootstrap;
3. deploy a new digest while registry or node storage becomes constrained;
4. HPA requests capacity but quota/taint prevents scheduling;
5. node is drained while PVC topology and PDB constrain movement;
6. workload secret/identity rotates;
7. one network policy or DNS path fails;
8. `platformtriage` identifies the first failing boundary;
9. repair restores one authoritative workload state;
10. backup/restore and cleanup prove no hidden residual dependency.

## Optional cloud exercise

In a dedicated sandbox:

- verify exact identity/account/project/region;
- create minimal VPC/network, compute/load balancer, storage and workload identity;
- inject one route/quota/IAM/restore fault;
- record cost and ownership metadata;
- destroy automatically;
- verify no disks, IPs, snapshots, gateways, logs or identities remain.

No cloud spend is required when a safe sandbox is unavailable; provider-neutral design and local emulation remain mandatory.

## Final defense

Answer using project evidence:

1. How are infrastructure resources, limits, utilization and saturation modeled?
2. What are failure domains, blast radius, redundancy and shared fate?
3. When are bare metal, VM, container, Kubernetes and managed service appropriate?
4. How do KVM/QEMU/libvirt virtualize CPU, memory and devices?
5. How do VM networks, disks, images, snapshots and backups differ?
6. Which namespaces, cgroups, capabilities and seccomp mechanisms form a container?
7. How do OCI image layers, tags, digests, SBOM and signatures work?
8. How do runtime, Docker networking, volumes and Compose lifecycle work?
9. How do cloud service models and shared responsibility change ownership?
10. How do regions, zones, compute scaling and load balancing affect availability?
11. How do cloud routes, NAT, policies, DNS and private endpoints form connectivity?
12. How are block, file, object and managed data services selected and recovered?
13. How do cloud IAM, workload identity, secrets, quotas and break-glass access work?
14. How are capacity, cost allocation, commitments, RTO and RPO evaluated?
15. How do Terraform configuration, state, provider and remote resources relate?
16. How are Terraform graph, modules, addresses and provider aliases designed?
17. How are locking, imports, moved resources, state splits and recovery handled?
18. What belongs in image, cloud-init, configuration management and application deployment?
19. How are IaC plans, tests, policy, drift and post-apply verification organized?
20. How do Kubernetes API, etcd, controllers, scheduler and kubelet reconcile state?
21. How are Pods and workload controllers chosen?
22. How do Services, DNS, ingress/Gateway, CNI and NetworkPolicy connect workloads?
23. How do PV, PVC, StorageClass, CSI, topology and backup interact?
24. How do ServiceAccounts, RBAC, Secrets, quotas and admission isolate workloads?
25. How do requests, limits, QoS, scheduling, HPA and disruption affect capacity?
26. How are cluster upgrades, node replacement, backup and restore performed?
27. When is multi-cluster justified?
28. What makes an internal platform a product with a supported golden path?
29. How does `platformtriage` find the first non-converged boundary?
30. Which evidence proves the platform is reproducible, recoverable and safely removable?

Every answer references a command, plan, state version, manifest, event, metric, packet/storage evidence, restore result, platform status or incident.

## Completion criteria

The intensive is complete when:

- clean checkout rebuilds the local platform;
- resource/failure/capacity maps match actual topology;
- VM and container images are pinned, inspectable and secret-free;
- Terraform state is protected, locked, versioned and recoverable;
- imports/migrations/drift/partial applies are exercised safely;
- cluster and add-ons are built and upgraded from code;
- workloads use correct controllers, probes and graceful termination;
- network default-deny and exact connectivity tests pass;
- stateful workloads restore independently on a fresh target;
- ServiceAccounts/RBAC/quotas/admission and secret rotation are tested;
- requests/limits/HPA/PDB/topology survive burst, drain and one-node loss within stated capacity;
- self-service platform contract creates a supported workload with status and guardrails;
- `platformtriage` is read-only and redacted;
- all 60 faults are reproducible or have documented equivalent substitute;
- at least 20 blind incidents and four combined cases are solved;
- all 30 defense answers are supported by evidence;
- destroy/cleanup finds no unintended local or cloud resource;
- generalized knowledge is transferred to `knowledge`.

## Delayed assessment

After 7–14 days without rereading:

1. rebuild the platform from clean state;
2. answer the 30 defense questions;
3. diagnose four random faults including one combined case;
4. import and move one Terraform resource without replacement;
5. deploy and troubleshoot one stateful workload from scratch;
6. perform node drain/replacement and one backup restore;
7. rotate workload identity/secret and verify least privilege;
8. change platform contract compatibly and migrate one workload;
9. produce capacity/cost/failure recommendation for a new workload;
10. explain which remaining problems belong to delivery, observability, distributed systems, security or SRE.

После delayed assessment уровень 3–4 можно считать закреплённым.
