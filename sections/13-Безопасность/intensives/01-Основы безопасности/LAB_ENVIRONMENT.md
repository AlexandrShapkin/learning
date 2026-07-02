# Лабораторное окружение

## Базовая система

Recommended workstation or disposable VM:

```text
secure-platform-lab
├── 8–12 CPU threads
├── 24–32 GiB RAM
├── 180+ GiB SSD
├── current supported Linux distribution
└── isolated local network with synthetic identities and data
```

Reduced topology can use 16 GiB RAM by disabling the full log stack and running fewer platform replicas. Record reductions because isolation, availability and detection experiments depend on topology.

## Required tools

- Git, Bash, Make, curl, jq and yq;
- Go toolchain;
- Docker or Podman and Compose;
- `kubectl` plus kind/k3d/k3s;
- PostgreSQL client/server or container;
- OpenSSL;
- `ss`, `tcpdump`, `nft`/`iptables` and OpenSSH client;
- Trivy or Grype;
- Syft;
- Cosign;
- Gitleaks;
- Semgrep, gosec and `govulncheck`;
- checksums and standard Linux process/filesystem utilities.

Recommended:

- Keycloak, Dex or equivalent local identity provider;
- OPA and Conftest;
- step-ca;
- Vault in dev/local mode only;
- OWASP ZAP baseline scanner;
- Falco and auditd;
- OpenTelemetry Collector, Prometheus and Grafana;
- local OpenSearch/Loki/SIEM-like store;
- kubectl-who-can or equivalent authorization inspection;
- kube-bench and kube-linter/polaris as supporting checks;
- Helm and Kustomize;
- MinIO for object/data-protection exercises;
- `age` or SOPS for encrypted configuration examples;
- local mail/webhook receiver for MFA/session/detection tests.

## Default topology

```text
browser/test client
        |
        v
reverse proxy / API gateway
        |
Go web/API replicas ─── PostgreSQL
        |               object storage
        |               background worker
        |
identity provider ─ policy engine
        |
local CA / secret store

platform and evidence
├── container registry
├── CI/CD simulation
├── Kubernetes cluster
├── audit/security logs
├── detections and local alert receiver
└── synthetic incident evidence store
```

## Laboratory identities

Use synthetic identities only:

- normal user;
- privileged operator;
- application administrator;
- support/read-only user;
- CI workload;
- API service workload;
- background worker workload;
- emergency/break-glass identity;
- disabled/expired identity;
- simulated malicious or compromised identity restricted to the lab.

Never reuse real passwords, emails, access tokens, certificates or cloud accounts.

## Scope and authorization

Allowed targets:

- local containers and VMs created for the intensive;
- local Kubernetes cluster and namespaces marked for the laboratory;
- intentionally vulnerable synthetic application routes;
- loopback or private laboratory network ranges;
- local mock identity/provider/webhook endpoints.

Prohibited:

- public websites, APIs, IP ranges or registries;
- organization, employer or customer systems;
- internet-wide scanning or credential testing;
- password spraying, phishing, social engineering or malware deployment;
- exploitation beyond what is required to validate one local defensive control;
- persistence outside the disposable lab.

## Workspace

```text
sprints/<NN-topic>/work/
├── app/
├── identity/
├── policies/
├── crypto/
├── secrets/
├── infrastructure/
├── supply-chain/
├── detections/
├── incidents/
├── evidence/
├── tests/
└── README.md
```

Create only directories actually used.

## Sensitive-data rules

- use synthetic names, identifiers and business records;
- never commit private keys, tokens, session cookies or password hashes derived from real passwords;
- generate ephemeral CA, certificates and secrets per laboratory run;
- store secrets in ignored runtime files or local secret manager;
- redact Authorization, Cookie, Set-Cookie and credential-bearing headers;
- bound audit/event payload size;
- do not collect unrelated host or browser data;
- delete ephemeral credentials and encrypted test data during cleanup.

## Security-testing limits

- scanners target an explicit allowlist and fixed port/path scope;
- request rates and concurrency are capped;
- destructive methods are disabled unless a synthetic disposable resource requires them;
- fuzzers have time, memory, corpus and target limits;
- ZAP or equivalent runs in baseline/passive mode by default;
- active tests require an exact local route and rollback;
- no exploit payload repository is committed;
- findings contain reproduction sufficient for local validation, not weaponized automation;
- packet capture and forensic collection use exact process/interface/time filters.

## Reproducibility evidence

Record:

- host OS/kernel/architecture;
- Go, database, identity provider, policy engine and cluster versions;
- image digests and SBOM/provenance tool versions;
- release, configuration and policy revisions;
- identity, role and authorization test matrix;
- certificate/secret issuance and rotation epochs;
- scanner ruleset/database date where relevant;
- exact synthetic fault or control-failure condition;
- expected control, detection and recovery result;
- cleanup and credential-revocation result.

## Commit policy

Commit:

- application and policy source;
- synthetic identity/authorization fixtures without secrets;
- infrastructure and security configuration;
- threat models and data-flow diagrams;
- SBOM/provenance/signature verification commands;
- bounded scanner/fuzzer configurations;
- detection rules and tests;
- sanitized incident timelines and findings;
- remediation evidence;
- commands to regenerate ephemeral artifacts.

Do not commit:

- private keys, tokens, passwords, cookies or recovery codes;
- real personal, customer or company data;
- raw sensitive logs, memory dumps or packet captures;
- registry/database/object-store volumes;
- active cloud credentials or kubeconfigs;
- exploit kits, malware or internet scanning scripts;
- unredacted forensic bundles;
- large generated artifacts.
