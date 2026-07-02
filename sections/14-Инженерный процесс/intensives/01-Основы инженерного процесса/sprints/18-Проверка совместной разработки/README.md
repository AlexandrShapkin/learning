# Спринт 18. Проверка совместной разработки

Ориентировочный объём: 14–21 час.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 14–17.

## Исходная задача

Создать `work/collaboration-checkpoint/` — complete multi-branch change history with atomic commits, focused pull requests, structured reviews, ownership routing and safe integration/recovery.

## Required artifacts

- disposable Git repository with divergent branches;
- coherent commit series;
- at least three focused PR descriptions/diffs;
- review comments from four perspectives;
- ownership and fallback rules;
- merge-queue/integration evidence;
- one revert and one reflog/bisect recovery.

## Mandatory failure cases

1. Mixed-purpose commit.
2. Long-lived branch diverges significantly.
3. Shared history is rewritten unsafely.
4. Large PR hides unrelated risk.
5. Review misses correctness while debating style.
6. Blocking/suggestion intent is unclear.
7. Approval covers outdated revision.
8. One expert bottlenecks all reviews.
9. Ownership routing is stale.
10. Merge queue verifies stale combined state.
11. Revert breaks compatibility.
12. Regression cannot be bisected reproducibly.

## Defense

1. Why are commits atomic?
2. Why was the branch strategy chosen?
3. Which history operation is safe on shared refs?
4. How is each PR scoped?
5. What context makes review efficient?
6. Which review findings were blocking and why?
7. How was disagreement resolved?
8. How is latest revision verified?
9. What happens when owner is unavailable?
10. How is combined-state integration tested?
11. How is a change reverted safely?
12. How was the regression located/recovered?

## Критерии прохождения

- Git history explains intent and remains recoverable;
- changes are small, reviewable and incrementally integrated;
- review feedback targets meaningful risk and latest revision;
- ownership has fallback and does not create one-person bottleneck;
- merge/revert/recovery paths are demonstrated;
- all twelve failure cases are reproduced or corrected;
- at least 10 of 12 defense answers cite graphs, diffs or test evidence;
- destructive Git practice remains confined to disposable refs.

## Результат для базы знаний

Checkpoint-specific note не требуется. Update Git/review/ownership notes where the exercise changed assumptions.