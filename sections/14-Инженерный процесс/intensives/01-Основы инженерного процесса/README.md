# Основы инженерного процесса

Основной интенсив раздела «Инженерный процесс». Его цель — научиться проектировать и улучшать путь изменения программной системы: от обнаружения проблемы и принятия решения до интеграции, проверки, поставки, сопровождения и накопления организационного знания.

Практика выполняется на одном synthetic Go-продукте и его engineering system:

- small web/API application with PostgreSQL;
- issue and change specifications in Markdown;
- Git branches, commits and pull-request simulations;
- automated tests, static analysis and CI;
- RFC, ADR, runbook and contributor documentation;
- ownership and review rules;
- flow/quality metrics generated from synthetic history;
- deliberately flawed requirements, reviews, tests and process policies.

## Результат прохождения

После завершения необходимо уметь самостоятельно:

- описывать engineering lifecycle from discovery to operation and retirement;
- превращать observed problem into outcome and falsifiable hypothesis;
- отделять requirements from implementation decisions;
- фиксировать constraints, assumptions, risks and open questions;
- формулировать functional, quality, operational and compliance requirements;
- писать acceptance criteria and completion evidence;
- поддерживать traceability without bureaucratic duplication;
- slicing large changes by user value, risk and learning;
- выбирать research, spike, prototype, experiment, RFC and ADR;
- приоритизировать using value, urgency, risk reduction and cost of delay;
- estimate ranges and forecast completion using throughput/history;
- identify dependencies, critical path and integration risk;
- limit WIP and manage queues, blocked work and expedite cases;
- plan and replan under changing information;
- understand Git objects, history and integration strategies;
- create atomic, reviewable commits and reversible changes;
- design branch, merge and release policies suited to team context;
- write focused pull requests and conduct evidence-based review;
- manage code ownership, maintainership and review load;
- create risk-based test strategy and layered verification;
- choose unit, integration, contract, end-to-end and exploratory tests;
- use CI checks, static analysis and quality gates proportionately;
- prevent defect recurrence through root-cause and system changes;
- write documentation for users, contributors, operators and decision makers;
- use RFC, ADR and technical specifications appropriately;
- design onboarding, handoff and knowledge-transfer paths;
- clarify roles, ownership, escalation and team interfaces;
- communicate decisions, uncertainty and feedback effectively;
- interpret lead time, cycle time, WIP, throughput, change-failure and recovery metrics;
- detect metric gaming and local optimization;
- run retrospectives and improvement experiments;
- manage technical and process debt explicitly;
- standardize and automate repeated high-value work;
- review the engineering process as a feedback system.

Целевой уровень: 3 по всему разделу и 4 по problem framing, requirements/decomposition, Git collaboration, quality strategy, technical decisions, flow analysis and systemic process improvement.

## Границы

Интенсив не заменяет:

- product-management specialization;
- people-management apprenticeship;
- Scrum/Kanban certification;
- project-management certification;
- organization-specific legal/compliance procedures;
- deep software architecture course;
- CI/CD and production operations specialization;
- language-specific testing specialization;
- large-enterprise transformation practice.

The route avoids ceremony for its own sake. Every artifact must reduce uncertainty, enable coordination, preserve evidence or improve a real decision.

## Предварительные знания

Рекомендуется завершить основные интенсивы 01–13.

Минимально необходимы:

- Go application development and testing;
- Git command-line basics;
- pull-request and CI concepts;
- software architecture and API basics;
- deployment and operational lifecycle basics;
- logs, incidents and recovery concepts;
- ability to read technical English.

## Лабораторное окружение

Default laboratory:

- Linux host or VM;
- Go, Git, Bash, Make, jq and yq;
- GitHub CLI or equivalent optional;
- Docker/Podman and PostgreSQL;
- Markdown, Mermaid/PlantUML optional;
- `golangci-lint`, `staticcheck`, `govulncheck`;
- test, coverage, benchmark and race tooling;
- local CI runner or GitHub Actions workflow files;
- scripts for generating synthetic issue/PR/change history;
- optional SQLite/Python for metric analysis;
- optional Backstage-like catalogue or CODEOWNERS examples.

Подробности: [`LAB_ENVIRONMENT.md`](LAB_ENVIRONMENT.md).

Проверка:

```bash
bash scripts/check-environment.sh
```

## Принципы прохождения

1. Start from a problem and expected outcome, not from a tool or ceremony.
2. Requirements describe observable behavior and constraints, not hidden implementation preferences.
3. Decomposition should produce independently verifiable learning or value.
4. Estimates are ranges and forecasts, not promises detached from uncertainty.
5. WIP is limited to expose queues and finish work before starting more.
6. Git history should explain why and allow safe reversal.
7. Review focuses on risk, correctness and maintainability, not personal style.
8. Tests and gates are selected by failure cost and feedback speed.
9. Documentation has a reader, decision or task; stale duplication is removed.
10. Metrics support questions and experiments; they are not individual performance targets.
11. Retrospectives produce small owned experiments, not generic action lists.
12. Automation follows repeated, understood work rather than automating confusion.
13. General mechanisms move to `knowledge`; synthetic artifacts and experiments remain in `learning`.

## Основной стек

- Go and PostgreSQL;
- Git and GitHub-style collaboration;
- Markdown, Mermaid/PlantUML optional;
- Make and Bash;
- Go test, race, coverage, fuzzing and benchmarks;
- staticcheck/golangci-lint/govulncheck;
- GitHub Actions or local CI simulation;
- jq/yq and optional Python/SQLite for metrics.

## Порядок спринтов

