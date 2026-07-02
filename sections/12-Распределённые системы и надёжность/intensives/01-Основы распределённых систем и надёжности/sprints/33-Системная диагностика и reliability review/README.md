# Спринт 33. Системная диагностика и reliability review

Ориентировочный объём: 21–31 час.

## Центральный вопрос

Как локализовать first divergence in a distributed failure and оценить, действительно ли архитектура сохраняет заявленные свойства при частичных отказах и перегрузке?

## Результат спринта

После завершения необходимо уметь:

- correlate request, operation, message, partition, replica, term and offset identities;
- reconstruct distributed timelines with causal uncertainty;
- distinguish client timeout from committed/ongoing effect;
- identify stale writer, stale replica and stale routing;
- separate broker, consumer, coordinator and domain-state failures;
- inspect quorum, term, epoch and ownership evidence;
- diagnose retry storms, queue growth and cascading failure;
- preserve evidence before restart/failover;
- perform reliability review from invariants and failure domains;
- identify hidden coordination and common-mode dependencies;
- rank architecture risks by likelihood, impact and detectability;
- convert diagnosis into a tested guard or redesign.

## Diagnostic loop

```text
state exact user impact and invariant
→ identify operation/message/replica/epoch scope
→ preserve histories, offsets, terms, versions and topology
→ reconstruct causal path and failure domains
→ rank competing hypotheses
→ run one discriminating read-only check
→ locate first divergence
→ repair or isolate minimally
→ verify data, ownership, backlog and user behavior
→ add invariant check, admission control or design correction
```

## Лабораторная работа

Создать `work/distributed-diagnostics/`.

### `disttriage`

Read-only commands:

```text
disttriage operation --id ID
disttriage message --id ID
disttriage replica --key KEY
disttriage partition --id ID
disttriage quorum --group NAME
disttriage leader --group NAME
disttriage workflow --id ID
disttriage backlog --stream NAME
disttriage topology
disttriage timeline --from TIME --to TIME
```

### Required cases

Solve at least 20 single-layer and 8 combined faults covering RPC, replication, consistency, partitioning, messaging, coordination, overload and failover.

### Requirements

- tool is read-only, bounded and redacted;
- canonical identities connect user request to effects and replicated state;
- timeline separates wall time, logical/causal order and uncertainty;
- stale writer/owner/consumer is detectable through epoch/generation;
- quorum and commit evidence are explicit;
- backlog/attempt amplification and capacity state are visible;
- at least one leading hypothesis is falsified per case;
- repair verification covers authoritative state, convergence, backlog and user behavior;
- review maps every critical invariant to controls and fault tests;
- recommendations distinguish correctness, availability, operability and cost.

### Combined examples

- lost response + retry storm + duplicate external effect;
- stale discovery + old leader + delayed write;
- minority writes + sloppy quorum + read repair conflict;
- rebalance + stale router + hot shard;
- consumer rebalance + dedup expiry + replay;
- expired lease + paused holder + missing fencing;
- region failover + DNS split + async replication lag;
- telemetry loss + queue growth + misleading health checks.

## Результат для базы знаний

- **Systematic diagnosis of distributed systems**.
- **Distributed operation, message, replica and epoch correlation**.
- **Quorum, ownership and first-divergence evidence**.
- **Distributed reliability reviews and invariant coverage**.
- **Correctness, availability, operability and cost risk classification**.

## Когда переходить дальше

Можно переходить к итоговой работе, когда unfamiliar combined faults are localized through immutable identities and causal evidence, and reliability claims are mapped to tested controls.