# Основы данных и хранилищ

Основной интенсив раздела «Данные и хранилища». Его цель — связать logical data model с physical storage, query execution, transactional guarantees, distributed placement и operational recovery.

PostgreSQL используется как основная исследовательская система: она позволяет наблюдать schema, SQL, transactions, MVCC, WAL, indexes, plans, replication и backup/recovery в одной среде. Другие хранилища вводятся только для сравнения моделей и гарантий.

## Результат прохождения

После завершения необходимо уметь самостоятельно:

- выделять entities, relationships, identifiers, invariants и retention rules;
- различать conceptual, logical and physical data models;
- выбирать data types and serialization formats;
- проектировать relational schemas, constraints, keys and normalization boundaries;
- писать joins, aggregates, subqueries, CTEs, window functions and data-modification queries;
- понимать relational algebra at practical level;
- проектировать transactions and retry boundaries;
- воспроизводить dirty/nonrepeatable/phantom reads, lost update, write skew and serialization failures;
- объяснять locks, deadlocks, MVCC snapshots and vacuum;
- понимать pages, tuples, WAL, checkpoints, buffer cache and crash recovery;
- создавать B-tree, hash, GIN, GiST and BRIN indexes по назначению;
- читать `EXPLAIN (ANALYZE, BUFFERS)` и проверять estimates;
- понимать statistics, selectivity, join algorithms and planner choices;
- выполнять backward-compatible schema/data migrations;
- использовать connection pooling, prepared statements, batching and bulk loading;
- сравнивать relational, key-value, document, graph, columnar, time-series and search models;
- проектировать object/file/block storage usage;
- выбирать cache policy and consistency strategy;
- понимать queues, logs, consumer groups, delivery semantics and idempotency;
- понимать replication, failover, lag, partitioning and sharding;
- создавать logical/physical backups, PITR and restore drills;
- применять least privilege, encryption, retention and deletion workflows;
- наблюдать workload, capacity, bloat, locks, lag and cost;
- диагностировать data correctness, performance, availability and recovery incidents.

Целевой уровень: 3 по всему разделу и 4 по relational modeling, SQL, transactions, indexes/plans, backup/recovery и диагностике PostgreSQL.

## Границы

Интенсив не заменяет:

- полный DBA/SRE production curriculum;
- глубокую реализацию storage engine;
- полный курс distributed systems;
- data science, ML и статистику;
- enterprise data governance;
- vendor-specific certification;
- полный курс data engineering;
- глубокое администрирование каждого NoSQL продукта.

Смежные темы включаются для понимания выбора и поведения хранилищ.

## Предварительные знания

Рекомендуется завершить основные интенсивы по операционным системам, сетям, программированию и алгоритмам.

Минимально необходимы:

- Linux shell и Git;
- Go на уровне написания CLI/service/tests;
- files, processes, sockets and basic networking;
- B-tree, hashing, sorting and concurrency basics;
- Docker/Podman Compose или возможность установить PostgreSQL локально;
- технический английский.

## Лабораторное окружение

Эталонная среда — disposable Linux VM с контейнерным runtime или отдельными локальными instances.

Основной набор:

- PostgreSQL client/server;
- Go and PostgreSQL driver;
- SQLite;
- Redis;
- один document store;
- один search engine;
- S3-compatible object storage;
- один message log/broker;
- monitoring and load tools.

Подробности: [`LAB_ENVIRONMENT.md`](LAB_ENVIRONMENT.md).

Проверка:

```bash
bash scripts/check-environment.sh
```

## Принципы прохождения

1. Начинать с data contract and invariants, а не с выбора продукта.
2. SQL и schema проверяются реальными constraints/tests, а не только диаграммой.
3. Любое performance утверждение подтверждается plan, buffers, timing and workload metadata.
4. Transaction guarantees проверяются concurrent experiment.
5. Миграция считается готовой только при rollback/forward-recovery strategy.
6. Backup считается существующим только после успешного restore drill.
7. Replication/HA experiment включает client-visible behavior and data-loss boundary.
8. Не хранить real personal data, secrets or production dumps.
9. Raw large dumps, WAL archives and profiles не коммитятся; сохраняются scripts and concise evidence.
10. Обобщённые механизмы переносятся в `knowledge`; environment-specific configs/results остаются в `learning`.

## Основной стек

- PostgreSQL — primary relational and internals laboratory;
- Go — clients, workload generators, migrations and verification tools;
- SQL and `psql` — direct experiments;
- SQLite — embedded/locking comparison;
- Redis — key-value/cache structures;
- MongoDB-compatible document store or equivalent — document model comparison;
- ClickHouse-compatible analytical store or PostgreSQL columnar comparison where feasible;
- OpenSearch/Elasticsearch-compatible engine — inverted-index/search model;
- MinIO or another S3-compatible server — object storage;
- NATS JetStream, Redpanda/Kafka or equivalent — queue/log/stream experiments.

A concrete product may be substituted when the mechanism and guarantees remain equivalent and documented.

## Порядок спринтов

