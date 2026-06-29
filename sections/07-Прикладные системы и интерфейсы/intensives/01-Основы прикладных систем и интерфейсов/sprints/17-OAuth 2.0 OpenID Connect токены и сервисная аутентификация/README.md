# Спринт 17. OAuth 2.0, OpenID Connect, токены и сервисная аутентификация

Ориентировочный объём: 20–29 часов.

## Центральный вопрос

Как делегировать authorization and authenticate users/services через external identity provider, не смешивая roles, tokens, clients and trust boundaries?

## Результат спринта

После завершения необходимо уметь:

- различать authentication, authorization and delegation;
- понимать resource owner, client, authorization server and resource server roles;
- различать access, refresh and ID tokens;
- понимать OpenID Connect as identity layer over OAuth;
- использовать Authorization Code with PKCE for browser/public clients;
- проверять state, nonce and redirect URI;
- понимать token audience, issuer, subject, expiry and scopes;
- валидировать signed JWTs against trusted metadata/keys;
- понимать opaque token introspection conceptually;
- проектировать refresh-token rotation/reuse detection;
- выбирать browser backend/session pattern versus token-in-browser;
- не использовать ID token as general API access token;
- проектировать logout/revocation with provider limitations;
- использовать client credentials/workload identity for services where justified;
- управлять key rotation and clock skew;
- избегать logging/storage leakage of tokens;
- тестировать wrong issuer/audience/signature/nonce/redirect cases;
- понимать OAuth security best-practice evolution and avoid deprecated flows.

## Основной маршрут

### Шаг 1. Protocol roles

Draw browser/application/provider/resource server sequence. Identify which component sees credentials, authorization code and tokens.

### Шаг 2. Browser login

Implement Authorization Code + PKCE against local provider. Prefer backend-for-frontend/session where browser does not need long-lived bearer tokens directly.

### Шаг 3. Token validation

Resource server validates issuer, audience, signature, expiry/not-before, token type and required scopes. Claims are inputs, not automatically trusted authorization for every resource.

### Шаг 4. Service authentication

Compare static client secret, mTLS/workload identity and signed client assertion conceptually. Use local safe mechanism and rotate credentials.

## Ресурсы

- OAuth 2.0 framework and current IETF security best-practice specifications.
- OpenID Connect Core, Discovery and RP-Initiated Logout docs.
- local OIDC provider official docs.
- OWASP OAuth/OIDC and JWT guidance.
- JOSE/JWT specifications as reference.

## Практические задания

1. Configure local OIDC provider, public/confidential clients and redirect URIs.
2. Implement browser login with code + PKCE and backend session.
3. Validate access tokens in a separate resource service.
4. Reproduce wrong issuer/audience/expired/unknown key failures.
5. Rotate provider signing key and refresh discovery/JWKS safely.
6. Implement refresh-token rotation scenario in a controlled client.
7. Add service-to-service client credential or workload identity lab.
8. Compare session/BFF and browser bearer-token approaches.

## Лабораторная работа

Создать `work/identity-protocol-lab/`.

### Components

- local OIDC provider;
- browser client/BFF;
- resource API;
- protected admin/service endpoint;
- token/session inspector without secret output;
- provider configuration scripts;
- protocol negative-test suite.

### Requirements

- exact redirect URIs; no broad wildcard in final config;
- state and PKCE verified;
- nonce verified where ID token response requires it;
- ID token used only for client authentication context;
- access token audience/resource checked;
- issuer/discovery endpoint allowlisted;
- algorithms/keys accepted only from trusted configuration;
- token expiry and clock skew bounded;
- refresh token stored only in appropriate confidential/server context in main design;
- no token in URL/log/browser persistent storage for main flow;
- provider/client secrets ignored from Git;
- authorization still loads/checks application resource;
- sign-out behavior and residual provider session documented.

### Failure scenarios

1. Redirect URI accepts attacker-controlled target.
2. State/PKCE missing or not bound to transaction.
3. ID token sent as API access token.
4. Resource server accepts token for another audience.
5. Issuer/JWKS URL derived from untrusted token.
6. Signature algorithm/key selection is unsafe.
7. Refresh token reused after rotation without detection.
8. Token stored in localStorage and exposed to script/XSS.
9. Logout clears app session but provider/client token remains usable unexpectedly.
10. Service credential shared by all instances and never rotated.
11. Scope interpreted as object-level authorization.

## Самопроверка

1. OAuth versus OpenID Connect?
2. Authorization server versus resource server?
3. Access, refresh and ID tokens?
4. Why Authorization Code with PKCE?
5. State versus nonce?
6. Issuer and audience checks?
7. JWT versus opaque token?
8. Why ID token is not access token?
9. Browser session/BFF advantage?
10. Scope versus resource authorization?
11. How key/credential rotation works?

## Результат для базы знаний

- **OAuth roles and delegated authorization**.
- **OpenID Connect authentication layer**.
- **Authorization Code with PKCE**.
- **Access, refresh and ID token semantics**.
- **JWT issuer, audience, signature and time validation**.
- **Browser BFF/session versus bearer-token client**.
- **Refresh-token rotation and reuse detection**.
- **Service-to-service authentication options**.

## Когда переходить дальше

Можно переходить, когда login/service flows reject every wrong trust parameter, tokens never substitute object authorization, and credential/session revocation limits are understood and tested.