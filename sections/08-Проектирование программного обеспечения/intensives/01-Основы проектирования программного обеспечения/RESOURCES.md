# Ресурсы интенсива

Это общая библиография. В каждом спринте указан минимальный обязательный маршрут. Не требуется читать все книги подряд.

## Управление сложностью и качество кода

- *A Philosophy of Software Design*, John Ousterhout.
- *Code Complete*, Steve McConnell, selected design/construction chapters.
- *Clean Code*, Robert C. Martin — читать критически and verify by change scenarios.
- *The Practice of Programming*, Kernighan and Pike.
- Go Code Review Comments, Effective Go and standard library source.
- *Software Design: Creating Solutions for Ill-Structured Problems*, David Budgen, selected sections.

## Refactoring and legacy code

- *Refactoring*, Martin Fowler.
- *Working Effectively with Legacy Code*, Michael Feathers.
- *Refactoring to Patterns*, Joshua Kerievsky, selected examples.
- *Your Code as a Crime Scene*, Adam Tornhill, selected change-history techniques.
- Git documentation for history, bisect and patch-based change analysis.

## Модульность, зависимости и components

- *Structured Design*, Yourdon and Constantine, cohesion/coupling concepts.
- *Designing Software Architectures*, Cervantes and Kazman, selected design/evaluation material.
- *Building Evolutionary Architectures*, Ford, Parsons and Kua.
- *Fundamentals of Software Architecture*, Richards and Ford.
- *Software Architecture in Practice*, Bass, Clements and Kazman.
- Go package and module documentation; `go list` and `go/packages` documentation.

## Object and domain modeling

- *Domain-Driven Design*, Eric Evans.
- *Implementing Domain-Driven Design*, Vaughn Vernon, selected tactical/strategic patterns.
- *Domain Modeling Made Functional*, Scott Wlaschin — conceptual comparison, despite F# examples.
- *Patterns, Principles, and Practices of Domain-Driven Design*, Millett and Tune.
- Martin Fowler’s analysis patterns and domain-model articles as secondary references.

## Design patterns

- *Design Patterns*, Gamma, Helm, Johnson and Vlissides.
- *Head First Design Patterns* as a practical secondary source.
- *Patterns of Enterprise Application Architecture*, Martin Fowler.
- *Enterprise Integration Patterns*, Hohpe and Woolf, selected integration patterns.
- Go standard library and mature open-source code for idiomatic adaptations.

## Architectural styles

- *Clean Architecture*, Robert C. Martin — use as one dependency-rule perspective, not universal template.
- *Hexagonal Architecture* writings by Alistair Cockburn.
- *Onion Architecture* and ports/adapters references.
- *Monolith to Microservices*, Sam Newman.
- *Building Microservices*, Sam Newman, selected decomposition/evolution chapters.
- *Release It!*, Michael Nygard, selected stability/integration sections.
- *Designing Data-Intensive Applications*, Kleppmann, selected messaging and data-boundary chapters.

## Modular monoliths and bounded contexts

- Modular-monolith writings and examples from recognized practitioners, validated against source code and tests.
- Context Mapping and bounded-context material from DDD references.
- Team Topologies, Skelton and Pais, only where organizational boundaries affect architecture.
- Context Mapper and related tools optional; hand-written maps remain sufficient.

## Integration and contract evolution

- HTTP/OpenAPI/Protocol Buffers specifications from the application intensive.
- *Enterprise Integration Patterns*.
- Consumer-driven contract and schema-evolution documentation for selected tools.
- PostgreSQL migration and transaction documentation.
- Message broker official docs for delivery/ordering semantics.
- Anti-corruption layer and published-language patterns from DDD.

## Architecture decisions and documentation

- Architecture Decision Records by Michael Nygard.
- C4 model documentation by Simon Brown.
- *Documenting Software Architectures*, Clements et al., selected views.
- arc42 documentation template as optional reference.
- Mermaid and Graphviz documentation.
- Structurizr/C4 tooling optional; plain text/Markdown sources are sufficient.

## Architecture evaluation and quality attributes

- *Software Architecture in Practice* quality-attribute scenarios and tactics.
- ATAM overview and lightweight architecture review materials.
- *Designing Software Architectures* attribute-driven design.
- *Building Evolutionary Architectures* fitness functions.
- SRE/performance/security references from adjacent intensives when a quality scenario requires them.

## Go-specific design

- Go language specification and standard library documentation.
- Go blog and talks on package design, interfaces, errors, context and testing.
- *100 Go Mistakes and How to Avoid Them*, selected design/API chapters.
- *Learning Go* or equivalent as language reference only.
- `go vet`, staticcheck, race detector, fuzzing and benchmark docs.
- `go/packages`, `go/ast`, `go/types` docs for architecture-rule checks.

## Testing and architecture verification

- Go testing and `httptest` documentation.
- Characterization-test material from Feathers.
- Property-based and fuzz-testing references.
- Mutation testing as optional confidence experiment.
- Consumer contract tests from the application intensive.
- Architecture tests through custom package/import checks.

## Правила работы с источниками

1. Principle or pattern is tested against a concrete change/failure scenario.
2. Book examples are not copied mechanically into Go or production design.
3. Framework architecture diagrams are not accepted as evidence of actual dependency direction.
4. Metrics support a hypothesis; change simulations and tests decide.
5. Product-specific guarantees require tested version/configuration.
6. Multiple reputable viewpoints are compared for disputed architectural advice.
7. Do not copy copyrighted diagrams, chapters or proprietary architecture documents into the repository.
8. Final recommendation must state context, forces, consequences and rejected alternatives.
