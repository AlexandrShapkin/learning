# Реализация итоговой работы

## 1. System, assets and threat model

Create before security controls:

- context and container data-flow diagrams;
- asset and data inventories;
- actors, identities and trust boundaries;
- realistic threat scenarios and assumptions;
- security objectives and critical invariants;
- control owners and residual risks.

Minimum invariants:

```text
one user or tenant cannot access another tenant's protected objects
only authorized identities perform privileged or sensitive actions
one compromised workload cannot obtain unrelated secrets or data
artifacts are deployed only when digest, signature and provenance satisfy policy
sensitive data is collected, retained and deleted according to defined purpose
security evidence cannot be silently removed by the workload being investigated
```

## 2. Identity and account lifecycle

Implement:

- synthetic user registration/invitation and verification;
- password storage with maintained KDF;
- login throttling without account enumeration;
- session rotation, expiry and revocation;
- MFA enrollment, challenge, backup/recovery and reset;
- account disable/delete and global logout;
- privileged reauthentication;
- security events for identity lifecycle.

Test credential stuffing simulation only with synthetic accounts and strict request limits.

## 3. Federation and token handling

Use local Keycloak/Dex or equivalent.

Required:

- Authorization Code with PKCE;
- exact redirect allowlist;
- state and nonce validation;
- issuer, audience, signature, expiry and scope checks;
- separation of ID, access and refresh tokens;
- refresh rotation/replay behavior;
- signing-key rotation;
- logout/revocation behavior and delay evidence.

## 4. Authorization and policy

Provide:

- subject/action/resource/context model;
- object- and tenant-level checks;
- RBAC for broad job functions;
- ABAC/ReBAC for ownership, relationship and environment context;
- OPA or equivalent policy-as-code;
- policy unit/integration tests;
- policy cache/revocation model;
- support/delegated access and break-glass workflow;
- deny-by-default enforcement in API and background paths.

## 5. Workload identity

Implement:

- separate API, worker, CI and administrative identities;
- short-lived certificates/tokens;
- local trust domain and CA;
- mTLS on at least one service path;
- service-level authorization;
- bootstrap identity and issuance audit;
- leaf/intermediate/root rotation;
- compromised workload revocation and stale-credential rejection.

## 6. Applied cryptography

Use maintained libraries only.

Required:

- CSPRNG-based tokens;
- password KDF with parameter versioning;
- HMAC for one integrity/authenticity use case;
- AEAD for sensitive field or object data;
- associated-data context binding;
- detached signature for release/data manifest;
- key separation and version identifiers;
- envelope-encryption rotation;
- tamper, nonce, wrong-context and old/new-key tests.

No custom cryptographic protocol or primitive implementation is accepted as a production control.

## 7. PKI and TLS

Create:

- offline-like local root and issuing intermediate;
- server/client leaf profiles with SAN/EKU constraints;
- automated issuance/renewal;
- TLS and mTLS endpoints;
- certificate inventory and expiry monitoring;
- overlapping rotation procedure;
- leaf/intermediate compromise procedures;
- trust-store cleanup after migration;
- tests for wrong hostname, wrong purpose, expiry and unknown issuer.

## 8. Secrets and tokens

Implement:

- secret inventory with owner, consumer, scope and expiry;
- Vault/local secret manager with workload authentication;
- no static root token or credentials in source/image;
- short-lived database/API credentials where practical;
- dual-read/single-write rotation;
- emergency revoke and dependent-service restart order;
- CI/runtime secret separation;
- secret access audit events;
- Git/image/log/history scanning and leak response.

## 9. Data protection

Create:

- data classification and flow inventory;
- collection purpose and minimization decisions;
- field/object/transport encryption choices;
- restricted-data access policies and events;
- pseudonymization/tokenization where justified;
- retention jobs and deletion workflow;
- cache/queue/log/analytics/backup handling;
- restore-time re-deletion/reconciliation;
- synthetic breach-scope calculation.

## 10. Linux and network hardening

Required:

- dedicated non-root service accounts;
- least-privilege file ownership and permissions;
- systemd/container sandbox and resource limits;
- capability reduction, seccomp and MAC profile where available;
- key-based administrative access and no shared accounts;
- service/port/package inventory and reduction;
- audit events for privilege and protected-file changes;
- network flow matrix;
- default-deny ingress, egress and lateral policies;
- protected administrative path and metadata/internal endpoint controls.

## 11. Container and Kubernetes security

Implement:

- minimal pinned-base image;
- non-root runtime and no privilege escalation;
- read-only root filesystem and explicit writable mounts;
- dropped capabilities and seccomp;
- restricted Pod Security posture;
- least-privilege service accounts and RBAC;
- default-deny NetworkPolicy;
- no privileged/host namespace/hostPath use without documented exception;
- admission policy for image identity and workload restrictions;
- audit/Falco detection for one suspicious runtime behavior.

## 12. Cloud-like security

Simulate or use a dedicated provider sandbox only.

Required:

- separate human, CI and workload roles;
- short-lived role assumption;
- trust and permission policies;
- private object storage and explicit public-access prevention;
- metadata-service protection;
- encryption-key administration/use separation;
- control-plane and sensitive data-access events;
- cross-account/project access with expiry and conditions;
- break-glass identity and review.

No real production account is used.

## 13. Application and browser security

Implement and test:

- typed validation and safe parsing;
- parameterized database queries;
- safe process invocation without shell interpolation;
- canonical path and archive extraction controls;
- parser/body/file resource limits;
- contextual output encoding and safe templates;
- CSP, cookie, CSRF, CORS and framing controls;
- safe redirects and browser token handling;
- negative and Go fuzz tests.

