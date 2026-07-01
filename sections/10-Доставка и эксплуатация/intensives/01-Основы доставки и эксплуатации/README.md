# Основы доставки и эксплуатации

Основной интенсив раздела «Доставка и эксплуатация». Его цель — научиться проектировать и сопровождать полный путь изменения: от исходного кода и зависимостей до проверенного артефакта, безопасного выпуска, восстановления и улучшения после инцидентов.

Основная практика выполняется на одном synthetic Go-сервисе с PostgreSQL, background worker and HTTP API. Артефакты собираются один раз, подписываются/проверяются и продвигаются между локальными development, staging and production-like environments. Kubernetes from the infrastructure intensive is the main runtime, but core mechanisms are also compared with Compose/VM deployment.

## Результат прохождения

После завершения необходимо уметь самостоятельно:

- картировать delivery value stream and change-risk boundaries;
- фиксировать source, dependency and build inputs;
- получать reproducible/verifiable binaries and OCI images;
- управлять package/image repositories, versions, provenance and retention;
- выбирать test levels and enforce meaningful quality gates;
- проектировать CI pipelines, runners, caches, artifacts and concurrency;
- обеспечивать merge safety and fast feedback;
- различать continuous integration, continuous delivery and continuous deployment;
- проектировать environment boundaries and artifact promotion;
- вести release versions, notes, approvals and compatibility metadata;
- отделять configuration and secrets from immutable artifacts;
- выполнять secret issuance, rotation and revocation;
- выбирать recreate, rolling, blue-green and canary deployment;
- использовать progressive delivery and automated stop criteria;
- отделять deployment from release through feature flags;
- выполнять backward-compatible database/API/event migrations;
- выбирать rollback or roll forward based on irreversible state;
- применять GitOps/control-loop delivery where it adds ownership clarity;
- проводить production-readiness review before first release;
- создавать runbooks, maintenance and change procedures;
- планировать capacity, upgrades and routine operational lifecycle;
- определять backup scope, RTO, RPO and restore evidence;
- проводить disaster-recovery exercises;
- организовывать incident detection, severity, command, escalation and communication;
- стабилизировать service without destroying evidence;
- проводить blameless, evidence-based postmortems;
- превращать actions into verified system/process improvements;
- определять SLI, SLO, SLA and error budgets;
- использовать release/change metrics without gaming them;
- диагностировать delivery failures across commit, pipeline, artifact, environment, deployment and runtime layers.

Целевой уровень: 3 по всему разделу и 4 по reproducible delivery, progressive deployment, compatible migrations, recovery exercises, incident command and SLO-driven release decisions.

## Границы

Интенсив не заменяет:

- полный security engineering and supply-chain security course;
- глубокий курс observability implementation;
- vendor-specific CI/CD certification;
- production SRE rotation or on-call apprenticeship;
- organizational change-management framework;
- distributed consensus/database replication specialization;
- complete product-management and stakeholder-communication course.

Смежные темы включаются настолько, насколько они нужны для безопасной доставки и эксплуатации.

## Предварительные знания

Рекомендуется завершить основные интенсивы по Linux, сетям, программированию, данным, прикладным системам, проектированию and infrastructure platforms.

Минимально необходимы:

- Git, branches, commits and merge requests;
- Go modules, tests and build commands;
- Linux shell, processes and filesystems;
- Docker/OCI images and Compose;
- basic Kubernetes objects and `kubectl`;
- PostgreSQL migrations and transactions at overview level;
- HTTP APIs and backward compatibility;
- ability to read logs/events and execute diagnostic commands;
- technical English.

## Лабораторное окружение

Default laboratory:

- Linux workstation or VM;
- Git and a GitHub repository;
- Go, Make, Bash, jq/yq;
- Docker or Podman plus Compose;
- local OCI registry;
- GitHub Actions as primary CI implementation; local runner/emulation optional;
- k3s/kind/k3d cluster;
- `kubectl`, Helm and Kustomize;
- optional Argo CD or Flux for GitOps experiments;
- PostgreSQL and MinIO or another object store;
- Cosign plus SBOM/provenance tooling;
- Prometheus-compatible metrics only for release/SLO evidence;
- synthetic status page/chat/email endpoints for incident communication.

