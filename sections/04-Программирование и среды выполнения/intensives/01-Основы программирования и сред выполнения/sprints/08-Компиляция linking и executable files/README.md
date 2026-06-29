# Спринт 08. Компиляция, linking и executable files

Ориентировочный объём: 14–20 часов.

## Центральный вопрос

Как source code преобразуется в machine code и executable, какие artifacts появляются между этапами и что делает loader при запуске?

## Результат спринта

После завершения необходимо уметь:

- объяснять compiler pipeline: lexical/syntax analysis, type checking, IR, optimization, code generation;
- различать compile unit, object file, archive/library and executable;
- объяснять symbol definition/reference and relocation;
- различать static and dynamic linking;
- читать basic ELF sections/segments, headers and symbols;
- использовать `go build -x -work`, `go tool compile`, `go tool link`, `go tool objdump` на практическом уровне;
- использовать `file`, `readelf`, `objdump`, `nm`, `ldd`;
- находить function call and simple arithmetic in assembly;
- понимать inlining, dead-code elimination and bounds-check elimination conceptually;
- объяснять build tags, GOOS/GOARCH and cross-compilation;
- понимать роль cgo and system linker;
- отличать source compatibility, ABI compatibility and binary compatibility;
- исследовать build metadata and reproducibility;
- диагностировать missing symbol/library, architecture mismatch and loader failure.

## Основной маршрут

### Шаг 1. Compiler stages

Read selected chapters from CS:APP/compiler sources and Go compiler overview. Draw:

```text
source → tokens/AST → type information → IR/SSA
→ optimized machine code → object/package archive
→ linker → executable
```

Not every Go internal stage needs memorization; each stage must answer what class of errors/transformations it handles.

### Шаг 2. Build trace

Use:

```bash
go build -x -work ./cmd/app
go build -gcflags='all=-m=2' ./cmd/app
go tool objdump -s 'main.main' ./app
```

Inspect only relevant output and keep scripts to reproduce.

### Шаг 3. ELF and linking

Study ELF overview and commands:

```bash
file app
readelf -hSWl app
readelf -s app
nm -n app
objdump -d app
ldd app
```

Understand sections as link-time organization and segments as loader mappings.

### Шаг 4. Static/dynamic/cgo/cross-build

Compare pure Go binary and cgo-linked binary. Cross-compile a pure Go command for another supported target and inspect file type without executing it.

## Ресурсы

### Обязательный маршрут

- Go command/compiler/linker documentation.
- CS:APP chapters on machine code and linking.
- ELF specification overview and binutils manuals.
- Go compiler optimization diagnostics.

### Альтернативные объяснения

- *Linkers and Loaders* selected chapters.
- Eli Bendersky articles on linking/ELF as secondary explanations.

### Углубление

- SSA construction and optimization passes;
- position-independent code;
- symbol versioning;
- dynamic loader internals;
- DWARF debug info;
- reproducible build IDs;
- whole-program optimization.

## Практические задания

### 1. Symbol journey

Create two packages where one calls exported function from another. Find symbol/reference in package artifacts/executable and map source function to disassembly.

### 2. Optimization evidence

Write small functions demonstrating:

- inlining candidate/non-candidate;
- dead branch elimination;
- bounds-check elimination success/failure;
- constant folding;
- escape-related allocation.

Use compiler diagnostics and benchmarks, not assumptions.

### 3. Dynamic dependency

Build tiny C shared library and Go cgo caller. Reproduce:

- library found;
- missing loader path;
- wrong architecture if safely available;
- ABI-breaking function signature mismatch in controlled example.

### 4. Binary metadata

Compare two builds for hashes, build IDs, embedded paths and VCS info. Use flags only after understanding what changes. Do not claim bit reproducibility without proof.

## Лабораторная работа

Create `work/buildlab/`.

### Components

```text
cmd/buildlab/
internal/mathops/
internal/textops/
cbridge/          # optional C shared/static library
scripts/
fixtures/
```

### Commands

```text
make build
make inspect
make build-static-or-pure
make build-cgo
make cross
make compare
make clean
```

### Required artifacts

- build trace filtered to relevant tools;
- ELF header/sections/segments summary;
- symbol map for selected functions;
- disassembly excerpts linked to source;
- static/dynamic dependency comparison;
- cross-compiled binary inspection;
- compiler optimization report;
- script verifying build from clean module cache after dependencies are available.

### Failure scenarios

1. Undefined symbol/reference.
2. Missing shared library.
3. Wrong `GOOS/GOARCH` executable.
4. cgo disabled when required.
5. Build tag excludes implementation.
6. Duplicate symbol or package conflict where practical.
7. Source/API compatible change that changes binary layout across C boundary.
8. Debug symbols stripped, debugger loses names/lines.
9. Build embeds unintended absolute path/version data.

## Дополнительный эксперимент

Use `go tool compile -S` and `objdump` to compare source-level assembly versus linked binary code. Explain why addresses/names may differ.

Alternative: write same function in C and Go, compile with optimization off/on and compare machine code without ranking languages globally.

## Самопроверка

1. What does parser/type checker/code generator do?
2. What is object file?
3. What is symbol and relocation?
4. Static versus dynamic linking?
5. Sections versus segments?
6. What does OS loader map?
7. Why can source compile but executable fail at startup?
8. What is ABI?
9. How does cgo change build/link/runtime dependencies?
10. What proves optimization actually happened?
11. Why are identical sources not automatically bit-identical builds?

Практическая проверка: given an executable and build logs, identify architecture, dependencies, selected symbols, mappings and likely startup failure.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Compiler pipeline**.
- **Intermediate representation and optimization**.
- **Object file, symbol and relocation**.
- **Static and dynamic linking**.
- **ELF sections and segments**.
- **Program loader**.
- **ABI and binary compatibility**.
- **Go build process and compiler diagnostics**.
- **Cross-compilation and cgo**.

## Когда переходить дальше

Можно переходить, когда build artifacts are inspectable, selected source operations are found in machine code, and link/loader failures are reproduced and explained.