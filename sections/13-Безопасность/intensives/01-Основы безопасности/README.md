# Основы безопасности

Основной интенсив раздела «Безопасность». Его цель — научиться рассматривать безопасность как проверяемое свойство системы: от активов, идентичностей и данных до приложений, инфраструктуры, цепочки поставки, обнаружения и восстановления.

Практика выполняется на synthetic security platform:

- Go web/API application and background worker;
- PostgreSQL and object storage;
- identity provider and policy engine;
- local CA, certificate and secret-management components;
- Docker/Compose and Kubernetes;
- CI/CD, SBOM, signing and provenance flow;
- security logging, detections and incident evidence;
- intentionally misconfigured but isolated laboratory resources.

## Результат прохождения

После завершения необходимо уметь самостоятельно:

- различать asset, threat, vulnerability, exposure, control and risk;
- строить data-flow diagrams, trust boundaries and attack-surface inventories;
- применять least privilege, separation of duties, defense in depth and zero trust;
- проектировать user/service identity lifecycle;
- реализовывать password, MFA, session and recovery controls;
- безопасно использовать OAuth 2.0, OpenID Connect and federation;
- выбирать RBAC, ABAC, ReBAC and policy-as-code;
- организовывать workload identity, mTLS and short-lived credentials;
- применять secure randomness, hashes, KDFs, MACs, AEAD and signatures;
- управлять PKI, certificate validation, issuance, rotation and revocation;
- проектировать secret/key/token lifecycle and compromise response;
- классифицировать данные, минимизировать сбор, шифровать и удалять их;
- harden Linux users, services, filesystems and audit trails;
- сегментировать networks and control ingress/egress;
- защищать container images, runtime and Kubernetes workloads;
- проектировать cloud IAM, metadata, network and storage controls;
- писать код с безопасной обработкой input, files, commands and errors;
- предотвращать XSS, CSRF, CORS, SSRF, injection and broken access control;
- защищать APIs, webhooks, uploads and asynchronous interfaces;
- управлять dependencies, vulnerabilities, SBOM and license/provenance data;
- укреплять CI/CD trust boundaries, artifacts and IaC;
- проводить code review, SAST, DAST, fuzzing and controlled security validation;
- приоритизировать vulnerabilities by exploitability, exposure and business impact;
- создавать security events, detections and triage procedures;
- проводить evidence preservation, containment, eradication and recovery;
- формировать policies, audit evidence and secure development lifecycle;
- оценивать residual risk and control effectiveness.

Целевой уровень: 3 по всему разделу и 4 по threat modeling, IAM, application/API security, supply-chain security, detection/response and cross-layer security review.

## Границы

Интенсив не заменяет:

- professional penetration-testing or red-team authorization and apprenticeship;
- malware development/reverse-engineering specialization;
- exploit-development or offensive tradecraft course;
- production cryptographic engineering review;
- legal/compliance counsel;
- vendor-specific SOC, IAM or cloud certification;
- full digital-forensics laboratory accreditation;
- physical-security or personnel-security program.

All testing is defensive, authorized and restricted to synthetic local resources. Public, third-party or production targets are out of scope.

## Предварительные знания

Рекомендуется завершить основные интенсивы 01–12.

Минимально необходимы:

- Go application development and testing;
- Linux users, permissions, processes and networking;
- HTTP, TLS, DNS and browser basics;
- SQL, transactions and data modeling;
- Docker, Kubernetes and cloud concepts;
- CI/CD and software-delivery basics;
- logs, metrics and incident timelines;
- distributed identity and failure concepts;
- technical English.

## Лабораторное окружение

Default laboratory:

- isolated Linux VM or disposable workstation;
- Go, Git, Bash, Make, jq and yq;
- Docker/Podman, Compose and local Kubernetes;
- PostgreSQL and MinIO or equivalent object storage;
- Keycloak/Dex or another local identity provider;
- OPA or another local policy engine;
- OpenSSL and optional step-ca;
- Vault dev/local mode or equivalent secret store;
- Trivy/Grype, Syft, Cosign and Gitleaks;
- Semgrep, gosec and `govulncheck`;
- OWASP ZAP baseline against the local lab only;
- Falco/auditd and local log/SIEM-like stack;
- Prometheus/OpenTelemetry/Grafana for supporting evidence;
- kind/k3d/k3s, Helm and Kustomize;
- `nftables`/`iptables`, `tcpdump`, `ss` and OpenSSH client.

