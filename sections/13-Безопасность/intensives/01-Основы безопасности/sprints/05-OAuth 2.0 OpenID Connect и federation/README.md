# Спринт 05. OAuth 2.0, OpenID Connect и federation

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как делегировать доступ и вход между приложениями, не превращая bearer tokens, redirects and clients into new trust failures?

## Результат спринта

После завершения необходимо уметь:

- distinguish authentication from authorization delegation;
- understand OAuth roles, grants, scopes and redirect URIs;
- use Authorization Code with PKCE for browser/native clients;
- understand OpenID Connect ID token, UserInfo and nonce;
- validate issuer, audience, signature, expiry and state;
- distinguish access, ID and refresh tokens;
- design refresh rotation and revocation;
- avoid implicit/resource-owner-password patterns;
- protect confidential and public clients appropriately;
- understand federation logout/session limitations;
- use local identity provider metadata and key rotation.

## Основной маршрут

1. Integrate the app with local Keycloak/Dex.
2. Implement Authorization Code + PKCE.
3. Validate tokens and OIDC claims explicitly.
4. Add refresh rotation and session revocation.
5. Rotate signing keys and test cached metadata behavior.

## Лабораторная работа

Создать `work/oauth-oidc/`.

### Requirements

- exact client type, redirect allowlist and grant are documented;
- state and nonce are generated and validated;
- PKCE uses a strong verifier/challenge;
- ID token is never used as API authorization token;
- access token validation checks issuer, audience, signature, time and scopes;
- refresh tokens rotate and replay is detected where supported;
- logout/revocation behavior and delays are measured;
- signing-key rotation works without accepting unknown issuers/algorithms;
- authorization decisions use server-side policy, not client UI claims;
- tokens are excluded from URLs/logs/storage where inappropriate.

### Failure scenarios

1. Redirect URI accepts wildcard/open redirect.
2. State or nonce is missing.
3. API accepts token for another audience/issuer.
4. ID token is treated as access token.
5. Refresh token replay is undetected.
6. Algorithm/key selection trusts attacker-controlled header incorrectly.
7. Logout from app does not terminate provider session or API token as assumed.

## Результат для базы знаний

- **OAuth 2.0 roles and authorization-code flow**.
- **PKCE, state and redirect validation**.
- **OpenID Connect identity tokens and nonce**.
- **Access-token validation and scopes**.
- **Refresh-token rotation and federation logout**.

## Когда переходить дальше

Можно переходить, когда forged, replayed, wrong-audience and redirect-manipulated flows are rejected and token lifecycle is observable.