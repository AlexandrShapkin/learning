# Спринт 22. Leader election, consensus и Raft

Ориентировочный объём: 21–31 час.

## Центральный вопрос

Как несколько узлов приходят к одному последовательному журналу и единому лидеру при crash, delay and partitions?

## Результат спринта

После завершения необходимо уметь:

- отличать leader election, consensus and replication;
- понимать term, vote, majority and leader completeness;
- объяснять Raft election and log replication;
- различать committed and merely appended entries;
- понимать quorum availability and minority behavior;
- prevent stale leader from committing;
- apply replicated state-machine commands deterministically;
- understand snapshots and log compaction;
- handle membership change conceptually;
- distinguish safety from liveness under timing assumptions;
- read terms/indexes/commit positions during diagnosis;
- avoid building production consensus casually.

## Основной маршрут

1. Implement simplified Raft simulation or instrument an educational library.
2. Trigger election, leader crash and follower catch-up.
3. Partition old leader from majority.
4. Rejoin divergent logs and observe conflict truncation.
5. Snapshot/compact and restore one node.

## Лабораторная работа

Создать `work/raft-consensus/`.

### Requirements

- state-machine commands are deterministic;
- terms, votes, log index and commit index are observable;
- only majority-backed current-term entries become committed per model;
- minority cannot make committed progress;
- old leader cannot overwrite committed entries;
- follower conflict resolution is tested;
- node restart restores durable term/vote/log state;
- snapshot includes last included index/term and state checksum;
- timing changes affect liveness, not safety;
- invariants are checked over randomized event schedules.

### Failure scenarios

1. Two leaders in different terms are treated as safety violation automatically.
2. Old leader serves/accepts unsafe writes without quorum/lease rule.
3. Entry exists on leader but is reported committed prematurely.
4. Vote state is lost on restart.
5. Snapshot and remaining log do not align.
6. Non-deterministic state machine diverges across replicas.
7. Membership change loses overlapping quorum.

## Результат для базы знаний

- **Leader election and distributed consensus**.
- **Raft terms, voting and log replication**.
- **Committed entries and replicated state machines**.
- **Raft snapshots and log compaction**.
- **Consensus safety and liveness assumptions**.

## Когда переходить дальше

Можно переходить, когда randomized crash/partition histories preserve one committed log and timing failures affect progress without violating safety.