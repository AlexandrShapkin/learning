# Основы проектирования программного обеспечения

Основной интенсив раздела «Проектирование программного обеспечения». Его цель — научиться управлять сложностью и изменениями на уровнях функции, типа, пакета, модуля, приложения and system boundary.

Основная практика выполняется на Go. В центре находится одно эволюционирующее приложение: сначала намеренно связанное и неудобное для изменений, затем покрытое characterization tests, разделённое на модули, снабжённое предметной моделью, архитектурными контрактами и безопасными путями миграции.

## Результат прохождения

После завершения необходимо уметь самостоятельно:

- отличать essential complexity from accidental complexity;
- измерять дизайн через стоимость изменений, локальность и число затрагиваемых решений;
- создавать понятные функции, типы и модули с явными инвариантами;
- управлять cohesion, coupling, information hiding and dependency direction;
- проектировать устойчивые interfaces and contracts;
- применять композицию и внедрение зависимостей без framework ceremony;
- использовать design principles as diagnostic heuristics;
- выполнять small-step refactoring under tests;
- классифицировать и обслуживать technical debt;
- моделировать entities, value objects, aggregates, domain services and events;
- выделять bounded contexts and translation boundaries;
- выбирать design patterns by forces and consequences;
- различать application, domain, infrastructure and presentation responsibilities;
- проектировать layered, hexagonal and modular-monolith structures;
- оценивать event-driven and service architectures by quality attributes;
- проектировать API/message contracts and anti-corruption layers;
- формулировать architecture drivers and trade-off decisions;
- создавать C4-like diagrams, ADRs and architecture tests;
- использовать strangler, branch by abstraction and compatibility windows;
- вводить seams into legacy code and preserve observable behavior;
- оценивать architecture through scenarios, risks and change simulations;
- диагностировать design erosion, cycles, boundary leaks and runtime consequences.

Целевой уровень: 3 по всему разделу и 4 по модульности, dependency management, domain modeling, modular monoliths, evolutionary change and architecture evaluation.

## Границы

Интенсив не заменяет:

- полный курс требований and product discovery;
- отдельный курс алгоритмов, языков and runtime internals;
- глубокий курс distributed systems;
- enterprise-framework certification;
- полный курс organizational design;
- специализацию по security architecture;
- процессный курс по delivery/project management;
- формальную верификацию software systems.

Смежные темы включаются только настолько, насколько они нужны для обоснованного проектирования и эволюции программной системы.

## Предварительные знания

Рекомендуется завершить основные интенсивы по программированию, данным и прикладным системам.

Минимально необходимы:

- уверенный Go, interfaces, errors, tests and concurrency basics;
- Git and command line;
- SQL/PostgreSQL basics;
- HTTP/API and background processing concepts;
- способность читать существующий код and failing tests;
- технический английский.

## Лабораторное окружение

Эталонная среда — disposable Linux VM or workstation profile.

Основной набор:

- Go toolchain;
- Git, Make, Bash and jq;
- PostgreSQL;
- Docker/Podman and Compose;
- Graphviz and Mermaid-compatible renderer optional;
- static analysis and dependency visualization tools;
- benchmark/profiling tools;
- mutation/architecture-testing utilities optional.

Подробности: [`LAB_ENVIRONMENT.md`](LAB_ENVIRONMENT.md).

Проверка:

```bash
bash scripts/check-environment.sh
```

## Принципы прохождения

1. Design оценивается через concrete change scenarios, not visual symmetry.
2. Сначала фиксируется observable behavior; затем меняется структура.
3. Каждая abstraction должна скрывать решение or stabilize a variation.
4. Interface вводится со стороны consumer and only for real variation/test boundary.
5. Business invariants защищаются model and persisted constraints, not comments.
6. Package/module boundary должен иметь владельца данных and explicit contract.
7. Pattern is a named trade-off, not goal.
8. Architectural style выбирается by quality attributes and constraints.
9. Distribution is a cost; local modularity precedes service extraction.
10. Evolutionary change requires compatibility, observability and rollback/forward path.
11. Diagrams and ADRs must match code and executable checks.
12. General mechanisms move to `knowledge`; project-specific code, diagrams and evidence remain in `learning`.

## Основной стек

- Go — implementations, refactorings and architecture experiments;
- PostgreSQL — persistence and transaction boundary examples;
- HTTP and messaging adapters — integration boundaries;
- Git — change history and refactoring checkpoints;
- `go test`, race detector, benchmarks and fuzzing;
- `go vet`, staticcheck or equivalent;
- `go list`, dependency graph tools and custom architecture tests;
- Graphviz/Mermaid — structural and sequence diagrams;
- Docker Compose — reproducible external dependencies when required.

## Порядок спринтов

