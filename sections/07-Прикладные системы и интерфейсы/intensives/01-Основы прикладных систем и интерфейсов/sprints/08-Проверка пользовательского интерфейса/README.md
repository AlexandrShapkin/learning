# Спринт 08. Проверка пользовательского интерфейса

Ориентировочный объём: 13–19 часов.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 01–07.

## Исходная задача

Создать `work/interface-checkpoint/` — accessible responsive browser client for a synthetic multi-tenant task/order application against a deterministic fake API.

## Обязательные сценарии

- list and search;
- detail navigation;
- create and edit form;
- optimistic status update with conflict;
- destructive confirmation dialog;
- permission denied;
- not found;
- slow request and stale data;
- offline/network failure;
- malformed server payload;
- browser back/forward and reload;
- keyboard-only complete workflow.

## Requirements

### Structure and accessibility

- semantic landmarks and heading hierarchy;
- skip link and visible focus;
- native links, buttons and form controls;
- accessible names, hints and errors;
- dialog focus entry/trap/escape/return;
- no color-only status;
- automated accessibility scan plus manual keyboard check.

### Responsive behavior

- narrow, medium and wide layouts;
- 200% zoom;
- long translated strings;
- reduced motion;
- no unintended page-level horizontal scrolling;
- stable loading/media layout.

### State and navigation

- URL-backed filters and selected page;
- reloadable/shareable routes;
- stable back/forward behavior;
- discriminated UI/request states;
- one owner for every mutable value;
- effects cleaned and bounded;
- no stale response overwrite.

### Data interaction

- runtime validation of unknown payloads;
- cancellation and deduplication;
- retry taxonomy;
- field and summary validation errors;
- optimistic rollback/reconciliation;
- idempotency identifier for repeated mutation;
- cursor pagination without duplicate rendering.

## Tests

- pure logic unit tests;
- component tests by accessible role/name;
- runtime decoder tests;
- router/history tests;
- keyboard and accessibility checks;
- browser tests in Chromium and Firefox;
- viewport/locale/time-zone matrix;
- slow/offline/malformed/conflict scenarios.

## Blind cases

Randomly select at least eight:

1. unstable list key moves form state;
2. old request overwrites current query;
3. filter missing from query cache key;
4. dialog focus is lost;
5. keyboard action unavailable;
6. error communicated only by color;
7. route state disappears after reload;
8. optimistic update remains after conflict;
9. duplicate submit;
10. malformed payload accepted by type assertion;
11. long translation clips controls;
12. retry loop during authentication/network failure.

## Defense

1. User journey versus component tree?
2. Semantic HTML versus ARIA?
3. How event propagation affects components?
4. Which state belongs in URL?
5. Derived versus stored client state?
6. Why runtime validation is required with TypeScript?
7. How cancellation prevents stale responses?
8. When optimistic update is acceptable?
9. What makes an error message contextual?
10. Which manual accessibility checks remain necessary?
11. How responsive layout survives content growth?
12. Which evidence proves the user-visible result?

## Критерии прохождения

- clean install/build/test succeeds;
- all required journeys work by keyboard;
- semantic/accessibility checks pass;
- browser history and URLs remain correct;
- slow/offline/conflict/malformed cases preserve context;
- no stale or duplicate mutation is silently accepted;
- eight blind cases are diagnosed and repaired;
- tests avoid implementation-only selectors;
- at least 10 of 12 defense answers are correct.

## Результат для базы знаний

Checkpoint-specific note не требуется. Исправить existing notes if browser evidence contradicted the prior model.