# Программирование и среды выполнения

Практическое изучение создания и выполнения программ: от типов, функций и организации кода до компиляции, памяти, runtime, конкурентности, тестирования, профилирования и взаимодействия с операционной системой.

Раздел соответствует области [«Программирование и среды выполнения»](https://github.com/AlexandrShapkin/knowledge/tree/main/content/Программирование%20и%20среды%20выполнения) базы знаний.

## Основной интенсив

### [01. Основы программирования и сред выполнения](intensives/01-Основы%20программирования%20и%20сред%20выполнения/)

Основной язык практики — Go. Python, JavaScript/TypeScript, Java, Rust, C и Bash применяются точечно для сравнения систем типов, моделей памяти, компиляции, интерпретации, JIT, event loop и инструментов.

После прохождения необходимо уметь:

- переводить требования в корректные типы, функции, модули и проверяемые контракты;
- объяснять путь от исходного кода до процесса, машинных инструкций и runtime state;
- различать компиляцию, интерпретацию, bytecode, virtual machine и JIT;
- понимать stack, heap, pointers, escape analysis, garbage collection и ownership;
- проектировать обработку ошибок с сохранением контекста;
- работать с файлами, потоками, процессами, сигналами, sockets и сериализацией;
- писать безопасный concurrent code с goroutines, channels, locks и cancellation;
- различать concurrency, parallelism и asynchronous execution;
- управлять modules, dependencies, versions и reproducible builds;
- писать unit, integration, property, fuzz и end-to-end tests;
- использовать debugger, race detector, profiler, tracing и benchmarks;
- находить panic, race, deadlock, leak, excessive allocation и CPU hot path;
- создавать надёжные CLI и service applications;
- обоснованно выбирать язык и runtime под задачу.

Ориентировочный объём: 190–260 часов.

## Планируемые тематические углубления

После основного интенсива могут быть добавлены:

- **Go internals и production development** — scheduler, GC, compiler, standard library, performance и runtime diagnostics;
- **Rust и управление памятью** — ownership, lifetimes, unsafe, FFI и low-level concurrency;
- **JVM и Java runtime** — bytecode, class loading, JIT, GC, threads и diagnostics;
- **JavaScript/TypeScript и event loop** — browser/Node runtimes, promises, async I/O и type tooling;
- **Python runtime и automation** — object model, interpreter, GIL, packaging, async и performance;
- **Compilers and language implementation** — lexer, parser, IR, optimization, VM и garbage collector;
- **Systems programming in C** — ABI, manual memory, POSIX, debugging and undefined behavior.

Каждое углубление будет самостоятельным маршрутом, а не обязательным продолжением основного интенсива.

## Связи с другими разделами

- Аппаратное выполнение, cache и machine instructions изучаются в [«Вычислительных системах»](../01-Вычислительные%20системы/).
- Процессы, virtual memory, files и syscalls со стороны ОС изучаются в [«Операционных системах»](../02-Операционные%20системы/).
- Сетевые протоколы, TCP/TLS и packet path изучаются в [«Сетях и протоколах»](../03-Сети%20и%20протоколы/).
- Алгоритмический выбор структур и сложность относятся к [«Алгоритмам и структурам данных»](../05-Алгоритмы%20и%20структуры%20данных/).
- Архитектура компонентов и design principles продолжаются в [«Проектировании программного обеспечения»](../08-Проектирование%20программного%20обеспечения/).
- CI/CD, packaging и deployment продолжаются в [«Доставке и эксплуатации»](../10-Доставка%20и%20эксплуатация/).
- Production diagnostics продолжаются в [«Наблюдаемости и диагностике»](../11-Наблюдаемость%20и%20диагностика/).