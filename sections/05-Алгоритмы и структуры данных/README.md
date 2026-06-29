# Алгоритмы и структуры данных

Практическое изучение выбора представления данных, построения корректных алгоритмов и оценки их стоимости по времени, памяти и поведению на реальных входах.

Раздел соответствует области [«Алгоритмы и структуры данных»](https://github.com/AlexandrShapkin/knowledge/tree/main/content/Алгоритмы%20и%20структуры%20данных) базы знаний.

## Основной интенсив

### [01. Основы алгоритмов и структур данных](intensives/01-Основы%20алгоритмов%20и%20структур%20данных/)

Основной язык реализации — Go. Он используется для собственных структур, тестов, benchmarks, generators и command-line laboratories. Python допускается для небольших визуализаций и проверки математических гипотез, но не заменяет основную реализацию.

После прохождения необходимо уметь:

- формализовать вход, выход, ограничения и инварианты задачи;
- доказывать корректность алгоритма и завершение;
- оценивать worst, average, best и amortized complexity;
- выбирать структуру данных по набору операций и характеристикам входа;
- реализовывать и тестировать arrays, lists, stacks, queues, hash tables, trees, heaps, tries, graphs и disjoint sets;
- применять binary search, sorting, graph traversal, shortest paths, MST и string algorithms;
- распознавать задачи для divide and conquer, greedy, dynamic programming, backtracking, sliding window и two pointers;
- учитывать locality, allocations, branch behavior и external-memory constraints;
- сравнивать theoretical complexity с benchmark/profile evidence;
- применять стандартную библиотеку вместо собственной реализации там, где это снижает риск;
- диагностировать incorrect result, timeout, memory blow-up и деградацию на adversarial input.

Ориентировочный объём: 190–270 часов.

## Планируемые тематические углубления

После основного интенсива могут быть добавлены:

- **Продвинутые графовые алгоритмы** — flows, matching, advanced shortest paths, dynamic graphs;
- **Продвинутые структуры данных** — segment trees, Fenwick trees, sparse tables, persistent structures;
- **Строковые алгоритмы** — suffix arrays/trees, automata, approximate matching;
- **Алгоритмы для собеседований и соревнований** — ограниченный по времени problem-solving route;
- **Algorithm engineering** — cache-aware, SIMD, external-memory and parallel implementations;
- **Approximation and randomized algorithms**;
- **Computational geometry**;
- **Optimization and operations research**.

Эти маршруты будут отдельными интенсивами, а не обязательной частью основного.

## Связи с другими разделами

- Memory layout и cache behavior изучаются глубже в [«Вычислительных системах»](../01-Вычислительные%20системы/).
- Go implementations, generics, testing и profiling — в [«Программировании и средах выполнения»](../04-Программирование%20и%20среды%20выполнения/).
- Database indexes и query algorithms — в [«Данных и хранилищах»](../06-Данные%20и%20хранилища/).
- Архитектура компонентов и API — в [«Проектировании программного обеспечения»](../08-Проектирование%20программного%20обеспечения/).
- Distributed algorithms — в [«Распределённых системах и надёжности»](../12-Распределённые%20системы%20и%20надёжность/).