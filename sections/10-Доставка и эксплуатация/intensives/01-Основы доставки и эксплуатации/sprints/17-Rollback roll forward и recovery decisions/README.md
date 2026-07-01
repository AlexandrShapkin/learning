# Спринт 17. Rollback, roll forward и recovery decisions

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Когда returning to an older artifact restores service safely, and when data, contracts, queues or external effects require roll forward or another recovery action?

## Результат спринта

После завершения необходимо уметь:

- distinguish deployment rollback, configuration rollback, traffic switch and data restore;
- classify reversible and irreversible release effects;
- build rollback compatibility matrix;
- choose rollback versus roll forward under time pressure;
- understand code rollback cannot undo external effects;
- preserve evidence before rollback where possible;
- automate bounded rollback while verifying exact target revision;
- handle queue/jobs during version change;
- use feature disable or traffic isolation as intermediate stabilization;
- define recovery decision authority and time budget;
- verify state invariants after recovery;
- reconcile emergency changes into desired state.

## Основной маршрут

1. Break a release through code-only regression and roll back.
2. Break through incompatible schema/data change and demonstrate unsafe rollback.
3. Compare feature disable, traffic switch, rollback and forward patch.
4. Recover interrupted background work and external-provider effects.

## Лабораторная работа

Создать `work/release-recovery/`.

### Requirements

- release manifest states rollback compatibility and irreversible steps;
- recovery matrix covers artifact, config, schema, data, queue and external effects;
- rollback verifies target digest/config/schema before traffic;
- forward fix is predesigned for one irreversible migration;
- feature flag/traffic isolation provides bounded mitigation;
- queued/in-flight work is paused, drained or made compatible explicitly;
- recovery preserves enough events/logs/state for diagnosis;
- post-recovery probes verify user path and data invariants;
- emergency manual action is recorded and reconciled;
- measured time-to-decision and time-to-recovery are reported.

### Failure scenarios

1. Old binary cannot read new schema/data.
2. Rollback resends irreversible notification/payment.
3. Queue contains messages only new version understands.
4. Traffic is switched before old environment is healthy.
5. Automatic rollback loops between unhealthy revisions.
6. Config rollback targets wrong artifact assumptions.
7. Evidence disappears after mass restart/deletion.
8. Hot forward fix is not reconciled into main/release state.

## Результат для базы знаний

- **Software rollback, roll forward and traffic recovery**.
- **Release rollback compatibility matrix**.
- **Irreversible data and external release effects**.
- **Feature disable and traffic isolation as mitigation**.
- **Release recovery verification and reconciliation**.

## Когда переходить дальше

Можно переходить, когда recovery choice is made from explicit code/config/data/contract/effect state and both safe rollback and required forward repair are exercised.