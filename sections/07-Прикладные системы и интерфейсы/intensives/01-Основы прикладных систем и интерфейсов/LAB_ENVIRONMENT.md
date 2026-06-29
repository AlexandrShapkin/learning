# Лабораторное окружение

## Базовая система

Рекомендуется disposable Linux VM or workstation profile:

```text
application-lab
├── 6–8 vCPU
├── 16 GiB RAM
├── 100 GiB SSD
├── current supported Linux distribution
├── local graphical browser
└── container runtime with Compose support
```

Минимально достаточно 4 vCPU, 8 GiB RAM and 50 GiB disk, если auxiliary services запускать по одному. Browser performance, accessibility and end-to-end tests удобнее выполнять на host workstation, а stateful services — в disposable containers/VM.

## Обязательные инструменты

- Go toolchain;
- Git, Make, Bash, jq and curl;
- Node.js current supported release;
- npm, pnpm or another lockfile-based package manager;
- TypeScript compiler;
- Chromium and Firefox;
- Docker/Podman and Compose or equivalent;
- PostgreSQL client/server;
- Redis client/server or container;
- OpenSSL;
- Graphviz optional;
- `ps`, `ss`, `lsof`, `/usr/bin/time`;
- browser developer tools.

Frontend/testing tools used by the main route:

- Vite or equivalent development/build tool;
- React and React DOM;
- Vitest or equivalent unit runner;
- Playwright;
- axe-core integration or equivalent accessibility checker;
- ESLint and formatter;
- bundle analyzer optional.

Auxiliary services started per sprint:

- PostgreSQL;
- Redis;
- NATS JetStream or equivalent broker;
- MinIO or equivalent S3-compatible storage;
- Mailpit or equivalent SMTP capture;
- Keycloak or another local OAuth/OIDC provider;
- OpenTelemetry Collector;
- Prometheus/Grafana/Jaeger-compatible local stack where needed;
- mock external API/webhook receiver.

## Workspace

Each sprint creates `work/` only when practice begins:

```text
sprints/<NN-topic>/work/
├── cmd/
├── internal/
├── web/
│   ├── src/
│   ├── public/
│   └── tests/
├── api/
├── migrations/
├── fixtures/
├── scripts/
├── compose/
├── reports/
└── README.md
```

Large browser traces, videos, screenshots, coverage artifacts, object data and database volumes are generated outside Git or ignored.

## Browser matrix

Minimum supported laboratory matrix:

- current Chromium-based browser;
- current Firefox;
- WebKit through Playwright where available;
- keyboard-only navigation;
- reduced motion and high-contrast/forced-colors checks where supported;
- narrow, medium and wide viewport;
- slow network and offline simulation;
- locale and time-zone variation.

The project documents an explicit browser-support policy. It does not claim universal compatibility from one browser.

## Local service layout

Use isolated non-default ports and local hostnames:

```text
app.local.test
api.local.test
id.local.test
hooks.local.test
objects.local.test
mail.local.test
```

TLS can be introduced through a local development certificate authority. Certificates and private keys remain outside Git.

## Baseline commands

```bash
go version
node --version
npm --version
psql --version
docker compose version
```

Go checks:

```bash
gofmt -w .
go test ./...
go test -race ./...
go vet ./...
```

Frontend checks:

```bash
npm ci
npm run typecheck
npm run lint
npm run test
npm run build
npm run test:e2e
```

Exact commands may differ with package manager, but lockfile and reproducible install are mandatory.

## Reproducibility

Record:

- Go, Node.js, browser and service versions;
- lockfiles and module versions;
- build mode and feature flags;
- tested viewport, locale and time zone;
- test dataset seed and size;
- browser/cache warm or cold state;
- network throttling and concurrency;
- backend/client configuration differences;
- CPU/memory limits for containers;
- user journey and expected result.

## Data and secrets policy

Use only synthetic users, organizations, files and external-system payloads. Do not commit:

- production/customer data;
- real access/refresh tokens;
- passwords, cookie values or signing keys;
- OAuth client secrets;
- SMTP/object storage credentials;
- browser profiles or persistent sessions;
- raw traces/logs containing personal or authorization data;
- real third-party API keys.

Commit `.env.example`; actual `.env`, certificates and secrets stay ignored.

## Safety limits

- load tests cap users, requests, duration, files and bytes;
- background workers cap concurrency, attempts and queue depth;
- webhook/fault servers bind only locally;
- uploaded files are synthetic and scanned/validated according to sprint rules;
- external API tests use mocks/sandboxes;
- OIDC redirect URIs are local and explicit;
- browser automation never logs into real accounts;
- email/SMS/push tests terminate in local capture/fake providers;
- destructive data actions target isolated tenants and databases;
- fault modes are opt-in and reversible;
- cleanup verifies sessions, workers, listeners, browser processes and temporary objects.

## Committed artifacts

Commit:

- source, contracts and tests;
- package/module lockfiles;
- migrations and small fixtures;
- local service configuration without secrets;
- accessibility and browser-support notes;
- concise screenshots only when they explain a state;
- generated API docs where reproducible and small;
- test scripts and incident cards;
- commands to regenerate traces/reports.

Do not commit:

- `node_modules`, binaries or caches;
- Playwright browser binaries;
- database/service volumes;
- raw browser videos/traces from every run;
- large coverage/performance outputs;
- private certificates and secrets;
- generated user uploads/object data;
- real notification payloads.
