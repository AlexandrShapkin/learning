# Спринт 13. Recreate, rolling и blue-green deployment

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как выбрать deployment strategy based on availability, capacity, compatibility and recovery needs, and how to verify that runtime traffic actually follows the intended revision?

## Результат спринта

После завершения необходимо уметь:

- distinguish deployment from release;
- compare recreate, rolling and blue-green strategies;
- understand surge, unavailable, draining and readiness;
- calculate temporary capacity requirements;
- design pre-deploy and post-deploy checks;
- verify exact artifact/config/schema revision;
- handle long-lived connections and background jobs;
- understand load balancer/service cutover behavior;
- define stop, continue and rollback conditions;
- avoid declaring success at manifest apply time;
- manage old environment retention and cleanup;
- account for irreversible data/external effects.

## Основной маршрут

1. Deploy one service with recreate and measure downtime.
2. Configure rolling update with bounded surge/unavailable.
3. Implement blue-green cutover and return path.
4. Test active connections, worker jobs and readiness delay.
5. Compare capacity, complexity and recovery time.

## Лабораторная работа

Создать `work/deployment-strategies/`.

### Requirements

- one immutable release manifest drives all strategies;
- readiness reflects ability to serve current dependency/config/schema state;
- graceful termination drains requests/jobs;
- rolling strategy has capacity calculation and observed replacement order;
- blue and green environments are independently verifiable;
- cutover changes a controlled routing reference, not artifact contents;
- post-deploy probes verify user path and build metadata;
- old environment retention has time/condition and cleanup;
- rollback is refused when compatibility assumptions are broken;
- deployment report includes duration, errors, capacity and recovery evidence.

### Failure scenarios

1. Recreate is used where downtime is unacceptable.
2. Rolling rollout starts new Pods that cannot read old/new schema.
3. Readiness passes before cache/migration/dependency is usable.
4. Old Pods are killed before connection draining.
5. Blue-green doubles capacity beyond quota.
6. Routing cutover succeeds but background workers run in both environments.
7. Rollback points traffic to old app with incompatible data.
8. Old environment is deleted before validation window ends.

## Результат для базы знаний

- **Recreate, rolling and blue-green deployment**.
- **Deployment readiness, draining and surge capacity**.
- **Blue-green traffic cutover and old-environment retention**.
- **Deployment verification versus manifest success**.
- **Deployment strategy compatibility constraints**.

## Когда переходить дальше

Можно переходить, когда each strategy has measured capacity/downtime/recovery behavior and rollout success is based on user-path evidence rather than controller completion alone.