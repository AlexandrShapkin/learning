# Основы программирования и сред выполнения

Основной интенсив раздела «Программирование и среды выполнения». Программирование изучается не как набор синтаксических конструкций, а как путь от модели задачи до исполняемой программы, наблюдаемого runtime behavior и доказуемой корректности.

Go используется как основной язык. Другие языки вводятся только там, где их модель позволяет увидеть механизм, скрытый или устроенный иначе в Go.

## Результат прохождения

После завершения необходимо уметь самостоятельно:

- описывать данные через типы и инварианты;
- разбивать вычисление на функции, packages и modules;
- выбирать между concrete types, interfaces, generics и composition;
- сохранять контекст ошибок и определять recovery boundary;
- понимать этапы parsing, type checking, code generation, linking и program startup;
- читать basic assembly, symbol tables, binary sections и stack traces;
- различать native compilation, interpretation, bytecode VM и JIT;
- объяснять роль runtime: startup, stack management, scheduler, GC, reflection и OS integration;
- понимать stack/heap placement, escape analysis, allocation и object lifetime;
- сравнивать garbage collection, ownership и manual memory management;
- корректно работать с files, streams, encoding, serialization, processes, signals и environment;
- писать TCP/UDP/HTTP clients and servers с timeouts и cancellation;
- проектировать goroutine lifecycle, channels, locks, atomics и backpressure;
- объяснять memory ordering, data race, deadlock, livelock и starvation;
- различать asynchronous I/O, concurrency и CPU parallelism;
- управлять Go modules, semantic versions, dependency graph и reproducible builds;
- писать unit, table-driven, integration, property, fuzz и system tests;
- использовать `go test`, race detector, coverage, benchmarks, `pprof`, trace, Delve, GDB, `strace` и sanitizers по назначению;
- находить memory leak-like retention, goroutine leak, descriptor leak, contention и CPU hot path;
- создавать CLI и daemon/service applications с configuration precedence, graceful shutdown и observable behavior;
- выбирать язык/runtime по constraints задачи, а не по привычке.

Целевой уровень: 3 по всему разделу и 4 по Go, program execution, memory, concurrency, testing и diagnostics.

## Границы

Интенсив не заменяет:

- полный курс алгоритмов и структур данных;
- enterprise architecture и domain-driven design;
- frontend/browser engineering;
- production database engineering;
- разработку полноценного компилятора;
- глубокое изучение конкретной VM или GC implementation;
- formal verification;
- полный security engineering curriculum.

Смежные темы включаются только для объяснения поведения программы и инженерных решений.

## Предварительные знания

Рекомендуется завершить:

- [«Основы вычислительных систем»](../../../01-Вычислительные%20системы/intensives/01-Основы%20вычислительных%20систем/);
- [«Основы операционных систем и Linux»](../../../02-Операционные%20системы/intensives/01-Основы%20операционных%20систем%20и%20Linux/).

Минимально необходимы:

- Linux shell и Git;
- двоичная/шестнадцатеричная запись;
- процессы, files, virtual memory и syscalls на обзорном уровне;
- базовые сети;
- возможность читать техническую документацию на английском.

Предварительное знание Go не обязательно: первые спринты создают рабочую основу, но темп рассчитан на интенсивную самостоятельную практику.

## Лабораторное окружение

Эталонная среда — disposable Linux VM или отдельная development machine с актуальной поддерживаемой Go toolchain. Сравнительные runtimes устанавливаются по мере необходимости.

Подробности: [`LAB_ENVIRONMENT.md`](LAB_ENVIRONMENT.md).

Проверка:

```bash
bash scripts/check-environment.sh
```

## Принципы прохождения

1. Каждый спринт завершается работающим кодом, tests или runtime evidence.
2. Не вести отдельный progress backlog: состояние видно по выполненным artifacts и tests.
3. Перед оптимизацией или исправлением runtime failure фиксировать воспроизводимый symptom и baseline.
4. Теория проверяется через compiler output, debugger, profiler, trace, race detector, OS tools или comparative implementation.
5. Не копировать готовое решение лаборатории: основная ценность — собственная реализация по подготовленному specification.
6. Код форматируется и проверяется автоматически.
7. Small focused notes переносятся в `knowledge` после эксперимента, а не до него.
8. Raw profiles, binaries, large traces и machine-specific outputs не коммитятся.
9. Проверочные спринты сначала выполняются без перечитывания предыдущих материалов.
10. «Работает» не считается завершением без tests, failure behavior и explanation of constraints.

## Основной стек

- Go — основной production-like код;
- Bash — запуск, fixtures и OS integration;
- C — ABI, manual memory, undefined behavior и syscall comparison;
- Python — dynamic typing, interpreter и rapid scripting comparison;
- Java — bytecode/JVM/JIT/GC comparison;
- JavaScript/TypeScript — event loop и asynchronous execution;
- Rust — ownership, lifetimes и memory safety comparison.

Сравнительные задания малы и не требуют одинакового mastery всех языков.

## Порядок спринтов

