# Спринт 03. Хеш-таблицы, множества и отображения

Ориентировочный объём: 15–22 часа.

## Центральный вопрос

Как hash function turns keys into table positions, почему expected O(1) не является unconditional guarantee и как collision strategy влияет на correctness/performance?

## Результат спринта

После завершения необходимо уметь:

- define map/set abstract operations;
- explain hash/equality contract;
- distinguish chaining and open addressing;
- understand collision, load factor, resize and tombstone;
- implement linear/quadratic probing or double hashing;
- explain expected versus worst-case lookup;
- understand clustering and adversarial keys;
- choose initial capacity/growth policy;
- reason about mutable keys and canonicalization;
- distinguish membership map from ordered map;
- use Go map semantics correctly;
- test collision-heavy cases;
- compare memory overhead and locality;
- understand randomized hash seeds conceptually;
- avoid using hash as cryptographic integrity proof;
- choose hash table versus tree/sorted slice.

## Основной маршрут

### Шаг 1. Abstract map/set

Define Put/Get/Delete/Contains/Len and duplicate-key semantics.

### Шаг 2. Hashing

Study uniform hashing assumption, modulo/capacity choices and equality consistency. Use controlled integer/string hashes for education, not security.

### Шаг 3. Collision strategies

Implement separate chaining and open addressing. Analyze expected probe/chain lengths as load grows.

### Шаг 4. Resize and deletion

Rehashing is not simple array copy. For open addressing, deletion requires tombstones or cluster repair.

## Ресурсы

### Обязательный маршрут

- CLRS hash tables.
- Open Data Structures hash tables.
- Go language/runtime map behavior at public-semantics level.
- Sedgewick hash tables.

### Альтернативные объяснения

- MIT 6.006 hashing lectures.
- Skiena dictionary structures.

### Углубление

- Robin Hood/Cuckoo/Hopscotch hashing;
- perfect/minimal perfect hashing;
- consistent hashing;
- hash-flood defenses;
- cache-efficient hash tables.

## Практические задания

### 1. Chained table

Implement generic table with configurable hasher/equality, resize and stats for chain lengths.

### 2. Open addressing

Implement linear probing with states empty/occupied/deleted. Test wraparound and full-table behavior.

### 3. Collision experiment

Use good hash, constant hash and patterned bad hash. Measure probes/chains versus load factor.

### 4. Set operations

Implement union/intersection/difference and compare hash-set versus sorted-slice algorithms for different size ratios.

## Лабораторная работа

Создать `work/hashlab/`.

### Components

- chained map;
- open-address map;
- adapters for Go map and sorted slice;
- key generators: uniform, sequential, shared-prefix, adversarial collision;
- operation trace generator;
- stats command.

### Requirements

- differential tests against Go map;
- randomized insert/update/delete/get traces;
- resize preserves all entries;
- load/probe/chain histograms generated;
- memory and allocation benchmarks;
- deterministic listing only via explicit sorting;
- no unsafe dependency on Go runtime internals;
- hash function documented as non-cryptographic;
- optional stable hashing for persisted format treated separately.

### Failure scenarios

1. Hash/equality disagree.
2. Delete breaks probe chain.
3. Rehash forgets entries.
4. Load factor approaches one.
5. Mutable/canonicalized key changes semantics.
6. Constant hash causes O(n).
7. Negative integer hash/index conversion error.
8. Map iteration assumed deterministic.
9. Concurrent access incorrectly assumed safe.

## Самопроверка

1. What must hash/equality guarantee?
2. What is collision?
3. Chaining versus open addressing?
4. What is load factor?
5. Why expected O(1), not guaranteed O(1)?
6. What is clustering?
7. Why resize requires rehash?
8. What is tombstone?
9. Hash table versus balanced tree?
10. Why ordinary hash is not cryptographic proof?

## Результат для базы знаний

- **Map and set abstract data types**.
- **Hash function and equality contract**.
- **Collision and load factor**.
- **Separate chaining**.
- **Open addressing and tombstones**.
- **Hash table resizing**.
- **Expected and worst-case hash complexity**.
- **Hash table versus ordered structures**.

## Когда переходить дальше

Можно переходить, когда both table variants pass adversarial differential tests and degradation is explained through load/collision statistics.