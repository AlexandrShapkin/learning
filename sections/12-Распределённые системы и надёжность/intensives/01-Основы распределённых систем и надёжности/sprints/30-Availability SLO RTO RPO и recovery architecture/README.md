# Спринт 30. Availability, SLO, RTO, RPO и recovery architecture

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как связать user-facing availability objectives, redundancy, failure budgets and recovery requirements with concrete distributed architecture?

## Результат спринта

После завершения необходимо уметь:

- distinguish availability, durability, consistency and recoverability;
- define distributed user-journey SLI/SLO;
- calculate serial/parallel dependency availability approximately;
- understand common-mode/correlated failure limits;
- allocate reliability budget across dependencies;
- define RTO and RPO per failure scenario;
- choose redundancy and recovery mechanism by objective;
- distinguish failover from restore;
- define minimum service tier during recovery;
- reason about error budget and change/reliability work;
- measure actual recovery and data loss;
- avoid multiplying vendor SLAs mechanically.

## Основной маршрут

1. Model availability of request path with three dependencies.
2. Compare serial, optional and redundant dependency structures.
3. Define SLO/RTO/RPO for zone loss, region loss and data corruption.
4. Map each objective to failover, replay, backup or rebuild mechanism.

## Лабораторная работа

Создать `work/reliability-objectives/`.

### Requirements

- SLI uses user-visible successful valid operations;
- dependency model includes optional/degraded paths and correlated failures;
- SLO is linked to capacity and architecture, not copied from convention;
- RTO includes detection, decision, provisioning, data, traffic and validation;
- RPO names authoritative state and exact loss boundary;
- failover and restore mechanisms are tested separately;
- minimum service tier and unavailable features are explicit;
- objective gaps are recorded honestly;
- cost/complexity of additional redundancy is estimated;
- error-budget policy permits risk-reducing changes during poor reliability.

### Failure scenarios

1. Component uptime is used as user availability.
2. Vendor SLAs are multiplied without dependency/correlation model.
3. RTO excludes operator decision and traffic propagation.
4. RPO is declared zero with asynchronous replication.
5. Failover protects availability but propagates corruption.
6. Redundancy shares the same control plane/failure domain.
7. SLO target exceeds achievable tested capacity/recovery.

## Результат для базы знаний

- **Distributed availability, durability and recoverability**.
- **Dependency availability and correlated failures**.
- **Distributed-system SLI and SLO design**.
- **RTO and RPO by failure scenario**.
- **Reliability objectives and architecture cost**.

## Когда переходить дальше

Можно переходить, когда SLO/RTO/RPO claims are traced to tested architecture and measured failure/recovery paths rather than nominal redundancy.