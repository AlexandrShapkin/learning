# Спринт 03. Семантический HTML, формы и доступность

Ориентировочный объём: 16–23 часа.

## Центральный вопрос

Как построить interface structure and interaction semantics так, чтобы приложение было понятно browser, keyboard users, assistive technologies and automated tests?

## Результат спринта

После завершения необходимо уметь:

- выбирать semantic elements by meaning, not appearance;
- строить heading and landmark structure;
- использовать links and buttons according to behavior;
- связывать labels, descriptions and validation messages with controls;
- выбирать native input types and attributes;
- проектировать keyboard navigation and visible focus;
- понимать accessibility tree conceptually;
- использовать ARIA only when native semantics are insufficient;
- управлять focus after dialogs, errors and route changes;
- создавать accessible modal/dialog, menu and disclosure patterns;
- различать required, invalid, disabled and readonly states;
- обеспечивать error summary and field-level context;
- учитывать screen-reader announcements through live regions cautiously;
- тестировать with keyboard, accessibility tree and automated checker;
- понимать that automated checks do not prove complete accessibility.

## Основной маршрут

### Шаг 1. Document semantics

Build landmarks, headings, lists, tables and navigation. Verify outline visually and through accessibility tree.

### Шаг 2. Native controls

Use links, buttons, inputs, selects, details and dialog before custom widgets. Native elements provide keyboard and form semantics.

### Шаг 3. Forms and errors

Define label, hint, required state, validation timing, submitted value, server error and focus behavior. Do not erase user input after failure.

### Шаг 4. Custom interaction

Implement one disclosure and one dialog according to WAI-ARIA Authoring Practices. Test escape, focus trap/return and background interaction.

## Ресурсы

- WHATWG HTML forms and interactive elements.
- WCAG current standard and understanding documents.
- WAI-ARIA Authoring Practices.
- MDN accessibility guides.
- axe-core documentation as automated support.

## Практические задания

1. Audit a div-based mock interface and replace it with semantic elements.
2. Build keyboard-accessible navigation and data table.
3. Implement a multi-field form with client/server errors.
4. Create dialog and disclosure without inaccessible custom behavior.
5. Test zoom, reduced motion, high contrast and screen-reader labels.

## Лабораторная работа

Создать `work/accessible-interface/`.

### Screens

- catalog/list page;
- detail page;
- create/edit form;
- confirmation dialog;
- permission-denied and error pages;
- status notification region.

### Requirements

- one logical H1 and consistent heading hierarchy;
- landmarks and skip link;
- every control has accessible name;
- keyboard order follows visual/logical order;
- focus indicator is visible;
- no keyboard trap except deliberate dialog behavior with escape/return;
- form errors identify field, reason and correction;
- color is not the only status signal;
- table markup used only for tabular data;
- automated accessibility test passes agreed rules;
- manual keyboard checklist included;
- semantic HTML remains usable without CSS/JavaScript for core content.

### Failure scenarios

1. Clickable `div` is not keyboard-operable.
2. Icon button has no accessible name.
3. Placeholder replaces label.
4. Error is only red border.
5. Dialog opens but focus remains behind it.
6. Closing dialog loses focus location.
7. Positive `tabindex` creates unexpected order.
8. ARIA role contradicts native element.
9. Disabled control hides why action is unavailable.
10. Automated scanner passes while workflow is unusable by keyboard.

## Самопроверка

1. Semantic HTML provides what?
2. Link versus button?
3. Accessible name comes from where?
4. Label, description and error differ how?
5. Native element versus ARIA custom widget?
6. What is accessibility tree?
7. How focus should move after validation/dialog?
8. Why color-only status fails?
9. What automated tools miss?
10. What makes a form error actionable?

## Результат для базы знаний

- **Semantic HTML and landmarks**.
- **Links, buttons and native controls**.
- **Accessible names, descriptions and errors**.
- **Keyboard navigation and focus management**.
- **Accessibility tree and ARIA boundaries**.
- **Accessible form validation**.
- **Dialog and disclosure accessibility patterns**.
- **Automated and manual accessibility testing**.

## Когда переходить дальше

Можно переходить, когда the complete form/dialog workflow works by keyboard, has correct accessible names and preserves context through validation and server errors.