# Спринт 12. Единый язык и ограниченные контексты

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как разделить large domain into contexts where terms, models and rules remain coherent, and how to translate between contexts without a universal shared model?

## Результат спринта

После завершения необходимо уметь:

- понимать ubiquitous language as context-specific working language;
- выявлять homonyms and overloaded terms;
- различать subdomain and bounded context;
- определять context boundary by model, ownership and change;
- строить context map;
- различать upstream/downstream relationships;
- понимать partnership, customer-supplier, conformist, published language and ACL patterns;
- избегать shared database/model as accidental context coupling;
- проектировать translation and anti-corruption boundary;
- выбирать duplicated concepts versus shared kernel;
- понимать shared kernel governance cost;
- связывать contexts with modules and teams cautiously;
- проектировать cross-context IDs and references;
- определять ownership of source data and derived copies;
- управлять semantic evolution and contract compatibility;
- проверять boundaries through change scenarios and dependency rules.

## Основной маршрут

### Шаг 1. Language discovery

For concepts such as `Order`, `Customer`, `Product`, `Status`, `Price`, `Account` collect meanings across fulfillment, catalog, billing and support. Mark where same word has different lifecycle/rules.

### Шаг 2. Context candidates

Define candidate contexts:

- Work Management;
- Catalog/Inventory;
- Billing;
- Fulfillment;
- Identity/Access;
- Support/Reporting.

For each state model, owner, source data, incoming/outgoing contracts and independent changes.

### Шаг 3. Context map

Draw relationships and select integration pattern. A bounded context is not automatically a service or repository.

### Шаг 4. Translation

Implement one ACL translating external/upstream language into local types and one published contract between contexts.

## Ресурсы

- *Domain-Driven Design*, strategic design chapters.
- Context Mapping references.
- *Implementing Domain-Driven Design*, bounded contexts and context maps.
- Integration contract material from application/data intensives.

## Практические задания

1. Find five overloaded terms and define context-specific meanings.
2. Separate two conflicting models previously sharing one type.
3. Draw context map with upstream/downstream relationships.
4. Implement anti-corruption adapter for external billing/provider model.
5. Compare duplicated values with shared kernel for one concept.
6. Test independent evolution of two contexts.

## Лабораторная работа

Создать `work/bounded-contexts/`.

### Requirements

- every context has explicit purpose, language and owner of truth;
- same word may have separate types when semantics differ;
- contexts do not import each other’s internal packages;
- cross-context communication uses explicit contract/translation;
- shared kernel, if used, is tiny and has coordinated ownership/change rules;
- database ownership is explicit; cross-context direct table access is eliminated in target path;
- IDs/references do not imply shared mutable object graph;
- context map identifies power/dependency direction;
- one upstream incompatible change is absorbed by ACL or contract migration;
- change scenarios show reduced semantic coupling;
- context boundaries are not forced to equal deployment boundaries.

### Failure scenarios

1. One canonical `Order`/`User` model is shared by all contexts.
2. Context boundaries are copied from organization chart without model evidence.
3. Every package is called bounded context.
4. Each bounded context becomes microservice prematurely.
5. Shared kernel grows into global common model.
6. Downstream imports upstream internal type and fields.
7. Direct database query bypasses published contract.
8. ACL only renames fields but leaks upstream semantics/policy.
9. Context map ignores ownership and change direction.
10. Duplicated data is treated as error despite independent semantics/lifecycle.

## Самопроверка

1. Ubiquitous language is global or contextual?
2. Subdomain versus bounded context?
3. What evidence suggests a context boundary?
4. Bounded context versus service/module?
5. Context map shows what?
6. Upstream versus downstream?
7. Anti-corruption layer protects what?
8. Shared kernel cost?
9. Why duplicated concepts may be correct?
10. How independent change validates a boundary?

## Результат для базы знаний

- **Ubiquitous language within a bounded context**.
- **Subdomain and bounded context**.
- **Context mapping and relationship patterns**.
- **Published language and anti-corruption layer**.
- **Shared kernel and duplicated concepts**.
- **Data/model ownership across contexts**.
- **Bounded context versus deployment boundary**.
- **Semantic compatibility between contexts**.

## Когда переходить дальше

Можно переходить, когда conflicting meanings no longer share one internal model, cross-context dependencies are explicit/translated, and two contexts can evolve through tested contracts rather than coordinated internal changes.