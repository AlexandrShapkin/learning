# Ресурсы интенсива

Это общая библиография. В каждом спринте указан минимальный обязательный маршрут. Читать все книги и specifications подряд не требуется.

## Go

- A Tour of Go: https://go.dev/tour/
- Go Language Specification: https://go.dev/ref/spec
- Effective Go: https://go.dev/doc/effective_go
- Go modules reference: https://go.dev/ref/mod
- Go memory model: https://go.dev/ref/mem
- Go command documentation: https://pkg.go.dev/cmd/go
- Go compiler diagnostics: `go tool compile`, `go tool objdump`, `go build -gcflags`.
- Go runtime package docs: https://pkg.go.dev/runtime
- Go diagnostics: https://go.dev/doc/diagnostics
- Go blog and official testing/fuzzing/profile articles: https://go.dev/blog/
- Standard library documentation: https://pkg.go.dev/std

## Общие основы программирования

- *Structure and Interpretation of Computer Programs* — abstraction, procedures, interpreters and evaluation models.
- *Programming Language Pragmatics*, Michael Scott — languages, types, runtime and implementation.
- *Concepts, Techniques, and Models of Computer Programming*, Van Roy and Haridi — paradigms and concurrency models.
- *Crafting Interpreters*, Robert Nystrom: https://craftinginterpreters.com/
- *Types and Programming Languages*, Benjamin Pierce — углубление по type systems.

## Компиляция, linking и binaries

- *Compilers: Principles, Techniques, and Tools* — selected compiler pipeline chapters.
- *Engineering a Compiler* — IR and optimization overview.
- *Linkers and Loaders*, John Levine.
- System V ABI and ELF specifications for target platform.
- GNU Binutils manuals: `as`, `ld`, `readelf`, `objdump`, `nm`.
- GCC/Clang documentation.
- *Computer Systems: A Programmer's Perspective* — linking, machine code and process model chapters.

## Runtime и memory management

- *The Garbage Collection Handbook* — selected conceptual chapters.
- Go GC guide and runtime documentation.
- Rust Book ownership chapters: https://doc.rust-lang.org/book/
- C standard/library and POSIX references for manual memory comparison.
- JVM specification: https://docs.oracle.com/javase/specs/
- CPython developer guide: https://devguide.python.org/
- V8 documentation: https://v8.dev/docs

## Concurrency

- *The Art of Multiprocessor Programming*, Herlihy and Shavit.
- *Java Concurrency in Practice* for general concurrency patterns.
- Go memory model and `sync`, `sync/atomic`, `context` docs.
- *Communicating Sequential Processes*, C. A. R. Hoare — conceptual source.
- Linux pthreads/man-pages for thread comparison.
- Node.js event loop documentation.
- Python asyncio documentation.

## OS interaction and I/O

- *The Linux Programming Interface*, Michael Kerrisk.
- Linux man-pages project: https://man7.org/linux/man-pages/
- POSIX specifications: https://pubs.opengroup.org/onlinepubs/
- Go packages: `os`, `io`, `bufio`, `path/filepath`, `os/exec`, `syscall`, `net`, `net/http`, `encoding/*`.
- `strace`, `lsof`, `proc(5)`, `signal(7)`, `socket(7)`.

## Testing

- Go testing package and command documentation.
- Go fuzzing documentation: https://go.dev/doc/fuzz/
- *xUnit Test Patterns*, Gerard Meszaros.
- *Growing Object-Oriented Software, Guided by Tests* — selected design/testing concepts.
- Property-based testing literature and QuickCheck papers.
- Testcontainers/docs only where integration isolation is needed.

## Debugging and performance

- Delve documentation: https://github.com/go-delve/delve/tree/master/Documentation
- GDB documentation: https://sourceware.org/gdb/documentation/
- Go `pprof`, `runtime/trace`, benchmarks and diagnostics docs.
- Brendan Gregg performance methodology and flame graphs: https://www.brendangregg.com/
- *Systems Performance*, Brendan Gregg.
- `perf`, Valgrind and sanitizer documentation.

## Dependency and build systems

- Semantic Versioning: https://semver.org/
- Go modules reference and checksum database/proxy documentation.
- Reproducible Builds project: https://reproducible-builds.org/
- Software Package Data Exchange/SBOM concepts as optional extension.
- Language-specific package managers only for comparison: npm, pip, Maven/Gradle, Cargo.

## Serialization and protocols

- JSON RFC 8259.
- Protocol Buffers documentation: https://protobuf.dev/
- XML specifications only for comparison.
- Unicode Standard and UTF-8 RFC 3629.
- Go `encoding/json`, `encoding/xml`, `encoding/binary`, `unicode/utf8` docs.

## CLI and configuration

- POSIX utility conventions.
- GNU Coding Standards CLI sections as one reference, not mandatory dogma.
- `getopt(3)`/Go `flag` package.
- Twelve-Factor App configuration principle as a limited reference.
- systemd service/environment documentation when daemon integration is practiced.

## Языки для сравнения

- Python language reference: https://docs.python.org/3/reference/
- Java Language and JVM specifications.
- ECMAScript specification and MDN JavaScript guide.
- TypeScript handbook: https://www.typescriptlang.org/docs/handbook/
- Rust Reference and Rustonomicon for optional unsafe details.
- C language standard references and cppreference as secondary navigation.
- Bash manual: https://www.gnu.org/software/bash/manual/

## Правило работы с источниками

1. Начинать с обязательных разделов конкретного спринта.
2. Specification использовать для точного semantics; tutorial — для первого объяснения.
3. Поведение toolchain проверять на установленной версии через commands and tests.
4. Secondary articles не считать доказательством runtime behavior без reproduction.
5. Не копировать книги, specifications, toolchains или large third-party source into repository.