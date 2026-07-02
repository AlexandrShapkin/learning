# Ресурсы интенсива

Это общая библиография. Внутри каждого спринта указан обязательный minimum route. Не требуется читать всё последовательно.

## Security foundations and risk

- NIST Cybersecurity Framework 2.0.
- NIST SP 800-30 risk assessment guidance.
- NIST SP 800-53 control catalogue as a reference, not a checklist to copy blindly.
- ISO/IEC 27001/27002 concepts where accessible through lawful summaries and organizational material.
- OWASP Threat Modeling resources and Threat Modeling Manifesto.
- MITRE ATT&CK used for detection/threat mapping, not as a complete risk model.

## Identity and access

- NIST SP 800-63 Digital Identity Guidelines.
- OAuth 2.0 Security Best Current Practice and relevant RFCs.
- OpenID Connect Core and Discovery specifications.
- WebAuthn/FIDO2 specifications and implementation guidance.
- Keycloak/Dex and OPA official documentation.
- SPIFFE/SPIRE specifications and workload-identity material.

## Cryptography, TLS and secrets

- OWASP Cryptographic Storage, Password Storage and Secrets Management cheat sheets.
- RFCs and official documentation for TLS 1.3, X.509 validation, JOSE/JWT and selected algorithms.
- NIST cryptographic standards and recommendations where applicable.
- *Serious Cryptography*, Jean-Philippe Aumasson, selected conceptual chapters.
- OpenSSL, step-ca and Vault official documentation.
- libsodium/Go standard-library guidance for safe primitive use.

## Application and API security

- OWASP ASVS.
- OWASP Top 10 and API Security Top 10 as discovery aids, not full security models.
- OWASP Cheat Sheet Series.
- CWE and CAPEC references.
- Go security documentation, `govulncheck`, gosec and fuzzing documentation.
- browser security specifications for cookies, CSP, CORS and Fetch.

## Infrastructure, containers and cloud

- CIS Benchmarks where licensing/access permits; use as references, not universal defaults.
- Kubernetes security documentation and Pod Security Standards.
- NIST container security guidance.
- Docker/OCI image and runtime security documentation.
- cloud-provider security documentation for IAM, metadata, network and storage patterns, compared across providers.
- Falco, auditd and Linux security documentation.

## Supply chain and secure delivery

- SLSA specification.
- Sigstore/Cosign documentation.
- SPDX and CycloneDX specifications.
- in-toto and provenance concepts.
- OpenSSF Scorecard and secure software development resources.
- NIST Secure Software Development Framework.
- GitHub Actions security hardening guidance and equivalent CI documentation.

## Vulnerability management and testing

- CVE, CPE, CVSS and EPSS documentation.
- CISA Known Exploited Vulnerabilities catalogue.
- OWASP Testing Guide.
- Semgrep, Trivy/Grype, Syft, ZAP and fuzzing official documentation.
- NIST vulnerability management guidance.

## Detection, incident response and forensics

- NIST SP 800-61 incident-handling guidance and current successor material.
- NIST log-management and digital-forensics guidance.
- Sigma rule specification.
- MITRE ATT&CK and D3FEND for mapping hypotheses and controls.
- Falco/auditd/OpenTelemetry logging documentation.
- *The Practice of Network Security Monitoring*, selected defensive chapters.

## Governance, privacy and assurance

- NIST Privacy Framework.
- NIST CSF Govern function.
- CIS Controls as a prioritized reference.
- SOC 2, ISO 27001, PCI DSS, GDPR and other frameworks only as context relevant to the chosen synthetic organization; verify current official requirements before real-world use.
- security architecture and secure-development lifecycle materials from NIST SSDF and OWASP SAMM.

## Rules for sources

1. Standards and official specifications define protocol and assurance requirements.
2. Product documentation defines version-specific defaults and limitations.
3. Cheat sheets and Top 10 lists are starting points, not complete design evidence.
4. Scanner findings are hypotheses until exposure and behavior are verified safely.
5. A control is accepted only with owner, scope, protected asset, failure mode and test evidence.
6. Cryptographic choices use maintained libraries and documented safe constructions.
7. Compliance evidence does not prove practical resistance to the modeled threat.
8. Offensive examples remain bounded to local synthetic systems and are expressed as defensive test cases.
9. Do not copy private reports, paid-course content, credentials or proprietary detection logic.