Подробности: [`LAB_ENVIRONMENT.md`](LAB_ENVIRONMENT.md).

Проверка:

```bash
bash scripts/check-environment.sh
```

## Принципы прохождения

1. Build once, verify once, promote the same immutable artifact.
2. A green pipeline is evidence for named checks, not proof of correctness.
3. Pipeline state, artifacts and deployment state have explicit owners and retention.
4. Delivery credentials are short-lived and scoped to exact environment/action.
5. Configuration and secrets are independent lifecycle objects, not hidden image contents.
6. Every rollout has health criteria, stop condition and recovery path.
7. Rollback is valid only when data, contracts and external effects remain compatible.
8. Production readiness includes operation, recovery, ownership and support.
9. Backups are accepted only after restore evidence.
10. During incidents, restore service and preserve evidence before broad cleanup.
11. Postmortem actions must reduce a named recurrence or detection/recovery gap.
12. SLO/error budgets inform delivery decisions but do not replace judgment.
13. Metrics are diagnostic signals, not targets for ranking people.
14. General mechanisms move to `knowledge`; pipeline definitions, release evidence and incident artifacts remain in `learning`.

## Основной стек

- Go, Git, Make and Bash;
- GitHub Actions and reusable workflows;
- Docker/Podman, BuildKit and OCI registry;
- Cosign, SBOM and provenance tools;
- PostgreSQL migration tooling;
- Kubernetes, Helm and Kustomize;
- Argo CD or Flux for one GitOps route;
- feature flags through a small local implementation or OpenFeature-compatible provider;
- Prometheus-compatible release/SLO metrics;
- `curl`, `jq`, `git bisect`, `diff`, checksums and signature verification;
- optional OpenTelemetry/log aggregation only where incident evidence requires it.

## Порядок спринтов

1. [Путь изменения, delivery value stream и риски](sprints/01-Путь%20изменения%20delivery%20value%20stream%20и%20риски/)
2. [Build graph, зависимости и фиксированные входы](sprints/02-Build%20graph%20зависимости%20и%20фиксированные%20входы/)
3. [Воспроизводимые сборки и проверяемые результаты](sprints/03-Воспроизводимые%20сборки%20и%20проверяемые%20результаты/)
4. [Артефакты, версии, репозитории и provenance](sprints/04-Артефакты%20версии%20репозитории%20и%20provenance/)
5. [Автоматические тесты и quality gates](sprints/05-Автоматические%20тесты%20и%20quality%20gates/)
6. [Pipeline as code, runners, caches и concurrency](sprints/06-Pipeline%20as%20code%20runners%20caches%20и%20concurrency/)
7. [Merge safety, feedback и интеграция изменений](sprints/07-Merge%20safety%20feedback%20и%20интеграция%20изменений/)
8. [Проверка сборки и CI](sprints/08-Проверка%20сборки%20и%20CI/)
9. [Окружения, parity и продвижение артефактов](sprints/09-Окружения%20parity%20и%20продвижение%20артефактов/)
10. [Версии, релизы, release notes и approvals](sprints/10-Версии%20релизы%20release%20notes%20и%20approvals/)
11. [Конфигурация и параметры окружений](sprints/11-Конфигурация%20и%20параметры%20окружений/)
12. [Секреты, выдача, ротация и отзыв](sprints/12-Секреты%20выдача%20ротация%20и%20отзыв/)
13. [Recreate, rolling и blue-green deployment](sprints/13-Recreate%20rolling%20и%20blue-green%20deployment/)
14. [Canary и progressive delivery](sprints/14-Canary%20и%20progressive%20delivery/)
15. [Feature flags и разделение deploy/release](sprints/15-Feature%20flags%20и%20разделение%20deploy%20release/)
16. [Совместимые API и database migrations](sprints/16-Совместимые%20API%20и%20database%20migrations/)
17. [Rollback, roll forward и recovery decisions](sprints/17-Rollback%20roll%20forward%20и%20recovery%20decisions/)
18. [Проверка релиза и развёртывания](sprints/18-Проверка%20релиза%20и%20развёртывания/)
19. [Continuous delivery, deployment и GitOps](sprints/19-Continuous%20delivery%20deployment%20и%20GitOps/)
20. [Production readiness и операционный контракт](sprints/20-Production%20readiness%20и%20операционный%20контракт/)
21. [Runbooks, maintenance и управление изменениями](sprints/21-Runbooks%20maintenance%20и%20управление%20изменениями/)
22. [Capacity, upgrades и жизненный цикл сервиса](sprints/22-Capacity%20upgrades%20и%20жизненный%20цикл%20сервиса/)
23. [Backup, restore, RTO и RPO](sprints/23-Backup%20restore%20RTO%20и%20RPO/)
24. [Disaster recovery и непрерывность сервиса](sprints/24-Disaster%20recovery%20и%20непрерывность%20сервиса/)
25. [Обнаружение, severity и роли инцидента](sprints/25-Обнаружение%20severity%20и%20роли%20инцидента/)
26. [Incident command, escalation и коммуникация](sprints/26-Incident%20command%20escalation%20и%20коммуникация/)
27. [Стабилизация, восстановление и сохранение доказательств](sprints/27-Стабилизация%20восстановление%20и%20сохранение%20доказательств/)
28. [Postmortem и корректирующие действия](sprints/28-Postmortem%20и%20корректирующие%20действия/)
29. [SLI, SLO, SLA и error budgets](sprints/29-SLI%20SLO%20SLA%20и%20error%20budgets/)
30. [Delivery metrics, change risk и непрерывное улучшение](sprints/30-Delivery%20metrics%20change%20risk%20и%20непрерывное%20улучшение/)
31. [Системная диагностика доставки и эксплуатации](sprints/31-Системная%20диагностика%20доставки%20и%20эксплуатации/)
99. [Итоговая работа](sprints/99-Итоговая%20работа/)

