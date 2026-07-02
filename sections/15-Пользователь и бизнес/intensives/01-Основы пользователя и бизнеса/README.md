# Основы пользователя и бизнеса

Основной интенсив раздела «Пользователь и бизнес». Его цель — научиться связывать реальные потребности людей и организаций с проверяемой продуктовой ценностью, бизнес-процессами, требованиями, аналитикой, экономикой и внедрением изменений.

Практика выполняется на одном synthetic B2B-продукте — системе управления заявками и выездными работами:

- dispatchers, field workers, managers, customers and support;
- web/API application and PostgreSQL;
- configurable workflows, business rules and notifications;
- onboarding, training and support materials;
- synthetic interviews, observations, surveys and usability sessions;
- event analytics, funnels, cohorts and experiments;
- pricing, cost, revenue and risk model;
- staged pilot, rollout and adoption evidence.

## Результат прохождения

После завершения необходимо уметь самостоятельно:

- различать users, customers, buyers, sponsors, process owners and affected stakeholders;
- анализировать stakeholder power, incentives, conflicts and decision rights;
- формулировать research questions and evidence plans;
- проводить synthetic/authorized interviews, contextual inquiry and observation;
- проектировать surveys and interpret their limits;
- сегментировать пользователей по поведению, контексту и потребностям;
- использовать jobs-to-be-done, outcomes and problem hypotheses critically;
- строить personas only from evidence and avoid fictional stereotypes;
- моделировать customer journey, moments of truth and failure paths;
- строить service blueprint across frontstage, backstage and support systems;
- оценивать usability, onboarding, accessibility and support burden;
- формулировать product vision, value proposition and strategic choices;
- строить outcome goals, metric trees and guardrail metrics;
- выбирать roadmap bets and priorities without feature-list theater;
- различать prototype, concierge test, MVP, pilot and scale rollout;
- моделировать as-is and to-be business processes;
- находить bottlenecks, handoffs, exceptions and manual controls;
- формализовать business rules, decision tables and authoritative sources;
- связывать business, user and system requirements with outcomes;
- анализировать organizational change impact and stakeholder adoption;
- проектировать event taxonomy, identities and data-quality checks;
- анализировать acquisition, activation, engagement, retention and conversion;
- использовать cohorts and segmentation without misleading aggregation;
- проектировать A/B and quasi-experiments with guardrails;
- отличать correlation from causal evidence;
- объединять support feedback, research and product analytics;
- рассчитывать revenue, gross margin, CAC, LTV, payback and contribution margin;
- оценивать TCO, ROI, NPV/payback assumptions and opportunity cost;
- моделировать operational, legal, privacy, continuity and reputational risks;
- формулировать pricing and packaging hypotheses;
- проектировать pilot, rollout, training, migration and support readiness;
- определять adoption, customer success and product health signals;
- принимать continue, pivot, scale, sunset and stop decisions;
- проводить системный review продукта и бизнес-контекста.

Целевой уровень: 3 по всему разделу и 4 по user research, product strategy, business-process analysis, requirements/outcomes, product analytics, experimentation, economics and rollout decisions.

## Границы

Интенсив не заменяет:

- professional UX research apprenticeship with real participants;
- product-design and visual-interface specialization;
- sales, marketing or finance specialization;
- legal, tax, accounting or regulatory counsel;
- executive strategy and portfolio-management experience;
- domain-expert knowledge in healthcare, finance, industrial safety or other regulated fields;
- production data-science and experimentation-platform engineering;
- real organizational change-management practice.

All research participants, company data, financials and operational histories are synthetic or explicitly authorized. No deceptive research, dark patterns or collection of unnecessary personal data is allowed.

## Предварительные знания

Рекомендуется завершить основные интенсивы 01–14.

Минимально необходимы:

- basic software and API understanding;
- ability to read logs, data tables and simple SQL;
- basic statistics: distributions, averages, proportions and uncertainty;
- requirements and engineering-process basics;
- data privacy and security fundamentals;
- ability to read technical and business English.

