# Спринт 14. Стоимость, ёмкость и устойчивость облачной платформы

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как connect workload demand, resource capacity, failure tolerance and cloud billing so that the platform remains affordable without destroying required resilience?

## Результат спринта

После завершения необходимо уметь:

- строить unit cost and cost-allocation model;
- различать fixed, variable and idle cost;
- понимать utilization, rightsizing and commitment trade-offs;
- учитывать network egress, NAT, logging, snapshots and managed-service hidden costs;
- проектировать tags/labels and cost ownership;
- прогнозировать baseline, peak, growth and failure capacity;
- учитывать regional/AZ capacity and quotas;
- сравнивать reserved/committed, on-demand and spot capacity;
- оценивать resilience cost and recovery alternatives;
- понимать RTO/RPO at infrastructure design level;
- выполнять game-day style capacity/failure experiment;
- избегать cost optimization that removes headroom, backups or observability;
- использовать budgets/alerts and automatic expiry;
- различать cost anomaly and expected scale event.

## Основной маршрут

1. Build monthly cost model for the synthetic platform across three deployment options.
2. Attribute cost by environment/team/service and unit such as request/job/tenant.
3. Model normal peak, one-zone failure and 2× growth capacity.
4. Identify top cost drivers and run one safe optimization experiment.
5. Define budget/anomaly/expiry controls.

## Ресурсы

- FinOps Foundation introductory material.
- selected provider pricing/calculator/budget docs.
- capacity planning and reliability references.

## Лабораторная работа

Создать `work/cloud-economics/`.

### Requirements

- inventory includes compute, storage, requests, data transfer, gateways, logs and backups;
- costs are allocated through mandatory ownership/environment tags;
- one useful unit-cost metric is defined;
- baseline, peak, growth and failure headroom are modeled;
- commitment/spot scenarios include interruption and underutilization risk;
- RTO/RPO alternatives compare warm, restore and multi-zone designs;
- budgets and expiration checks are automated;
- optimization preserves performance, recovery and observability requirements;
- orphan-resource detection covers disks, IPs, snapshots and load balancers;
- assumptions and provider-price date/version are recorded;
- no real unbounded spend is created.

### Failure scenarios

1. VM cost is optimized while NAT/egress/logging dominates.
2. Rightsizing removes failure/maintenance headroom.
3. Commitment locks in wrong resource family/region.
4. Spot interruption removes all replicas.
5. Backup retention grows indefinitely.
6. Cost tags are missing or mutable without governance.
7. Budget alert exists but no response/automatic expiry.
8. Multi-region cost is accepted without RTO/RPO requirement.

## Самопроверка

1. Fixed, variable and idle cloud cost?
2. Unit cost usefulness?
3. Rightsizing versus headroom?
4. Commitment versus capacity reservation?
5. Common hidden cloud costs?
6. Cost allocation requires what metadata?
7. RTO versus RPO?
8. Resilience cost alternatives?
9. Budget versus anomaly detection?
10. How to prove optimization did not reduce reliability?

## Результат для базы знаний

- **Cloud cost allocation and unit economics**.
- **Cloud rightsizing, commitments and spot capacity**.
- **Capacity planning for peak, growth and failures**.
- **Infrastructure RTO and RPO trade-offs**.
- **Cloud hidden costs and orphan resources**.
- **Budgets, expiry and cost anomaly controls**.

## Когда переходить дальше

Можно переходить, когда platform cost is attributable and forecast across normal/failure/growth scenarios, and every optimization preserves explicit capacity and recovery requirements.