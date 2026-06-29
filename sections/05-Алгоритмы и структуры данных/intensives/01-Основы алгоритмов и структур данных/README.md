# Основы алгоритмов и структур данных

Основной интенсив раздела. Цель — не запомнить каталог решений, а научиться переходить от требований и ограничений к модели данных, корректному алгоритму, доказательству и измеренному implementation behavior.

Go используется для основных реализаций. Стандартная библиотека сначала рассматривается как production choice, затем механизмы реализуются вручную в учебных целях.

## Результат прохождения

После завершения необходимо уметь самостоятельно:

- формулировать size parameter, input domain, output contract и invalid cases;
- строить loop/representation invariants и доказывать partial/total correctness;
- использовать O, Θ и Ω корректно;
- различать worst, average, expected и amortized costs;
- анализировать recurrence relations и summations на практическом уровне;
- выбирать representation по операциям, memory layout и growth pattern;
- реализовывать generic structures с ясными invariants;
- создавать reference implementation и differential/property tests;
- работать с arrays, linked lists, stacks, queues, deques, hash tables, sets/maps;
- применять ordered search, sorting and selection;
- реализовывать trees, balanced-tree models, heaps and tries;
- представлять graphs и применять BFS, DFS, topological sort, SCC, shortest paths and MST;
- использовать Union-Find;
- применять string matching and hashing;
- распознавать divide-and-conquer, greedy, dynamic programming and backtracking structure;
- использовать prefix sums, two pointers and sliding window;
- понимать LRU/LFU, Bloom filters, external sorting and parallel speedup limits;
- измерять runtime, allocations, locality and scaling;
- отличать algorithmic bottleneck от implementation/runtime bottleneck;
- обоснованно выбирать стандартную библиотеку или custom implementation.

Целевой уровень: 3 по всему разделу и 4 по complexity analysis, basic structures, sorting/search, graphs, dynamic programming и algorithm diagnostics.

## Границы

Интенсив не заменяет:

- полный курс дискретной математики;
- олимпиадную подготовку высокого уровня;
- формальные методы и theorem provers;
- полный курс probability/statistics;
- database internals;
- distributed algorithms;
- numerical methods;
- computational geometry и operations research.

Темы включаются ровно настолько, насколько нужны для анализа и применения основных алгоритмов.

## Предварительные знания

Рекомендуется завершить основные интенсивы по вычислительным системам и программированию. Минимально необходимы:

- уверенное программирование на Go;
- functions, slices, maps, structs, generics and tests;
- basic memory/cache understanding;
- умение запускать benchmarks and profiles;
- школьная алгебра, logarithms and sums;
- Git и Linux shell.

## Лабораторное окружение

Эталонная среда — Linux development environment с Go toolchain. Подробности: [`LAB_ENVIRONMENT.md`](LAB_ENVIRONMENT.md).

Проверка:

```bash
bash scripts/check-environment.sh
```

## Принципы прохождения

1. Сначала формализовать contract and constraints, затем писать код.
2. Для каждого алгоритма фиксировать invariant и complexity рядом с implementation/tests, не в progress table.
3. Сначала написать простой reference solution, затем optimized variant.
4. Correctness доказывается reasoning plus tests; benchmarks correctness не доказывают.
5. Complexity hypothesis проверяется scaling experiment, а не одним timing.
6. Adversarial and boundary inputs обязательны.
7. Built-in/stdlib solution сравнивается с учебной реализацией.
8. Не хранить сотни однотипных платформенных задач; сохранять reusable patterns and representative cases.
9. Notes в `knowledge` создаются после эксперимента.
10. Нельзя объяснять performance только Big O, игнорируя constants, locality, allocation and input distribution.

## Порядок спринтов

