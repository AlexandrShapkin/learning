# Спринт 12. Минимальные остовы и Union-Find

Ориентировочный объём: 14–20 часов.

## Центральный вопрос

Как connect all vertices of weighted undirected graph with minimum total edge weight, и как efficiently maintain evolving connectivity?

## Результат спринта

После завершения необходимо уметь:

- define spanning tree/forest and MST;
- distinguish MST from shortest-path tree;
- understand cut and cycle properties;
- implement Kruskal with disjoint-set union;
- implement Prim with priority queue;
- implement Union-Find with union by rank/size and path compression;
- explain near-constant amortized DSU operations;
- handle disconnected graph as minimum spanning forest;
- understand non-unique MST and tie behavior;
- verify acyclicity, connectivity and weight;
- compare Prim/Kruskal by density/representation;
- use DSU for offline connectivity and cycle detection;
- distinguish undirected requirement;
- avoid assuming greedy correctness without exchange/cut proof.

## Основной маршрут

### Шаг 1. DSU

Implement parent forest, find, union. Add size/rank and path compression, then compare tree depth/operation counts.

### Шаг 2. MST properties

Study cut property and safe edge; use it to justify Kruskal and Prim.

### Шаг 3. Kruskal

Sort edges; add if endpoints in different sets. Complexity includes sorting.

### Шаг 4. Prim

Grow one component using minimum crossing edge. For disconnected input restart to produce forest or reject according to contract.

## Ресурсы

### Обязательный маршрут

- CLRS MST and disjoint-set chapters.
- Sedgewick union-find/MST.
- Princeton Algorithms union-find/MST lectures.
- MIT graph greedy lectures.

### Углубление

- Borůvka;
- dynamic connectivity;
- offline LCA via DSU;
- second-best MST;
- parallel MST.

## Практические задания

1. Implement basic/optimized DSU and visualize parent depth.
2. Implement Kruskal and Prim.
3. Generate graphs with equal weights/multiple MSTs.
4. Verify selected forest through independent checks.
5. Apply DSU to connectivity queries and redundant-edge detection.

## Лабораторная работа

Создать `work/mst-lab/`.

### Components

- generic/int vertex DSU;
- Kruskal;
- eager/lazy Prim variant;
- random connected/disconnected graph generators;
- exhaustive MST oracle for tiny graphs;
- visualization/report.

### Requirements

- undirected edge normalization;
- self-loop/parallel-edge policy;
- 64-bit/checked weight accumulation;
- differential tests Kruskal versus Prim;
- exhaustive tiny-graph optimality check;
- verify edge count, acyclicity, component coverage and total weight;
- benchmark sparse/dense graphs;
- DSU counters for find depth/compression;
- deterministic tie-breaking only if promised.

### Failure scenarios

1. Directed graph accepted silently.
2. Disconnected graph expected one tree.
3. DSU union changes wrong root/size.
4. Find without compression returns stale/loop.
5. Integer total-weight overflow.
6. Parallel edge mishandled.
7. Prim restarts incorrectly or misses component.
8. MST confused with shortest-path tree.
9. Greedy edge selected without safe-edge property.

## Самопроверка

1. Spanning tree versus forest?
2. MST versus shortest-path tree?
3. What is cut property?
4. How Kruskal avoids cycles?
5. How Prim grows tree?
6. What does DSU represent?
7. Path compression/union by rank effect?
8. Why complexity is amortized?
9. Can MST be non-unique?
10. Prim versus Kruskal by graph density?

## Результат для базы знаний

- **Spanning tree, forest and MST**.
- **Cut and cycle properties**.
- **Kruskal and Prim algorithms**.
- **Disjoint-set union**.
- **Path compression and union by rank**.
- **MST verification and non-uniqueness**.

## Когда переходить дальше

Можно переходить, когда Prim/Kruskal agree, tiny exhaustive oracle confirms optimality, and DSU invariants hold under randomized operations.