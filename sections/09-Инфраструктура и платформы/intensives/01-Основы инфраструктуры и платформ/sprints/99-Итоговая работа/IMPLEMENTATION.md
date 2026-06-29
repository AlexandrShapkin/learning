# Реализация итоговой работы

## 1. Resource and failure model

Document:

- host CPU, memory, disk and network capacity;
- allocatable/reserved/failure headroom;
- VM/container/Kubernetes resource ownership;
- host, node, rack-like, zone-like and cluster failure domains;
- control-plane/data-plane dependencies;
- normal, maintenance and one-failure capacity.

Every resource has owner, source of truth, lifecycle, quota and cleanup command.

## 2. Host and VM foundation

Terraform manages:

- isolated libvirt networks;
- infra and k3s VMs;
- CPU/memory resource shapes;
- persistent and ephemeral disks;
- cloud-init data references;
- predictable names/addresses;
- ownership and expiry metadata.

Requirements:

- pinned base image/checksum;
- stable Terraform addresses;
- no secrets in state/user-data/Git;
- VM replacement preserves separately owned persistent data;
- vCPU/memory/disk/network contention tests;
- snapshot and independent backup/restore distinction;
- exact cleanup and orphan checks.

## 3. Images and configuration

- reproducible VM image or well-defined cloud image baseline;
- cloud-init for first-boot identity/bootstrap only;
- Ansible or image pipeline for host baseline;
- no machine identity/SSH host keys/secrets in reusable image;
- runtime packages and versions controlled;
- image promotion and retirement policy;
- repeated configuration converges;
- failed bootstrap leads to observable replacement/recovery.

## 4. OCI registry and workloads

- local registry with persistent storage and bounded access;
- multi-stage non-root application images;
- digest-pinned deployments;
- build context/secret controls;
- SBOM and signature/provenance evidence;
- registry/image retention and garbage-collection procedure;
- runtime root filesystem/writable paths explicit;
- graceful signal handling.

## 5. Terraform state and delivery

- remote-like backend with encryption, versioning and locking;
- least-privilege state access;
- separate state ownership where lifecycle/blast radius differs;
- modules for network, VMs, storage and cluster composition;
- imports and moved-resource migration examples;
- format/validate/lint/module tests;
- plan JSON summary and destructive-action checks;
- policy for ownership, expiry, public exposure and persistent-data protection;
- post-apply probes and scheduled drift report;
- partial apply/orphan reconciliation;
- wrong-target destroy refusal.

## 6. Kubernetes cluster

Build multi-node k3s from code.

Inventory:

- Kubernetes/control-plane version;
- containerd/runtime;
- CNI and network policy implementation;
- CoreDNS;
- ingress/Gateway implementation;
- storage provisioner/CSI-like capability;
- metrics and policy components;
- node labels, taints and capacity.

The cluster is replaceable; manual node changes are either codified or discarded.

## 7. Workloads and controllers

Required:

- Deployment for stateless API;
- Job/CronJob or worker controller for background work;
- StatefulSet only for justified stable identity/storage;
- startup/readiness/liveness probes;
- termination grace and draining;
- rollout strategy and failed-rollout evidence;
- PDB compatible with capacity;
- immutable image references;
- no unmanaged naked Pods.

## 8. Networking

- Pod/Service/DNS/Gateway traffic diagram;
- internal ClusterIP and headless Services where appropriate;
- one controlled edge route with TLS;
- default-deny ingress/egress policy;
- exact DNS, application and required external flows;
- CNI enforcement tests;
- no unintended NodePort/public exposure;
- positive/negative reachability suite;
- diagnostics for endpoint, DNS, policy, ingress and node path.

## 9. Storage and data recovery

- at least two storage classes or modes with documented topology/reclaim behavior;
- dynamic PVC provisioning;
- StatefulSet claim templates;
- expansion and filesystem growth test;
- node/topology/attachment failure test;
- application-consistent database backup;
- object/file data backup where applicable;
- restore to separate namespace/cluster target;
- cluster-state backup separate from application data;
- retained volume/orphan review.

