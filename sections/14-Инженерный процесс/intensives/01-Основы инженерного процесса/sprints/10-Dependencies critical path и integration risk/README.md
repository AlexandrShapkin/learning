# Спринт 10. Dependencies, critical path и integration risk

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Как выявлять и уменьшать dependencies so they do not create hidden queues, late integration and false parallelism?

## Результат спринта

После завершения необходимо уметь:

- различать hard, soft, technical, organizational and external dependencies;
- identify critical path and integration points;
- reduce dependencies through interfaces, stubs and sequencing;
- plan contract and compatibility work early;
- expose waiting and dependency ownership;
- distinguish coordination from actual dependency;
- manage external uncertainty and fallback;
- avoid parallel work that converges only at the end;
- detect dependency amplification across teams/components.

## Основной маршрут

1. Build dependency graph for one large change.
2. Mark critical path and risky integration boundaries.
3. Remove or invert at least two dependencies.
4. Design early contract/integration checks.
5. Simulate one delayed external dependency.

## Лабораторная работа

Создать `work/dependencies/`.

### Requirements

- each dependency names provider, consumer, artifact and readiness evidence;
- critical path is based on actual ordering, not organizational hierarchy;
- interface/contract is tested before final integration;
- external dependency has timeout, fallback or decision deadline;
- dependency wait time is visible;
- stubs/mocks are retired or validated against reality;
- late integration risk is reduced through incremental integration;
- ownership and escalation are explicit without status bureaucracy.

### Failure scenarios

1. Teams work in parallel but integrate only at the end.
2. Shared component/API contract remains implicit.
3. External dependency has no fallback or decision date.
4. Stub diverges from provider behavior.
5. “Blocked” item has no named dependency owner/evidence.
6. Coordination meeting is mistaken for dependency resolution.

## Результат для базы знаний

- **Engineering dependencies and critical path**.
- **Integration-risk reduction**.
- **Contract-first and incremental integration**.
- **External dependency uncertainty**.

## Когда переходить дальше

Можно переходить, когда critical dependencies are explicit, tested early and reduced enough that integration does not become a final surprise.