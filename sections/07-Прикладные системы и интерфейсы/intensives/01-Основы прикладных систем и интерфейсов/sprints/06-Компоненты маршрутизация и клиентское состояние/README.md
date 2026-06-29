# Спринт 06. Компоненты, маршрутизация и клиентское состояние

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как разделить browser interface into reusable components and routes without scattering ownership of state, effects and accessibility behavior?

## Результат спринта

После завершения необходимо уметь:

- определять component boundary by responsibility;
- различать props/input, local state, derived state and external state;
- избегать duplicated derived state;
- понимать render/effect lifecycle in the chosen framework;
- использовать stable identity and keys correctly;
- проектировать controlled and uncontrolled form elements;
- разделять route state, URL state and transient UI state;
- создавать nested routes and not-found/error routes;
- сохранять browser back/forward semantics;
- применять state lifting only to nearest shared owner;
- использовать context/global store only for genuinely shared concerns;
- проектировать component composition over configuration explosion;
- управлять focus after route/dialog changes;
- избегать effect loops and stale subscriptions;
- тестировать components through user-observable behavior;
- понимать hydration/server-rendering overview without making it mandatory.

## Основной маршрут

### Шаг 1. Component model

Rebuild the framework-free client in React or equivalent. Components keep semantics from earlier sprints; framework does not justify replacing native elements.

### Шаг 2. State ownership

For every value ask:

```text
who owns it
who changes it
can it be derived
must it survive navigation/reload
must it be shareable in URL
is it server state
```

### Шаг 3. Routing

Map routes to resources and workflows. Query/filter/page state belongs in URL when sharing/bookmarking matters.

### Шаг 4. Effects

Effects synchronize with external systems. Pure derivations belong in render/computation, not effects. Subscriptions/timers require cleanup.

## Ресурсы

- React official documentation on components, state and effects.
- Router official documentation used in the lab.
- MDN History and URL APIs.
- Testing Library principles.

## Практические задания

1. Split list/detail/form UI into components with explicit ownership.
2. Remove duplicated derived state.
3. Implement nested routes and URL-backed filters.
4. Reproduce unstable key and stale effect bugs.
5. Add focus behavior after navigation and dialog actions.
6. Compare local state, URL state and shared context.

## Лабораторная работа

Создать `work/component-client/`.

### Screens

- authenticated shell;
- searchable list with URL filters;
- detail page;
- create/edit form;
- modal confirmation;
- notification area;
- not-found, permission and generic error pages.

### Requirements

- component APIs are typed;
- semantic HTML/accessibility from sprints 03–04 preserved;
- route URLs are stable and reloadable;
- back/forward restores expected view state;
- server data is not copied into unrelated local state without reason;
- derived totals/labels are computed, not synchronized by effect;
- effects have cleanup and complete dependencies;
- list keys reflect stable entity identity;
- focus moves predictably on route/error/dialog transitions;
- component tests use roles/names rather than implementation selectors;
- no global store for purely local state.

### Failure scenarios

1. Array index key moves input state to wrong row.
2. Prop copied to state and becomes stale.
3. Effect writes state that retriggers itself.
4. Filter state disappears on refresh/share.
5. Route change leaves focus on removed element.
6. Context update rerenders entire app unnecessarily.
7. Modal state is owned by unrelated global singleton.
8. Client route blocks normal link/open-in-new-tab behavior.
9. Component test passes while accessible name is missing.
10. Loading/error booleans create impossible combined state.

## Самопроверка

1. What defines a component boundary?
2. Local versus derived state?
3. Route/URL state belongs where?
4. What is stable list key?
5. Controlled versus uncontrolled input?
6. What is effect for?
7. Why cleanup matters?
8. When context/global store is justified?
9. Composition versus large configurable component?
10. How route change affects focus?

## Результат для базы знаний

- **Frontend component boundaries**.
- **Local, derived, URL and server state**.
- **Stable identity and list keys**.
- **Client-side routing and browser history**.
- **Effects as external synchronization**.
- **Component composition and state ownership**.
- **Focus management during route transitions**.

## Когда переходить дальше

Можно переходить, когда every state value has one clear owner, URL/back-forward behavior is correct, and effects exist only for external synchronization with verified cleanup.