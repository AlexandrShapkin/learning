# Спринт 26. Проверка application и supply-chain security

Ориентировочный объём: 15–22 часа.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 20–25.

## Исходная задача

Создать `work/appsec-supply-chain-checkpoint/` — web/API application and delivery path protected from common input, browser, authorization, dependency and artifact-substitution failures.

## Required capabilities

- typed input contracts and safe database/process/file operations;
- XSS, CSRF, CORS, cookie and CSP controls;
- object-level API authorization;
- SSRF, webhook and upload protections;
- dependency inventory and SBOM;
- signed artifact and provenance verification;
- CI trust boundaries, secret scanning and IaC policy;
- negative/fuzz tests and remediation evidence.

## Mandatory fault cases

1. SQL/command/path injection.
2. Stored/reflected active content.
3. Cross-site state-changing request.
4. Credentials-enabled arbitrary CORS origin.
5. Cross-user/tenant API object access.
6. SSRF path to internal/metadata endpoint.
7. Unsafe upload serving or archive extraction.
8. Vulnerable/unmaintained dependency in shipped artifact.
9. SBOM/provenance mismatch with artifact digest.
10. Mutable/unsigned artifact substitution.
11. Untrusted PR receives protected pipeline authority.
12. Secret removed from source but not revoked/history-reviewed.

## Defense

1. Which trust boundaries receive untrusted input?
2. How are dangerous operations isolated?
3. Which browser controls are primary versus defense in depth?
4. Where is object-level authorization enforced?
5. How is outbound network access restricted?
6. How are uploads and webhooks authenticated/contained?
7. How is the shipped dependency set identified?
8. How are vulnerability findings prioritized?
9. What does signature/provenance verification prove?
10. How is CI/CD privilege separated from untrusted code?
11. How are IaC exceptions governed?
12. Which application/supply-chain risks remain?

## Критерии прохождения

- all input/browser/API boundary tests pass;
- unsafe URL/file/webhook paths are contained;
- exact artifact has linked SBOM, signature and provenance;
- CI/CD and IaC policies reject untrusted/unsafe changes;
- all twelve faults are reproduced and corrected;
- at least 10 of 12 defense answers cite tests, policies, digests or findings;
- cleanup revokes synthetic secrets and removes test artifacts.

## Результат для базы знаний

Checkpoint-specific note не требуется. Update AppSec/supply-chain notes where tool or runtime evidence changed assumptions.