1. [Сложность, изменения и стоимость дизайна](sprints/01-Сложность%20изменения%20и%20стоимость%20дизайна/)
2. [Именование, локальность и явные инварианты](sprints/02-Именование%20локальность%20и%20явные%20инварианты/)
3. [Функции, типы, пакеты и смысловая цельность](sprints/03-Функции%20типы%20пакеты%20и%20смысловая%20цельность/)
4. [Инкапсуляция, контракты и абстракции](sprints/04-Инкапсуляция%20контракты%20и%20абстракции/)
5. [Зависимости, композиция и внедрение](sprints/05-Зависимости%20композиция%20и%20внедрение/)
6. [Принципы проектирования как эвристики](sprints/06-Принципы%20проектирования%20как%20эвристики/)
7. [Рефакторинг и технический долг](sprints/07-Рефакторинг%20и%20технический%20долг/)
8. [Проверка качества кода и модулей](sprints/08-Проверка%20качества%20кода%20и%20модулей/)
9. [Сущности, объекты-значения и инварианты](sprints/09-Сущности%20объекты-значения%20и%20инварианты/)
10. [Агрегаты, доменные сервисы и события](sprints/10-Агрегаты%20доменные%20сервисы%20и%20события/)
11. [Предметные сценарии и модели состояний](sprints/11-Предметные%20сценарии%20и%20модели%20состояний/)
12. [Единый язык и ограниченные контексты](sprints/12-Единый%20язык%20и%20ограниченные%20контексты/)
13. [Шаблоны проектирования и условия применимости](sprints/13-Шаблоны%20проектирования%20и%20условия%20применимости/)
14. [Прикладные и enterprise-шаблоны](sprints/14-Прикладные%20и%20enterprise-шаблоны/)
15. [Проверка предметной модели и шаблонов](sprints/15-Проверка%20предметной%20модели%20и%20шаблонов/)
16. [Слоистая архитектура и границы приложения](sprints/16-Слоистая%20архитектура%20и%20границы%20приложения/)
17. [Порты, адаптеры и направление зависимостей](sprints/17-Порты%20адаптеры%20и%20направление%20зависимостей/)
18. [Модульный монолит и компонентные границы](sprints/18-Модульный%20монолит%20и%20компонентные%20границы/)
19. [Событийная архитектура и асинхронные границы](sprints/19-Событийная%20архитектура%20и%20асинхронные%20границы/)
20. [Сервисная архитектура и цена распределения](sprints/20-Сервисная%20архитектура%20и%20цена%20распределения/)
21. [Интеграционные контракты и anti-corruption layer](sprints/21-Интеграционные%20контракты%20и%20anti-corruption%20layer/)
22. [Атрибуты качества и архитектурные драйверы](sprints/22-Атрибуты%20качества%20и%20архитектурные%20драйверы/)
23. [Архитектурные решения, диаграммы и fitness functions](sprints/23-Архитектурные%20решения%20диаграммы%20и%20fitness%20functions/)
24. [Эволюция архитектуры и совместимые миграции](sprints/24-Эволюция%20архитектуры%20и%20совместимые%20миграции/)
25. [Legacy-системы, seams и characterization tests](sprints/25-Legacy-системы%20seams%20и%20characterization%20tests/)
26. [Оценка архитектуры, риски и стоимость](sprints/26-Оценка%20архитектуры%20риски%20и%20стоимость/)
27. [Системная диагностика дизайна и архитектуры](sprints/27-Системная%20диагностика%20дизайна%20и%20архитектуры/)
99. [Итоговая работа](sprints/99-Итоговая%20работа/)

## Покрытие основных вопросов

| Вопрос | Спринты |
|---|---|
| Как разделить систему на понятные части? | 01–05, 16–18 |
| Где провести границы модулей и контекстов? | 03–05, 12, 16–18 |
| Как уменьшить связность и сохранить cohesion? | 03–07, 17–18 |
| Куда направлять зависимости? | 04–06, 16–18 |
| Когда композиция предпочтительнее наследования? | 05–06, 13 |
| Какие инварианты защищает модель? | 02, 09–11 |
| Когда pattern упрощает или усложняет? | 13–15 |
| Как выбрать архитектурный стиль? | 16–23, 26 |
| Как отделить бизнес-правила от инфраструктуры? | 09–11, 16–18 |
| Как управлять совместимостью интеграций? | 19–21, 24 |
| Как фиксировать решения и компромиссы? | 22–23, 26 |
| Как безопасно развивать существующую систему? | 07, 24–27, 99 |

Таблица является статической картой покрытия и не требует ручного ведения прогресса.

## Итоговая работа

Финальный проект — `architecture-evolution-lab`: намеренно запутанная Go-система, которая поэтапно превращается в проверяемый modular monolith and selectively extracted service boundary without full rewrite.

Система должна позволять:

- измерять стоимость заданных изменений до и после redesign;
- проверять package/module dependency rules;
- моделировать несколько bounded contexts;
- сравнивать layered, hexagonal, modular and service variants;
- выполнять compatibility-preserving migrations;
- применять characterization tests and seams;
- фиксировать ADRs, quality scenarios and architecture fitness checks;
- диагностировать boundary erosion and runtime consequences.

## Вклад в базу знаний

Каждый спринт содержит конкретные рекомендуемые заметки. Отдельный backlog не ведётся. General design mechanisms переносятся в `knowledge`; source code, diagrams, ADRs, change simulations and incident evidence остаются в `learning`.

## Общая библиография

Основные книги, статьи and official documentation собраны в [`RESOURCES.md`](RESOURCES.md). Внутри каждого спринта указан обязательный минимальный маршрут.
