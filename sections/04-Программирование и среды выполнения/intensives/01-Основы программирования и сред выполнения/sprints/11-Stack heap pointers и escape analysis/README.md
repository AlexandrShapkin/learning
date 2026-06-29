# Спринт 11. Stack, heap, pointers и escape analysis

Ориентировочный объём: 14–20 часов.

## Центральный вопрос

Где размещаются данные программы, как ссылки and aliases affect lifetime, и почему source-level variable не имеет навсегда закреплённого места хранения?

## Результат спринта

После завершения необходимо уметь:

- distinguish logical variable lifetime from physical stack/heap placement;
- explain call stack, goroutine stack growth and heap conceptually;
- use pointers for identity/mutation/large-value semantics without C-style arithmetic;
- understand addressability, dereference and nil pointer;
- explain escape analysis and compiler-dependent placement;
- read `-gcflags=-m=2` output cautiously;
- measure allocations with benchmarks and pprof;
- understand copies, aliasing and object retention;
- inspect struct size/alignment with `unsafe.Sizeof` without making unsafe mandatory;
- recognize slice/string/interface headers conceptually;
- distinguish memory leak from reachable retention and temporary high usage;
- avoid returning pointers/slices that expose mutable internal state;
- diagnose excessive allocation, stack overflow and retained backing arrays.

## Основной маршрут

### Шаг 1. Stack and heap model

Review process virtual memory and call frames. In Go, stacks grow/move; pointer validity is maintained by runtime. Avoid fixed-address mental model.

### Шаг 2. Pointers and values

Study Go spec on pointers, addressability, assignments and method receivers. Compare value copies for structs/slices/interfaces.

### Шаг 3. Escape analysis

Use compiler diagnostics on minimal examples:

- returned pointer;
- interface boxing;
- closure capture;
- large object;
- slice allocation;
- inlining effect.

Escape is not automatically performance defect.

### Шаг 4. Allocation measurement

Use:

```bash
go test -bench . -benchmem
go test -run Test -memprofile mem.out
go tool pprof mem.out
```

Distinguish alloc_space, alloc_objects, inuse_space and inuse_objects.

## Ресурсы

### Обязательный маршрут

- Go specification pointer/addressability sections.
- Go diagnostics/pprof docs.
- Compiler escape diagnostics.
- CS:APP memory/call stack chapters.

### Альтернативные объяснения

- Go blog/runtime stack articles.
- C pointer/memory examples for contrast.

### Углубление

- allocator size classes;
- stack maps and safe points;
- cache alignment/false sharing;
- unsafe.Pointer rules;
- arenas/regional allocation;
- object representation.

## Практические задания

### 1. Placement predictions

Before compiling, predict whether values may escape, then inspect diagnostics. Explain mismatches and compiler freedom.

### 2. Aliasing matrix

Create functions receiving struct, pointer, slice, map, interface and array. Mutate and record which caller-visible state changes.

### 3. Retention

Read large file/buffer, keep tiny subslice/reference and observe retained heap. Fix by copy/streaming and compare in-use profile.

### 4. Layout

Inspect sizes/alignment for reordered struct fields. Measure only if many instances matter; explain readability/compatibility trade-off.

## Лабораторная работа

Create `work/memlab/` with Go command and benchmark suite.

### Workloads

- parse records with allocating and streaming designs;
- pointer versus value API;
- interface/generic/concrete processing;
- closure capture;
- pooled buffers versus ordinary allocation;
- retained subslice;
- recursive stack growth;
- object graph reachable/unreachable.

### CLI

```text
memlab run WORKLOAD --items N --size N
memlab profile WORKLOAD --out DIR
memlab explain WORKLOAD
```

### Requirements

- deterministic input generator;
- memory limits for experiments;
- benchmarks with `-benchmem`;
- heap profiles analyzed by script/text summary;
- correctness tests before performance comparison;
- no use of `sync.Pool` as default without measured benefit;
- unsafe experiment isolated behind build tag;
- no claims based on one benchmark run;
- profiles not committed unless tiny/sanitized.

### Failure scenarios

1. Nil pointer dereference.
2. Retained large backing array.
3. Unbounded append.
4. Interface conversion increases allocation.
5. Closure captures larger state than intended.
6. Recursive stack overflow or excessive depth.
7. Pool retains too much memory/stale data.
8. Caller mutates aliased buffer after handoff.
9. Benchmark optimized away or measures setup.

## Дополнительный эксперимент

Compare Go escape/allocation with equivalent C stack/malloc and Rust ownership examples. Focus on lifetime guarantees and tooling, not simplistic speed ranking.

## Самопроверка

1. Variable lifetime versus storage location?
2. What is stack frame?
3. Why can Go stack move?
4. What does escape analysis decide?
5. Is heap allocation always slow/wrong?
6. How do slice/map/pointer copies differ?
7. What causes backing-array retention?
8. How do alloc_space and inuse_space differ?
9. Why can `sync.Pool` increase memory?
10. What is aliasing?
11. Why can compiler results change across versions?

Практическая проверка: given heap profile and source, identify allocation/retention hypotheses and design one discriminating benchmark/profile.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Stack and heap in program runtime**.
- **Pointers and addressability in Go**.
- **Value copy and aliasing**.
- **Escape analysis**.
- **Goroutine stack growth**.
- **Heap allocation metrics**.
- **Memory retention versus leak**.
- **Struct layout and alignment**.
- **Slice backing array retention**.

## Когда переходить дальше

Можно переходить, когда allocation/retention are measured, aliasing behavior is tested, and stack/heap placement is treated as compiler/runtime decision rather than syntax rule.