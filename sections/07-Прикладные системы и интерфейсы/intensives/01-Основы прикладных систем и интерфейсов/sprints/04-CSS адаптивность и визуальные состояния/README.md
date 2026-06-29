# Спринт 04. CSS, адаптивность и визуальные состояния

Ориентировочный объём: 15–22 часа.

## Центральный вопрос

Как превратить semantic document into a resilient visual interface that adapts to viewport, content, input method and user preferences without hiding application state?

## Результат спринта

После завершения необходимо уметь:

- понимать cascade, specificity, inheritance and source order;
- применять box model and sizing;
- использовать normal flow, flexbox and grid;
- выбирать relative, fixed and intrinsic units;
- проектировать mobile-first/responsive layouts;
- использовать container/media queries where appropriate;
- учитывать content growth, localization and zoom;
- создавать design tokens for spacing, typography and states;
- поддерживать hover, focus, active, disabled, loading and error states;
- применять `prefers-reduced-motion` and color-scheme preferences;
- понимать stacking contexts and overflow;
- избегать layout shifts from images/content loading;
- обеспечивать readable typography and contrast;
- создавать print/basic no-script fallback where relevant;
- диагностировать cascade, overflow and responsive regressions.

## Основной маршрут

### Шаг 1. Cascade and layout

Build layout first in normal flow, then use flex/grid for explicit relationships. Avoid absolute positioning as general page layout.

### Шаг 2. Responsive constraints

Test at narrow/wide viewport, 200% zoom, long translated strings, large system fonts and dynamic content. Design around content rather than fixed device names.

### Шаг 3. Component states

Every interactive component must define default, hover, focus-visible, active, disabled, pending, success and error states as applicable.

### Шаг 4. Motion and rendering stability

Respect reduced motion. Reserve space for images/results and avoid animations that block reading or imply unavailable actions.

## Ресурсы

- MDN CSS cascade, box model, flexbox, grid and responsive design.
- CSS specifications through W3C.
- WCAG contrast/reflow/zoom requirements.
- browser DevTools layout and rendering tools.

## Практические задания

1. Rebuild fixed desktop layout using intrinsic responsive behavior.
2. Create list/detail/form layouts with grid and flexbox.
3. Test long localization strings and large fonts.
4. Implement focus, loading, empty and error visual states.
5. Reproduce and fix overflow, stacking-context and layout-shift bugs.
6. Add reduced-motion behavior.

## Лабораторная работа

Создать `work/responsive-interface/` based on sprint 03.

### Requirements

- usable from 320 CSS pixels to wide desktop;
- no horizontal page scrolling at supported narrow width except intentional data region;
- layout remains usable at 200% zoom;
- content order remains logical when CSS is removed;
- long names and translated strings wrap without clipping;
- images/media have dimensions/aspect ratio;
- focus style is not removed;
- status is not communicated only by animation or color;
- reduced-motion preference disables nonessential motion;
- forms remain usable with mobile touch targets;
- screenshot tests cover representative viewports but do not replace semantic tests;
- CSS organization avoids uncontrolled specificity escalation.

### Failure scenarios

1. Fixed width clips on narrow viewport.
2. Absolute layout overlaps translated content.
3. `100vw` produces unwanted scrollbar.
4. Modal hidden behind unexpected stacking context.
5. Loading replacement causes large layout shift.
6. Disabled and enabled controls look identical.
7. Hover-only action is unavailable on touch/keyboard.
8. Motion ignores user preference.
9. CSS reorders content visually but not logically.
10. High specificity requires repeated `!important`.

## Самопроверка

1. Cascade and specificity?
2. Normal flow versus positioned layout?
3. Flexbox versus grid?
4. Intrinsic sizing means what?
5. Mobile-first means what?
6. Why test zoom and long strings?
7. What creates stacking context?
8. How prevent layout shift?
9. `focus` versus `focus-visible`?
10. Which states must a component expose?

## Результат для базы знаний

- **CSS cascade, specificity and inheritance**.
- **Normal flow, flexbox and grid**.
- **Intrinsic and responsive layout**.
- **Viewport, container and content-driven adaptation**.
- **Visual states of interactive components**.
- **Reduced motion and user preferences**.
- **Stacking contexts and overflow**.
- **Layout stability and responsive testing**.

## Когда переходить дальше

Можно переходить, когда interface remains usable across viewport, zoom, localization and preference variants, and every interaction state is visibly distinguishable without breaking semantics.