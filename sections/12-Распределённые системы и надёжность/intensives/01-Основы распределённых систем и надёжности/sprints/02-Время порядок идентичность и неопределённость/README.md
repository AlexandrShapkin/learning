# Спринт 02. Время, порядок, идентичность и неопределённость

Ориентировочный объём: 16–23 часа.

## Центральный вопрос

Как рассуждать о порядке событий и уникальности операций без общего надёжного времени?

## Результат спринта

После завершения необходимо уметь:

- различать physical, monotonic and logical time;
- понимать clock skew, drift and synchronization limits;
- различать total, partial and causal order;
- применять Lamport timestamps conceptually;
- определять stable node, process, request, operation and attempt identities;
- избегать wall-clock time as uniqueness/ordering guarantee;
- проектировать sortable identifiers with collision assumptions;
- понимать duplicate, delayed and reordered messages;
- восстанавливать happens-before relationships;
- формулировать uncertainty in technical timeline.

## Основной маршрут

1. Run three processes with controlled clock offsets.
2. Generate concurrent events and compare timestamp order with causality.
3. Implement Lamport clock in a small message simulation.
4. Add operation and attempt IDs to retried requests.

## Лабораторная работа

Создать `work/time-ordering/`.

### Requirements

- wall and monotonic times are used for correct purposes;
- logical clock advances on local and received events;
- concurrent events remain explicitly unordered;
- operation ID is stable across retries while attempt ID changes;
- node/process epochs prevent ID reuse after restart;
- late/reordered messages are accepted or rejected by explicit rule;
- timeline marks known causal order and unknown order;
- no correctness decision depends only on synchronized wall clocks.

### Failure scenarios

1. Clock jumps backward.
2. Two nodes create same time-based ID.
3. Delayed old request arrives after newer update.
4. Process restart reuses sequence numbers.
5. Timestamp order contradicts message causality.
6. Retry is mistaken for a new logical operation.

## Результат для базы знаний

- **Physical, monotonic and logical time**.
- **Happens-before and partial ordering**.
- **Lamport clocks**.
- **Distributed operation and attempt identity**.
- **Clock skew and ordering uncertainty**.

## Когда переходить дальше

Можно переходить, когда concurrent, delayed and retried operations remain distinguishable without relying on wall-clock ordering.