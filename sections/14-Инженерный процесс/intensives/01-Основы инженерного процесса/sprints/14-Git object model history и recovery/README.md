# Спринт 14. Git object model, history и recovery

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как Git represents content and history, и как использовать это понимание для безопасного восстановления и анализа изменений?

## Результат спринта

После завершения необходимо уметь:

- объяснять blobs, trees, commits, refs, HEAD and object identity;
- различать working tree, index and repository;
- читать graph and parent relationships;
- use diff, log, show, reflog and bisect;
- distinguish revert, reset, restore, checkout/switch and rebase;
- recover lost commits and accidental branch moves;
- understand merge bases and three-way merge;
- use signed/verified history conceptually;
- avoid unsafe history rewrite on shared branches.

## Основной маршрут

1. Build a disposable repository and inspect raw objects.
2. Create divergent histories and merges.
3. Lose/move refs and recover through reflog.
4. Locate a regression with bisect.

## Лабораторная работа

Создать `work/git-model/`.

### Requirements

- object graph and refs are inspected directly;
- index/working-tree distinctions are demonstrated;
- merge base and conflict origin are explained;
- accidental reset/branch deletion is recovered;
- public-history correction uses revert or explicit coordination;
- bisect uses a reproducible test command;
- destructive commands default to disposable branches;
- recovery report records commands and resulting graph.

### Failure scenarios

1. Uncommitted work is lost through misunderstood reset/restore.
2. Shared branch is force-pushed without coordination.
3. Merge conflict is resolved without understanding both histories.
4. Lost commit is assumed deleted despite reflog.
5. Bisect test is flaky and points to wrong commit.
6. Generated/large artifacts obscure useful history.

## Результат для базы знаний

- **Git object model and references**.
- **Working tree, index and repository**.
- **Merge bases and three-way merge**.
- **Git reflog, recovery and bisect**.

## Когда переходить дальше

Можно переходить, когда divergent history, accidental ref movement and regression location can be explained and recovered from the object graph.