Подробности: [`LAB_ENVIRONMENT.md`](LAB_ENVIRONMENT.md).

Проверка:

```bash
bash scripts/check-environment.sh
```

## Принципы прохождения

1. Every activity requires an owned asset, authorized scope and rollback path.
2. Threat models describe realistic actors, capabilities and trust boundaries.
3. Controls are evaluated by prevented, detected or recoverable failure modes.
4. Authentication does not imply authorization.
5. Long-lived static credentials are treated as exceptional debt.
6. Cryptographic algorithms are not invented or implemented for production use.
7. Sensitive data is minimized before it is encrypted.
8. Least privilege includes time, scope, resource and operation.
9. Security logging avoids secrets and personal-data overcollection.
10. Vulnerability severity is adjusted by exposure, exploitability and business context.
11. Detection without a response path is incomplete.
12. Recovery includes credential rotation, persistence removal and control validation.
13. Security testing never targets public or third-party systems.
14. General mechanisms move to `knowledge`; synthetic evidence and implementations remain in `learning`.

## Основной стек

- Go, PostgreSQL and HTTP APIs;
- Keycloak/Dex and OPA;
- OpenSSL, step-ca and Vault local mode;
- Docker/Compose and Kubernetes;
- Trivy/Grype, Syft, Cosign, Gitleaks, Semgrep, gosec and `govulncheck`;
- OWASP ZAP baseline in isolated scope;
- Falco/auditd and local log analytics;
- Prometheus/OpenTelemetry/Grafana;
- Bash, Make, jq and yq.

## Порядок спринтов

1. [Цели безопасности, активы, угрозы и риск](sprints/01-Цели%20безопасности%20активы%20угрозы%20и%20риск/)
2. [Threat modeling, trust boundaries и attack surface](sprints/02-Threat%20modeling%20trust%20boundaries%20и%20attack%20surface/)
3. [Security architecture, least privilege и zero trust](sprints/03-Security%20architecture%20least%20privilege%20и%20zero%20trust/)
4. [Identity lifecycle, passwords, MFA и sessions](sprints/04-Identity%20lifecycle%20passwords%20MFA%20и%20sessions/)
5. [OAuth 2.0, OpenID Connect и federation](sprints/05-OAuth%202.0%20OpenID%20Connect%20и%20federation/)
6. [Authorization, RBAC, ABAC, ReBAC и policy enforcement](sprints/06-Authorization%20RBAC%20ABAC%20ReBAC%20и%20policy%20enforcement/)
7. [Workload identity, service authentication и mTLS](sprints/07-Workload%20identity%20service%20authentication%20и%20mTLS/)
8. [Проверка основ безопасности и IAM](sprints/08-Проверка%20основ%20безопасности%20и%20IAM/)
9. [Randomness, hashes, KDF, MAC и password storage](sprints/09-Randomness%20hashes%20KDF%20MAC%20и%20password%20storage/)
10. [Symmetric encryption, AEAD, public-key cryptography и signatures](sprints/10-Symmetric%20encryption%20AEAD%20public-key%20cryptography%20и%20signatures/)
11. [PKI, TLS и certificate lifecycle](sprints/11-PKI%20TLS%20и%20certificate%20lifecycle/)
12. [Secrets, keys, tokens, KMS и rotation](sprints/12-Secrets%20keys%20tokens%20KMS%20и%20rotation/)
13. [Data classification, encryption, retention и privacy](sprints/13-Data%20classification%20encryption%20retention%20и%20privacy/)
14. [Проверка криптографии и защиты данных](sprints/14-Проверка%20криптографии%20и%20защиты%20данных/)
15. [Linux hardening, privilege isolation и audit](sprints/15-Linux%20hardening%20privilege%20isolation%20и%20audit/)
16. [Network segmentation, firewall, VPN и egress control](sprints/16-Network%20segmentation%20firewall%20VPN%20и%20egress%20control/)
17. [Container, image, runtime и Kubernetes security](sprints/17-Container%20image%20runtime%20и%20Kubernetes%20security/)
18. [Cloud IAM, network, storage и metadata security](sprints/18-Cloud%20IAM%20network%20storage%20и%20metadata%20security/)
19. [Проверка защиты систем и инфраструктуры](sprints/19-Проверка%20защиты%20систем%20и%20инфраструктуры/)
20. [Secure coding, input validation и dangerous operations](sprints/20-Secure%20coding%20input%20validation%20и%20dangerous%20operations/)
21. [Web and browser security](sprints/21-Web%20and%20browser%20security/)
22. [API, webhook, upload и SSRF security](sprints/22-API%20webhook%20upload%20и%20SSRF%20security/)
23. [Dependency management, SBOM и vulnerability data](sprints/23-Dependency%20management%20SBOM%20и%20vulnerability%20data/)
24. [Software supply chain, signatures и provenance](sprints/24-Software%20supply%20chain%20signatures%20и%20provenance/)
25. [CI-CD, IaC, policy и secret scanning](sprints/25-CI-CD%20IaC%20policy%20и%20secret%20scanning/)
26. [Проверка application и supply-chain security](sprints/26-Проверка%20application%20и%20supply-chain%20security/)
27. [Vulnerability management и remediation](sprints/27-Vulnerability%20management%20и%20remediation/)
28. [Security review, SAST, DAST и fuzzing](sprints/28-Security%20review%20SAST%20DAST%20и%20fuzzing/)
29. [Security logging, SIEM и detection engineering](sprints/29-Security%20logging%20SIEM%20и%20detection%20engineering/)
30. [Endpoint, network detection и threat intelligence](sprints/30-Endpoint%20network%20detection%20и%20threat%20intelligence/)
31. [Incident response, forensics, containment и recovery](sprints/31-Incident%20response%20forensics%20containment%20и%20recovery/)
32. [Проверка detection and response](sprints/32-Проверка%20detection%20and%20response/)
33. [Governance, policies, audit, compliance и privacy](sprints/33-Governance%20policies%20audit%20compliance%20и%20privacy/)
34. [Secure SDLC, security metrics и системный review](sprints/34-Secure%20SDLC%20security%20metrics%20и%20системный%20review/)
99. [Итоговая работа](sprints/99-Итоговая%20работа/)

