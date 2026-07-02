# Спринт 99. Итоговая работа

Ориентировочный объём: 80–115 часов.

## Задача

Создать `secure-platform-lab` — synthetic application and platform demonstrating risk-driven security architecture, identity, authorization, cryptographic lifecycle, data protection, infrastructure hardening, secure software supply chain, vulnerability management, detection and trusted incident recovery.

Проект не является production security product or offensive laboratory. Его задача — доказать через policies, tests, signed artifacts, detections and incident exercises, что выбранные controls prevent, detect or contain modeled threats within an explicitly authorized local scope.

## Reference system

Synthetic customer-workflow platform:

- Go web application and API;
- background worker and PostgreSQL;
- object storage and webhook/provider simulators;
- local identity provider and policy engine;
- local CA and secret store;
- container registry, CI/CD and Kubernetes deployment;
- security log, detection and incident-evidence stack;
- synthetic users, workloads, data and intentionally unsafe configurations.

## Target topology

```text
browser / API clients
        |
reverse proxy / gateway
        |
Go application replicas ─── PostgreSQL
        |                    object storage
        |                    worker / webhook processor
        |
identity provider ─ policy engine
        |
local CA / secret store

software and platform trust
├── source and CI/CD
├── dependency inventory and SBOM
├── signed OCI artifact and provenance
├── policy-controlled registry/deployment
├── hardened Kubernetes runtime
├── security events and detections
└── incident evidence and sectriage
```

## Repository structure

```text
work/secure-platform-lab/
├── app/
├── identity/
├── policies/
├── crypto/
├── secrets/
├── data-protection/
├── infrastructure/
├── supply-chain/
├── vulnerabilities/
├── detections/
├── incidents/
├── governance/
├── tests/
├── scripts/
├── Makefile
└── README.md
```

## Документы итоговой работы

- [`IMPLEMENTATION.md`](IMPLEMENTATION.md) — mandatory subsystems, stages and evidence.
- [`FAULTS.md`](FAULTS.md) — catalogue of 64 bounded defensive security faults.
- [`ASSESSMENT.md`](ASSESSMENT.md) — blind cases, clean reconstruction and final defense.

## Mandatory capabilities

1. Asset/risk register, data-flow diagrams and threat model.
2. Trust zones, least privilege and break-glass controls.
3. User identity lifecycle, secure sessions, MFA and recovery.
4. OAuth/OIDC federation and strict token validation.
5. Object/tenant authorization and policy-as-code.
6. Workload identity, short-lived credentials and mTLS.
7. Secure randomness, KDF, AEAD, signatures and key separation.
8. PKI, certificate issuance, rotation and revocation.
9. Secret/token lifecycle and compromise response.
10. Data classification, minimization, encryption, retention and deletion.
11. Linux, network, container, Kubernetes and cloud-like hardening.
12. Secure coding, browser, API, webhook, upload and SSRF controls.
13. Dependency inventory, SBOM and vulnerability prioritization.
14. Signed artifacts, provenance and deployment verification.
15. CI/CD, IaC, secret scanning and policy enforcement.
16. SAST, DAST, fuzzing and regression tests.
17. Security logging, endpoint/network detections and telemetry integrity.
18. Incident evidence, containment, credential rotation and trusted recovery.
19. Policies, audit evidence, exceptions and secure SDLC.
20. Read-only `sectriage` and cross-layer security review.

## Mandatory scenarios

1. Threat-model and constrain one high-risk user/data flow.
2. Revoke a user/session/MFA path after suspected account compromise.
3. Reject wrong-issuer/audience/replayed federation tokens.
4. Block cross-user and cross-tenant object access.
5. Rotate workload certificate and revoke one compromised service identity.
6. Detect tampered ciphertext/signature and complete key rotation.
7. Remove a leaked secret from current use and historical exposure paths.
8. Delete sensitive data across primary, cache/log and backup simulation.
9. Reject unsafe Linux/container/Kubernetes/cloud-like configurations.
10. Contain unauthorized ingress, egress and lateral network paths.
11. Prevent XSS, CSRF, CORS, injection, traversal and SSRF cases.
12. Verify webhook/upload safety and API abuse limits.
13. Link exact deployed artifact to SBOM, signature and provenance.
14. Reject untrusted CI context, mutable artifact and unsafe IaC.
15. Prioritize and remediate one exposed vulnerability end to end.
16. Detect credential misuse, privilege change and suspicious runtime/network behavior.
17. Preserve evidence and recover from a combined credential/application/platform incident.
18. Prove audit evidence for selected controls and identify one ineffective paper control.
19. Use `sectriage` to reconstruct identity, artifact, vulnerability, detection and incident state.

## Main results

The completed laboratory includes:

- risk register and threat model;
- identity and authorization test matrices;
- certificate, secret and key lifecycle evidence;
- data inventory and deletion verification;
- hardened host/network/container/Kubernetes configurations;
- application/API/browser security regression tests;
- SBOM, signature, provenance and admission evidence;
- vulnerability inventory and remediation records;
- detection rules and synthetic test cases;
- incident evidence, timeline and trusted-recovery report;
- governance/evidence catalogue and secure-SDLC map;
- `sectriage` output and systemic security review;
- 64 reproducible defensive fault definitions.

## Execution order

1. Build the reference system, asset inventory and threat model.
2. Add user/workload identity and authorization.
3. Add cryptographic, PKI, secret and data controls.
4. Harden Linux, network, containers, Kubernetes and cloud-like access.
5. Harden application, browser and API boundaries.
6. Build SBOM/signing/provenance and CI/IaC controls.
7. Add vulnerability and security-testing workflows.
8. Add security events, detections and evidence protection.
9. Run incident containment and trusted recovery.
10. Add governance evidence, `sectriage` and final assessment.

## Artifacts to commit

- application and policy source;
- synthetic identity/authorization fixtures without secrets;
- threat models and control mappings;
- infrastructure and admission policies;
- scanner/fuzzer/test configurations with strict scope;
- SBOM/provenance/signature verification commands;
- detection rules and tests;
- sanitized findings, timelines and recovery reports;
- read-only diagnostic tooling;
- commands to regenerate ephemeral certificates/secrets/evidence;
- links to generalized `knowledge` notes.

Do not commit:

- private keys, passwords, tokens, cookies or recovery codes;
- real personal, company or customer data;
- raw sensitive logs, captures, dumps or forensic bundles;
- database/registry/object-store volumes;
- cloud credentials, kubeconfigs or identity-provider exports with secrets;
- malware, exploit kits or internet scanning automation;
- weaponized payload collections;
- large generated artifacts.

## Safety and authorization

- every target is local, synthetic, allowlisted and disposable;
- scanners and fuzzers have route, rate, time, memory and request limits;
- active validation is limited to one exact local control hypothesis;
- no public, employer, customer or third-party systems are tested;
- no phishing, password spraying, malware deployment or persistence outside the lab;
- network policies and packet captures target exact namespaces/interfaces;
- incident evidence is redacted and access-controlled;
- cleanup revokes every synthetic credential and removes temporary identities, rules, volumes and captures.

## Результат для базы знаний

Итоговая работа должна завершить или исправить заметки по risk, threat modeling, IAM, OAuth/OIDC, authorization, workload identity, cryptography, PKI, secrets, data protection, host/network/platform security, AppSec, supply chain, vulnerability management, detection, incident response and governance.

Configurations, test cases, detections and synthetic incident evidence remain in `learning`; generalized mechanisms move to `knowledge`.
