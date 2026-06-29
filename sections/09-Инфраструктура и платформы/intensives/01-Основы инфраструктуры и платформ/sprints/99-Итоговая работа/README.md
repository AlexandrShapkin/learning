# Спринт 99. Итоговая работа

Ориентировочный объём: 60–90 часов.

## Задача

Создать `platform-foundation-lab` — воспроизводимую локальную инфраструктурную платформу, связывающую виртуальные машины, container registry, Terraform, configuration management, multi-node Kubernetes, network/storage/identity policies, self-service workload contract, backup/restore, capacity/cost evidence and controlled fault injection.

Проект не является production cloud or universal Kubernetes distribution. Его задача — доказать understanding of resource, state, reconciliation, isolation and recovery boundaries through one bounded platform that can be rebuilt and destroyed safely.

## Architecture

```text
Linux host
├── KVM/QEMU/libvirt
│   ├── infra VM
│   │   ├── local OCI registry
│   │   ├── state/backup helpers
│   │   └── optional DNS/object storage
│   ├── k3s-server-1
│   ├── k3s-agent-1
│   └── k3s-agent-2
├── Terraform
│   ├── virtual networks
│   ├── VMs/disks
│   ├── cluster/bootstrap resources
│   └── optional cloud sandbox module
├── cloud-init + Ansible/image definitions
├── k3s + containerd
│   ├── CNI and NetworkPolicy
│   ├── ingress/Gateway and DNS
│   ├── StorageClass/CSI-like storage
│   ├── RBAC, quotas and admission policy
│   ├── metrics/log/event evidence
│   └── backup/restore components
└── self-service platform contract
    └── renders/reconciles one supported application workload
```

## Workloads

Synthetic platform consumers:

- stateless Go API;
- PostgreSQL or another stateful database;
- background Job/CronJob worker;
- object storage client;
- internal and external Service routes;
- application Secret/ConfigMap and workload identity;
- one horizontally scaled workload;
- one stateful workload with backup/restore;
- one platform-created workload from self-service contract.

## Repository structure

```text
work/platform-foundation-lab/
├── terraform/
│   ├── modules/
│   ├── environments/lab/
│   └── tests/
├── images/
├── cloud-init/
├── ansible/
├── compose/
├── kubernetes/
│   ├── bootstrap/
│   ├── platform/
│   ├── workloads/
│   ├── policies/
│   └── overlays/lab/
├── platform-api/
├── faults/
├── scripts/
├── fixtures/
├── reports/
├── docs/
├── Makefile
└── README.md
```

## Документы итоговой работы

- [`IMPLEMENTATION.md`](IMPLEMENTATION.md) — mandatory capabilities, stages and evidence.
- [`FAULTS.md`](FAULTS.md) — catalogue of 60 bounded infrastructure/platform faults.
- [`ASSESSMENT.md`](ASSESSMENT.md) — blind incidents, rebuild, recovery and final defense.

## Mandatory platform capabilities

1. Host environment check and safety marker.
2. Terraform-managed isolated networks, VMs and disks.
3. Versioned/locked remote-like state backend or faithful local simulation.
4. Pinned VM image with cloud-init and Ansible/image baseline.
5. Local OCI registry with digest-pinned workload images.
6. Multi-node k3s cluster rebuilt from code.
7. Namespaced application environments with RBAC, quotas and default-deny policy.
8. Ingress/Gateway, DNS and internal Service discovery.
9. Dynamic/static persistent storage plus independent application backup.
10. Requests, limits, topology spread, PDB and HPA.
11. Cluster/control-plane and application-data backup/restore.
12. Upgrade and node replacement procedure.
13. Self-service workload contract with status and generated resources.
14. Read-only `platformtriage` collector.
15. Fault injection with bounded cleanup.
16. Optional cloud sandbox mapping for network/IAM/storage/compute concepts.

## Mandatory scenarios