1. [Алгоритмическая задача, корректность и стоимость](sprints/01-Алгоритмическая%20задача%20корректность%20и%20стоимость/)
2. [Массивы, списки, стеки и очереди](sprints/02-Массивы%20списки%20стеки%20и%20очереди/)
3. [Хеш-таблицы, множества и отображения](sprints/03-Хеш-таблицы%20множества%20и%20отображения/)
4. [Бинарный поиск и упорядоченные данные](sprints/04-Бинарный%20поиск%20и%20упорядоченные%20данные/)
5. [Сортировка и выбор порядковой статистики](sprints/05-Сортировка%20и%20выбор%20порядковой%20статистики/)
6. [Деревья и двоичные деревья поиска](sprints/06-Деревья%20и%20двоичные%20деревья%20поиска/)
7. [Сбалансированные деревья и B-деревья](sprints/07-Сбалансированные%20деревья%20и%20B-деревья/)
8. [Кучи, приоритетные очереди и префиксные деревья](sprints/08-Кучи%20приоритетные%20очереди%20и%20префиксные%20деревья/)
9. [Проверка структур данных](sprints/09-Проверка%20структур%20данных/)
10. [Графы, BFS, DFS и компоненты](sprints/10-Графы%20BFS%20DFS%20и%20компоненты/)
11. [Кратчайшие пути](sprints/11-Кратчайшие%20пути/)
12. [Минимальные остовы и Union-Find](sprints/12-Минимальные%20остовы%20и%20Union-Find/)
13. [Строковые алгоритмы](sprints/13-Строковые%20алгоритмы/)
14. [Рекурсия и разделяй и властвуй](sprints/14-Рекурсия%20и%20разделяй%20и%20властвуй/)
15. [Жадные алгоритмы](sprints/15-Жадные%20алгоритмы/)
16. [Динамическое программирование](sprints/16-Динамическое%20программирование/)
17. [Поиск с возвратом и branch and bound](sprints/17-Поиск%20с%20возвратом%20и%20branch%20and%20bound/)
18. [Префиксные суммы, два указателя и скользящее окно](sprints/18-Префиксные%20суммы%20два%20указателя%20и%20скользящее%20окно/)
19. [Кеширование и вероятностные структуры](sprints/19-Кеширование%20и%20вероятностные%20структуры/)
20. [Внешние алгоритмы](sprints/20-Внешние%20алгоритмы/)
21. [Параллельные алгоритмы](sprints/21-Параллельные%20алгоритмы/)
22. [Algorithm engineering и производительность](sprints/22-Algorithm%20engineering%20и%20производительность/)
23. [Практическое решение задач и стандартная библиотека](sprints/23-Практическое%20решение%20задач%20и%20стандартная%20библиотека/)
24. [Системная диагностика алгоритма](sprints/24-Системная%20диагностика%20алгоритма/)
25. [Итоговая работа](sprints/99-Итоговая%20работа/)

## Покрытие основных вопросов

| Вопрос | Спринты |
|---|---|
| Как выбрать структуру данных? | 01–09, 22–23 |
| Как оценить зависимость времени от размера? | 01, 05, 14, 16, 21–24 |
| Worst, average и amortized? | 01–05, 19, 22 |
| Как memory layout влияет на performance? | 02–03, 06–08, 20–22 |
| Массив против списка? | 02, 22 |
| Почему hash table не всегда O(1)? | 03, 19, 22 |
| Как balanced tree сохраняет эффективность? | 06–07 |
| Как представить graph и выбрать traversal? | 10–12 |
| Когда binary search применим? | 04, 23 |
| Как сравнивать sorting algorithms? | 05, 20, 22 |
| Когда greedy корректен? | 15 |
| Когда нужен DP? | 16 |
| Как уменьшить повторные вычисления? | 14–19 |
| Как доказать корректность? | 01, 04–18, 24 |
| Как проверять boundaries/errors? | все спринты |
| Когда stdlib предпочтительнее? | 02–08, 22–23 |
| Как связаны algorithm, memory and hardware? | 02, 05–08, 20–22 |

Таблица готова заранее и не требует ручного обновления.

## Итоговая работа

Финальный проект — `algolab`: библиотека и CLI для запуска, проверки и сравнения алгоритмов на generated/realistic datasets.

Система включает:

- generic structures and algorithms;
- reference and optimized implementations;
- property/differential tests;
- workload generators;
- complexity/scaling experiments;
- profiles and cache/allocation evidence;
- external-memory and parallel mode;
- controlled adversarial inputs;
- fault catalogue and blind diagnosis.

## Вклад в базу знаний

Каждый спринт содержит список рекомендуемых заметок. Отдельный backlog не ведётся. В `knowledge` переносится generalized mechanism; implementations, datasets, benchmarks and incident evidence остаются в `learning`.

## Общая библиография

Основные книги, курсы и references собраны в [`RESOURCES.md`](RESOURCES.md). Внутри каждого спринта указан минимальный маршрут.