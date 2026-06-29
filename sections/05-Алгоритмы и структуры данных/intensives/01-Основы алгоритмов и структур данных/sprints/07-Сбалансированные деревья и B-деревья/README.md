# Спринт 07. Сбалансированные деревья и B-деревья

Ориентировочный объём: 16–23 часа.

## Центральный вопрос

Как поддерживать bounded height during updates и почему external-memory trees use high branching factor rather than binary shape?

## Результат спринта

После завершения необходимо уметь:

- объяснять balance condition and logarithmic height;
- понимать rotations and local restructuring;
- реализовывать AVL tree полностью или red-black tree core operations;
- объяснять red-black invariants conceptually;
- сравнивать AVL and red-black trade-offs;
- понимать B-tree nodes, keys, children, split and merge;
- объяснять why B/B+ trees fit block storage;
- distinguish search tree from database index implementation;
- implement ordered map operations and range scan;
- reason about update/read costs and node occupancy;
- validate all structural invariants;
- compare balanced tree with sorted slice and hash map;
- understand order-statistic augmentation overview;
- avoid claiming all trees are O(log n) without invariant.

## Основной маршрут

### Шаг 1. Rotations and AVL

Study height/balance factor and LL/LR/RR/RL cases. Implement insertion first, then deletion if time permits; deletion is mandatory in lab for chosen balanced variant.

### Шаг 2. Red-black model

Understand coloring invariants and mapping to 2-3-4 trees. Full implementation optional if AVL is implemented completely.

### Шаг 3. B-tree

Study node capacity, split before descent, root split, deletion overview and B+ leaf linking.

### Шаг 4. Ordered API

Support lower bound, range iteration and predecessor/successor. These distinguish ordered tree from hash map.

## Ресурсы

### Обязательный маршрут

- CLRS red-black/B-tree chapters.
- Open Data Structures balanced trees.
- Sedgewick red-black BST.
- Database systems B+ tree overview as cross-reference.

### Углубление

- treaps, skip lists;
- weight-balanced trees;
- order-statistic trees;
- copy-on-write B-trees;
- cache-oblivious trees.

## Практические задания

1. Implement rotations independently and verify inorder preservation.
2. Implement AVL or full red-black ordered map.
3. Build small in-memory B-tree with configurable minimum degree.
4. Add range queries and order-statistic augmentation optional.
5. Compare node occupancy/height under random and ordered workloads.

## Лабораторная работа

Создать `work/balanced-tree-lab/`.

### Required structures

- complete AVL tree with insert/delete/get/range; or complete red-black tree;
- educational B-tree with search/insert/delete or search/insert plus rigorously tested delete model if full delete is excessive;
- stdlib/sorted-slice/hash adapters.

### Requirements

- invariant checker: ordering, heights/colors, parent/child relations, B-tree occupancy;
- randomized differential traces;
- exhaustive small-operation sequences where feasible;
- Graphviz snapshots for rotations/splits;
- comparison counters and height distribution;
- range-scan benchmarks;
- node-size/branching-factor experiment;
- deletion never leaves invalid root/underfull child;
- API does not expose mutable nodes.

### Failure scenarios

1. Rotation reconnects parent incorrectly.
2. Height metadata stale.
3. Deletion violates balance/color.
4. B-tree split loses median/child.
5. Underflow borrow/merge bug.
6. Root collapse missed.
7. Range iterator skips/duplicates keys.
8. Comparator inconsistent.

## Самопроверка

1. What does balanced mean?
2. How rotation preserves order?
3. AVL versus red-black?
4. Why logarithmic height follows invariant?
5. Why B-tree has many children?
6. What is B+ tree leaf linkage?
7. Tree versus hash map for ranges?
8. What must invariant checker verify?
9. Why deletion harder than insertion?
10. How node size relates to storage blocks/cache?

## Результат для базы знаний

- **Balanced search-tree invariant**.
- **Tree rotations**.
- **AVL and red-black trees**.
- **B-tree and B+ tree**.
- **Range queries in ordered maps**.
- **Branching factor and external-memory efficiency**.

## Когда переходить дальше

Можно переходить, когда chosen balanced tree survives randomized insert/delete traces and B-tree splits/merges are verified by structural invariants.