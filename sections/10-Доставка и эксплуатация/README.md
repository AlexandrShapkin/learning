# Доставка и эксплуатация

Практическое изучение пути программного изменения от исходного кода до работающей системы: сборки, проверок, артефактов, CI/CD, релизов, развёртывания, конфигурации, восстановления и операционного сопровождения.

Раздел соответствует области [«Доставка и эксплуатация»](https://github.com/AlexandrShapkin/knowledge/tree/main/content/Доставка%20и%20эксплуатация) базы знаний.

## Основной интенсив

### [01. Основы доставки и эксплуатации](intensives/01-Основы%20доставки%20и%20эксплуатации/)

Маршрут строится вокруг одного Go-сервиса и его полного change flow: commit → reproducible build → verified immutable artifact → promotion through environments → progressive deployment → operation, recovery and incident learning.

После прохождения необходимо уметь:

- получать воспроизводимый и проверяемый артефакт из исходного кода;
- проектировать quality gates and pipeline as code;
- различать continuous integration, delivery and deployment;
- продвигать один immutable artifact между окружениями;
- управлять версиями, release metadata and artifact repositories;
- выбирать rolling, blue-green, canary and recreate strategies;
- отделять deployment from release through feature flags;
- выполнять backward-compatible API and database migrations;
- выбирать rollback or roll forward by system state;
- отделять configuration and secrets from artifacts;
- проводить production-readiness reviews and routine maintenance;
- определять backup, restore, RTO, RPO and disaster-recovery procedures;
- организовывать incident command, escalation and communication;
- проводить evidence-based postmortems and track corrective actions;
- применять SLI, SLO, SLA and error budgets to release decisions;
- измерять delivery performance without turning metrics into targets;
- диагностировать failures across source, pipeline, artifact, deployment and runtime boundaries.

Ориентировочный объём: 320–450 часов.

## Планируемые тематические углубления

- **Reproducible builds and software supply chain**;
- **Advanced CI/CD pipeline architecture**;
- **Progressive delivery and feature management**;
- **GitOps and deployment control loops**;
- **Database and API release engineering**;
- **Backup, restore and disaster recovery**;
- **Incident command and operational readiness**;
- **SLO-driven delivery and change risk**;
- **Release engineering for multi-service systems**.

Каждое углубление будет самостоятельным маршрутом.

## Связи с другими разделами

- Compute, container and Kubernetes platforms — [«Инфраструктура и платформы»](../09-Инфраструктура%20и%20платформы/).
- Metrics, logs, traces and diagnostic instrumentation — [«Наблюдаемость и диагностика»](../11-Наблюдаемость%20и%20диагностика/).
- Replication, consensus and distributed fault tolerance — [«Распределённые системы и надёжность»](../12-Распределённые%20системы%20и%20надёжность/).
- Pipeline, artifact and secret protection — [«Безопасность»](../13-Безопасность/).
- Code review, work planning and team process — [«Инженерный процесс»](../14-Инженерный%20процесс/).
- Product impact, stakeholder communication and service expectations — [«Пользователь и бизнес»](../15-Пользователь%20и%20бизнес/).