## Покрытие основных вопросов

| Вопрос | Спринты |
|---|---|
| Как получить воспроизводимый и проверяемый артефакт? | 01–04, 08 |
| Какие проверки выполнять до merge/release? | 05–08 |
| CI versus continuous delivery/deployment? | 06–09, 19 |
| Как продвигать один artifact между environments? | 04, 09–10, 19 |
| Как выбрать deployment strategy and stop criteria? | 13–18 |
| Rollback versus roll forward? | 16–18, 27 |
| Как отделить configuration and secrets? | 11–12 |
| Что входит в operational readiness? | 20–22 |
| Как определить backup/restore requirements? | 23–24 |
| Как реагировать и коммуницировать during incident? | 25–27, 31 |
| Как проводить postmortem and improvements? | 28, 30–31 |
| Как применять SLO/error budget to delivery? | 29–30 |

## Итоговая работа

Финальный проект — `delivery-operations-lab`: complete software delivery and service-operations laboratory with reproducible builds, signed artifacts, CI quality gates, immutable promotion, progressive deployment, feature flags, compatible migrations, GitOps reconciliation, operational readiness, backup/restore, disaster recovery, incident command, postmortem actions and SLO-driven release decisions.

Система должна позволять:

- reproduce an artifact from pinned source/build inputs;
- promote the same artifact through three environments;
- verify signatures, SBOM and provenance;
- stop or continue canary by measured criteria;
- rotate secrets and configuration independently;
- deploy compatible database/API changes;
- restore from failed release or irreversible migration;
- recover data/service under RTO/RPO exercise;
- conduct and document a full incident;
- decide release policy from SLO/error-budget evidence;
- diagnose failures through read-only `deliverytriage` tooling.

## Вклад в базу знаний

Each sprint names exact recommended notes. General mechanisms move to `knowledge`; pipeline definitions, release manifests, artifacts metadata, recovery reports and incident evidence remain in `learning`.

## Общая библиография

Official specifications, documentation and books are listed in [`RESOURCES.md`](RESOURCES.md). Each sprint identifies the required minimum route.
