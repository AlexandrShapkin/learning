# Лабораторное окружение

## Базовая система

Recommended host:

```text
platform-lab-host
├── x86_64 or arm64 with hardware virtualization
├── 8–12 CPU threads
├── 24–32 GiB RAM
├── 200+ GiB SSD
├── current supported Linux distribution
└── local network access without production credentials
```

A smaller machine can run reduced node counts. Record deviations and capacity limits.

## Required tools

- Git, Bash, Make, curl, jq, yq;
- KVM/QEMU/libvirt tools where supported;
- cloud-init and image utilities;
- Docker or Podman plus Compose;
- buildx/BuildKit-compatible image builder;
- local OCI registry;
- Terraform CLI; OpenTofu is acceptable for compatible labs;
- Ansible;
- `kubectl`;
- kind or k3d;
- k3s for multi-node VM lab;
- Helm and Kustomize;
- `ip`, `ss`, `nft`, `tcpdump`, `dig`, `traceroute`;
- `lsblk`, `mount`, `fio`, `df`, `du`;
- `systemctl`, `journalctl`, `ps`, `top`, `vmstat`, `iostat`;
- `openssl` and SSH client.

Recommended:

- Packer or equivalent image builder;
- `crictl`, `ctr`, `nerdctl`;
- `skopeo`, `regctl` or `crane`;
- Cosign and SBOM tooling;
- Cilium CLI/Hubble or another observable CNI;
- Velero or equivalent backup tool;
- Prometheus/Grafana stack;
- policy engine such as Kyverno or Gatekeeper;
- cost estimation tools for Terraform plans;
- one cloud provider CLI for optional sandbox.

## Default topology

```text
host
├── libvirt network 10.40.0.0/24
├── infra VM
│   ├── local registry
│   ├── DNS/NTP helpers optional
│   └── Terraform state backend optional
├── k3s-server-1
├── k3s-agent-1
├── k3s-agent-2
└── kind/k3d disposable clusters
```

Reduced topology may use one k3s server and one agent.

## Workspace

```text
sprints/<NN-topic>/work/
├── terraform/
├── ansible/
├── images/
├── compose/
├── kubernetes/
│   ├── base/
│   └── overlays/
├── scripts/
├── fixtures/
├── reports/
├── faults/
└── README.md
```

Do not precreate empty directories.

## Optional cloud sandbox

Use one dedicated sandbox account/project/subscription with:

- no production trust or network connectivity;
- MFA and short-lived credentials;
- explicit region allowlist;
- service quotas kept low;
- budget and cost alerts;
- resource tags/labels identifying owner, expiry and lab;
- automated destroy and orphan-resource check;
- no public access unless required and bounded;
- no real customer or personal data.

Never rely on “free tier” as a safety boundary.

## Reproducibility evidence

Record:

- host OS/kernel/architecture;
- CPU virtualization support and memory/disk capacity;
- QEMU/libvirt, container runtime, Terraform and Kubernetes versions;
- image digests and base image sources;
- Terraform provider lock file;
- Kubernetes node/runtime/CNI/CSI versions;
- resource limits and fault parameters;
- state/backend locations without secrets;
- commands to rebuild and clean every lab;
- cloud region/account alias and budget limit, not credentials.

## Safety rules

- every destructive script checks a repository marker and explicit `--lab` flag;
- cloud destroy scripts require exact sandbox account/project confirmation;
- workloads cap CPU, memory, disk, objects, nodes and duration;
- packet filters and routes are changed only in isolated namespaces/VMs;
- disk experiments use loop devices or disposable virtual disks;
- VM snapshots are not backups unless independently copied/tested;
- no privileged container or host mount without named purpose and cleanup;
- Kubernetes faults target labeled lab namespaces/nodes only;
- infrastructure state and secrets are never committed;
- cleanup verifies VMs, networks, volumes, images, containers, clusters, load balancers, disks and cloud resources.

## Commit policy

Commit:

- Terraform, Ansible and image definitions;
- Compose and Kubernetes manifests;
- provider lock files where appropriate;
- small synthetic fixtures;
- architecture diagrams and platform contracts;
- concise plan/apply/restore/failure reports;
- policy and verification scripts;
- commands to regenerate generated artifacts.

Do not commit:

- Terraform state or plan files containing values;
- kubeconfig, service-account tokens or cloud credentials;
- VM/container/cluster volumes;
- private keys and generated certificates;
- large images, backups, logs, packet captures and registry data;
- real account IDs, addresses or production topology;
- generated vendor charts/manifests without source/customization record.
