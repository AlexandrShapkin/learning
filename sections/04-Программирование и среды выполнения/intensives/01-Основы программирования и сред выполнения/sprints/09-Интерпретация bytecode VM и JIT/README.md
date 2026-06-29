# Спринт 09. Интерпретация, bytecode, VM и JIT

Ориентировочный объём: 15–22 часа.

## Центральный вопрос

Как программа может выполняться без заранее созданного native executable, и какие функции берут на себя interpreter, bytecode virtual machine и JIT compiler?

## Результат спринта

После завершения необходимо уметь:

- различать source interpreter, AST interpreter, bytecode VM and native execution;
- объяснять frontend versus execution engine;
- понимать tokenize/parse/evaluate cycle;
- читать простую stack-based bytecode sequence;
- реализовать basic interpreter and bytecode VM;
- объяснять virtual machine state: instruction pointer, operand stack, call frames and heap;
- различать ahead-of-time and just-in-time compilation;
- объяснять profiling/tiers/deoptimization conceptually;
- inspect Python bytecode, Java bytecode and JavaScript runtime traces at overview level;
- понимать dynamic type checks and runtime errors;
- объяснять why “interpreted language” can include compilation and native code;
- compare startup, peak performance, portability and diagnostics trade-offs;
- diagnose syntax, bytecode verification/class loading and runtime evaluation failures.

## Основной маршрут

### Шаг 1. Language frontend

Read Crafting Interpreters chapters on scanning, parsing and tree-walk interpretation. Implement grammar for expressions/statements.

### Шаг 2. AST interpreter

Understand environment/scope, expression evaluation, control flow and function calls. Reuse concepts from sprint 03.

### Шаг 3. Bytecode VM

Study stack machine:

```text
LOAD_CONST
LOAD_LOCAL
ADD
JUMP_IF_FALSE
CALL
RETURN
```

Implement compiler from AST to bytecode and VM execution loop.

### Шаг 4. Existing runtimes

Inspect:

```bash
python3 -m dis program.py
javac Program.java && javap -c -v Program
node --print-bytecode program.js   # only if supported by installed runtime
```

Treat implementation flags as version-specific.

### Шаг 5. JIT concepts

Study hot code detection, optimized code generation, speculative assumptions and deoptimization. No JIT implementation required.

## Ресурсы

### Обязательный маршрут

- Crafting Interpreters: scanning, parsing, evaluating and bytecode VM selected chapters.
- Python `dis` documentation.
- JVM specification bytecode/class file overview.
- V8 high-level documentation.

### Альтернативные объяснения

- SICP metacircular evaluator chapters.
- *Programming Language Pragmatics* runtime chapters.

### Углубление

- register-based VMs;
- tracing versus method JIT;
- inline caches;
- hidden classes/shapes;
- bytecode verification;
- WebAssembly;
- dynamic language optimization.

## Практические задания

### 1. Expression interpreter

Implement literals, arithmetic, comparison, variables and errors. Preserve source positions in diagnostics.

### 2. Scope/functions

Add lexical environments, blocks, functions and closures. Write tests for shadowing/capture/recursion.

### 3. Bytecode compiler

Compile expressions and conditional jumps to bytecode. Implement disassembler and deterministic instruction listing.

### 4. Runtime comparison

Implement same loop/function in Python, Java and JavaScript. Collect startup and steady-state timings cautiously, bytecode/disassembly and runtime errors. No broad performance conclusions.

## Лабораторная работа

Create `work/minilang/` in Go.

### Language

Supports:

- integers/booleans/strings;
- variables and lexical blocks;
- arithmetic/comparison;
- `if`, `while`;
- functions and return;
- closures;
- built-in `print`, `len`, `clock` with injected deterministic clock for tests.

### Execution modes

```text
minilang run file.ml          # AST interpreter
minilang compile file.ml -o file.mbc
minilang exec file.mbc        # bytecode VM
minilang disassemble file.mbc
minilang repl
```

### Requirements

- scanner/parser diagnostics with line/column;
- AST and bytecode modes produce same observable results;
- bytecode format has magic/version/checksum;
- VM limits stack, instructions and allocation to prevent runaway tests;
- call frames and lexical captures implemented explicitly;
- no `eval` or host-language execution shortcut;
- tests for parser precedence, scope, closure, recursion, invalid bytecode and limits;
- fuzz parser/bytecode decoder with bounded runs;
- benchmark AST versus VM only as local evidence.

### Failure scenarios

1. Syntax error with recovery/location.
2. Undefined variable.
3. Type mismatch at runtime.
4. Divide by zero.
5. Stack overflow/recursion limit.
6. Infinite loop stopped by instruction budget.
7. Corrupted/unsupported bytecode.
8. Closure captures wrong environment.
9. Jump target invalid.
10. Host panic leaks through language boundary.

## Дополнительный эксперимент

Add simple constant folding or peephole optimization and prove semantic equivalence with tests. Show changed bytecode and benchmark only affected workload.

Alternative: compile a subset to WebAssembly and compare execution model.

## Самопроверка

1. What does interpreter execute?
2. What is AST?
3. Why compile to bytecode?
4. What state does VM maintain?
5. Stack-based versus register-based VM?
6. What does JIT compile?
7. What is a hot path?
8. Why can JIT deoptimize?
9. Why is Python/JavaScript not simply “line-by-line source execution”?
10. Where do dynamic type errors occur?
11. What portability does VM provide?

Практическая проверка: given source, AST and bytecode, trace exact evaluation/call-frame sequence and locate error stage.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Interpretation and interpreter**.
- **Lexer, parser and AST**.
- **Bytecode and virtual machine**.
- **Operand stack and call frame**.
- **Ahead-of-time and JIT compilation**.
- **Profiling and deoptimization in JIT**.
- **Dynamic type checks**.
- **Python/JVM/V8 execution overview**.

## Когда переходить дальше

Можно переходить, когда AST and bytecode modes agree, invalid bytecode is rejected, and compilation/interpreting/JIT distinctions are explained without language-label simplification.