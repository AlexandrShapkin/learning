# Спринт 16. Полнотекстовый поиск и инвертированные индексы

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Как transform documents into searchable terms, rank approximate relevance and maintain a derived search index without confusing it with the transactional source of truth?

## Результат спринта

После завершения необходимо уметь:

- объяснять inverted index, term dictionary and postings list;
- различать exact filtering, full-text search and vector/semantic search overview;
- понимать tokenization, normalization, stemming and stop words;
- проектировать mappings, field types and analyzers;
- различать analyzed text and exact keyword fields;
- понимать term frequency, inverse document frequency and BM25 conceptually;
- использовать filters separately from scored queries;
- работать with phrase, prefix, fuzzy and wildcard queries cautiously;
- понимать refresh, segment merge and near-real-time visibility;
- проектировать idempotent indexing and document versioning;
- синхронизировать source database and search index through outbox/CDC;
- выполнять reindex with alias/switch strategy;
- применять search-after or equivalent stable pagination;
- проектировать aggregations and cardinality limits;
- диагностировать missing, stale, duplicated and incorrectly analyzed documents;
- сравнивать PostgreSQL full-text search with dedicated search engine;
- понимать why relevance requires evaluation corpus, not intuition.

## Основной маршрут

### Шаг 1. Text analysis pipeline

Trace:

```text
raw field → character filters → tokenizer → token filters
→ terms → postings → query analysis → candidate documents → score
```

### Шаг 2. Mapping and query semantics

Define exact identifiers, text fields, dates, numerics and nested/object structures. Avoid dynamic mapping surprises.

### Шаг 3. Relevance

Build small judged query set. Compare exact filter, term/match, phrase and fuzzy behavior. Explain BM25 components without treating score as probability.

### Шаг 4. Derived-index lifecycle

Use database source of truth, outbox/change stream, idempotent document IDs/version, retry and reconciliation. Reindex into new index and switch alias only after verification.

## Ресурсы

- OpenSearch or Elasticsearch official mapping, analysis, query and operations docs.
- PostgreSQL full-text search documentation.
- Information retrieval textbook chapters on inverted indexes and ranking.
- DDIA derived-data and stream-processing chapters.

## Практические задания

1. Build analyzers for multilingual product text.
2. Compare keyword and analyzed text behavior.
3. Implement filters plus scored query.
4. Evaluate BM25 ranking on a small judged corpus.
5. Reproduce refresh delay and stale index.
6. Implement idempotent database-to-search projection.
7. Perform zero/low-downtime reindex with alias switch.

## Лабораторная работа

Создать `work/search-lab/`.

### Domain

Product catalog and order-support knowledge documents with titles, descriptions, tags, categories, tenant, availability and timestamps.

### Components

- PostgreSQL source tables/outbox;
- PostgreSQL FTS baseline;
- dedicated search index;
- Go indexer/reconciler;
- query API;
- relevance evaluation corpus;
- reindex and alias scripts.

### Requirements

- explicit mappings and analyzers;
- tenant and authorization filters cannot be bypassed by scoring query;
- exact IDs/codes use non-analyzed fields;
- document version prevents stale overwrite;
- indexer retry is idempotent;
- reconciliation compares source/index counts and hashes/samples;
- pagination uses stable sort/search-after where needed;
- reindex verifies documents before switch;
- large result windows and wildcard abuse bounded;
- relevance changes evaluated against corpus.

### Failure scenarios

1. Identifier field analyzed into tokens.
2. Dynamic mapping chooses wrong type.
3. Query analyzer differs unexpectedly from index analyzer.
4. Refresh delay interpreted as lost write.
5. Old event overwrites newer document.
6. Deleted source document remains searchable.
7. Reindex alias switched before completion.
8. Authorization filter omitted.
9. Deep offset pagination becomes expensive/inconsistent.
10. Fuzzy/wildcard query explodes work.
11. Score treated as calibrated probability.
12. Search index used as only source of truth.

## Самопроверка

1. What is an inverted index?
2. Analyzed text versus keyword?
3. What does analyzer do?
4. BM25 score means what?
5. Filter versus scored query?
6. Why search visibility may be delayed?
7. How derived index stays consistent?
8. Why versioned idempotent indexing matters?
9. How reindex/alias switch works?
10. PostgreSQL FTS versus dedicated engine?

## Результат для базы знаний

- **Inverted index and postings lists**.
- **Text analyzers and tokenization**.
- **Exact and full-text fields**.
- **BM25 and relevance evaluation**.
- **Near-real-time refresh and segments**.
- **Database-to-search derived index**.
- **Idempotent indexing and reconciliation**.
- **Reindexing and search pagination**.

## Когда переходить дальше

Можно переходить, когда query semantics and relevance are tested, source/index divergence is detectable and repairable, and reindex preserves authorized searchable results.