1. Clean host prerequisites → complete platform build.
2. Push signed/inspectable image to local registry and deploy by digest.
3. Deploy stateless API through self-service contract.
4. Deploy stateful workload with PVC and restore path.
5. Scale API and observe scheduler/HPA/capacity behavior.
6. Drain/replace a node without violating stated availability.
7. Rotate workload secret/identity safely.
8. Apply network default-deny and permit exact flows.
9. Detect and reconcile Terraform drift.
10. Interrupt infrastructure apply/bootstrap and recover.
11. Upgrade cluster/add-ons one supported step.
12. Restore cluster/application into fresh isolated target.
13. Exhaust quota/capacity safely and recover.
14. Run one-zone/host failure simulation.
15. Provision and destroy optional cloud sandbox resources with budget/tag/identity controls.
16. Diagnose a combined cross-layer incident through `platformtriage`.

## Main results

The completed platform must include:

- resource and failure-domain map;
- physical/host capacity and maintenance headroom model;
- VM image/network/storage lifecycle;
- OCI image reproducibility, SBOM/signature/provenance evidence;
- container runtime/network/volume diagnostics;
- cloud responsibility/network/IAM/storage/cost mapping;
- Terraform modules, remote state, locking, imports and migrations;
- IaC plan/policy/test/drift pipeline;
- Kubernetes reconciliation/workloads/network/storage/access/scheduling lifecycle;
- backup, restore, upgrade and node replacement;
- self-service platform contract and golden path;
- capacity/cost and support boundaries;
- read-only diagnostics and fault catalogue.

## Execution order

1. Validate host and define resource/failure budgets.
2. Build VM images, network and storage through Terraform.
3. Configure infra services and local registry.
4. Bootstrap multi-node k3s and inventory versions/components.
5. Install network, ingress, storage, metrics and policy capabilities.
6. Add namespaces, identities, quotas, admission and secrets path.
7. Deploy reference stateless/stateful/background workloads.
8. Add autoscaling, disruption and topology controls.
9. Implement backup, restore, upgrade and replacement procedures.
10. Build self-service workload contract and status path.
11. Add IaC/Kubernetes tests, drift and policy checks.
12. Implement `platformtriage`, faults and capacity/cost reports.
13. Run blind incidents, clean rebuild and delayed assessment.

## Artifacts to commit

- Terraform/module/configuration code and provider lock files;
- cloud-init, Ansible and image build definitions;
- Compose and Kubernetes manifests/customizations;
- platform API/schema/controller/renderer source;
- small synthetic fixtures;
- resource/failure/data-flow diagrams;
- policies, tests and verification scripts;
- concise capacity, cost, upgrade and recovery reports;
- fault definitions and sanitized incident cards;
- commands to regenerate plans, graphs and large artifacts;
- links to generalized `knowledge` notes.

Do not commit:

- Terraform state/plan, kubeconfig or credentials;
- cloud access keys, service-account tokens or private keys;
- VM/container/cluster/registry volumes;
- backups containing secrets or application data;
- large images, packet captures, logs and generated reports;
- real account IDs, addresses or production topology;
- unbounded fault/load/cost scripts.

## Safety

- all local resources use dedicated networks, names, labels and state;
- destructive commands require repository marker, exact target and `--lab`;
- cloud operations require sandbox identity, budget and automatic expiry;
- workloads cap CPU, memory, storage, replicas, retries and duration;
- network/storage faults operate only on labeled namespaces/VMs/devices;
- backups/restores use synthetic data and isolated targets;
- cleanup verifies VMs, networks, volumes, images, containers, clusters, state locks, cloud resources and credentials.

## Результат для базы знаний

Итоговая работа должна завершить или исправить заметки по resource/failure domains, virtualization, containers, OCI, cloud compute/network/storage/IAM/cost, Terraform state/modules/evolution, Kubernetes architecture/workloads/network/storage/access/scheduling/lifecycle, platform engineering and cross-layer diagnostics.

Source code, manifests, state experiments, reports and incident evidence remain in `learning`; generalized mechanisms move to `knowledge`.
