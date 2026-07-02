# Спринт 31. Fault injection, deterministic testing и chaos engineering

Ориентировочный объём: 21–31 час.

## Центральный вопрос

Как систематически проверять safety and liveness under rare schedules and partial failures rather than relying on happy-path integration tests?

## Результат спринта

После завершения необходимо уметь:

- define invariant and experiment hypothesis before fault;
- use deterministic event scheduling and random seeds;
- inject message delay/loss/duplication/reordering;
- pause, crash and restart processes at exact boundaries;
- inject clock, disk, CPU and network faults safely;
- perform state-machine/model-based testing;
- shrink/minimize failing histories conceptually;
- distinguish chaos engineering from random destruction;
- define steady-state hypothesis and abort conditions;
- preserve histories, terms, offsets and versions;
- test recovery/failback, not only failure detection;
- prioritize fault combinations by architecture assumptions.

## Основной маршрут

1. Build deterministic in-memory message scheduler for one protocol.
2. Generate randomized histories with fixed seed.
3. Check invariants after every transition.
4. Reproduce the same failure in container/network laboratory.
5. Run one bounded chaos experiment against user-facing steady state.

## Лабораторная работа

Создать `work/distributed-testing/`.

### Requirements

- every test names safety/liveness property;
- random seed, topology, event schedule and fault parameters are recorded;
- scheduler can delay/drop/duplicate/reorder and pause/restart nodes;
- invariant checker runs continuously;
- a failing history is reproducible and minimized manually or automatically;
- real-network experiment validates model assumptions;
- chaos experiment has scope, steady state, abort and rollback;
- telemetry/control path remains available;
- no fault affects unrelated host/cluster resources;
- recovery and cleanup are verified.

### Failure scenarios

1. Random chaos has no hypothesis or invariant.
2. Test seed/history is not reproducible.
3. Model omits disk persistence/restart behavior that matters.
4. Fault injector shares failure domain and stops cleanup.
5. Experiment only checks process health, not data invariant.
6. Partition heals but stale writer remains.
7. Test suite never explores concurrent boundary ordering.
8. Chaos reaches production-like shared resources accidentally.

## Результат для базы знаний

- **Deterministic simulation of distributed systems**.
- **Model-based and invariant-driven distributed testing**.
- **Fault injection schedules and reproducible histories**.
- **Chaos engineering hypotheses and abort conditions**.
- **Recovery validation after fault experiments**.

## Когда переходить дальше

Можно переходить, когда one nontrivial invariant violation is found through reproducible scheduling and the corrected system survives both model and real fault replay.