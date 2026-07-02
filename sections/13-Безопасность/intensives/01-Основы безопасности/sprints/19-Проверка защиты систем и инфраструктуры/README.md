# Спринт 19. Проверка защиты систем и инфраструктуры

Ориентировочный объём: 15–22 часа.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 15–18.

## Исходная задача

Создать `work/infrastructure-security-checkpoint/` — hardened Linux/container/Kubernetes/cloud-like environment with least privilege, segmentation, workload identity, audit and policy enforcement.

## Required capabilities

- non-root hardened service;
- restrictive filesystem/capability/systemd or container sandbox;
- default-deny network and egress controls;
- secure administrative path;
- hardened image and Kubernetes workload;
- least-privilege service accounts/RBAC;
- cloud-like short-lived roles and private storage;
- audit and runtime detections.

## Mandatory fault cases

1. Service runs as root with broad filesystem access.
2. World-readable config/secret.
3. Direct backend bypasses gateway/authentication.
4. Flat network permits lateral movement.
5. Arbitrary egress reaches metadata/internal endpoint.
6. Secret remains in image layer.
7. Privileged Pod/hostPath/host namespace.
8. Broad Kubernetes service-account permissions.
9. Mutable image tag changes deployed artifact.
10. Static cloud credential in CI/image.
11. Public object storage or overbroad resource policy.
12. Audit/detection evidence is absent or modifiable by workload.

## Defense

1. Which host privileges are required and why?
2. Which network flows are allowed and why?
3. Where can proxy/policy controls be bypassed?
4. How is administrative access isolated?
5. How are images and runtime restricted?
6. Which Kubernetes identities and permissions exist?
7. How are workload/cloud credentials issued?
8. How are metadata and object storage protected?
9. Which actions are audited?
10. How are admission/runtime controls tested?
11. Which failure domains or shared controls remain?
12. What residual infrastructure risk is accepted?

## Критерии прохождения

- normal workload runs under minimum tested privileges;
- unlisted network and cloud-like access is denied;
- container/Kubernetes policies reject unsafe examples;
- static credentials and public storage are absent;
- host, control-plane and runtime evidence is attributable;
- all twelve faults are reproduced and corrected;
- at least 10 of 12 defense answers cite policies, permissions or events;
- cleanup removes firewall rules, credentials, namespaces and test storage.

## Результат для базы знаний

Checkpoint-specific note не требуется. Update infrastructure-security notes where measured platform behavior changed assumptions.