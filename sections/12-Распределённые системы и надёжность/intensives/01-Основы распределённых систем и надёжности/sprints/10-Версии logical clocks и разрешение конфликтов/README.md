# Спринт 10. Версии, logical clocks и разрешение конфликтов

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как определить concurrent versus causally ordered updates and merge them without relying on wall-clock last-write-wins?

## Результат спринта

После завершения необходимо уметь:

- применять versions, compare-and-set and optimistic concurrency;
- понимать Lamport clocks and vector clocks/version vectors;
- определять dominance and concurrency;
- explain last-write-wins limitations;
- design domain-specific conflict resolution;
- preserve tombstones and deletion semantics;
- handle retry of conditional updates;
- perform anti-entropy without resurrecting deleted state;
- bound metadata growth;
- expose unresolved conflicts when automatic merge is unsafe.

## Основной маршрут

1. Implement versioned replicated object.
2. Generate concurrent updates on partitioned replicas.
3. Compare wall-clock LWW, vector versions and domain merge.
4. Add delete/tombstone and anti-entropy.

## Лабораторная работа

Создать `work/version-conflicts/`.

### Requirements

- conditional writes reject stale expected version;
- vector/version metadata identifies causal dominance and concurrency;
- concurrent values are retained until safe resolution;
- merge function is associative/commutative/idempotent where claimed;
- deletion has tombstone/version and bounded GC conditions;
- retry cannot apply an old conditional update twice;
- LWW is used only with documented lost-update risk;
- metadata compaction does not destroy necessary causality.

### Failure scenarios

1. Clock-skewed LWW loses newer logical update.
2. Concurrent edits are mistaken for overwrite order.
3. Tombstone expires before disconnected replica returns.
4. Read repair resurrects deleted value.
5. Version metadata grows without bound.
6. Automatic merge violates domain invariant.

## Результат для базы знаний

- **Optimistic concurrency and compare-and-set**.
- **Lamport and vector clocks**.
- **Causal dominance and concurrent versions**.
- **Distributed conflict resolution**.
- **Tombstones, resurrection and metadata compaction**.

## Когда переходить дальше

Можно переходить, когда partitioned concurrent updates are detected and resolved without wall-clock ordering or silent loss of domain information.