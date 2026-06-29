# Спринт 07. Проверка языкового основания

Ориентировочный объём: 10–15 часов.

Новая теория не вводится. Первая попытка выполняется без повторного чтения спринтов 01–06.

## Проверяемые области

- development loop and observable behavior;
- values, types, Unicode and control flow;
- functions, scopes, closures and methods;
- slices, maps, structs, interfaces and generics;
- errors, panic and resource cleanup;
- packages, modules and dependencies.

## Исходная задача

Создать `work/eventlog/` — reusable event-log library and CLI.

```text
eventlog append FILE EVENT_JSON
eventlog list FILE [--type TYPE] [--after TIME]
eventlog stats FILE [--json]
eventlog validate FILE
eventlog compact FILE
```

Format is append-only JSON Lines with explicit schema version, event ID, timestamp, type and payload.

## Требования к модели

- named types for IDs, event type and schema version;
- constructor/validation prevents invalid event;
- raw JSON payload preserved without float precision loss;
- deterministic output/list ordering;
- Unicode correctly handled;
- library independent of CLI;
- interfaces only at storage/clock/ID consumer boundaries;
- generics used only where they improve type safety;
- errors preserve operation/path/line/cause;
- typed errors for validation/conflict/not found;
- no global mutable state;
- module can be consumed by separate test module.

## File safety

- append checks write/close errors;
- compact writes temp file and atomic replace where supported;
- corrupted line is reported with line/offset;
- original retained on compaction failure;
- resource cleanup tested through fakes;
- optional advisory lock behavior documented, full concurrency comes later.

## Tests

Mandatory:

- table-driven unit tests;
- randomized invariant test for append/read sequence;
- malformed/truncated/large input cases;
- typed nil regression;
- slice/map aliasing regression;
- dependency/API consumer test;
- golden CLI outputs;
- clean checkout build.

## Injected failures

1. Invalid JSON/schema.
2. Duplicate ID.
3. Unicode/invalid UTF-8 payload policy.
4. Partial final line.
5. Read failure midway.
6. Write/close/rename failure.
7. Wrong file permissions.
8. Captured mutable config changed after pipeline creation.
9. Shadowed error suppresses failure.
10. Accidental local `replace` breaks clean build.
11. Interface contains typed nil.
12. Caller mutates returned event payload/map.

## Defense

Ответить без материалов:

1. How does source become running CLI at current abstraction level?
2. What constraints are enforced by type versus runtime validation?
3. What is captured by closure?
4. How do slice aliasing and map mutation affect API safety?
5. Why can interface be non-nil around nil pointer?
6. How is error context preserved without duplicate logging?
7. How does atomic replacement protect state?
8. What are package/module boundaries?
9. How does dependency version reach executable?
10. What makes CLI behavior deterministic and scriptable?

## Критерии прохождения

- all commands work from clean checkout;
- library and CLI separation is maintained;
- all twelve failures are reproduced and tested;
- no raw internal mutable data leaks;
- compaction preserves original on failure;
- module graph contains no unexplained dependency;
- at least 8 of 10 defense answers are correct;
- resulting notes update only mechanisms that were actually tested.

При затруднении:

- development loop → sprint 01;
- types/Unicode → sprint 02;
- functions/closures → sprint 03;
- structures/interfaces/generics → sprint 04;
- errors/resources → sprint 05;
- packages/modules → sprint 06.

## Результат для базы знаний

Checkpoint-specific note не требуется. Исправить существующие notes only where implementation exposed incorrect assumptions.