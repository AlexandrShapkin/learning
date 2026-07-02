# Спринт 08. Проверка основ безопасности и IAM

Ориентировочный объём: 15–22 часа.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 01–07.

## Исходная задача

Создать `work/security-iam-checkpoint/` — threat-modeled application with user and workload identities, federation, MFA, sessions, fine-grained authorization and least-privilege service access.

## Required capabilities

- asset/risk register and trust-boundary diagram;
- user account lifecycle and secure sessions;
- MFA enrollment and recovery;
- OAuth/OIDC login with PKCE;
- object- and tenant-level authorization;
- workload identities and mTLS;
- policy tests and access-decision events;
- break-glass workflow.

## Mandatory fault cases

1. Account enumeration through login/recovery.
2. Session fixation or stale session after privilege change.
3. MFA reset from stolen session.
4. Open/wildcard redirect URI.
5. Token with wrong issuer or audience.
6. Cross-user or cross-tenant object access.
7. Broad admin/support role.
8. Policy-engine outage or stale policy cache.
9. Shared workload credential.
10. Certificate accepted without peer-name validation.
11. Disabled identity retains active access.
12. Break-glass access remains permanent/unreviewed.

## Defense

1. Which assets and realistic threats drive the design?
2. Where are trust boundaries and enforcement points?
3. Which privileges are time/resource/action scoped?
4. How are passwords, MFA and recovery protected?
5. How are sessions rotated and revoked?
6. How are OAuth/OIDC tokens validated?
7. Where is object-level authorization enforced?
8. Why was RBAC/ABAC/ReBAC chosen for each decision?
9. How are workload identities issued and rotated?
10. What does mTLS prove and not prove?
11. How is break-glass controlled?
12. What residual IAM risks remain?

## Критерии прохождения

- threat model and access matrix match the deployed system;
- user and workload credentials are isolated and revocable;
- federation flows reject redirect, issuer, audience and replay failures;
- object/tenant authorization denies all cross-boundary attempts;
- policy failures have explicit behavior and evidence;
- all twelve faults are reproduced and corrected;
- at least 10 of 12 defense answers reference policies, events or tests;
- cleanup revokes all synthetic sessions, tokens and certificates.

## Результат для базы знаний

Checkpoint-specific note не требуется. Update risk/IAM notes where test evidence changed design assumptions.