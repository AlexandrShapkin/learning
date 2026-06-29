# Ресурсы интенсива

Это общая библиография. В каждом спринте указан минимальный обязательный маршрут. Читать все книги и product manuals подряд не требуется.

## Общие основы

- *Designing Data-Intensive Applications*, Martin Kleppmann.
- *Database Internals*, Alex Petrov.
- *Database System Concepts*, Silberschatz, Korth and Sudarshan.
- *Database Management Systems*, Ramakrishnan and Gehrke.
- CMU 15-445/645 Database Systems lectures and notes.
- Berkeley/Stanford database courses as alternative academic routes.

## PostgreSQL

- PostgreSQL official documentation: https://www.postgresql.org/docs/
- SQL language, data definition, data manipulation and functions chapters.
- Concurrency control and transaction isolation chapters.
- Indexes, performance tips and `EXPLAIN` chapters.
- Server administration, WAL, backup, replication and monitoring chapters.
- PostgreSQL source code/readme files only for targeted internals reading.
- *The Internals of PostgreSQL* as secondary guided reference.
- *PostgreSQL 14 Internals* or current equivalent as version-aware secondary material.

## SQL and relational modeling

- SQL standard concepts through PostgreSQL documentation.
- *SQL and Relational Theory*, C. J. Date, selected conceptual chapters.
- *SQL Performance Explained*, Markus Winand / Use The Index, Luke.
- *Fundamentals of Database Systems*, Elmasri and Navathe, modeling/normalization chapters.
- PostgreSQL Exercises and generated local exercises.

## Transactions and concurrency

- PostgreSQL MVCC and explicit locking documentation.
- *Designing Data-Intensive Applications* transaction chapters.
- Berenson et al., critique/definitions of isolation levels.
- Adya thesis/materials as advanced reference.
- Jepsen articles only as distributed-consistency case studies, not primary PostgreSQL source.

## Storage engines and indexes

- CMU 15-445 lectures on storage, buffer pools, indexes, execution and recovery.
- *Database Internals* B-tree, LSM, WAL and distributed chapters.
- PostgreSQL `pageinspect`, `amcheck`, visibility and free-space-map documentation.
- Papers on B-trees, ARIES and LSM as optional primary sources.

## Query processing and optimization

- PostgreSQL `EXPLAIN`, planner statistics and configuration docs.
- CMU lectures on relational algebra, operators, joins and optimization.
- *SQL Performance Explained*.
- PostgreSQL wiki articles only as secondary navigation; verify against current docs and experiments.

## NoSQL and specialized storage

- Redis official documentation: https://redis.io/docs/
- MongoDB official documentation or equivalent document-store docs.
- Apache Cassandra documentation for wide-column concepts.
- Neo4j/Cypher documentation for graph model comparison.
- ClickHouse documentation for columnar/analytical model.
- TimescaleDB or Prometheus storage documentation for time-series concepts.
- OpenSearch/Elasticsearch documentation for inverted indexes, mappings, analyzers and search.

## Object, file and block storage

- Amazon S3 API and consistency documentation.
- MinIO documentation for local S3-compatible experiments.
- Linux filesystem/block concepts from OS intensive.
- SNIA/object-storage references as optional.

## Caching

- Redis data types, expiry, eviction and persistence docs.
- DDIA caching and derived-data discussions.
- Cache invalidation patterns from reliable engineering references.
- RFCs/HTTP caching belong primarily to application/network sections but may be cross-referenced.

## Queues and streams

- Apache Kafka design/protocol/operations documentation.
- NATS JetStream documentation as lightweight laboratory alternative.
- DDIA event logs, stream processing and messaging chapters.
- Enterprise Integration Patterns, selected messaging semantics.

## Replication, partitioning and recovery

- PostgreSQL streaming/logical replication documentation.
- DDIA replication and partitioning chapters.
- PostgreSQL backup/PITR documentation.
- Vendor docs for snapshots/object versioning only when used in lab.
- Disaster recovery guidance from recognized cloud/database documentation as secondary source.

## Security and lifecycle

- PostgreSQL authentication, roles, privileges, row-level security and encryption-related docs.
- OWASP data protection and database security references.
- NIST data lifecycle/backup guidance where relevant.
- Product documentation for auditing, encryption and retention.

## Go data access

- `database/sql` documentation.
- pgx documentation and examples.
- Go context, error and testing docs.
- Migration tooling documentation only after understanding SQL migrations.
- Testcontainers or Compose for integration isolation when justified.

## Правила работы с источниками

1. Product behavior проверять по official documentation installed/versioned system.
2. Textbook defines model; experiment confirms behavior and boundary.
3. `EXPLAIN ANALYZE` запускать только на safe synthetic workloads.
4. Secondary blog post не считать доказательством без reproduction.
5. Не копировать product documentation or datasets into repository.
6. Version-specific statements include tested version.
7. Production recommendation requires workload, failure and operational constraints.