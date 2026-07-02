# Спринт 08. Модели согласованности

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Какие наблюдаемые гарантии нужны клиенту при concurrent operations and replication, and which weaker model is sufficient?

## Результат спринта

После завершения необходимо уметь:

- различать linearizability, serializability and strict serializability;
- понимать sequential and causal consistency;
- определять eventual consistency precisely;
- применять read-your-writes, monotonic reads and monotonic writes;
- формулировать session guarantees;
- различать real-time order and transaction order;
- проектировать consistency contract per operation;
- распознавать stale, fractured and non-monotonic reads;
- выбирать stronger guarantees only where value justifies cost;
- строить histories for verification.

## Основной маршрут

1. Generate concurrent read/write histories on replicated state.
2. Reproduce stale and non-monotonic reads.
3. Add session routing/version tokens for read-your-writes.
4. Compare linearizable write/read path with eventual follower reads.

## Лабораторная работа

Создать `work/consistency-models/`.

### Requirements

- each API operation names required consistency model;
- client histories include invocation/completion and observed values;
- read-your-writes and monotonic-read cases are tested;
- linearizable register behavior is tested under concurrency/partition;
- eventual convergence includes conflict and time/trigger assumptions;
- transaction isolation is not mislabeled as distributed consistency;
- one weaker model is selected for latency/availability reason;
- UI/business behavior under stale data is explicit.

### Failure scenarios

1. User writes then reads stale follower.
2. Repeated reads move backward in version.
3. Two objects are read from incompatible snapshots.
4. “Eventually consistent” has no convergence mechanism.
5. Database serializability is assumed to make external RPC atomic.
6. Cache invalidation violates claimed consistency.

## Результат для базы знаний

- **Linearizability and real-time order**.
- **Sequential and causal consistency**.
- **Eventual consistency and convergence**.
- **Session guarantees**.
- **Consistency contracts and client histories**.

## Когда переходить дальше

Можно переходить, когда consistency is stated as testable client-observable behavior for each operation rather than a database/product label.