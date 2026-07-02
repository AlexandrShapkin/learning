# Спринт 15. Commits, branching и integration strategies

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как организовать commits and branches so changes remain reviewable, integrable, reversible and releasable?

## Результат спринта

После завершения необходимо уметь:

- create atomic commits with coherent intent;
- write commit messages that preserve rationale;
- separate refactoring, behavior and generated changes;
- compare trunk-based, short-lived branches and longer release branches;
- use merge, squash and rebase deliberately;
- keep branches small and current;
- manage compatibility and feature toggles;
- design protected branch and merge requirements;
- avoid long-lived divergence and integration debt;
- revert or disable one slice safely.

## Основной маршрут

1. Turn a tangled feature branch into coherent commits.
2. Compare merge, squash and rebase histories.
3. Integrate three dependent slices incrementally.
4. Revert one change without reverting unrelated work.

## Лабораторная работа

Создать `work/git-integration/`.

### Requirements

- each commit builds/tests or has explicit reason not to;
- unrelated formatting/generated changes are isolated;
- commit message explains intent and trade-off;
- branch lifetime and sync policy are explicit;
- integration strategy matches release/audit context;
- feature toggle has owner and removal condition;
- compatibility permits incremental merge;
- revert path is tested;
- protected branch rules enforce necessary checks only.

### Failure scenarios

1. One commit mixes refactor, feature and generated files.
2. Long-lived branch integrates only at release time.
3. Rebase rewrites shared work unexpectedly.
4. Squash removes required audit/decision history.
5. Merge commit adds no useful context and obscures graph.
6. Toggle becomes permanent dead branch.
7. Revert breaks schema/API compatibility.

## Результат для базы знаний

- **Atomic commits and commit intent**.
- **Git branching and integration strategies**.
- **Merge, squash and rebase trade-offs**.
- **Feature toggles and reversible changes**.

## Когда переходить дальше

Можно переходить, когда small slices integrate continuously, history remains understandable and one change can be reverted without collateral damage.