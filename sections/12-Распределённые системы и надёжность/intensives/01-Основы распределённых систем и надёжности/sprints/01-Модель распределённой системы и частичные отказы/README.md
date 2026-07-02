# Спринт 01. Модель распределённой системы и частичные отказы

Ориентировочный объём: 16–23 часа.

## Центральный вопрос

Какие свойства появляются, когда одна логическая система состоит из нескольких процессов и узлов, связанных ненадёжной сетью?

## Результат спринта

После завершения необходимо уметь:

- моделировать nodes, processes, messages, local state and shared goals;
- различать local and remote call semantics;
- определять failure domains and trust assumptions;
- различать crash, omission, timing, partition and arbitrary failures;
- объяснять partial failure and failure detection uncertainty;
- формулировать safety and liveness properties;
- различать fault, failure and recovery;
- описывать system model as synchronous, asynchronous or partially synchronous;
- определять which state is authoritative;
- строить failure matrix before implementation.

## Основной маршрут

1. Split a local Go service into API and state process.
2. Compare local function call with RPC under delay, loss and crash.
3. Write safety/liveness properties for one account-transfer-like operation.
4. Pause one process without killing it and observe ambiguity.

## Лабораторная работа

Создать `work/system-model/`.

### Requirements

- topology and failure-domain map;
- explicit network/storage/process assumptions;
- at least eight fault classes and expected observations;
- safety/liveness invariants;
- one case where caller cannot know whether remote effect happened;
- one case where component is alive but unavailable;
- one case where system remains partially useful;
- no use of “node is down” without detector evidence and timeout policy.

### Failure scenarios

1. Lost request versus lost response.
2. Slow process versus crashed process.
3. Network partition with both sides alive.
4. Process restarts with stale local state.
5. Dependency is reachable but overloaded.
6. Health check path works while operation path fails.

## Результат для базы знаний

- **Distributed-system models and assumptions**.
- **Partial failures and failure detection**.
- **Safety and liveness properties**.
- **Crash, omission, timing and partition faults**.
- **Local versus remote operations**.

## Когда переходить дальше

Можно переходить, когда system guarantees are written as invariants under explicit failure assumptions rather than inferred from successful requests.