## Лабораторное окружение

Default laboratory:

- Linux host or VM;
- Go, Git, Bash, Make, jq and yq;
- PostgreSQL and SQLite optional;
- Python with pandas/matplotlib optional for analysis;
- Jupyter optional;
- Markdown, Mermaid/PlantUML or BPMN tooling;
- browser and accessibility inspection tools;
- local survey/interview fixtures and synthetic transcripts;
- event generator and analytics scripts;
- Docker/Podman for the reference application;
- spreadsheet support only for small financial models where code would obscure the reasoning.

Подробности: [`LAB_ENVIRONMENT.md`](LAB_ENVIRONMENT.md).

Проверка:

```bash
bash scripts/check-environment.sh
```

## Принципы прохождения

1. Start from observed behavior and context, not stakeholder opinion alone.
2. Research questions precede methods and artifacts.
3. Users, customers, buyers and owners are treated as distinct roles.
4. Evidence quality and uncertainty are stated explicitly.
5. Personas, journeys and process maps are hypotheses until validated.
6. Metrics represent behavior and outcomes, not truth by themselves.
7. Experiments require ethical scope, causal assumptions and guardrails.
8. Business cases expose assumptions and ranges rather than precise fiction.
9. Regulatory, privacy and continuity constraints are considered before rollout.
10. Adoption and support are part of the product, not post-release cleanup.
11. A roadmap is a sequence of bets and decisions, not a promise list.
12. Stop, sunset and no-build decisions are valid outcomes.
13. General mechanisms move to `knowledge`; synthetic research, models and evidence remain in `learning`.

## Основной стек

- Go and PostgreSQL reference product;
- SQL, jq and optional Python/pandas;
- Markdown and Mermaid/PlantUML/BPMN tooling;
- Docker/Compose;
- browser accessibility/dev tools;
- synthetic event generator and experiment scripts;
- optional spreadsheet for concise financial models.

## Порядок спринтов

