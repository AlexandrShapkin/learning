# Спринт 20. Production readiness и операционный контракт

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Какие ownership, dependency, recovery, capacity and support conditions must be true before a new service or major capability is considered operationally ready?

## Результат спринта

После завершения необходимо уметь:

- conduct a production-readiness review;
- define service owner, escalation and support hours;
- inventory dependencies and failure modes;
- verify health, graceful shutdown and degraded behavior;
- define capacity assumptions and quotas;
- identify persistent state and backup requirements;
- document configuration/secret/certificate lifecycles;
- define rollout, rollback/forward-fix and maintenance paths;
- create operational acceptance criteria;
- distinguish launch blockers from tracked risk;
- define supportability and diagnostic evidence;
- avoid checklist completion without executable proof.

## Основной маршрут

1. Create readiness criteria for the reference service.
2. Walk through dependency, data, deployment, recovery and ownership scenarios.
3. Mark missing evidence and run validation exercises.
4. Accept/reject launch with explicit risks and owners.

## Лабораторная работа

Создать `work/production-readiness/`.

### Requirements

- service catalog entry names owner, repository, runtime and support contact;
- dependency map includes timeouts, quotas and fallback/degraded behavior;
- artifact/config/schema/runtime revisions are observable;
- probes, shutdown and maintenance behavior are tested;
- capacity baseline, expected growth and one-failure headroom are stated;
- persistent data has backup and restore owner;
- secrets/certificates have rotation and expiry handling;
- release and recovery runbooks are exercised;
- access/support/audit requirements are explicit;
- risks have owner, severity and review trigger;
- readiness decision cites evidence rather than checkbox status.

### Failure scenarios

1. Service launches with no named operational owner.
2. Dependency timeout/retry behavior is unknown.
3. Backup exists but restore was never tested.
4. Certificate/secret expires shortly after launch.
5. Health check passes while critical path fails.
6. Capacity estimate excludes background/peak/failure load.
7. Runbook references permissions/tools responders do not have.
8. Review approves because every field is filled, not because tests pass.

## Результат для базы знаний

- **Production readiness review**.
- **Service operational ownership and support contract**.
- **Operational dependency and failure inventory**.
- **Launch blockers, accepted risks and review triggers**.
- **Executable readiness evidence**.

## Когда переходить дальше

Можно переходить, когда the service has a named support/recovery contract and readiness claims are proven through deployment, dependency, capacity and restore exercises.