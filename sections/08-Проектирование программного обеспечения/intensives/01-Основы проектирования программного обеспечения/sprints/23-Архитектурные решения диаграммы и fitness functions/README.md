# Спринт 23. Архитектурные решения, диаграммы и fitness functions

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как фиксировать architecture so that decisions, context and boundaries remain understandable and executable rather than becoming stale diagrams and ceremonial documents?

## Результат спринта

После завершения необходимо уметь:

- писать concise Architecture Decision Records;
- фиксировать context, decision, alternatives and consequences;
- различать decision, rule, assumption and observation;
- обновлять/supersede decisions without rewriting history;
- использовать C4-like context, container and component views;
- создавать sequence/data-flow/deployment views only where useful;
- выбирать view by stakeholder question;
- избегать one giant universal diagram;
- связывать diagrams with source and generation commands;
- создавать architecture fitness functions;
- проверять import/dependency/data/API rules automatically;
- измерять cycle, forbidden dependency and contract drift;
- тестировать quality scenarios where automatable;
- понимать limitations of static architecture tests;
- проводить decision review by trigger, not calendar bureaucracy;
- поддерживать traceability from driver to ADR, code and test.

## Основной маршрут

### Шаг 1. ADRs

For five major decisions create records:

```text
status/date/owners
context and drivers
decision
alternatives and rejection reasons
positive/negative consequences
assumptions and risks
validation evidence
review/supersede trigger
```

### Шаг 2. Views

Create only views needed to answer:

- what system and actors exist;
- which deployable/runtime containers exist;
- which modules/components own responsibilities/data;
- how a critical scenario flows;
- where trust and failure boundaries lie.

### Шаг 3. Fitness functions

Implement checks for:

- forbidden Go imports;
- dependency cycles;
- module public/internal boundary;
- cross-module table access convention;
- OpenAPI/protobuf compatibility;
- maximum synchronous dependency chain or explicit allowlist;
- critical quality scenario smoke tests.

### Шаг 4. Drift exercise

Intentionally violate one boundary and one contract. Ensure checks fail with actionable message, then repair.

## Ресурсы

- Architecture Decision Records by Michael Nygard.
- C4 model documentation.
- *Documenting Software Architectures* selected views.
- *Building Evolutionary Architectures* fitness functions.
- Go AST/packages tooling documentation.

## Практические задания

1. Write ADR for modular monolith versus services.
2. Supersede one ADR after new evidence.
3. Draw context/container/component plus one sequence view.
4. Generate dependency diagram from code and compare with intended view.
5. Implement forbidden-import and cycle checks.
6. Add contract compatibility and quality-scenario checks.
7. Remove one diagram/document that answers no stakeholder question.

## Лабораторная работа

Создать `work/architecture-evidence/`.

### Required artifacts

- `adr/` with at least eight concise decisions;
- context, container and component diagrams as text source;
- sequence diagram for critical workflow;
- module/data ownership map;
- architecture rule tests;
- contract compatibility tests;
- quality-scenario fitness checks;
- traceability index from driver → decision → code/check.

### Requirements

- ADRs record rejected alternatives and negative consequences;
- historical decisions are superseded, not silently rewritten;
- diagrams include scope, legend and version/source;
- generated/source diagrams can be reproduced;
- diagrams match actual runtime/dependency evidence;
- architecture tests fail on deliberate violations;
- failure messages identify rule and remediation context;
- rules have exceptions through explicit reviewed allowlist/ADR;
- fitness functions are stable enough for CI and do not use noisy vanity metrics;
- manual review remains for semantic qualities static tools cannot prove;
- no duplicated documentation of facts derivable directly from code unless it explains intent.

### Failure scenarios

1. ADR contains decision but no context/trade-off.
2. ADR is written after implementation as justification theater.
3. Old ADR is edited to hide changed assumptions.
4. Diagram uses ambiguous boxes/arrows and no scope.
5. Intended architecture diagram differs from import/runtime flow.
6. Architecture test checks naming only and misses re-export/backdoor.
7. Fitness threshold is arbitrary/noisy and blocks harmless change.
8. Exceptions accumulate without decision/expiry trigger.
9. One giant diagram attempts to serve all audiences.
10. Documentation duplicates implementation details and becomes stale.
11. Static check claims to prove semantic data ownership it cannot observe.

## Самопроверка

1. ADR records what?
2. Decision versus rule/assumption/observation?
3. Why supersede rather than rewrite?
4. Context/container/component views answer what?
5. Which view fits runtime scenario?
6. Fitness function means what?
7. What architecture rules can imports enforce?
8. What static tools cannot prove?
9. How handle exceptions?
10. How trace driver to implementation/evidence?

## Результат для базы знаний

- **Architecture Decision Records**.
- **Context, container, component and dynamic views**.
- **Architecture documentation by stakeholder question**.
- **Architecture fitness functions**.
- **Dependency, boundary and contract architecture tests**.
- **Decision supersession and evidence traceability**.
- **Architecture documentation drift**.

## Когда переходить дальше

Можно переходить, когда decisions and views explain real trade-offs, at least three architectural boundaries are executable checks, and deliberate drift is detected with actionable evidence.