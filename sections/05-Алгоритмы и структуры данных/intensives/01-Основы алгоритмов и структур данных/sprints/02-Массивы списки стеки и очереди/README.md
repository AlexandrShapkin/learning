# Спринт 02. Массивы, списки, стеки и очереди

Ориентировочный объём: 15–21 час.

## Центральный вопрос

Как contiguous and linked representations change operation cost, memory overhead, locality and API guarantees?

## Результат спринта

После завершения необходимо уметь:

- distinguish fixed array, dynamic array/slice and linked list;
- explain index access, insertion, deletion and growth costs;
- understand length, capacity, reallocation and amortized append;
- implement singly/doubly/circular linked lists;
- implement stack, queue, deque and ring buffer;
- reason about sentinel nodes and edge cases;
- compare locality and pointer overhead;
- understand ownership and aliasing in APIs;
- choose representation from operation mix;
- use standard library/slices instead of custom structures where suitable;
- write invariant/property tests;
- detect off-by-one, lost link, cycle and stale reference bugs;
- measure memory and cache-related behavior cautiously.

## Основной маршрут

### Шаг 1. Arrays and dynamic arrays

Study contiguous layout, indexing, resizing and amortized growth. Experiment with Go slices while keeping language semantics separate from abstract dynamic array.

### Шаг 2. Linked lists

Implement node chains and define invariants for head/tail/length/links. Compare singly versus doubly linked structures.

### Шаг 3. Stacks and queues

Implement:

- slice-backed stack;
- linked stack;
- circular queue;
- deque;
- bounded ring buffer.

### Шаг 4. Representation choice

Compare not only asymptotics but also allocation, locality, API simplicity and iteration.

## Ресурсы

### Обязательный маршрут

- Open Data Structures array/list chapters.
- CLRS elementary data structures.
- Go `slices` and `container/list` docs.
- CPU locality review from computing-systems intensive.

### Альтернативные объяснения

- Sedgewick stacks/queues.
- CS61B lists and deques.

### Углубление

- gap buffers/ropes;
- intrusive lists;
- lock-free queues;
- persistent vectors;
- cache-oblivious layouts.

## Практические задания

### 1. Dynamic array

Implement generic vector with `Len`, `Cap`, `Get`, `Set`, `Append`, `Insert`, `Delete`, `Reserve`, `Shrink`. Count moves/reallocations and prove amortized append experimentally.

### 2. Linked structures

Implement singly and doubly linked lists with forward/reverse iteration, insert/remove and invariant validator.

### 3. Ring buffer

Implement bounded generic queue supporting wraparound. Test empty/full distinction and zero capacity policy.

### 4. Workload comparison

Compare vector/list/deque for:

- sequential iteration;
- random access;
- push front/back;
- middle insertion when node/index already known versus search required;
- memory per element.

## Лабораторная работа

Создать `work/sequence-lab/`.

### API

Common operation trace:

```text
push_front, push_back, pop_front, pop_back,
get, set, insert, remove, iterate
```

Implement adapters for slice/vector, singly list, doubly list and ring deque.

### Requirements

- model-based randomized tests against simple reference slice;
- invariant validation after every operation in debug tests;
- deterministic trace seeds;
- benchmarks by operation mix and size;
- allocation and approximate memory overhead report;
- locality comparison using sequential traversal and optional cache counters;
- no pointer exposure that bypasses invariants;
- production recommendation for each workload.

### Failure scenarios

1. Empty pop/access.
2. Index equal to length.
3. Ring wraparound.
4. Capacity growth overflow.
5. Removing only element breaks head/tail.
6. Doubly list previous link stale.
7. Cycle introduced.
8. Slice alias lets caller mutate internal state.
9. Benchmark compares search+insert against insert with known node unfairly.

## Самопроверка

1. Why array indexing is O(1)?
2. Why middle insert in array is O(n)?
3. Why list random access is O(n)?
4. What makes append amortized O(1)?
5. List versus array locality?
6. What does sentinel simplify?
7. Stack versus queue versus deque?
8. How ring buffer distinguishes full/empty?
9. Why O(1) list insertion may still require O(n) search?
10. When `container/list` is unnecessary?

## Результат для базы знаний

- **Array and dynamic array**.
- **Amortized growth of dynamic array**.
- **Singly and doubly linked list**.
- **Stack, queue, deque and ring buffer**.
- **Sentinel node and structural invariant**.
- **Contiguous versus linked memory layout**.
- **Operation-mix-based structure choice**.

## Когда переходить дальше

Можно переходить, когда randomized traces preserve invariants and representation choices are justified by complete operation cost plus memory/locality evidence.