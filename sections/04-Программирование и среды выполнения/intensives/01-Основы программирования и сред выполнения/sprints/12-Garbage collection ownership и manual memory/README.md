# Спринт 12. Garbage collection, ownership и manual memory

Ориентировочный объём: 15–22 часа.

## Центральный вопрос

Как runtime or programmer determines when memory may be reclaimed, and what reliability/performance trade-offs follow from GC, ownership and manual allocation?

## Результат спринта

После завершения необходимо уметь:

- explain allocation, reachability, roots and reclamation;
- distinguish tracing GC, reference counting and manual free conceptually;
- explain mark/sweep and generational/compacting concepts;
- understand Go concurrent tracing GC at operational level;
- interpret `GOGC`, memory limit and `gctrace` cautiously;
- distinguish GC pause, CPU overhead, allocation rate and live heap;
- diagnose retention versus unreachable garbage;
- use finalizers only as last-resort safety, not resource management;
- explain C lifetime failures: use-after-free, double-free, leak, buffer overflow;
- explain Rust ownership, borrowing and lifetimes at practical comparison level;
- understand reference cycles in reference-counted systems;
- select memory strategy based on latency, throughput, safety and integration constraints;
- avoid premature manual pooling/tuning;
- prove correctness under stress and sanitizers.

## Основной маршрут

### Шаг 1. Memory management models

Build comparison:

```text
manual allocation/free
reference counting
tracing garbage collection
ownership/borrow checking
region/arena concepts
```

Separate compile-time guarantees from runtime reclamation.

### Шаг 2. Go GC

Read official GC guide/runtime docs. Understand:

- heap goal;
- roots/reachability;
- concurrent mark;
- sweep;
- write barrier overview;
- memory limit;
- allocation-driven cycles.

Exact implementation may change; use current docs/tool output.

### Шаг 3. C and sanitizers

Write tiny isolated C programs for leak/use-after-free/double-free/out-of-bounds. Run AddressSanitizer/LeakSanitizer/Valgrind. Never integrate unsafe examples into main app.

### Шаг 4. Rust ownership

Complete Rust Book ownership/borrowing/lifetimes chapters and implement equivalent resource holder. Understand that ownership prevents classes of memory errors, but logical leaks/cycles/resource exhaustion remain possible.

## Ресурсы

### Обязательный маршрут

- Go GC guide and runtime docs.
- Garbage Collection Handbook selected introduction.
- Rust Book ownership chapters.
- Clang sanitizer and Valgrind docs.

### Альтернативные объяснения

- JVM GC overview for generational/collector comparison.
- CPython reference counting/cycle collector overview.

### Углубление

- tri-color invariant/write barriers;
- concurrent/parallel collectors;
- compaction;
- real-time GC;
- Rust unsafe and allocators;
- memory fragmentation;
- arenas.

## Практические задания

### 1. GC workload matrix

For same correct workload vary allocation rate/live set and collect:

- wall time;
- GC cycles;
- pause/CPU summaries;
- heap goal/live heap;
- RSS.

Compare default, altered `GOGC`, and memory limit in VM. Restore environment each run.

### 2. Retention

Create cache with no eviction, forgotten goroutine reference and global slice retention. Use heap profiles to identify roots, then fix lifecycle.

### 3. C memory failures

Compile/run each faulty program under sanitizer, then repair. Preserve source and short sanitizer classification, not core dumps.

### 4. Rust ownership

Implement buffer owner/borrowed view and file resource lifecycle. Attempt invalid alias/lifetime examples and record compiler diagnostics.

## Лабораторная работа

Create `work/lifecycle-lab/`.

### Components

- Go `objectgraph` workload generator;
- Go cache with bounded/unbounded modes;
- C `unsafe_cases/` built only by explicit target;
- Rust `ownership_cases/` small crate;
- scripts collecting profiles/sanitizer reports;
- comparison report generated from commands/results.

### Go experiments

1. High allocation, small live set.
2. Low allocation, large live set.
3. Retained graph via global/root.
4. Goroutine holding buffer.
5. Cache with TTL/LRU-like bound.
6. `sync.Pool` benefit and retention counterexample.
7. Finalizer nondeterminism demonstration without relying on it.
8. Memory limit causing more GC and possible throughput change.

### Requirements

- each experiment bounded by duration/memory/cgroup;
- same correctness checksum across variants;
- profiles and runtime metrics collected;
- no `runtime.GC` in normal design; explicit calls only labeled experiment;
- C failures run in subprocess/VM;
- Rust compiler failures stored as small expected diagnostics;
- comparison discusses safety, latency, CPU, developer burden and FFI.

### Failure scenarios

1. Go retained object graph.
2. Finalizer never/late runs.
3. Excessive GC due allocation rate.
4. Memory limit leads to high GC CPU.
5. C use-after-free.
6. C double-free.
7. C out-of-bounds.
8. Reference-count cycle conceptual/optional Python example.
9. Rust `Rc` cycle retains memory.
10. Pool returns stale sensitive data if not reset.

## Дополнительный эксперимент

Use Java with small heap and GC logs to compare generational collector behavior. Analyze only one bounded workload and avoid collector ranking.

## Самопроверка

1. What is reachability/root?
2. How does tracing GC know object is live?
3. GC versus reference counting?
4. What does ownership checker guarantee?
5. Why can GC language still leak memory logically?
6. What are live heap and allocation rate?
7. What does `GOGC` trade off?
8. Why finalizer cannot manage timely resource release?
9. What causes use-after-free/double-free?
10. Can Rust have memory leaks?
11. When can pooling hurt?

Практическая проверка: given memory growth graph/profile/runtime metrics, distinguish live-set growth, temporary garbage, fragmentation/RSS and leak-like retention hypotheses.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Memory lifetime and reclamation**.
- **Tracing garbage collection**.
- **Mark and sweep**.
- **Go garbage collector operational model**.
- **GC latency, throughput and memory trade-off**.
- **Manual memory management failures**.
- **Ownership and borrowing in Rust**.
- **Reference counting and cycles**.
- **Finalizers and resource lifetime**.

## Когда переходить дальше

Можно переходить, когда GC effects are measured, C/Rust comparisons are reproduced, and memory growth is classified by reachability/live set rather than called a leak by default.