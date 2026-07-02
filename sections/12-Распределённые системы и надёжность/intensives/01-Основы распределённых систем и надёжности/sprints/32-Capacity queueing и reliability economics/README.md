# Спринт 32. Capacity, queueing и reliability economics

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как определить capacity and headroom for a distributed system, учитывая очереди, fan-out, retries, failure reserve and cost of reliability?

## Результат спринта

После завершения необходимо уметь:

- apply Little’s Law to measured flow;
- distinguish throughput, concurrency, latency and queue length;
- identify service demand and bottleneck resource;
- understand utilization growth and nonlinear queueing delay;
- model fan-out and retry amplification;
- size for peak, rollout, zone loss and recovery backlog;
- separate steady-state and burst capacity;
- plan partition/consumer/connection capacity;
- estimate redundancy and reliability cost;
- avoid average-only capacity planning;
- define headroom and admission thresholds;
- compare scale-up, scale-out and architecture changes.

## Основной маршрут

1. Measure arrival/completion/concurrency/latency for each stage.
2. Validate Little’s Law on stable workload.
3. Ramp load through saturation knee.
4. Lose one zone/replica and measure minimum capacity.
5. Drain replay/backlog while serving live traffic.

## Лабораторная работа

Создать `work/capacity-queueing/`.

### Requirements

- workload model includes normal, peak, burst and recovery modes;
- arrival and service rates are separated;
- queue age and length are both measured;
- fan-out/retry/replication overhead is included;
- first bottleneck is identified experimentally;
- headroom covers rollout and one declared failure scenario;
- backlog drain capacity exceeds live arrivals by stated margin;
- per-partition/consumer/DB-connection limits are modeled;
- cost report separates compute, storage, network and redundancy;
- one reliability improvement is rejected or redesigned due disproportionate cost/complexity;
- uncertainty and growth assumptions are explicit.

### Failure scenarios

1. Average traffic hides peak/burst.
2. Utilization near 100% is planned as efficient steady state.
3. Retry traffic is counted as user demand.
4. Zone loss leaves insufficient quorum or throughput.
5. Adding workers saturates database/broker.
6. Replay competes with live traffic and prevents recovery.
7. Partition count/connection limits cap scale-out.
8. Redundancy doubles cost but shares same failure domain.

## Результат для базы знаний

- **Little’s Law for distributed workloads**.
- **Capacity, concurrency, queues and saturation**.
- **Retry, fan-out and replication capacity amplification**.
- **Failure and recovery headroom**.
- **Reliability cost and architecture trade-offs**.

## Когда переходить дальше

Можно переходить, когда peak, one-failure and backlog-recovery capacity are measured end to end and the first bottleneck is known rather than assumed.