1. [Моделирование и представление данных](sprints/01-Моделирование%20и%20представление%20данных/)
2. [Реляционная модель и основы SQL](sprints/02-Реляционная%20модель%20и%20основы%20SQL/)
3. [Ограничения, ключи и нормализация](sprints/03-Ограничения%20ключи%20и%20нормализация/)
4. [Сложные запросы и реляционные операции](sprints/04-Сложные%20запросы%20и%20реляционные%20операции/)
5. [Транзакции и уровни изоляции](sprints/05-Транзакции%20и%20уровни%20изоляции/)
6. [Блокировки, MVCC и взаимные блокировки](sprints/06-Блокировки%20MVCC%20и%20взаимные%20блокировки/)
7. [Проверка реляционного основания](sprints/07-Проверка%20реляционного%20основания/)
8. [Физическое хранение, WAL и восстановление после сбоя](sprints/08-Физическое%20хранение%20WAL%20и%20восстановление%20после%20сбоя/)
9. [Индексы и структуры доступа](sprints/09-Индексы%20и%20структуры%20доступа/)
10. [Планы выполнения, статистика и оптимизация запросов](sprints/10-Планы%20выполнения%20статистика%20и%20оптимизация%20запросов/)
11. [Изменение схемы и миграции данных](sprints/11-Изменение%20схемы%20и%20миграции%20данных/)
12. [Соединения, batching и массовая загрузка](sprints/12-Соединения%20batching%20и%20массовая%20загрузка/)
13. [Проверка внутреннего устройства хранилища](sprints/13-Проверка%20внутреннего%20устройства%20хранилища/)
14. [Key-value, документные и графовые модели](sprints/14-Key-value%20документные%20и%20графовые%20модели/)
15. [Колоночные, аналитические и временные хранилища](sprints/15-Колоночные%20аналитические%20и%20временные%20хранилища/)
16. [Полнотекстовый поиск и инвертированные индексы](sprints/16-Полнотекстовый%20поиск%20и%20инвертированные%20индексы/)
17. [Объектные, файловые и блочные хранилища](sprints/17-Объектные%20файловые%20и%20блочные%20хранилища/)
18. [Кеширование и согласованность кеша](sprints/18-Кеширование%20и%20согласованность%20кеша/)
19. [Очереди, журналы событий и потоки данных](sprints/19-Очереди%20журналы%20событий%20и%20потоки%20данных/)
20. [Репликация, высокая доступность и failover](sprints/20-Репликация%20высокая%20доступность%20и%20failover/)
21. [Partitioning, sharding и масштабирование](sprints/21-Partitioning%20sharding%20и%20масштабирование/)
22. [Резервное копирование, PITR и disaster recovery](sprints/22-Резервное%20копирование%20PITR%20и%20disaster%20recovery/)
23. [Жизненный цикл, безопасность и удаление данных](sprints/23-Жизненный%20цикл%20безопасность%20и%20удаление%20данных/)
24. [Наблюдаемость, ёмкость и стоимость хранения](sprints/24-Наблюдаемость%20ёмкость%20и%20стоимость%20хранения/)
25. [Системная диагностика данных и хранилищ](sprints/25-Системная%20диагностика%20данных%20и%20хранилищ/)
99. [Итоговая работа](sprints/99-Итоговая%20работа/)

## Покрытие основных вопросов

| Вопрос | Спринты |
|---|---|
| Как выбрать модель данных и тип хранилища? | 01–04, 14–19, 21 |
| Логическая модель против физического размещения? | 01–03, 08–10, 14–17 |
| Нормализация или денормализация? | 03–04, 14–15, 21 |
| Какие гарантии дают транзакции и isolation? | 05–07, 14, 19–21 |
| Как indexes и plans влияют на запросы? | 08–10, 13, 16 |
| Когда relational/document/KV/graph/search? | 14–16 |
| Как выбрать cache strategy? | 18–19 |
| Как replication/sharding влияют на guarantees? | 20–21 |
| Как безопасно менять schema/migrate data? | 11–13, 20–22 |
| Какие backups нужны для RPO/RTO? | 20, 22, 25, 99 |
| Как обнаруживать slow queries, locks and capacity pressure? | 10, 12–13, 20, 24–25 |
| Как оценивать стоимость роста данных? | 15, 17, 20–24 |

Таблица готова заранее и не требует ручного обновления.

## Итоговая работа

Финальный проект — `storage-lab-platform`: Go service and operational laboratory with PostgreSQL as system of record, cache, object storage, search index and event log.

Система должна позволять:

- пройти путь data model → schema → query → page/index/WAL;
- наблюдать transactions, locks and MVCC;
- выполнять migration and backfill;
- сравнивать relational and specialized read models;
- воспроизводить cache invalidation and event-delivery failures;
- тестировать replication/failover and partitioning;
- создавать backup/PITR and perform restore;
- диагностировать slow query, bloat, blocking, lag, capacity and data-consistency incidents.

## Вклад в базу знаний

Каждый спринт содержит рекомендуемые заметки. Отдельный backlog не ведётся. В `knowledge` переносится general mechanism; schemas, queries, configs, synthetic datasets and incident evidence остаются в `learning`.

## Общая библиография

Книги, courses, specifications and official documentation собраны в [`RESOURCES.md`](RESOURCES.md). Внутри каждого спринта указан минимальный маршрут.