1. [Жизненный цикл инженерного изменения](sprints/01-Жизненный%20цикл%20инженерного%20изменения/)
2. [Проблема, outcome и проверяемая гипотеза](sprints/02-Проблема%20outcome%20и%20проверяемая%20гипотеза/)
3. [Требования, ограничения и assumptions](sprints/03-Требования%20ограничения%20и%20assumptions/)
4. [Acceptance criteria, готовность и traceability](sprints/04-Acceptance%20criteria%20готовность%20и%20traceability/)
5. [Декомпозиция и vertical slicing](sprints/05-Декомпозиция%20и%20vertical%20slicing/)
6. [Research, spike, prototype и experiment](sprints/06-Research%20spike%20prototype%20и%20experiment/)
7. [Проверка постановки и декомпозиции](sprints/07-Проверка%20постановки%20и%20декомпозиции/)
8. [Приоритизация, value, risk и cost of delay](sprints/08-Приоритизация%20value%20risk%20и%20cost%20of%20delay/)
9. [Оценки, uncertainty и forecasting](sprints/09-Оценки%20uncertainty%20и%20forecasting/)
10. [Dependencies, critical path и integration risk](sprints/10-Dependencies%20critical%20path%20и%20integration%20risk/)
11. [Flow, queues, WIP и blocked work](sprints/11-Flow%20queues%20WIP%20и%20blocked%20work/)
12. [Планирование, replanning и delivery coordination](sprints/12-Планирование%20replanning%20и%20delivery%20coordination/)
13. [Проверка планирования и потока](sprints/13-Проверка%20планирования%20и%20потока/)
14. [Git object model, history и recovery](sprints/14-Git%20object%20model%20history%20и%20recovery/)
15. [Commits, branching и integration strategies](sprints/15-Commits%20branching%20и%20integration%20strategies/)
16. [Pull requests и code review](sprints/16-Pull%20requests%20и%20code%20review/)
17. [Ownership, maintainership и merge flow](sprints/17-Ownership%20maintainership%20и%20merge%20flow/)
18. [Проверка совместной разработки](sprints/18-Проверка%20совместной%20разработки/)
19. [Стратегия качества и risk-based testing](sprints/19-Стратегия%20качества%20и%20risk-based%20testing/)
20. [Unit, integration, contract и end-to-end tests](sprints/20-Unit%20integration%20contract%20и%20end-to-end%20tests/)
21. [CI checks, static analysis и quality gates](sprints/21-CI%20checks%20static%20analysis%20и%20quality%20gates/)
22. [Defect prevention, root cause и recurrence](sprints/22-Defect%20prevention%20root%20cause%20и%20recurrence/)
23. [Documentation as code и information architecture](sprints/23-Documentation%20as%20code%20и%20information%20architecture/)
24. [RFC, ADR и technical specification](sprints/24-RFC%20ADR%20и%20technical%20specification/)
25. [Knowledge transfer, onboarding и handoff](sprints/25-Knowledge%20transfer%20onboarding%20и%20handoff/)
26. [Проверка качества и инженерного контекста](sprints/26-Проверка%20качества%20и%20инженерного%20контекста/)
27. [Roles, ownership и team interfaces](sprints/27-Roles%20ownership%20и%20team%20interfaces/)
28. [Communication, feedback и decision making](sprints/28-Communication%20feedback%20и%20decision%20making/)
29. [Flow, quality и delivery metrics](sprints/29-Flow%20quality%20и%20delivery%20metrics/)
30. [Retrospectives и improvement experiments](sprints/30-Retrospectives%20и%20improvement%20experiments/)
31. [Technical debt, standardization и automation](sprints/31-Technical%20debt%20standardization%20и%20automation/)
32. [Системный review инженерного процесса](sprints/32-Системный%20review%20инженерного%20процесса/)
99. [Итоговая работа](sprints/99-Итоговая%20работа/)

## Покрытие основных вопросов

| Вопрос | Спринты |
|---|---|
| Как превратить потребность в проверяемую задачу? | 01–07 |
| Какие требования и критерии завершения нужны? | 03–07 |
| Как декомпозировать крупное изменение? | 05–07, 10–13 |
| Как управлять uncertainty, risk and dependencies? | 06, 08–13 |
| Как организовать Git, branches and review? | 14–18 |
| Какие проверки нужны до готовности? | 19–22, 26 |
| Когда использовать spike, RFC или ADR? | 06, 23–26 |
| Как сохранять и передавать контекст? | 23–28 |
| Как определить ownership and team interfaces? | 17, 25, 27–28 |
| Как измерять flow without gaming? | 11–13, 29–32 |
| Как находить причины задержек и дефектов? | 22, 29–32 |
| Что стандартизировать и автоматизировать? | 21, 23, 29–32 |

## Итоговая работа

Финальный проект — `engineering-system-lab`: complete engineering change from problem discovery through implementation, review, verification, delivery evidence, documentation and process improvement.

Система должна позволять:

- frame a measurable problem and outcome;
- maintain requirements, constraints and acceptance evidence;
- slice work into small releasable changes;
- plan under uncertainty and visible dependencies;
- create clean Git history and focused pull requests;
- perform structured multi-perspective reviews;
- execute layered tests and proportionate CI gates;
- preserve decisions through RFC/ADR and current documentation;
- assign ownership and coordinate interfaces;
- measure flow and quality from synthetic history;
- diagnose delays, rework and defects;
- run and evaluate improvement experiments;
- use read-only `engtriage` to reconstruct change state.

## Вклад в базу знаний

Each sprint names exact recommended notes. General mechanisms move to `knowledge`; issue/PR histories, experiments, scripts and review evidence remain in `learning`.

## Общая библиография

Books, standards and official documentation are listed in [`RESOURCES.md`](RESOURCES.md). Each sprint identifies the required minimum route.
