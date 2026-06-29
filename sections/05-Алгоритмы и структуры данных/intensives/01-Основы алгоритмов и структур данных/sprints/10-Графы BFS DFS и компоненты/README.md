# Спринт 10. Графы, BFS, DFS и компоненты

Ориентировочный объём: 17–24 часа.

## Центральный вопрос

Как представить arbitrary relations and systematically explore reachable structure without пропусков, повторной работы и неверной интерпретации direction/weights?

## Результат спринта

После завершения необходимо уметь:

- определять vertex, edge, path, cycle, degree, connectivity;
- различать directed/undirected, weighted/unweighted, simple/multigraph;
- выбирать adjacency list, matrix или edge list;
- оценивать memory and traversal complexity через V and E;
- реализовывать BFS and DFS iteratively/recursively;
- находить connected components;
- строить BFS shortest paths in unweighted graph;
- detecting cycles in directed/undirected graphs;
- выполнять topological sort;
- находить strongly connected components через Kosaraju or Tarjan;
- понимать discovery/finish times and edge classification overview;
- не путать tree parent with graph edge direction;
- обрабатывать disconnected graphs;
- тестировать graph algorithms against invariants/reference;
- визуализировать small graphs without relying on diagram as proof.

## Основной маршрут

### Шаг 1. Graph representation

Study CLRS/Sedgewick graph chapters. Compare:

```text
adjacency matrix: O(V²) memory, O(1) edge test
adjacency list: O(V+E) memory
edge list: compact for batch edge processing
```

Account for undirected edge stored twice in adjacency lists.

### Шаг 2. BFS

Invariant: queue contains discovered but not fully processed vertices; first discovery gives minimum edge-count distance in unweighted graph.

### Шаг 3. DFS

Use colors/states and explicit stack for deep graphs. Apply to cycles, components and topological order.

### Шаг 4. SCC

Implement Kosaraju or Tarjan and verify condensation graph is DAG.

## Ресурсы

### Обязательный маршрут

- CLRS elementary graph algorithms.
- Sedgewick Algorithms graph chapters.
- MIT 6.006 graph lectures.
- Open Data Structures graph representation.

### Альтернативные объяснения

- Princeton Algorithms II graph visualizations.
- Skiena graph traversal chapters.

### Углубление

- articulation points/bridges;
- biconnected components;
- Euler/Hamilton paths;
- dynamic graphs;
- compressed/succinct graphs.

## Практические задания

1. Implement directed/undirected graph builder with validation.
2. Implement BFS distances/parents/path reconstruction.
3. Implement iterative DFS, cycle detection and topological sort.
4. Implement SCC and condensation DAG.
5. Compare matrix/list for sparse and dense generated graphs.

## Лабораторная работа

Создать `work/graphlab/`.

### CLI

```text
graphlab generate --model MODEL --vertices V --edges E --seed S
graphlab bfs --source X
graphlab dfs
graphlab components
graphlab topo
graphlab scc
graphlab render --max-vertices N
```

### Requirements

- explicit directed/weighted metadata;
- duplicate/self-loop policy;
- deterministic vertex/result order where API promises it;
- path reconstruction validates reachability;
- iterative traversal supports deep chain;
- property tests: BFS edge inequality, topo edge order, SCC mutual reachability;
- differential checks on small graphs through simple oracle;
- operation/memory benchmarks by V/E/density;
- parser rejects unknown endpoints/oversized input.

### Failure scenarios

1. Disconnected graph handled as one component.
2. Undirected edge stored only one way.
3. Vertex marked visited too late, queue explodes.
4. DFS recursion overflows.
5. Directed/undirected cycle tests mixed.
6. Topological sort returns result for cycle.
7. SCC second pass order wrong.
8. Parallel edges/self-loops violate assumptions.
9. V² matrix allocation on huge sparse graph.

## Самопроверка

1. V and E in complexity?
2. Matrix versus adjacency list?
3. Why BFS gives unweighted shortest path?
4. When mark vertex visited?
5. BFS versus DFS use cases?
6. How detect directed cycle?
7. What does topological order require?
8. What is SCC?
9. Why condensation is DAG?
10. Why disconnected graph requires outer loop?

## Результат для базы знаний

- **Graph terminology and representation**.
- **BFS invariant and unweighted shortest path**.
- **DFS and traversal states**.
- **Connected components**.
- **Cycle detection**.
- **Topological sorting**.
- **Strongly connected components**.
- **Sparse versus dense graph representation**.

## Когда переходить дальше

Можно переходить, когда BFS/DFS/SCC/topological properties pass generated graph tests and representation choice is justified by V/E density and operations.