## 14. API, webhooks and uploads

Required:

- function/object/tenant authorization matrix;
- mass-assignment prevention;
- rate, concurrency, query and export-cost limits;
- outbound URL policy blocking loopback/private/metadata/redirect escapes;
- signed webhooks using raw bytes, timestamp and event ID;
- idempotent webhook processing;
- uploads outside executable/static roots;
- generated filenames, size/type/archive limits;
- authorized downloads and safe response headers.

## 15. Dependencies and vulnerability data

Create:

- source/module dependency inventory;
- OCI image package inventory;
- SPDX or CycloneDX SBOM;
- `govulncheck` plus Trivy/Grype results;
- normalized/deduplicated findings;
- reachability, exposure and business context;
- update/replacement/exception decisions;
- exact artifact digest linkage;
- emergency-advisory lookup procedure.

## 16. Software supply chain

Implement:

- reproducible or controlled build inputs;
- immutable OCI digest;
- SBOM and provenance for exact artifact;
- Cosign/local signing and verification;
- trusted signer/repository/workflow constraints;
- pinned actions, build images and downloads;
- build-once promotion;
- registry and deployment admission verification;
- signing/trust-root compromise response.

## 17. CI/CD and IaC security

Required:

- event/trust/credential map for workflows;
- untrusted PR/fork isolation;
- minimal workflow token permissions;
- short-lived deployment identity;
- disposable or cleaned self-hosted runner model;
- trusted cache/artifact boundaries;
- Gitleaks and revocation workflow;
- Semgrep/gosec/`govulncheck` gates;
- OPA/Conftest policy for IAM, storage, Kubernetes and logging;
- environment approval and exception process.

## 18. Security testing

Provide bounded:

- threat-model-driven manual review;
- SAST with triage and tuned rules;
- ZAP baseline/passive checks against explicit local routes;
- Go fuzz targets for parsers, files and authorization boundaries;
- negative authorization/browser/API tests;
- false-positive evidence and suppression lifecycle;
- remediation and regression tests;
- scanner/fuzzer timeout, memory, rate and corpus limits.

## 19. Vulnerability management

Create workflow for:

- exact affected asset and version;
- CVSS/EPSS/KEV plus reachability/exposure/business context;
- risk-tiered remediation targets;
- patch, configuration, isolation, replacement or acceptance;
- exception owner, expiry and compensating control;
- source, artifact and runtime verification;
- backlog age and recurrence metrics;
- emergency inventory and response.

## 20. Security events and detections

Collect and normalize:

- login, MFA, session and recovery events;
- authorization denies and privileged grants;
- secret/certificate/key access and rotation;
- data export/deletion/access;
- CI/CD, registry and deployment events;
- Kubernetes/cloud control-plane events;
- process, file, privilege and network events.

Create at least fifteen tested detection hypotheses with benign, positive and missing-telemetry cases. Protect log access/integrity and monitor the pipeline independently.

## 21. Incident response and evidence

Exercise a combined incident involving synthetic credential misuse, application control failure and platform exposure.

Required:

- declaration, severity, roles and communication;
- facts/hypotheses/decisions log;
- evidence source, timestamp, collector, hash and access record;
- identity, token, certificate, network and workload containment;
- vulnerable route and persistence checks;
- known-good artifact/configuration rebuild;
- credential/key rotation;
- affected-data and action scope;
- heightened monitoring and recovery validation;
- corrective actions and detection improvements.

## 22. Governance and assurance

Create:

- security charter and policy hierarchy;
- testable standards for IAM, data, development and incidents;
- control/risk/asset/evidence mapping;
- exception and risk-acceptance process;
- mock audit of design, implementation and operating effectiveness;
- third-party access/data/dependency review;
- privacy purpose, minimization, retention and processor map;
- evidence repository with minimal sensitive content;
- policy lifecycle and review schedule.

## 23. Secure SDLC and `sectriage`

Map security activities to idea, design, code, build, deploy, operate and retire.

Read-only commands:

```text
sectriage identity
sectriage access
sectriage secret
sectriage certificate
sectriage artifact
sectriage vulnerability
sectriage policy
sectriage detection
sectriage incident
sectriage data
sectriage evidence
```

The tool accepts exact subject/resource/digest/control/time scopes, redacts sensitive fields, limits output and never changes identity, policy, secret, deployment or incident state.

## 24. Verification commands

```text
make check
make up
make test-identity
make test-authorization
make test-crypto
make test-pki
make test-secrets
make test-data
make test-host-network
make test-kubernetes
make test-appsec
make test-api
make sbom
make sign
make verify-supply-chain
make test-pipeline-policy
make test-security
make test-detections
make incident-exercise
make triage-smoke
make audit-evidence
make verify
make down
make cleanup-check
```

## 25. Implementation stages

### Stage 1. Risk and identity

Assets, threat model, architecture, user/workload identity and authorization.

### Stage 2. Cryptography and data

Randomness, passwords, AEAD, PKI, secrets, classification and deletion.

### Stage 3. Infrastructure

Linux, network, container, Kubernetes and cloud-like hardening.

### Stage 4. Application

Secure coding, browser, API, webhook, upload and SSRF controls.

### Stage 5. Supply chain

Dependencies, SBOM, signatures, provenance, CI/CD and IaC policy.

### Stage 6. Assurance

Security review, scanners, fuzzing and vulnerability management.

### Stage 7. Detection and response

Events, detections, evidence, containment and trusted recovery.

### Stage 8. Governance and assessment

Policies, audit evidence, `sectriage`, clean reconstruction and blind cases.