## 10. Identity, configuration and policy

- dedicated ServiceAccount per workload class;
- short-lived/projected tokens where used;
- least-privilege RBAC positive/negative tests;
- ConfigMap and external secret-reference lifecycle;
- secret rotation and workload reload/restart test;
- ResourceQuota and LimitRange;
- admission policy for non-root, resource requests, image source/digest and host access;
- scoped, owned and expiring policy exceptions;
- no default broad ServiceAccount or cluster-admin application binding.

## 11. Scheduling and capacity

- measured CPU/memory requests;
- justified CPU/memory limits;
- topology spread/anti-affinity for required failure domains;
- taints/tolerations for node roles;
- HPA with meaningful metric and stabilization;
- node allocatable/system overhead model;
- normal, rollout, maintenance and failure capacity;
- drain under PDB;
- pressure, throttling, OOM and unschedulable evidence;
- quota and scale-out lag scenario.

## 12. Cluster lifecycle and recovery

- pre-upgrade inventory and API deprecation checks;
- supported control-plane/node/add-on upgrade sequence;
- agent and server node replacement;
- certificate/token lifecycle inventory;
- etcd/control-plane backup if applicable;
- manifests/config/secrets source reconstruction;
- application-data restore;
- restore to fresh cluster;
- rollback or forward-repair for failed upgrade;
- multi-cluster option assessed and rejected/accepted through named requirements.

## 13. Self-service platform capability

Implement versioned `Workload` contract containing:

```text
owner and service identity
image digest
resource class and replicas
network exposure
configuration and secret references
storage request
support tier and expiry
```

Platform output/status includes:

- namespace/environment;
- ServiceAccount/RBAC;
- quota/limits;
- NetworkPolicy;
- Deployment/Job/StatefulSet as selected;
- Service/Gateway route;
- ownership/cost labels;
- health/status and actionable validation errors.

Portal UI is optional and never the source of truth.

## 14. Optional cloud sandbox

Map the same concepts to one provider:

- dedicated sandbox hierarchy and identity;
- virtual network/subnets/routes/NAT/private endpoint;
- replaceable compute and load balancer;
- object/block or managed data service;
- workload/IaC identity and secret;
- quotas, tags, budget and expiry;
- backup/restore evidence;
- full automated destroy and orphan verification.

Cloud sandbox must remain optional for completion when spending/availability is constrained; provider-neutral design and local evidence remain mandatory.

## 15. Diagnostics

`platformtriage` is read-only and supports:

```text
path
host
vm
container
terraform
kubernetes
network
storage
identity
capacity
versions
ownership
```

It collects bounded versions, status, events, routes, endpoints, resource pressure, state metadata and ownership identifiers. It never prints secret values or applies fixes.

## 16. Verification commands

```text
make check-host
make images
make terraform-test
make plan
make apply
make configure
make cluster-bootstrap
make platform-install
make test-network
make test-storage
make test-rbac
make test-policy
make test-scheduling
make test-backup-restore
make test-upgrade
make test-platform-api
make fault-smoke
make verify
make destroy
make cleanup-check
```

## 17. Implementation stages

### Stage 1. Host and resource model

Capacity, safety marker, failure domains and baseline diagnostics.

### Stage 2. VM/IaC foundation

Images, networks, disks, Terraform state/modules and configuration management.

### Stage 3. Registry and cluster

Registry, k3s nodes, CNI, DNS, ingress, storage and metrics.

### Stage 4. Workload isolation

Namespaces, identities, RBAC, quotas, admission and network policies.

### Stage 5. Workloads and capacity

Stateless/stateful/jobs, probes, resources, HPA, topology and disruption.

### Stage 6. Lifecycle and recovery

Drift, node replacement, upgrades, backups and fresh-cluster restore.

### Stage 7. Platform product

Self-service contract, status, golden path, ownership and cost guardrails.

### Stage 8. Diagnostics and assessment

Fault catalogue, `platformtriage`, blind incidents, clean rebuild and delayed assessment.
