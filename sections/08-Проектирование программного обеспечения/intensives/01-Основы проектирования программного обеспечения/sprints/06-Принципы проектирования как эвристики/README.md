# Спринт 06. Принципы проектирования как эвристики

Ориентировочный объём: 17–24 часа.

## Центральный вопрос

Как использовать SOLID, DRY, KISS, YAGNI, Law of Demeter and CQS as diagnostic tools without turning them into contradictory slogans?

## Результат спринта

После завершения необходимо уметь:

- объяснять SRP as reason-to-change/cohesion heuristic;
- понимать OCP through stable variation points, not speculative extensibility;
- применять substitutability to observable contracts;
- проектировать narrow interfaces by client need;
- использовать dependency inversion selectively;
- различать knowledge duplication and textual duplication;
- понимать when duplication is cheaper than wrong abstraction;
- применять KISS against unnecessary mechanisms;
- применять YAGNI against unsupported future requirements;
- использовать Law of Demeter as coupling signal;
- применять command-query separation;
- распознавать principle conflicts and trade-offs;
- находить cargo-cult layering, interface proliferation and pattern obsession;
- выбирать simplest design satisfying current quality scenarios;
- проверять principle claim through change and test evidence;
- формулировать exceptions explicitly.

## Основной маршрут

### Шаг 1. Principle-to-symptom map

For each principle record:

```text
problem it detects
observable symptom
common over-application
counterexample
change scenario that validates it
```

### Шаг 2. Conflicting heuristics

Analyze examples:

- DRY versus independent bounded contexts;
- OCP versus YAGNI;
- SRP versus excessive fragmentation;
- abstraction versus KISS;
- interface segregation versus discoverability;
- CQS versus inherently transactional operations returning results.

### Шаг 3. Refactoring experiments

Take the same code smell and create two alternative designs. Evaluate by concrete future changes and invariant safety, not by counting principles satisfied.

### Шаг 4. Design decision

Write a short decision: context, forces, selected principle, conflicting principle, evidence and exit condition.

## Ресурсы

- Original/authoritative writings behind SOLID and related principles where available.
- *Agile Software Development, Principles, Patterns, and Practices*, selected design principles.
- *A Philosophy of Software Design* as contrasting perspective.
- *Refactoring* and Go API guidance.

## Практические задания

1. Find one SRP violation and one false-positive caused by small size bias.
2. Remove wrong abstraction created by premature DRY.
3. Introduce a real extension point for two demonstrated variants.
4. Test substitutability of two adapters by behavior/contract.
5. Split one broad interface by consumers.
6. Simplify an overengineered pattern/framework path.
7. Document one justified violation of a named principle.

## Лабораторная работа

Создать `work/design-heuristics/`.

### Cases

- pricing rules with likely variation;
- notification channels;
- persistence adapters;
- reporting formats;
- order state transition;
- duplicated validation across bounded contexts;
- broad service interface used by three clients.

### Requirements

- every change names an observed symptom;
- at least two alternatives are implemented for three cases;
- future variation is demonstrated, not invented;
- substitutability includes errors, atomicity and performance-relevant limits where applicable;
- duplicated code is classified as duplicated knowledge or coincidental similarity;
- interface splits follow client usage;
- no principle is used as sole justification;
- exceptions state why and when they should be revisited;
- final design is evaluated by change locality and behavioral tests.

### Failure scenarios

1. SRP means “one method per type”.
2. OCP creates plugin architecture for one known case.
3. LSP is checked only by matching method signatures.
4. ISP creates dozens of one-method interfaces with no consumers.
5. DIP requires interfaces around standard stable value types/functions.
6. DRY merges similar concepts from different contexts and couples evolution.
7. KISS becomes excuse for ignoring known failure/quality requirements.
8. YAGNI removes required compatibility or migration seam.
9. Law of Demeter wrappers merely forward long chains.
10. CQS is applied mechanically to commands that must return created identity/result.

## Самопроверка

1. SRP detects what?
2. OCP requires which evidence?
3. Substitutability includes which behaviors?
4. Interface segregation is driven by whom?
5. Dependency inversion is useful when?
6. Knowledge duplication versus textual duplication?
7. When duplication is safer than abstraction?
8. KISS versus ignoring complexity?
9. YAGNI versus planned compatibility seam?
10. How resolve conflicting principles?

## Результат для базы знаний

- **Design principles as contextual heuristics**.
- **SRP and reasons to change**.
- **OCP and demonstrated variation points**.
- **Behavioral substitutability**.
- **Client-driven interface segregation**.
- **Knowledge duplication and wrong abstraction**.
- **KISS, YAGNI and explicit exceptions**.
- **Law of Demeter and command-query separation**.

## Когда переходить дальше

Можно переходить, когда principles are tied to observed symptoms and change scenarios, and at least one over-applied principle has been reversed with better evidence.