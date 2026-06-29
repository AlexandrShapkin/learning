# Ресурсы интенсива

Это общая библиография. Внутри каждого спринта указан обязательный minimum route. Не требуется последовательно читать всё.

## Compute, datacenter and virtualization

- Linux kernel, KVM, QEMU and libvirt official documentation.
- Intel VT-x/AMD-V architecture references as optional deepening.
- cloud-init official documentation.
- *The Datacenter as a Computer*, selected chapters.
- *Systems Performance*, Brendan Gregg, selected capacity/resource chapters.
- vendor-neutral server, RAID, power and thermal references.

## Containers and OCI

- Linux namespaces, cgroups v2, capabilities, seccomp and mount documentation.
- OCI Image, Runtime and Distribution specifications.
- Docker Engine, Build, Compose and registry documentation.
- containerd, runc, CRI and rootless-container documentation.
- *Container Security*, Liz Rice, selected mechanism chapters.
- supply-chain specifications and tools: SBOM, signatures and provenance.

## Cloud platforms

- NIST cloud service/deployment model definitions.
- Architecture and service documentation of one selected cloud provider.
- Well-Architected Frameworks used as provider perspectives, not universal truth.
- Cloud networking, IAM, compute, object/block/file storage and load-balancer docs.
- FinOps Foundation material for allocation, forecasting and optimization.
- *Cloud Native Infrastructure*, selected chapters.

## Infrastructure as Code

- Terraform language, providers, state, modules, testing and CLI documentation.
- OpenTofu documentation as compatible alternative reference.
- provider documentation for libvirt/local/cloud/Kubernetes labs.
- Ansible documentation.
- cloud-init and optional Packer documentation.
- policy-as-code documentation for selected policy engine.
- *Terraform: Up & Running*, selected chapters, checked against current official docs.

## Kubernetes

- Kubernetes official concepts, tasks, references and API documentation.
- Kubernetes Enhancement Proposals for mechanisms that require deeper context.
- containerd/CRI, CNI, CSI, CoreDNS, Gateway API and metrics APIs documentation.
- kind, k3d and k3s official docs.
- Helm and Kustomize official docs.
- *Kubernetes Up & Running* as overview.
- *Kubernetes Patterns* and *Production Kubernetes*, selected trade-offs.

## Platform engineering

- CNCF platform engineering and platform maturity references.
- Team Topologies, only for interaction modes and cognitive-load context.
- Backstage or another developer-portal documentation as optional implementation.
- OpenAPI/JSON Schema/CUE or equivalent for platform contracts.
- cloud-native application and twelve-factor references used critically.
- SRE and FinOps material where the platform owns reliability/cost capabilities.

## Diagnostics and lifecycle

- Linux performance, networking and storage diagnostic documentation.
- Kubernetes troubleshooting, events, metrics and audit references.
- etcd backup/restore documentation for selected distribution.
- Velero or equivalent backup documentation.
- provider status/quotas/limits documentation.
- Prometheus, OpenTelemetry and log collection docs for basic infrastructure evidence.

## Rules for sources

1. Specifications and official docs define mechanisms; books provide models and trade-offs.
2. Version-specific guarantees are verified against the exact installed provider/runtime/cluster.
3. A cloud or Kubernetes recommendation must name workload, failure and cost assumptions.
4. Tutorials are not used as proof of isolation, persistence or recovery guarantees.
5. Commands and manifests are tested in the laboratory and pinned where reproducibility requires it.
6. Provider “best practices” are compared with constraints and alternatives.
7. Do not copy proprietary diagrams, paid course material or large documentation fragments.
8. Final notes state source version/date when behavior is release-sensitive.
