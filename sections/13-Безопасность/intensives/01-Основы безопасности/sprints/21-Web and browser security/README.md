# Спринт 21. Web and browser security

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как browser trust model, cookies, origins and active content create risks such as XSS, CSRF and confused cross-origin access?

## Результат спринта

После завершения необходимо уметь:

- understand origin, site and browser isolation concepts;
- prevent reflected, stored and DOM-based XSS through contextual encoding and safe APIs;
- apply Content Security Policy as defense in depth;
- protect state-changing requests from CSRF;
- configure cookies and session boundaries;
- understand CORS request/response semantics;
- prevent clickjacking and unsafe framing;
- manage redirects and external links safely;
- distinguish browser storage options and risks;
- use security headers appropriately;
- test browser controls in local scope.

## Основной маршрут

1. Add intentionally unsafe synthetic rendering and correct it.
2. Implement contextual output encoding and safe templating.
3. Configure CSP, frame restrictions and security headers.
4. Add CSRF protection and secure cookie attributes.
5. Test CORS with trusted and untrusted origins.

## Лабораторная работа

Создать `work/web-security/`.

### Requirements

- untrusted data is never inserted through unsafe HTML/script APIs;
- templates auto-escape and explicit exceptions are reviewed;
- CSP has minimal sources and no permanent unsafe-inline/eval bypass;
- state-changing cookie-authenticated requests require CSRF defense;
- cookies use appropriate Secure, HttpOnly, SameSite, path/domain and expiry;
- CORS uses exact origins and does not reflect arbitrary credentials-enabled origins;
- framing is denied or explicitly allowlisted;
- redirects validate destination and external links use safe behavior;
- tokens are not stored in inappropriate browser storage or URLs;
- browser tests verify controls rather than headers alone.

### Failure scenarios

1. Stored user text executes as script.
2. CSP is present but universally bypassed by unsafe-inline.
3. State-changing endpoint accepts cross-site form/request.
4. Cookie domain/path exposes session to unrelated app.
5. Credentials-enabled CORS reflects arbitrary origin.
6. Open redirect is used in login/recovery flow.
7. Security token appears in URL/referrer/history.

## Результат для базы знаний

- **Browser origins, sites and cross-origin boundaries**.
- **XSS prevention and contextual output encoding**.
- **Content Security Policy**.
- **CSRF protection and secure cookies**.
- **CORS, framing and redirect security**.

## Когда переходить дальше

Можно переходить, когда untrusted content, cross-site requests and untrusted origins cannot gain script execution or authenticated state-changing access.