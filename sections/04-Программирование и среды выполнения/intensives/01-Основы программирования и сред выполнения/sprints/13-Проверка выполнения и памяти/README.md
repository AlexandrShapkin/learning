# Спринт 13. Проверка выполнения и памяти

Ориентировочный объём: 10–16 часов.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 08–12.

## Проверяемые области

- compiler and linker pipeline;
- executable/ELF and loader;
- interpreter, bytecode VM and JIT concepts;
- runtime startup, ABI, reflection and init;
- stack/heap, pointers, escape and aliasing;
- GC, ownership and manual memory.

## Исходная задача

Extend `minilang` into `work/runtime-checkpoint/` with two execution engines and native host integrations.

### Required components

- AST interpreter;
- bytecode compiler/VM;
- Go host executable with build inspection;
- reflective binding layer for a small approved host API;
- memory-intensive script/workload mode;
- optional C/Rust comparison helpers;
- reproducible build/inspect/profile scripts.

## Part 1. Build and startup evidence

For host executable produce:

- build trace;
- architecture/file type;
- ELF sections/segments summary;
- selected symbols/disassembly;
- dynamic dependencies;
- startup trace to `main`;
- build/module info;
- clean rebuild hash comparison with documented sources of variation.

## Part 2. Execution equivalence

Create corpus of programs covering arithmetic, branches, loops, calls, closures and errors. AST and bytecode modes must match:

- stdout/stderr;
- value results;
- error category/location;
- side effects;
- execution limits.

Use differential tests and fuzz-generated valid/invalid programs where safe.

## Part 3. Runtime and reflection

Expose approved host functions such as `readText`, `hash`, `clock` and `env` through explicit registry. Reflection may adapt signatures but must reject unsupported types safely.

Failures:

- missing binding;
- wrong argument type/count;
- host error wrapping;
- host panic containment;
- nil/invalid reflect value;
- version mismatch.

## Part 4. Memory scenarios

Reproduce and diagnose:

1. escaped closure state;
2. large backing array retained by small slice;
3. unbounded VM object graph/global;
4. excessive temporary allocation;
5. recursive stack exhaustion/limit;
6. cache without eviction;
7. goroutine optional holder retaining heap;
8. pooling that retains/stales data;
9. GC memory-limit pressure;
10. C use-after-free or Rust rejected lifetime comparison.

Collect compiler escape output, benchmarks, heap profiles and runtime metrics. Keep raw profiles out of Git.

## Part 5. Failure-stage classification

Given examples classify and prove:

- lexical/syntax error;
- type/semantic compile error;
- link/missing symbol;
- loader/shared library failure;
- package init panic;
- interpreter runtime type error;
- bytecode verification failure;
- host binding error;
- nil pointer panic;
- memory retention/high allocation;
- manual memory violation.

## Defense

1. How does source become machine code/executable?
2. What does linker resolve?
3. Sections versus segments?
4. Interpreter versus bytecode VM?
5. AOT versus JIT?
6. What does runtime initialize/manage?
7. What is ABI/call frame?
8. Why can value escape to heap?
9. How does reachability drive GC?
10. GC versus ownership/manual memory?
11. Retention versus leak?
12. What evidence identifies failure stage?

## Критерии прохождения

- build/startup artifacts are reproducible;
- AST/VM differential corpus passes;
- invalid bytecode/reflection is rejected without host crash;
- all ten memory scenarios are reproduced and classified;
- profiles point to retained/allocation source;
- C unsafe case is isolated or Rust comparison proves compile-time rejection;
- at least 10 of 12 defense answers are correct;
- no undocumented tool/runtime internal is treated as stable API.

При затруднении:

- compiler/linker → sprint 08;
- interpreter/VM/JIT → sprint 09;
- runtime/ABI/reflection → sprint 10;
- stack/heap/escape → sprint 11;
- GC/ownership/manual memory → sprint 12.

## Результат для базы знаний

Новая checkpoint-specific заметка не нужна. Обновить mechanisms where evidence contradicted the previous model.