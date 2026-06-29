# Спринт 11. Кратчайшие пути

Ориентировочный объём: 17–24 часа.

## Центральный вопрос

Какие assumptions about edge weights determine a correct shortest-path algorithm, и как distinguish unreachable, negative cycle and overflow?

## Результат спринта

После завершения необходимо уметь:

- define path weight and shortest-path problem variants;
- use BFS for unit/unweighted edges;
- implement Dijkstra with priority queue;
- state nonnegative-edge precondition;
- understand stale-entry versus decrease-key implementations;
- implement Bellman–Ford and detect reachable negative cycles;
- implement DAG shortest paths through topological order;
- understand A* with admissible/consistent heuristic;
- reconstruct paths and predecessor tree;
- handle unreachable vertices;
- avoid integer overflow/infinity mistakes;
- compare single-source, single-pair and all-pairs overview;
- verify triangle/relaxation properties;
- choose representation/heap by graph characteristics;
- distinguish shortest distance from fewest edges;
- diagnose algorithm chosen under invalid assumptions.

## Основной маршрут

### Шаг 1. Relaxation

Core operation:

```text
if dist[u] + w(u,v) < dist[v], improve dist[v] and parent[v]
```

Define safe infinity and overflow handling.

### Шаг 2. Dijkstra

Prove why extracting minimum finalizes vertex only for nonnegative weights. Implement heap with stale entries first; indexed heap as comparison.

### Шаг 3. Bellman–Ford and DAG

Understand V-1 relaxation rounds and extra round for reachable negative cycle. DAG order permits one pass.

### Шаг 4. A*

Study `f=g+h`; admissible heuristic preserves optimality under conditions. Bad heuristic may degrade or break guarantees.

## Ресурсы

### Обязательный маршрут

- CLRS single-source shortest paths.
- Sedgewick shortest paths.
- MIT 6.006 shortest path lectures.
- A* foundational overview and heuristic conditions.

### Углубление

- Johnson/Floyd–Warshall;
- bidirectional search;
- contraction hierarchies;
- multi-criteria paths;
- dynamic shortest paths.

## Практические задания

1. Implement BFS, Dijkstra, Bellman–Ford and DAG shortest paths under one result contract.
2. Implement path reconstruction with cycle/invalid-parent protection.
3. Generate weighted graphs and compare algorithms where assumptions overlap.
4. Design A* grid heuristic and compare explored nodes with Dijkstra.
5. Create counterexamples for Dijkstra with negative edge and A* overestimating heuristic.

## Лабораторная работа

Создать `work/pathlab/`.

### Graph models

- sparse random nonnegative;
- dense;
- grid with obstacles;
- DAG;
- negative edges without cycle;
- reachable/unreachable negative cycle;
- disconnected graph.

### Requirements

- edge-weight type and overflow policy explicit;
- negative-edge validation for Dijkstra;
- Bellman–Ford marks/report affected vertices or returns precise cycle evidence;
- path cost recomputed from edges;
- differential tests against Bellman–Ford/Floyd–Warshall oracle on small valid graphs;
- A* heuristic checks/examples;
- counters: relaxations, heap pushes/pops, visited vertices;
- benchmarks by V/E/weight distribution;
- result distinguishes unreachable from overflow/error.

### Failure scenarios

1. Negative edge passed to Dijkstra.
2. Stale heap entry treated as current incorrectly.
3. Infinity plus weight overflows.
4. Source parent/path loop.
5. Negative cycle unreachable from source falsely reported.
6. Bellman–Ford runs too few rounds.
7. A* terminates with inadmissible heuristic assumption.
8. Equal-distance tie makes nondeterministic path when deterministic contract promised.
9. Zero-weight cycles mishandled.

## Самопроверка

1. What is relaxation?
2. Dijkstra precondition?
3. Why extracted minimum is final?
4. BFS shortest path under what weights?
5. Bellman–Ford detects what?
6. DAG shortest path complexity?
7. Admissible/consistent heuristic?
8. Unreachable versus infinite distance representation?
9. Stale heap entries versus decrease-key?
10. Why verify reconstructed path cost?

## Результат для базы знаний

- **Shortest-path problem variants**.
- **Edge relaxation**.
- **Dijkstra algorithm and nonnegative precondition**.
- **Bellman–Ford and negative cycles**.
- **Shortest paths in DAG**.
- **A* and heuristic conditions**.
- **Path reconstruction and infinity/overflow**.

## Когда переходить дальше

Можно переходить, когда algorithms agree on overlapping valid domains and invalid weight/cycle cases are rejected or classified precisely.