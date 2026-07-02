# Спринт 28. Load shedding и graceful degradation

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как сохранить наиболее важные функции и bounded recovery under overload by rejecting, simplifying or deferring less valuable work?

## Результат спринта

После завершения необходимо уметь:

- distinguish overload from dependency failure;
- define critical, degradable and deferrable features;
- shed work by priority, cost and deadline;
- degrade response quality/feature scope explicitly;
- use stale/cache/fallback data with freshness semantics;
- prevent fallback from overloading another dependency;
- shed before queue saturation;
- preserve control-plane/health/recovery traffic;
- communicate partial result and uncertainty to clients;
- drain backlog without immediate relapse;
- measure accepted/rejected/degraded work and user impact;
- test return to normal state.

## Основной маршрут

1. Create critical read/write, optional enrichment and batch paths.
2. Saturate dependency and compare queueing versus shedding.
3. Add stale-cache/simple-response/deferred-work degradation.
4. Recover gradually while draining backlog.

## Лабораторная работа

Создать `work/load-shedding/`.

### Requirements

- service defines priority classes and minimum viable behavior;
- shedding trigger uses queue age/concurrency/deadline/resource pressure;
- optional work is skipped before critical path resources are consumed;
- degraded responses identify freshness/completeness semantics;
- fallback capacity and failure mode are bounded;
- health/control/recovery requests retain reserved capacity;
- clients receive explicit retry/no-retry guidance;
- backlog drain rate exceeds arrivals without re-overload;
- normal-mode restoration has hysteresis/ramp;
- user-impact and capacity trade-offs are measured.

### Failure scenarios

1. Service queues everything until timeout/OOM.
2. Fallback calls the same failed dependency indirectly.
3. Stale data is returned as current without marker.
4. All traffic, including health/control, is shed.
5. Recovery immediately admits full load and fails again.
6. Deferred queue grows beyond retention/deadline.
7. Priority policy starves low-priority work permanently.

## Результат для базы знаний

- **Load shedding under distributed overload**.
- **Graceful degradation and minimum viable service**.
- **Stale, cached and partial fallback semantics**.
- **Priority traffic and reserved recovery capacity**.
- **Backlog drain and controlled recovery**.

## Когда переходить дальше

Можно переходить, когда overload preserves critical behavior and recovery capacity through explicit rejection/degradation instead of uncontrolled queueing.