# Спринт 10. Регионы, зоны, compute и балансировка

Ориентировочный объём: 17–24 часа.

## Центральный вопрос

Как размещать compute across regions and availability zones так, чтобы scaling, maintenance and failure behavior соответствовали требованиям приложения?

## Результат спринта

После завершения необходимо уметь:

- различать region, availability zone and edge location;
- понимать zonal and regional resources;
- выбирать VM, autoscaling group, serverless/container compute and managed platform;
- проектировать image/bootstrap/instance replacement;
- различать vertical and horizontal scaling;
- понимать health checks, load balancer listeners, target groups and draining;
- учитывать cross-zone and cross-region latency/cost;
- проектировать placement across failure domains;
- понимать spot/preemptible and reserved/committed capacity trade-offs;
- оценивать instance shape, burst and throttling models;
- учитывать startup time and scaling lag;
- выполнять rolling replacement and failure testing;
- избегать state on replaceable compute;
- отличать capacity reservation from billing discount.

## Основной маршрут

1. Model one stateless service in one zone, multi-zone and multi-region variants.
2. Build local load-balanced VM simulation or optional cloud autoscaling group.
3. Observe health check, connection draining and failed-instance replacement.
4. Compare scaling by VM size, replica count and managed execution model.

## Ресурсы

- selected provider region/AZ/compute/load-balancer/autoscaling docs.
- systems-performance and capacity references.
- cloud architecture availability guidance.

## Лабораторная работа

Создать `work/cloud-compute/`.

### Requirements

- compute resources are replaceable from image/bootstrap;
- application state is externalized;
- at least two failure domains are represented;
- load balancer uses application-relevant health check;
- draining/termination grace is measured;
- autoscaling signal, target and cooldown/stabilization are explicit;
- startup lag and minimum capacity are included;
- one instance/zone failure preserves intended service level;
- cost and latency of cross-zone/region traffic are noted;
- spot/preemptible interruption path is tested or simulated;
- cleanup removes all dynamic capacity and detached resources.

### Failure scenarios

1. Replicas exist but all are in one zone.
2. Load balancer checks TCP port while application is unusable.
3. Scale-out starts too late because boot/warm-up is ignored.
4. Scale-in kills active work without draining.
5. Stateful data lives on ephemeral instance disk.
6. Burst CPU credits or provider throttling causes latency.
7. Reserved pricing is mistaken for guaranteed capacity.
8. Multi-region design adds replication/consistency complexity without requirement.

## Самопроверка

1. Region versus availability zone?
2. Zonal versus regional resource?
3. Vertical versus horizontal scaling?
4. Health check versus readiness?
5. Connection draining purpose?
6. Autoscaling signal and lag?
7. Spot/preemptible trade-off?
8. Capacity reservation versus price commitment?
9. Replaceable compute requires what?
10. Why multi-region is not default?

## Результат для базы знаний

- **Cloud regions and availability zones**.
- **Replaceable cloud compute and images**.
- **Cloud load balancing and connection draining**.
- **Horizontal scaling and autoscaling lag**.
- **Spot/preemptible and committed capacity**.
- **Multi-zone and multi-region trade-offs**.

## Когда переходить дальше

Можно переходить, когда compute replacement and zone failure are tested, state is not tied to instances, and scaling decisions include signal quality, startup lag, draining and cost.