# Спринт 06. Деревья и двоичные деревья поиска

Ориентировочный объём: 15–21 час.

## Центральный вопрос

Как hierarchical representation supports recursive structure and ordered search, и почему shape дерева определяет стоимость операций?

## Результат спринта

После завершения необходимо уметь:

- определять root, parent, child, leaf, depth, height и subtree;
- представлять general and binary trees;
- выполнять preorder, inorder, postorder и level-order traversals;
- реализовывать traversal recursively and iteratively;
- формулировать invariants дерева;
- реализовывать BST search, insert, delete, min/max, predecessor/successor;
- понимать duplicate-key policy;
- объяснять O(h) и degeneration to O(n);
- проверять BST property;
- сериализовать/восстанавливать дерево безопасно;
- сравнивать pointer-based and array-based layout;
- использовать recursion depth limits;
- тестировать tree operations against sorted model;
- выбирать tree versus sorted slice/hash table.

## Основной маршрут

### Шаг 1. Tree vocabulary and traversal

Изучить CLRS/Open Data Structures sections. Для каждого traversal записать порядок посещения и use case.

### Шаг 2. Binary search tree

Invariant:

```text
all keys in left subtree < node key
all keys in right subtree > node key
```

Adapt explicitly for duplicates.

### Шаг 3. Deletion

Разобрать cases: leaf, one child, two children. Verify parent/root links and subtree preservation.

### Шаг 4. Shape and performance

Compare balanced-like random insertions, sorted insertion and shuffled input. Height is the operative parameter.

## Ресурсы

### Обязательный маршрут

- CLRS binary search trees.
- Open Data Structures binary trees/BST.
- Sedgewick search trees.
- MIT 6.006 tree lectures.

### Углубление

- threaded trees;
- order-statistic augmentation;
- persistent trees;
- compact/implicit layouts;
- tree serialization security.

## Практические задания

1. Implement iterative/recursive traversals and prove order.
2. Implement generic BST with duplicate policy.
3. Add invariant validator and height/size calculations.
4. Compare pointer tree with sorted slice for reads/updates.
5. Generate all small insertion orders and inspect resulting shapes.

## Лабораторная работа

Создать `work/treelab/`.

### Components

- general tree traversal utilities;
- BST map/set;
- serializer/deserializer with size/depth limits;
- operation-trace generator;
- Graphviz exporter;
- reference model using sorted slice/map.

### Requirements

- randomized differential tests;
- invariant validation after every mutation in tests;
- delete covers all structural cases;
- duplicate behavior explicit;
- iterative traversal handles deep trees;
- serialization rejects malformed/cyclic/oversized input;
- benchmark by tree height/distribution;
- report includes height, comparisons and allocations.

### Failure scenarios

1. Empty tree/root deletion.
2. Two-child deletion loses subtree.
3. Duplicate policy inconsistent.
4. Sorted insertion creates chain.
5. Recursive traversal overflows on deep tree.
6. Parent links stale.
7. Deserializer trusts invalid size/depth.
8. Iterator observes mutation without defined semantics.

## Самопроверка

1. Depth versus height?
2. What determines BST operation cost?
3. Why inorder is sorted?
4. How delete node with two children?
5. What is tree invariant?
6. Why random insertion does not guarantee balance?
7. Tree versus sorted slice/hash table?
8. Recursive versus iterative traversal?
9. How duplicates affect invariant?
10. Why validate deserialization limits?

## Результат для базы знаний

- **Tree terminology and representation**.
- **Tree traversals**.
- **Binary search tree invariant and operations**.
- **BST deletion**.
- **Tree height and degeneration**.
- **Pointer versus array tree layout**.

## Когда переходить дальше

Можно переходить, когда BST mutation passes randomized model tests and complexity is explained through measured height rather than assumed logarithmic behavior.