## Покрытие основных вопросов

| Вопрос | Спринты |
|---|---|
| Какие активы и угрозы важны? | 01–03 |
| Как оценивать risk and residual risk? | 01–03, 27, 33–34 |
| Как проектировать authentication and authorization? | 04–08 |
| Когда применять cryptographic mechanisms? | 09–14 |
| Как хранить secrets, keys and tokens? | 11–14 |
| Как уменьшить host/network/platform attack surface? | 15–19 |
| Какие угрозы характерны для web/API? | 20–22, 26, 28 |
| Как защищать software supply chain? | 23–26 |
| Как находить и приоритизировать vulnerabilities? | 23, 27–28 |
| Какие данные нужны для detection and investigation? | 29–32 |
| Как локализовать и восстановить систему? | 31–32 |
| Как встроить security into engineering process? | 24–26, 33–34 |
| Как подтверждать policies and requirements? | 33–34 |

## Итоговая работа

Финальный проект — `secure-platform-lab`: synthetic application and platform with identity, authorization, cryptographic controls, data protection, hardened infrastructure, secure supply chain, detection, incident-response exercises and read-only `sectriage` diagnostics.

Система должна позволять:

- model threats and trust boundaries;
- authenticate users and workloads with short-lived credentials;
- enforce fine-grained authorization;
- issue, rotate and revoke certificates/secrets;
- protect sensitive data across storage and transport;
- harden hosts, networks, containers and Kubernetes;
- prevent and detect common web/API failures;
- build and verify signed artifacts with SBOM and provenance;
- prioritize vulnerabilities and verify remediation;
- generate and investigate security detections;
- contain and recover from credential, application and platform compromise;
- map controls to risks, policies and audit evidence.

## Вклад в базу знаний

Each sprint names exact recommended notes. General mechanisms move to `knowledge`; configurations, synthetic findings, detections and incident evidence remain in `learning`.

## Общая библиография

Official standards, specifications and selected books are listed in [`RESOURCES.md`](RESOURCES.md). Each sprint identifies the required minimum route.