1. [Программа, исходный код и цикл разработки](sprints/01-Программа%20исходный%20код%20и%20цикл%20разработки/)
2. [Значения, типы и управление потоком](sprints/02-Значения%20типы%20и%20управление%20потоком/)
3. [Функции, области видимости и замыкания](sprints/03-Функции%20области%20видимости%20и%20замыкания/)
4. [Структуры данных, interfaces и generics](sprints/04-Структуры%20данных%20interfaces%20и%20generics/)
5. [Ошибки, panic и управление ресурсами](sprints/05-Ошибки%20panic%20и%20управление%20ресурсами/)
6. [Packages, modules и зависимости](sprints/06-Packages%20modules%20и%20зависимости/)
7. [Проверка языкового основания](sprints/07-Проверка%20языкового%20основания/)
8. [Компиляция, linking и executable files](sprints/08-Компиляция%20linking%20и%20executable%20files/)
9. [Интерпретация, bytecode, VM и JIT](sprints/09-Интерпретация%20bytecode%20VM%20и%20JIT/)
10. [Runtime, ABI, reflection и program startup](sprints/10-Runtime%20ABI%20reflection%20и%20program%20startup/)
11. [Stack, heap, pointers и escape analysis](sprints/11-Stack%20heap%20pointers%20и%20escape%20analysis/)
12. [Garbage collection, ownership и manual memory](sprints/12-Garbage%20collection%20ownership%20и%20manual%20memory/)
13. [Проверка выполнения и памяти](sprints/13-Проверка%20выполнения%20и%20памяти/)
14. [Files, streams, encoding и serialization](sprints/14-Files%20streams%20encoding%20и%20serialization/)
15. [Processes, signals, syscalls и file descriptors](sprints/15-Processes%20signals%20syscalls%20и%20file%20descriptors/)
16. [Goroutines, channels и structured concurrency](sprints/16-Goroutines%20channels%20и%20structured%20concurrency/)
17. [Locks, atomics и memory model](sprints/17-Locks%20atomics%20и%20memory%20model/)
18. [Async I/O, event loop и backpressure](sprints/18-Async%20IO%20event%20loop%20и%20backpressure/)
19. [CLI, configuration и application lifecycle](sprints/19-CLI%20configuration%20и%20application%20lifecycle/)
20. [Network programming](sprints/20-Network%20programming/)
21. [Testing и verification](sprints/21-Testing%20и%20verification/)
22. [Debugging, profiling и performance](sprints/22-Debugging%20profiling%20и%20performance/)
23. [Языки, runtimes и выбор технологии](sprints/23-Языки%20runtimes%20и%20выбор%20технологии/)
24. [Системная диагностика программы](sprints/24-Системная%20диагностика%20программы/)
25. [Итоговая работа](sprints/99-Итоговая%20работа/)

## Покрытие основных вопросов

| Вопрос | Спринты |
|---|---|
| Как исходный код превращается в программу? | 01, 06, 08–10 |
| Чем компиляция отличается от интерпретации? | 08–10, 23 |
| Какую роль выполняет runtime? | 09–13, 16–18 |
| Как язык представляет и проверяет типы? | 02–04, 23 |
| Где хранятся переменные и объекты? | 10–13 |
| Как управляется время жизни данных? | 03, 05, 11–12 |
| GC против manual/ownership? | 12–13, 23 |
| Как программа взаимодействует с ОС? | 14–15, 19–20 |
| Process, thread, task, goroutine? | 15–18 |
| Как возникают race и deadlock? | 16–18, 22, 24 |
| Async против parallel? | 16–18, 23 |
| Как организовать errors? | 05, 19–21 |
| Как управлять dependencies? | 06, 08, 19 |
| Как тестировать components и whole program? | 07, 13, 21, 24, 99 |
| Как найти bug, leak или high load? | 22, 24, 99 |
| Как выбрать язык/runtime? | 23, 99 |
| Что влияет на reliability/performance/maintainability? | 04–06, 11–12, 16–24 |

Таблица готова заранее и не требует ручного обновления во время обучения.

## Итоговая работа

Финальный проект — `runtime-lab`: Go application suite с CLI, daemon, concurrent worker pipeline, file/network interfaces, serialization, subprocess integration, tests, profiling, fault injection и comparative runtime experiments.

Проект должен позволять воспроизводить и диагностировать:

- panic and error propagation;
- data race and deadlock;
- goroutine/file descriptor leak;
- retained heap and excessive allocation;
- CPU hot loop and lock contention;
- cancellation/backpressure failures;
- partial I/O and malformed data;
- dependency/build/configuration mismatch;
- graceful shutdown and restart behavior.

## Вклад в базу знаний

Каждый спринт содержит готовый список рекомендуемых заметок. Отдельный backlog не ведётся.

В `knowledge` переносится обобщённый механизм. Исходный код, fixtures, profiles и incident evidence остаются в `learning`.

## Общая библиография

Книги, specifications и official docs собраны в [`RESOURCES.md`](RESOURCES.md). Внутри спринта указан минимальный обязательный маршрут.