1. [Пользователи, клиенты и заинтересованные стороны](sprints/01-Пользователи%20клиенты%20и%20заинтересованные%20стороны/)
2. [Research questions, evidence и ethics](sprints/02-Research%20questions%20evidence%20и%20ethics/)
3. [Интервью, observation и contextual inquiry](sprints/03-Интервью%20observation%20и%20contextual%20inquiry/)
4. [Опросы, sampling и количественные сигналы](sprints/04-Опросы%20sampling%20и%20количественные%20сигналы/)
5. [Сегментация, jobs и problem hypotheses](sprints/05-Сегментация%20jobs%20и%20problem%20hypotheses/)
6. [Personas, scenarios и anti-personas](sprints/06-Personas%20scenarios%20и%20anti-personas/)
7. [Customer journey и service blueprint](sprints/07-Customer%20journey%20и%20service%20blueprint/)
8. [Проверка исследования пользователей](sprints/08-Проверка%20исследования%20пользователей/)
9. [Value proposition, vision и positioning](sprints/09-Value%20proposition%20vision%20и%20positioning/)
10. [Product goals, outcomes и metric tree](sprints/10-Product%20goals%20outcomes%20и%20metric%20tree/)
11. [Strategy, roadmap и prioritization](sprints/11-Strategy%20roadmap%20и%20prioritization/)
12. [Prototype, MVP, pilot и validation](sprints/12-Prototype%20MVP%20pilot%20и%20validation/)
13. [Проверка продуктовой стратегии](sprints/13-Проверка%20продуктовой%20стратегии/)
14. [As-is и to-be business processes](sprints/14-As-is%20и%20to-be%20business%20processes/)
15. [Business rules, decisions и exceptions](sprints/15-Business%20rules%20decisions%20и%20exceptions/)
16. [Roles, events, data и sources of truth](sprints/16-Roles%20events%20data%20и%20sources%20of%20truth/)
17. [Business, user и system requirements](sprints/17-Business%20user%20и%20system%20requirements/)
18. [Stakeholder alignment и change impact](sprints/18-Stakeholder%20alignment%20и%20change%20impact/)
19. [Проверка процессов и требований](sprints/19-Проверка%20процессов%20и%20требований/)
20. [Product analytics, event taxonomy и data quality](sprints/20-Product%20analytics%20event%20taxonomy%20и%20data%20quality/)
21. [Funnels, activation, retention и cohorts](sprints/21-Funnels%20activation%20retention%20и%20cohorts/)
22. [Experiments, causality и A-B testing](sprints/22-Experiments%20causality%20и%20A-B%20testing/)
23. [Qualitative feedback, support и triangulation](sprints/23-Qualitative%20feedback%20support%20и%20triangulation/)
24. [Проверка аналитики и экспериментов](sprints/24-Проверка%20аналитики%20и%20экспериментов/)
25. [Revenue model и unit economics](sprints/25-Revenue%20model%20и%20unit%20economics/)
26. [TCO, ROI и business case](sprints/26-TCO%20ROI%20и%20business%20case/)
27. [Pricing, packaging и willingness to pay](sprints/27-Pricing%20packaging%20и%20willingness%20to%20pay/)
28. [Business risks, compliance и continuity](sprints/28-Business%20risks%20compliance%20и%20continuity/)
29. [Rollout, adoption и organizational change](sprints/29-Rollout%20adoption%20и%20organizational%20change/)
30. [Customer success, support и product operations](sprints/30-Customer%20success%20support%20и%20product%20operations/)
31. [Portfolio, scale, sunset и stop decisions](sprints/31-Portfolio%20scale%20sunset%20и%20stop%20decisions/)
32. [Системный review пользователя и бизнеса](sprints/32-Системный%20review%20пользователя%20и%20бизнеса/)
99. [Итоговая работа](sprints/99-Итоговая%20работа/)

## Покрытие основных вопросов

| Вопрос | Спринты |
|---|---|
| Кто пользователь, клиент, заказчик и владелец результата? | 01, 05–08, 18 |
| Как подтвердить проблему и потребность? | 02–08 |
| Как описать путь и проблемные точки? | 06–08, 29–30 |
| Как сформулировать ценность и стратегию? | 09–13 |
| Как описать бизнес-процесс и правила? | 14–19 |
| Как связать требования с результатом? | 10, 17–19 |
| Какие метрики подтверждают ценность и adoption? | 10, 20–24, 29–31 |
| Когда использовать prototype, MVP, pilot or experiment? | 12–13, 22–24 |
| Как оценить экономику и стоимость владения? | 25–28 |
| Как оценить риски и continuity? | 26, 28–32 |
| Как подготовить rollout and adoption? | 18, 29–30 |
| Когда масштабировать, менять или закрывать продукт? | 25–32 |

## Итоговая работа

Финальный проект — `product-business-lab`: complete product/business case for improving a synthetic field-service workflow, from research and process modeling to prototype, analytics, economics, pilot and scale/stop decision.

Система должна позволять:

- identify users, customers and decision makers;
- validate a problem through mixed research methods;
- model customer journey and business process;
- define value proposition, outcomes and strategic choice;
- produce vertical requirements and validation plan;
- instrument trustworthy product analytics;
- run one controlled experiment or pilot simulation;
- calculate unit economics, TCO and business case;
- assess privacy, operational and continuity risks;
- plan rollout, training, support and adoption;
- make evidence-based scale, pivot or stop decision;
- use read-only `biztriage` to reconstruct assumptions and evidence.

## Вклад в базу знаний

Each sprint names exact recommended notes. General mechanisms move to `knowledge`; synthetic transcripts, process maps, analytics and financial models remain in `learning`.

## Общая библиография

Books, standards and official guidance are listed in [`RESOURCES.md`](RESOURCES.md). Each sprint identifies the required minimum route.
