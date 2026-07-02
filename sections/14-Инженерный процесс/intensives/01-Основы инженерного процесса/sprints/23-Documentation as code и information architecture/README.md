# Спринт 23. Documentation as code и information architecture

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как сделать документацию частью изменения and keep it useful, findable and current without duplicating every source of truth?

## Результат спринта

После завершения необходимо уметь:

- define audiences, tasks and information types;
- apply tutorials/how-to/reference/explanation separation;
- organize navigation and discoverability;
- keep docs near code while linking authoritative runtime/config sources;
- automate examples, links and snippets where useful;
- review docs in pull requests;
- define ownership and freshness signals;
- retire obsolete content;
- avoid documentation that restates code without reader value;
- write concise operational and contributor guidance.

## Основной маршрут

1. Audit existing product documentation by audience/task.
2. Restructure one confused document set.
3. Add executable/tested examples or link checks.
4. Remove one duplicate/stale source.

## Лабораторная работа

Создать `work/documentation/`.

### Requirements

- each document names reader and purpose implicitly or explicitly;
- navigation supports common tasks and reference lookup;
- one authoritative source exists for configuration/contract facts;
- examples are tested or reproducible;
- change requiring docs is detectable in review/acceptance;
- owner/freshness condition is clear;
- obsolete pages redirect/archive/delete rather than linger;
- sensitive/private context is excluded;
- docs remain concise and task-oriented.

### Failure scenarios

1. README mixes tutorial, reference and design history incoherently.
2. Same configuration table exists in several stale copies.
3. Example commands no longer work.
4. Docs are updated after release only if remembered.
5. Search/navigation cannot locate common task.
6. Old design document is mistaken for current behavior.

## Результат для базы знаний

- **Documentation as code**.
- **Documentation information architecture**.
- **Tutorial, how-to, reference and explanation**.
- **Documentation ownership, freshness and retirement**.

## Когда переходить дальше

Можно переходить, когда a new contributor/user can find and execute key tasks and current facts have one authoritative maintainable source.