# Спринт 16. Сессии, cookies и защита от CSRF

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как browser session связывает authenticated user with requests, и какие cookie, expiration, fixation, CSRF and revocation failures must be controlled?

## Результат спринта

После завершения необходимо уметь:

- различать authentication session and application state;
- использовать opaque server-side session identifiers;
- понимать cookie domain, path, expiry and host scope;
- применять `Secure`, `HttpOnly` and `SameSite` attributes;
- понимать session fixation and rotation;
- проектировать idle and absolute expiration;
- выполнять logout and server-side revocation;
- ограничивать concurrent/device sessions where required;
- различать CSRF and XSS;
- применять synchronizer token or double-submit pattern according to architecture;
- использовать Origin/Referer/Fetch Metadata as additional signals;
- понимать why SameSite is not sole CSRF strategy for every case;
- защищать state-changing endpoints independent from UI;
- проектировать password/credential reset session invalidation;
- хранить session metadata safely;
- тестировать cross-site form/fetch scenarios;
- диагностировать stale, stolen and invalidated sessions.

## Основной маршрут

### Шаг 1. Session lifecycle

```text
credentials verified
→ new random session ID
→ server-side session record
→ secure cookie
→ activity/expiry/rotation
→ logout/revocation/cleanup
```

Session ID is an authentication credential and must not appear in logs/URLs.

### Шаг 2. Cookie scope

Use host-only cookies where possible. Understand domain/path do not create strong isolation between mutually untrusted applications on the same origin/site.

### Шаг 3. CSRF

A browser automatically attaches cookies, so attacker-controlled cross-site request may carry authority. Require anti-CSRF token and/or strict origin/metadata checks for unsafe cookie-authenticated requests.

### Шаг 4. Revocation and recovery

Rotate on sign-in/privilege change, revoke on logout/password reset/suspicious event, and bound server-side cleanup.

## Ресурсы

- MDN cookie and SameSite documentation.
- HTTP cookie specification.
- OWASP Session Management and CSRF Cheat Sheets.
- Fetch Metadata documentation.
- Go cryptographic random and secure comparison docs.

## Практические задания

1. Implement server-side session store and secure cookie.
2. Reproduce session fixation, then rotate correctly.
3. Build a cross-site CSRF attacker page against unsafe endpoint.
4. Add CSRF token plus origin/metadata validation.
5. Test idle and absolute expiration with fake clock.
6. Revoke all sessions after password reset.
7. Build session-management page listing/revoking devices.

## Лабораторная работа

Создать `work/session-security/`.

### Requirements

- session IDs generated with cryptographic randomness;
- only hash or safe identifier stored/logged where useful;
- cookie is Secure, HttpOnly and explicitly SameSite-scoped;
- no session ID in URL/localStorage;
- ID rotates after authentication and privilege change;
- server-side record includes subject, tenant, created/last-seen/expiry and revocation state;
- idle and absolute expiration deterministic in tests;
- unsafe methods require CSRF defense;
- safe GET has no business side effect;
- logout invalidates server state, not only client cookie;
- password reset/account disable revokes relevant sessions;
- cross-origin attack tests included;
- concurrent session cleanup is bounded.

### Failure scenarios

1. Pre-auth session ID survives login.
2. Cookie lacks Secure/HttpOnly or has overly broad domain.
3. Session ID appears in query/log/referrer.
4. Logout only deletes cookie while server session remains active.
5. CSRF token is global/predictable/not bound to session.
6. State-changing GET can be triggered cross-site.
7. SameSite assumed to prevent every CSRF scenario.
8. Idle expiry updated by attacker/background noise indefinitely.
9. Password reset does not revoke stolen sessions.
10. XSS is described as CSRF defense failure rather than separate threat.

## Самопроверка

1. Session ID represents what?
2. Why rotate after login?
3. Host-only versus Domain cookie?
4. Secure, HttpOnly and SameSite roles?
5. Idle versus absolute expiry?
6. CSRF versus XSS?
7. Why cookies enable CSRF?
8. Synchronizer token works how?
9. What does logout revoke?
10. Why reset/privilege change affects sessions?

## Результат для базы знаний

- **Server-side browser session lifecycle**.
- **Cookie scope and security attributes**.
- **Session fixation and rotation**.
- **Idle, absolute expiration and revocation**.
- **CSRF threat and token defense**.
- **Origin and Fetch Metadata checks**.
- **Session management and credential-reset invalidation**.

## Когда переходить дальше

Можно переходить, когда cross-site unsafe requests fail, session rotation/revocation is testable, and no session credential leaks through URL, storage or logs.