# Спринт 23. Безопасность прикладных границ

Ориентировочный объём: 20–29 часов.

## Центральный вопрос

Как защитить входы, выходы and browser/server boundaries from malicious or malformed data without relying on one framework or perimeter control?

## Результат спринта

После завершения необходимо уметь:

- создавать lightweight threat model for user journeys;
- identify assets, actors, trust boundaries and abuse cases;
- различать validation, sanitization, encoding and authorization;
- предотвращать SQL/command/template injection through safe APIs;
- понимать reflected/stored/DOM XSS and output-context encoding;
- применять Content Security Policy as defense-in-depth;
- понимать CORS as browser sharing policy, not authorization;
- использовать security headers deliberately;
- защищать redirects and callback URLs;
- ограничивать request body, JSON depth, multipart parts and decompression;
- защищать file upload/download lifecycle;
- предотвращать path traversal and unsafe filenames;
- понимать SSRF and outbound destination allowlisting;
- применять rate/concurrency limits with identity/context;
- избегать insecure object references through authorization;
- хранить passwords/keys/tokens using appropriate mechanisms;
- понимать dependency/build artifact risks at application level;
- безопасно отображать errors/logs;
- проводить negative security tests and remediation verification.

## Основной маршрут

### Шаг 1. Threat model

For main journeys list assets, entry points, trust boundaries, attacker capabilities, abuse cases and controls. Prioritize by impact and reachability.

### Шаг 2. Input/output contexts

Treat all external data as untrusted. Validate structure/limits, use parameterized APIs and encode at the final output context. “Sanitize everything” is not a universal strategy.

### Шаг 3. Browser controls

Apply CSP, frame/embed policy, MIME sniffing controls, referrer policy, secure cookies and strict CORS allowlist according to app requirements.

### Шаг 4. Files and outbound calls

Generate storage keys, validate size/type/content, isolate processing and serve downloads with safe headers. For server-side fetch, restrict schemes/hosts/IP ranges/redirects and response size.

## Ресурсы

- OWASP ASVS, Web Security Testing Guide and Cheat Sheet Series.
- browser CSP, CORS, Fetch Metadata and security-header docs.
- Go `html/template`, SQL parameterization, `os/exec` and URL/IP docs.
- file upload and SSRF prevention guidance.

## Практические задания

1. Threat-model sign-in, item edit, file upload and webhook configuration.
2. Reproduce reflected/stored/DOM XSS in isolated lab and fix by context.
3. Add CSP report-only, then enforce compatible policy.
4. Reproduce SQL/command/path injection against unsafe adapters.
5. Build malicious multipart/decompression/JSON-depth cases.
6. Implement SSRF-safe external preview/fetch service.
7. Test open redirects and CORS misconfiguration.
8. Add per-identity and global admission limits.

## Лабораторная работа

Создать `work/application-security/` as hardened version of the app.

### Requirements

- threat model tied to actual routes/data flows;
- all SQL uses parameterization;
- no shell invocation for simple operations; unavoidable commands use fixed executable/args and bounded environment;
- HTML rendering uses context-aware escaping;
- user HTML, if supported, uses narrowly configured sanitizer and tests;
- CSP avoids broad unsafe directives in final profile;
- CORS allowlist is exact and credentials behavior tested;
- redirects use relative or allowlisted destinations;
- file upload has size/count/type/checksum, generated key and isolated processing;
- download headers prevent unintended inline execution where applicable;
- SSRF handler rejects unsupported schemes, credentials, local/private targets, unsafe redirects and oversized responses;
- JSON/body/decompression/concurrency limits;
- authorization tests cover object/tenant access;
- errors/logs redact secrets and internals;
- dependency scan results are triaged, not blindly accepted;
- negative security regression suite included.

### Failure scenarios

1. User input inserted through `innerHTML`/unsafe template.
2. CSP allows inline/eval/every origin and provides little control.
3. CORS wildcard/reflect-origin used with credentials.
4. Redirect accepts `//attacker` or encoded external URL.
5. Filename becomes filesystem/object key directly.
6. Content type/extension trusted without content/serving controls.
7. Archive/compressed upload expands beyond limits.
8. Server-side fetch reaches metadata/local network through redirect/DNS.
9. Rate limit keyed only by attacker-controlled header.
10. SQL/command error exposes internals.
11. Input sanitization changes data but output context remains unsafe.
12. Security scanner finding is fixed superficially without exploit/regression test.

## Самопроверка

1. Threat model components?
2. Validation versus encoding versus sanitization?
3. XSS contexts differ how?
4. What does CSP provide?
5. Why CORS is not authorization?
6. Parameterization prevents what?
7. File upload trust boundaries?
8. What makes SSRF control difficult?
9. Open redirect impact?
10. Rate limit identity/global layers?
11. Why negative regression test matters?

## Результат для базы знаний

- **Application threat modeling**.
- **Validation, sanitization and output encoding**.
- **XSS and Content Security Policy**.
- **CORS and browser security headers**.
- **SQL, command and path injection prevention**.
- **Secure file upload and download boundaries**.
- **SSRF and outbound request restrictions**.
- **Application admission/rate limits**.
- **Security regression testing**.

## Когда переходить дальше

Можно переходить, когда abuse cases have bounded controls and regression tests, and no browser/server/file/outbound boundary relies solely on trust, UI hiding or generic sanitization.