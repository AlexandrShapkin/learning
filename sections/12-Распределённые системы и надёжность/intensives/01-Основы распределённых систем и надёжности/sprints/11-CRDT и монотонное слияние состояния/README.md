# Спринт 11. CRDT и монотонное слияние состояния

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Когда состояние можно проектировать так, чтобы independent concurrent updates merge deterministically without central coordination?

## Результат спринта

После завершения необходимо уметь:

- distinguish state-based and operation-based CRDTs;
- understand join semilattice and monotonic growth conceptually;
- implement G-Counter, PN-Counter, G-Set and observed-remove set at learning level;
- require commutative, associative and idempotent merge where appropriate;
- understand causal delivery requirements of op-based CRDTs;
- handle removals and tombstone/metadata cost;
- recognize invariants that CRDTs do not preserve automatically;
- choose CRDT only when domain semantics accept merged outcomes;
- test convergence under reorder, duplication and partition;
- compare coordination cost with merge complexity.

## Основной маршрут

1. Implement state-based counter and set replicas.
2. Deliver updates in different orders with duplicates.
3. Partition, update and merge replicas.
4. Attempt an invariant such as bounded inventory and identify why coordination may still be required.

## Лабораторная работа

Создать `work/crdt/`.

### Requirements

- merge law tests cover associativity, commutativity and idempotence;
- replicas converge after all states/operations are delivered;
- duplicate and reordered delivery do not corrupt result;
- remove semantics and metadata growth are explicit;
- disconnected replica recovery is tested;
- one domain fit and one non-fit are documented;
- invariant violation demonstrates limit of coordination-free merge;
- garbage collection assumptions are written.

### Failure scenarios

1. Merge depends on message order.
2. Duplicate operation increments twice.
3. Removed element resurrects after old replica returns.
4. Metadata/tombstones grow without bound.
5. Concurrent inventory decrements violate nonnegative stock.
6. Operation-based update is delivered without required causal context.

## Результат для базы знаний

- **State-based and operation-based CRDTs**.
- **Join-semilattice and monotonic merge**.
- **CRDT convergence laws**.
- **CRDT removals and metadata cost**.
- **CRDT limits for global invariants**.

## Когда переходить дальше

Можно переходить, когда replicas converge under partition, duplication and reordering, and the chosen domain explicitly accepts the merged semantics.