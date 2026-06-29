# Данные и хранилища

Практическое изучение моделирования, хранения, изменения, поиска, распределения, защиты и восстановления данных в программных системах.

Раздел соответствует области [«Данные и хранилища»](https://github.com/AlexandrShapkin/knowledge/tree/main/content/Данные%20и%20хранилища) базы знаний.

## Основной интенсив

### [01. Основы данных и хранилищ](intensives/01-Основы%20данных%20и%20хранилищ/)

Основная СУБД — PostgreSQL. SQLite используется для сравнения embedded storage и транзакционной модели. Redis, документное, поисковое, объектное и потоковое хранилища применяются точечно, чтобы сравнивать модели и эксплуатационные свойства, а не изучать десятки продуктов поверхностно.

После прохождения необходимо уметь:

- переводить предметные требования в logical schema, keys, constraints и lifecycle rules;
- писать и анализировать SQL-запросы;
- проектировать транзакции и объяснять isolation anomalies;
- понимать MVCC, locks, WAL, pages, checkpoints и vacuum;
- выбирать и проверять индексы;
- читать execution plans и находить причины дорогих запросов;
- выполнять безопасные schema/data migrations;
- выбирать relational, key-value, document, graph, columnar, time-series, search, object или stream storage;
- проектировать cache consistency, replication и partitioning;
- создавать backup/PITR и проверять восстановление;
- защищать данные и управлять retention/deletion;
- диагностировать slow queries, blocking, bloat, replication lag, capacity pressure и recovery failures;
- оценивать стоимость хранения и роста данных.

Ориентировочный объём: 220–310 часов.

## Планируемые тематические углубления

После основного интенсива могут быть добавлены:

- **PostgreSQL internals and performance** — buffer manager, WAL, vacuum, planner, extensions и production tuning;
- **Distributed SQL and consensus-backed storage**;
- **Streaming platforms and event processing**;
- **Search systems and relevance engineering**;
- **Analytical and columnar databases**;
- **Data engineering and lakehouse systems**;
- **Database reliability and disaster recovery**;
- **Storage engines** — B-tree/LSM, compaction, checksums and recovery;
- **Data security, privacy and governance**.

Каждое углубление будет самостоятельным маршрутом.

## Связи с другими разделами

- Files, block devices and page cache — [«Операционные системы»](../02-Операционные%20системы/).
- Network protocols and connection behavior — [«Сети и протоколы»](../03-Сети%20и%20протоколы/).
- Go clients, serialization, concurrency and profiling — [«Программирование и среды выполнения»](../04-Программирование%20и%20среды%20выполнения/).
- B-trees, hashing, external sorting and probabilistic structures — [«Алгоритмы и структуры данных»](../05-Алгоритмы%20и%20структуры%20данных/).
- Data access boundaries and domain modeling — [«Проектирование программного обеспечения»](../08-Проектирование%20программного%20обеспечения/).
- Deployment, backups and operational automation — [«Доставка и эксплуатация»](../10-Доставка%20и%20эксплуатация/).
- Metrics, logs and tracing — [«Наблюдаемость и диагностика»](../11-Наблюдаемость%20и%20диагностика/).
- Distributed consistency and failure models — [«Распределённые системы и надёжность»](../12-Распределённые%20системы%20и%20надёжность/).
- Access control, encryption and secrets — [«Безопасность»](../13-Безопасность/).