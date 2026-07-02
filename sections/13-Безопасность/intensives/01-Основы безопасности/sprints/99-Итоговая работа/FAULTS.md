# Каталог неисправностей

Every fault is opt-in, bounded, reversible and restricted to synthetic local resources. Each definition records affected asset/control, expected evidence, maximum scope and cleanup.

## Risk, identity and access

1. `asset-owner-missing` — critical asset has no owner or recovery requirement.
2. `trust-boundary-bypass` — backend is reachable without gateway/policy path.
3. `shared-admin-identity` — multiple operators use one privileged account.
4. `account-enumeration` — login/recovery reveals account existence.
5. `session-fixation` — session identifier survives authentication.
6. `stale-session-after-role-change` — revoked privilege remains active.
7. `mfa-reset-weakness` — stolen session can disable/reset MFA.
8. `oauth-open-redirect` — redirect validation accepts unintended target.
9. `token-wrong-audience` — API accepts token for another audience/issuer.
10. `object-authorization-bypass` — resource ID crosses user/tenant boundary.
11. `policy-cache-stale-allow` — revoked permission remains cached.
12. `shared-workload-credential` — multiple services share static secret.

## Cryptography, PKI, secrets and data

13. `predictable-security-token` — reset/session token lacks sufficient entropy.
14. `weak-password-storage` — fast or unsalted password hash.
15. `hmac-key-reuse` — one key is reused across unrelated purposes.
16. `aead-nonce-reuse` — nonce uniqueness breaks for one key.
17. `ciphertext-context-substitution` — encrypted value moves between records/tenants.
18. `signature-context-gap` — signature validates bytes but not intended artifact identity.
19. `tls-name-validation-disabled` — certificate chain is trusted without peer identity.
20. `certificate-expiry-cliff` — all replicas expire simultaneously.
21. `secret-in-source-or-image` — credential remains in repository/image layer.
22. `rotation-old-secret-valid` — previous credential remains usable after migration.
23. `sensitive-log-copy` — protected data appears in logs/analytics.
24. `backup-data-resurrection` — restore returns records expected to be deleted.

## Host, network, container and cloud

25. `root-service-broad-filesystem` — service runs root with unnecessary access.
26. `world-readable-config` — sensitive configuration permissions are broad.
27. `sudo-or-capability-overgrant` — account/service can escalate beyond need.
28. `flat-network-lateral-access` — application can reach unrelated service/data.
29. `arbitrary-egress` — workload can reach unapproved external/internal endpoints.
30. `metadata-endpoint-reachable` — request path can obtain workload/cloud identity.
31. `privileged-container` — Pod/container uses host/privileged capabilities.
32. `broad-kubernetes-rbac` — service account reads/changes unrelated resources.
33. `mutable-image-deployment` — tag resolves to unexpected artifact.
34. `public-object-storage` — ACL/policy interaction exposes synthetic restricted data.
35. `static-cloud-credential` — long-lived access key exists in CI/runtime.
36. `audit-evidence-modifiable` — workload can alter/delete its security records.

## Application, API and software supply chain

37. `sql-command-injection` — unsafe string composition reaches DB/process boundary.
38. `path-archive-escape` — path or archive extraction escapes storage root.
39. `stored-active-content` — untrusted content executes in browser.
40. `csrf-state-change` — cross-site request performs authenticated change.
41. `cors-arbitrary-origin` — credentials are exposed to untrusted origin.
42. `api-mass-assignment` — client changes protected role/owner/tenant field.
43. `ssrf-internal-access` — outbound fetch reaches private/metadata/admin endpoint.
44. `webhook-replay` — valid signed event is accepted repeatedly.
45. `unsafe-file-serving` — uploaded content is executed/interpreted actively.
46. `dependency-inventory-gap` — shipped component is absent from SBOM.
47. `vulnerability-runtime-mismatch` — source fixed but vulnerable artifact remains deployed.
48. `sbom-provenance-digest-mismatch` — evidence belongs to another artifact.
49. `valid-signature-wrong-signer` — verification ignores signer/repository/workflow identity.
50. `untrusted-pr-secret-access` — pull-request context receives protected credentials.
51. `cache-or-runner-persistence` — untrusted build contaminates trusted pipeline.
52. `iac-policy-bypass` — unsafe resource enters through unvalidated path/exception.

## Vulnerability, detection and incident response

53. `scanner-severity-mispriority` — raw severity overrides reachability/exposure context.
54. `permanent-risk-exception` — accepted vulnerability has no expiry/owner.
55. `security-event-secret-leak` — detection event contains token or sensitive payload.
56. `detection-missing-telemetry` — rule relies on unavailable source/field.
57. `noisy-rule-alert-flood` — routine activity hides meaningful signal.
58. `ioc-confidence-error` — old/shared indicator is treated as confirmed compromise.
59. `endpoint-sensor-silent-loss` — agent stops and system appears healthy.
60. `evidence-destroyed-by-restart` — containment begins before volatile evidence capture.
61. `partial-credential-containment` — account disabled while sessions/tokens/certificates remain.
62. `untrusted-recovery-artifact` — compromised image/config is redeployed.
63. `incident-closes-before-eradication` — vulnerable path or persistence remains.
64. `paper-control-without-evidence` — policy/framework claim has no deployed, tested control.

## Combined scenario library

- stolen session + weak MFA reset + stale role cache;
- wrong-audience token + object authorization gap + broad support role;
- shared workload credential + flat network + unrestricted secret access;
- certificate expiry + old CA trust + emergency verification disablement;
- repository secret leak + unrevoked old credential + backup/history exposure;
- sensitive logging + broad log access + weak retention;
- privileged Pod + broad service account + arbitrary egress;
- SSRF + metadata reachability + overprivileged cloud role;
- stored XSS + weak session cookie + missing privileged reauthentication;
- webhook replay + non-idempotent effect + absent security event;
- mutable image + mismatched provenance + admission bypass;
- untrusted PR + persistent runner + signing credential exposure;
- vulnerable dependency + stale deployment + permanent exception;
- detection source outage + noisy fallback rule + missed credential misuse;
- credential compromise + evidence-destroying restart + untrusted rebuild;
- compliant-looking policy + no owner + unverifiable evidence.

## Fault definition contract

Each implementation includes:

```text
name, asset and control objective
authorized local target and preconditions
synthetic misconfiguration or event sequence
expected preventive/detective/recovery behavior
expected identity, policy, artifact, event and evidence references
maximum requests, duration, files, credentials and resources
disable/rollback/revocation procedure
cleanup and baseline verification
new regression test, detection, policy or architectural correction
```

## Safety contract

Fault tooling must:

- require repository marker and explicit `--lab`;
- validate exact host, namespace, route, identity and artifact;
- reject public, third-party and unknown targets;
- cap request rate, concurrency, duration, corpus, storage and log volume;
- use synthetic identities, credentials, data and providers;
- never modify host clock or unrelated firewall/network paths;
- keep active validation to one exact control hypothesis;
- avoid malware, phishing, password spraying and persistence outside the lab;
- redact secrets and personal data from output;
- support `status`, `disable`, `revoke-all` and `cleanup`;
- verify credentials, sessions, certificates, policies, rules, captures, volumes and endpoints after cleanup.
