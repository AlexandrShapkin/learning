# Спринт 02. Браузер, навигация, DOM и события

Ориентировочный объём: 15–22 часа.

## Центральный вопрос

Как browser превращает URL, document and user input в navigation, DOM state, event dispatch and network activity?

## Результат спринта

После завершения необходимо уметь:

- объяснять navigation, document lifecycle and history;
- различать URL, origin, site and browsing context;
- понимать DOM tree and element/property/attribute differences;
- использовать event capture, target and bubble phases;
- применять event delegation;
- понимать default actions and `preventDefault`;
- работать with History API and URL state;
- различать full navigation and client-side navigation;
- понимать form submission and browser validation lifecycle;
- использовать Fetch API with abort signals;
- понимать same-origin policy and CORS at interface level;
- различать cookies, localStorage, sessionStorage and IndexedDB conceptually;
- понимать task/microtask rendering order at practical level;
- диагностировать event/listener and stale DOM problems;
- использовать browser developer tools for DOM, network and storage.

## Основной маршрут

### Шаг 1. Navigation and origin

Trace URL entry, DNS/HTTP from previous sections, response parsing, document creation and history entry. Define origin precisely and inspect redirects.

### Шаг 2. DOM and events

Build UI without framework. Observe capture/bubble, default actions, focus events and event delegation.

### Шаг 3. Network from browser

Use forms and Fetch API. Compare navigation request, fetch request and resource loading. Cancel a request with `AbortController`.

### Шаг 4. Client persistence

Store only synthetic preferences/drafts. Compare lifecycle, capacity, security and synchronization limitations of browser storage options.

## Ресурсы

- MDN: DOM, Events, History, Fetch, Storage and CORS.
- WHATWG HTML navigation and event-loop sections.
- browser DevTools network/application documentation.

## Практические задания

1. Build a multi-page navigation flow with standard links/forms.
2. Implement event delegation for dynamic list items.
3. Add client-side route state through URL/search parameters.
4. Cancel stale search requests.
5. Compare cookie/localStorage/sessionStorage behavior across tabs/reloads.
6. Trace task/microtask/render ordering with a bounded experiment.

## Лабораторная работа

Создать `work/browser-platform/`.

### Application

Framework-free catalog/task client with:

- list/detail/create pages;
- links and browser back/forward;
- search parameters;
- dynamic list actions;
- form submission;
- cancellable live search;
- local draft/preferences.

### Requirements

- core navigation works without client router;
- URLs represent shareable page/query state;
- back/forward behavior tested;
- event listeners do not multiply after rerender;
- default browser actions are preserved unless intentionally replaced;
- fetch cancellation distinguishes abort from server/network errors;
- storage contains no authentication secret;
- cross-tab behavior is documented;
- network and event traces explain observed ordering.

### Failure scenarios

1. Click handler blocks link behavior and keyboard activation.
2. History entries duplicate or back button breaks.
3. Old search response overwrites newer query result.
4. Listener attached on every update leaks/duplicates actions.
5. Attribute/property mismatch changes form state.
6. localStorage used as secure token vault.
7. DOM update assumes element still exists.
8. Same-origin/CORS error misdiagnosed as server business error.
9. Microtask loop delays rendering.

## Самопроверка

1. Origin versus site?
2. Attribute versus DOM property?
3. Capture, target and bubble?
4. What is event delegation?
5. Default action versus event listener?
6. Full versus client-side navigation?
7. Why URL should hold shareable state?
8. Fetch abort means what?
9. Browser storage options differ how?
10. Task versus microtask practically?

## Результат для базы знаний

- **Browser navigation and history**.
- **DOM attributes and properties**.
- **Event propagation and delegation**.
- **Default browser actions**.
- **Fetch cancellation and stale responses**.
- **Origin, same-origin policy and CORS**.
- **Browser storage lifecycle and limits**.
- **Browser event loop practical model**.

## Когда переходить дальше

Можно переходить, когда navigation, URL state, events, fetch cancellation and storage behavior are demonstrated without a frontend framework.