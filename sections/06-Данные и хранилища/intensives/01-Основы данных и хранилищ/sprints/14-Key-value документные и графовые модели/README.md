# Спринт 14. Key-value, документные и графовые модели

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Когда access pattern and relationship shape justify a non-relational model, и какие guarantees and operational costs появляются вместо familiar SQL constraints and joins?

## Результат спринта

После завершения необходимо уметь:

- различать storage model, query model and product category;
- проектировать key-value keys, values, namespaces and expiration;
- понимать access-by-key strength and secondary-query limitations;
- моделировать documents, nesting, embedding and references;
- выбирать document boundaries by update/read atomicity;
- понимать document schema evolution and validation;
- моделировать graph nodes, edges, properties and traversals;
- выбирать graph model for relationship-heavy queries;
- сравнивать relational joins, document aggregation and graph traversal;
- понимать per-record/document transaction boundaries;
- проверять actual multi-record transaction/consistency guarantees;
- проектировать partition key and avoid hot keys;
- учитывать duplication and denormalization repair;
- понимать secondary indexes and query limitations;
- использовать Redis data structures without treating Redis as universal database;
- выбирать relational/KV/document/graph from workload and failure constraints;
- избегать product selection by marketing labels.

## Основной маршрут

### Шаг 1. Key-value model

Define key grammar, value schema, TTL, atomic operations, conditional updates and scan behavior. Key design determines distribution and observability.

### Шаг 2. Document model

Compare embedding and references by:

- read locality;
- update frequency;
- document growth;
- atomicity boundary;
- duplication repair;
- query/index requirements.

### Шаг 3. Graph model

Represent relationship-first queries. Compare adjacency traversal with recursive SQL and document references.

### Шаг 4. Model selection

For each workload state required operations, consistency, scale, query flexibility, migration, backup and skill/operational costs.

## Ресурсы

- DDIA data-model chapters.
- Redis official data types and command semantics.
- MongoDB or equivalent document-model documentation.
- Neo4j/Cypher or equivalent property-graph documentation.
- PostgreSQL JSONB and recursive-query docs for comparison.

## Практические задания

1. Model sessions, counters and idempotency records in key-value form.
2. Model product catalog and customer profile as documents with two boundary variants.
3. Model recommendations/referrals/dependencies as graph.
4. Implement the same query in PostgreSQL, document store and graph store.
5. Create hot-key, oversized-document and duplicated-reference counterexamples.
6. Write a storage decision for five workloads.

## Лабораторная работа

Создать `work/model-comparison/`.

### Workloads

- session/token lookup;
- product catalog with variable attributes;
- customer aggregate/profile;
- social/referral/dependency traversal;
- idempotency and rate-limit state;
- relationship recommendation query.

### Components

- PostgreSQL implementation;
- Redis key-value implementation;
- document-store implementation;
- graph-store implementation or bounded graph comparison;
- common Go workload runner;
- consistency and migration tests;
- decision report generated from measured operations.

### Requirements

- same logical dataset and result checksums where semantics overlap;
- explicit source of truth for duplicated facts;
- document validation/versioning;
- key namespace and TTL policy;
- graph traversal depth/size limits;
- indexes defined for supported queries;
- no unrestricted scans in production-like path;
- atomicity and isolation tested rather than assumed;
- backup/restore and client/tooling implications noted;
- conclusion tied to workload, not product ranking.

### Failure scenarios

1. Hot key concentrates workload.
2. Key naming collision or tenant leak.
3. TTL expires source-of-truth data unexpectedly.
4. Document grows without bound.
5. Embedded duplicate facts diverge.
6. Reference requires many client round trips.
7. Document transaction boundary does not cover invariant.
8. Graph traversal expands without limit.
9. Secondary index missing or inconsistent with query.
10. Product advertised consistency assumed without test/config context.

## Самопроверка

1. What is a key-value model good at?
2. How key design affects distribution?
3. Embed versus reference in documents?
4. What is document atomicity boundary?
5. When graph model helps?
6. Graph traversal versus relational join?
7. What replaces relational constraints?
8. Why denormalization needs repair?
9. How secondary indexes affect model?
10. How choose storage by workload?

## Результат для базы знаний

- **Key-value data model and key design**.
- **Document embedding and references**.
- **Document schema evolution and validation**.
- **Property-graph model and traversal**.
- **Relational, document and graph comparison**.
- **Hot keys and oversized documents**.
- **Non-relational transaction boundaries**.
- **Storage selection by access pattern**.

## Когда переходить дальше

Можно переходить, когда overlapping workloads are compared through one contract, consistency/atomicity are tested, and every duplicated fact has an explicit source and repair path.