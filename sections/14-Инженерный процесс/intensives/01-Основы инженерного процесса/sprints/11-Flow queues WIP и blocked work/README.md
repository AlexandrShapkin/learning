# Спринт 11. Flow, queues, WIP и blocked work

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как управлять потоком изменений so that waiting and unfinished work do not dominate delivery time?

## Результат спринта

После завершения необходимо уметь:

- distinguish touch time, wait time, lead time and cycle time;
- visualize states and queues;
- apply WIP limits by bottleneck and policy;
- understand Little’s Law qualitatively;
- identify blocked, aging and abandoned work;
- design explicit pull and expedite policies;
- avoid starting work to look busy;
- measure queue age and flow efficiency;
- distinguish local utilization from system throughput;
- handle classes of service cautiously.

## Основной маршрут

1. Generate a synthetic 60-item work history.
2. Visualize arrival, active states, queues and completion.
3. Apply different WIP limits and compare outcomes.
4. Identify one bottleneck and one starvation pattern.

## Лабораторная работа

Создать `work/flow-analysis/`.

### Requirements

- state transitions have operational definitions;
- waiting and active time are measured separately;
- WIP limit reflects real bottleneck capacity;
- blocked items include cause, owner and next decision;
- aging work is reviewed before new starts;
- expedite usage is capped and visible;
- canceled/abandoned work leaves the system explicitly;
- metrics are aggregated and not used for individual ranking.

### Failure scenarios

1. Every person starts work to maximize utilization.
2. Review queue grows while coding continues.
3. Blocked items remain active forever.
4. WIP limit is raised whenever violated.
5. Expedite lane bypasses all limits permanently.
6. Cycle time excludes waiting states artificially.

## Результат для базы знаний

- **Engineering flow, queues and WIP**.
- **Lead time, cycle time and flow efficiency**.
- **Blocked and aging work**.
- **Pull systems and expedite policies**.

## Когда переходить дальше

Можно переходить, когда queues and aging work are visible and reducing WIP improves completion rather than merely shifting status labels.