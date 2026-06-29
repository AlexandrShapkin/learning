# Ресурсы интенсива

Это общая библиография. В каждом спринте указан минимальный обязательный маршрут. Не требуется читать все specifications and manuals подряд.

## Browser and web platform

- MDN Web Docs: https://developer.mozilla.org/
- WHATWG HTML Living Standard: https://html.spec.whatwg.org/
- CSS specifications and drafts through W3C: https://www.w3.org/Style/CSS/
- ECMAScript specification: https://tc39.es/ecma262/
- TypeScript Handbook: https://www.typescriptlang.org/docs/handbook/
- Web Platform Tests: https://web-platform-tests.org/
- Chrome and Firefox DevTools documentation.

## Accessibility and interface quality

- Web Content Accessibility Guidelines: https://www.w3.org/WAI/standards-guidelines/wcag/
- WAI-ARIA Authoring Practices: https://www.w3.org/WAI/ARIA/apg/
- Accessible Rich Internet Applications specification.
- Inclusive Components, Heydon Pickering.
- WebAIM articles/checklists as secondary practical material.
- axe-core and browser accessibility-tree documentation.

## Frontend engineering

- React official documentation: https://react.dev/
- Vite official documentation: https://vite.dev/
- Vitest official documentation: https://vitest.dev/
- Playwright official documentation: https://playwright.dev/
- Testing Library principles/documentation.
- web.dev performance and browser guidance as secondary material.

## Go server applications

- Go `net/http`, `context`, `encoding/json`, `html/template`, `database/sql`, `log/slog` and testing documentation.
- Go blog/articles on context, HTTP servers and profiling.
- Effective Go and CodeReviewComments for language conventions.
- pgx documentation for PostgreSQL access.
- Standard library first; framework documentation only when a concrete abstraction is introduced.

## HTTP and API design

- HTTP Semantics, Caching and related RFCs.
- REST architectural style through Roy Fielding’s dissertation and practical HTTP references.
- OpenAPI Specification: https://spec.openapis.org/oas/latest.html
- JSON Schema: https://json-schema.org/
- Problem Details for HTTP APIs specification.
- gRPC documentation: https://grpc.io/docs/
- Protocol Buffers documentation: https://protobuf.dev/
- GraphQL specification and official learning resources: https://spec.graphql.org/
- WebSocket protocol and MDN WebSocket API documentation.
- Server-Sent Events documentation through HTML/MDN.

## Identity and access

- OAuth specifications and current security best-practice documents through IETF OAuth Working Group.
- OpenID Connect Core and Discovery specifications: https://openid.net/developers/specs/
- Browser cookie and SameSite documentation.
- OWASP Authentication, Session Management, CSRF and Authorization Cheat Sheets.
- Local OIDC provider official documentation used in the laboratory.

## Background work and integrations

- NATS JetStream, Kafka/Redpanda or chosen broker official documentation.
- PostgreSQL transactional outbox patterns grounded in database/event semantics.
- Amazon Builders’ Library articles on timeouts, retries and backoff as secondary references.
- Enterprise Integration Patterns, selected chapters.
- Webhook provider documentation only for sandboxed examples.
- S3-compatible object-storage documentation for file workflows.

## Security

- OWASP Application Security Verification Standard.
- OWASP Web Security Testing Guide.
- OWASP Cheat Sheet Series.
- Content Security Policy, CORS, Fetch Metadata and browser security specifications/docs.
- Go security and cryptography package documentation.
- Security headers guidance verified against browser specifications.

## Testing

- Go testing, fuzzing, race detector and `httptest` docs.
- Playwright and Testing Library documentation.
- Pact or another contract-testing tool only as optional comparison.
- OpenAPI/JSON Schema validation tooling.
- Testcontainers or Compose for real-dependency tests.
- Martin Fowler’s testing articles as secondary conceptual material.

## Observability and performance

- OpenTelemetry specifications and language documentation: https://opentelemetry.io/docs/
- Prometheus instrumentation and metric naming docs.
- Go pprof and trace documentation.
- Browser Performance APIs, Navigation Timing, Resource Timing and User Timing docs.
- Core Web Vitals guidance as one browser/user-experience signal, not complete performance truth.
- Systems Performance methodology for resource diagnosis.

## Application architecture and quality

- Patterns of Enterprise Application Architecture, Martin Fowler, selected application patterns.
- Release It!, Michael Nygard, integration/failure sections.
- Designing Data-Intensive Applications, selected derived-data/integration chapters.
- A Philosophy of Software Design, John Ousterhout, selected module/interface principles.
- Domain-Driven Design terminology only where it clarifies application scenarios; deeper architecture belongs to the next section.

## Mobile, desktop and CLI comparisons

- Go `flag`/Cobra-like CLI documentation for automation interfaces.
- Progressive Web App and Web App Manifest documentation.
- Platform-specific mobile/desktop official docs only for comparative labs or later thematic intensives.

## Правила работы с источниками

1. Browser/API behavior проверять по specification and current official documentation.
2. Framework guide is not a substitute for understanding browser/HTTP mechanism.
3. Security-sensitive behavior проверять against current specifications and OWASP guidance.
4. Product-specific guarantee must include tested version/configuration.
5. Blog post forms a hypothesis; local reproducible experiment provides evidence.
6. Generated code and SDKs must be reviewed against the contract.
7. Do not copy copyrighted tutorials, examples or API documentation into the repository.
8. Production recommendation requires user journey, failure model, accessibility and operational constraints.
