# Спринт 15. Проверка облачной инфраструктуры

Ориентировочный объём: 14–21 час.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 09–14.

## Исходная задача

Создать `work/cloud-foundation-checkpoint/` — provider-neutral design plus optional real sandbox implementation for a multi-zone application foundation.

## Required architecture

- isolated account/project/environment;
- virtual network with edge, application and data subnets;
- replaceable compute behind load balancer;
- block/object storage and managed-data option;
- workload and IaC identities;
- secrets management;
- budgets, quotas and ownership tags;
- backup/restore target;
- documented cleanup.

## Required decisions

Compare:

- VM versus managed compute;
- self-managed versus managed database;
- one-zone, multi-zone and multi-region;
- public egress versus private service endpoints;
- on-demand, committed and interruptible capacity;
- snapshot, backup and point-in-time recovery.

## Mandatory fault cases

1. One zone unavailable.
2. Instance/target becomes unhealthy during requests.
3. Private subnet loses NAT/private endpoint.
4. DNS or route is wrong.
5. IAM permission is too narrow or too broad.
6. Secret rotates during active workload.
7. Quota blocks scale/recovery.
8. Block storage or managed database reaches capacity/IO limit.
9. Backup restore lacks key/permission/dependency.
10. Mutable image/tag changes compute contents.
11. Cost tag is missing and orphan disk/IP remains.
12. Destructive cleanup targets wrong account/project and is refused safely.

## Defense

1. Which responsibilities remain with the platform team?
2. Which resources are zonal/regional/global?
3. How does inbound/outbound traffic flow?
4. How are credentials issued and rotated?
5. What survives instance/AZ failure?
6. Which restore evidence meets RTO/RPO?
7. How does autoscaling account for startup and quotas?
8. Which costs dominate and who owns them?
9. What does managed service change?
10. Why multi-region was selected or rejected?
11. How are orphans and drift found?
12. How does cleanup verify the sandbox is empty?

## Критерии прохождения

- design states service models, responsibilities and failure domains;
- real or simulated implementation is reproducible;
- public exposure is minimal and private paths are tested;
- workload uses short-lived identity and runtime secret retrieval;
- one-zone and restore exercises meet stated behavior;
- all twelve faults are diagnosed;
- budget/quota/tag/expiry controls exist;
- destroy refuses wrong target and verifies residual resources;
- at least 10 of 12 defense answers are evidence-based.

## Результат для базы знаний

Checkpoint-specific note не требуется. Update cloud notes where provider evidence changed assumptions about scope, quotas, networking, recovery or cost.