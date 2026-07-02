# Итоговая проверка

## Blind security exercise

Solve at least 28 hidden cases:

- four risk/IAM cases;
- four cryptography/secrets/data cases;
- four host/network/platform cases;
- four application/API cases;
- four supply-chain/CI cases;
- four vulnerability/detection cases;
- two incident-response cases;
- two governance/cross-layer cases.

For each case:

```text
Exact asset, user/business impact and suspected security property
Authorized scope, topology, identities and trust boundaries
Relevant release, policy, certificate, secret and artifact revisions
Preserved events, logs, access decisions, hashes and evidence
Timeline with facts, hypotheses and uncertainty
Competing explanations and one discriminating read-only check
First control failure and contributing conditions
Minimal containment or correction
Identity, data, artifact, policy and user verification
Regression test, detection, policy or architecture improvement
```

## Clean reconstruction

From clean checkout and empty laboratory state:

1. verify tools, host capacity and scope markers;
2. build the synthetic application and data stores;
3. provision identity provider, policy engine, CA and secret store;
4. create synthetic users, workloads, roles and test data;
5. configure sessions, MFA, federation and authorization;
6. configure PKI, secrets, encryption, retention and deletion;
7. harden host, network, container, Kubernetes and cloud-like controls;
8. build, scan, generate SBOM/provenance and sign the artifact;
9. enforce CI/CD, IaC and deployment policies;
10. run secure coding, browser, API, webhook and upload tests;
11. run vulnerability inventory, review, SAST, DAST and fuzz tests;
12. provision security logging and detection rules;
13. run endpoint/network and telemetry-loss tests;
14. execute incident containment and trusted recovery;
15. generate governance/audit evidence and run `sectriage`;
16. revoke all credentials and destroy identities, policies, volumes and captures safely.

## Complete combined incident

Perform one scenario:

1. a dependency update introduces an exposed application weakness;
2. a synthetic user session is misused to reach a vulnerable API path;
3. object-level authorization and outbound URL policy are partially misconfigured;
4. a workload obtains broader cloud-like access than intended;
5. an unsigned/mismatched artifact is discovered in one environment;
6. security logs contain both useful evidence and one sensitive-field leak;
7. a noisy detection delays triage while endpoint telemetry later identifies unusual process/network behavior;
8. the affected identity, tokens, certificates, workload and egress path are contained;
9. evidence is preserved before rebuild;
10. known-good signed artifact and corrected policy are deployed;
11. secrets/certificates/sessions are rotated or revoked;
12. affected data and unauthorized actions are scoped;
13. detections, regression tests and policy gates are updated;
14. residual risk and governance evidence are reviewed.

## Supply-chain and identity exercise

1. submit a synthetic untrusted pull request attempting to access protected pipeline context;
2. introduce a mutable artifact tag and mismatched SBOM/provenance;
3. rotate identity-provider signing keys and workload certificates;
4. revoke one user, one refresh token and one workload identity;
5. prove that deployment policy rejects the substituted artifact and stale identities;
6. demonstrate controlled exception/break-glass behavior and full audit evidence.

## Final defense

Answer using project evidence:

1. Security objectives and properties?
2. Asset, threat, vulnerability, exposure and risk?
3. Inherent versus residual risk?
4. Trust boundary and attack surface?
5. Defense in depth versus duplicated controls?
6. Least privilege and zero trust?
7. Identification, authentication and authorization?
8. Password, MFA and account-recovery lifecycle?
9. Session rotation, expiry and revocation?
10. OAuth 2.0 roles and Authorization Code with PKCE?
11. OpenID Connect token and claim validation?
12. RBAC, ABAC and ReBAC?
13. Object- and tenant-level authorization?
14. Workload identity and mTLS?
15. Secure randomness, hashes, KDF and MAC?
16. AEAD, associated data and nonce requirements?
17. Encryption versus signatures?
18. PKI trust chains and TLS identity validation?
19. Certificate rotation and revocation?
20. Secret, key and token lifecycle?
21. Data classification, minimization and retention?
22. Encryption, deletion and backup restoration?
23. Linux least privilege, capabilities and auditing?
24. Segmentation, egress control and VPN boundaries?
25. Container image and runtime hardening?
26. Kubernetes identity, RBAC, Pod Security and admission?
27. Cloud IAM, metadata and storage protection?
28. Input validation, canonicalization and dangerous operations?
29. XSS, CSP, CSRF, cookies and CORS?
30. API authorization, SSRF, webhooks and uploads?
31. Dependency inventory, SBOM and vulnerability data?
32. Artifact signatures, provenance and trusted builders?
33. CI/CD trust boundaries and short-lived deployment identity?
34. IaC policy and security exceptions?
35. SAST, DAST, fuzzing and manual review?
36. Vulnerability risk prioritization and runtime verification?
37. Security event design and detection hypotheses?
38. Endpoint/network telemetry and threat intelligence?
39. Incident evidence and chain-of-custody concepts?
40. Containment, eradication and trusted recovery?
41. Governance, policy, standard and procedure?
42. Audit design versus operating effectiveness?
43. Secure SDLC and risk-tiered gates?
44. Security metrics and control effectiveness?
45. How does `sectriage` remain safe and useful?
46. Which threats and residual risks remain outside the tested model?

Every answer references a policy, test, identity event, authorization decision, artifact digest, signature, finding, detection, evidence hash or incident timeline.

## Completion criteria

The intensive is complete when:

- clean reconstruction creates the complete local security platform;
- asset, data, trust-boundary and threat models match deployment;
- user/workload identities are unique, least-privilege and revocable;
- sessions, MFA, federation and authorization pass negative tests;
- cryptographic controls use maintained libraries and tested lifecycle behavior;
- certificates, secrets and tokens rotate/revoke without uncontrolled exposure;
- sensitive data is minimized, encrypted, retained and deleted as documented;
- host, network, container, Kubernetes and cloud-like controls reject unsafe configurations;
- web/API/browser/file/outbound-request regression tests pass;
- exact artifact has linked SBOM, signature and provenance;
- CI/CD and IaC trust policies reject untrusted changes;
- vulnerabilities are prioritized and verified across source/artifact/runtime;
- detections are tested and telemetry loss is visible;
- incident evidence survives containment and recovery uses known-good state;
- credentials, persistence and vulnerable paths are verified absent after recovery;
- governance policies map to real controls and evidence;
- `sectriage` is read-only, bounded and redacted;
- all 64 faults are reproducible or have documented equivalent substitutes;
- at least 28 blind cases and two combined cases are solved;
- all 46 defense answers are evidence-based;
- cleanup finds no unintended identity, session, token, certificate, secret, rule, capture, endpoint or volume;
- generalized knowledge is transferred to `knowledge`.

## Delayed assessment

After 7–14 days without rereading:

1. rebuild the laboratory from clean state;
2. answer the 46 defense questions;
3. diagnose six random faults including one IAM, one crypto/data, one platform, one AppSec, one supply-chain and one detection/incident case;
4. write one threat model and authorization matrix for a new feature;
5. rotate one user/workload credential and one certificate hierarchy element;
6. prove one encrypted-data deletion and restore/re-deletion flow;
7. harden one new container/Kubernetes workload;
8. generate SBOM, sign artifact and verify provenance policy;
9. triage and remediate one vulnerability from source through runtime;
10. create and test one security detection;
11. preserve evidence, contain and recover from one synthetic incident;
12. use `sectriage` without mutating or exposing sensitive state;
13. identify one low-value control to remove and one architectural risk to prioritize;
14. explain which remaining work belongs to specialist AppSec, cloud security, SOC, forensics, compliance or offensive-security roles.

После delayed assessment уровень 3–4 можно считать закреплённым.
