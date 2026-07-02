# Безопасность

Практическое изучение управления рисками, идентификации, доступа, криптографии, защиты данных, операционных систем, сетей, приложений, контейнеров, облачной инфраструктуры, цепочки поставки, обнаружения и реагирования.

Раздел соответствует области [«Безопасность»](https://github.com/AlexandrShapkin/knowledge/tree/main/content/Безопасность) базы знаний.

## Основной интенсив

### [01. Основы безопасности](intensives/01-Основы%20безопасности/)

Маршрут строится вокруг одного synthetic Go-приложения и его среды: web/API, PostgreSQL, background worker, identity provider, secrets/PKI, CI/CD, containers, Kubernetes, cloud-like IAM/network controls, logging and incident laboratory.

После прохождения необходимо уметь:

- определять активы, угрозы, уязвимости, trust boundaries и риск;
- строить threat models and attack-surface inventories;
- применять least privilege, defense in depth and zero-trust principles;
- проектировать account lifecycle, passwords, MFA and sessions;
- использовать OAuth 2.0, OpenID Connect and federation safely;
- выбирать RBAC, ABAC, ReBAC and policy-enforcement models;
- организовывать workload identity and service authentication;
- применять hashing, KDF, MAC, AEAD, signatures and secure randomness;
- управлять PKI, certificates, keys, tokens and secrets;
- классифицировать, шифровать, минимизировать и удалять данные;
- harden Linux, networks, containers, Kubernetes and cloud resources;
- предотвращать common web/API vulnerabilities;
- управлять dependencies, SBOM, provenance, signatures and CI/CD trust;
- внедрять SAST, DAST, fuzzing, code review and controlled security testing;
- вести vulnerability inventory, prioritization and remediation;
- проектировать security logging, detections and alert triage;
- проводить containment, evidence preservation, recovery and lessons learned;
- строить policies, audits, compliance evidence and secure SDLC;
- связывать security controls with measurable risk reduction.

Ориентировочный объём: 410–570 часов.

## Планируемые тематические углубления

- **Identity and access management**;
- **Applied cryptography and PKI operations**;
- **Application and API security**;
- **Container, Kubernetes and cloud security**;
- **Software supply-chain security**;
- **Detection engineering and SIEM**;
- **Digital forensics and incident response**;
- **Vulnerability research in isolated laboratories**;
- **Security architecture and threat modeling**;
- **Governance, risk and compliance**.

Каждое углубление будет самостоятельным маршрутом.

## Связи с другими разделами

- OS isolation and privilege mechanisms — [«Операционные системы»](../02-Операционные%20системы/).
- Network protocols and packet paths — [«Сети и протоколы»](../03-Сети%20и%20протоколы/).
- Runtime and secure programming mechanisms — [«Программирование и среды выполнения»](../04-Программирование%20и%20среды%20выполнения/).
- Data protection and database access — [«Данные и хранилища»](../06-Данные%20и%20хранилища/).
- Application contracts and interfaces — [«Прикладные системы и интерфейсы»](../07-Прикладные%20системы%20и%20интерфейсы/).
- Security architecture and boundaries — [«Проектирование программного обеспечения»](../08-Проектирование%20программного%20обеспечения/).
- Platform placement and isolation — [«Инфраструктура и платформы»](../09-Инфраструктура%20и%20платформы/).
- Secure delivery, recovery and incident operations — [«Доставка и эксплуатация»](../10-Доставка%20и%20эксплуатация/).
- Telemetry and diagnostic evidence — [«Наблюдаемость и диагностика»](../11-Наблюдаемость%20и%20диагностика/).
- Distributed trust and resilience — [«Распределённые системы и надёжность»](../12-Распределённые%20системы%20и%20надёжность/).
