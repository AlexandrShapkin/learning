# Спринт 09. Quorums, CAP и PACELC

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как quorum choices and network partitions affect read/write availability, stale data and latency, and what CAP/PACELC actually constrain?

## Результат спринта

После завершения необходимо уметь:

- reason about N, R and W quorums;
- distinguish strict and sloppy quorums;
- understand quorum overlap and its assumptions;
- explain CAP during partition without reducing it to database branding;
- apply PACELC to partition and normal-operation trade-offs;
- understand read repair and anti-entropy;
- distinguish availability from successful HTTP response;
- account for correlated failure domains;
- understand hinted handoff limitations;
- test partition behavior from client histories.

## Основной маршрут

1. Implement or simulate N=3 replicated register with configurable R/W.
2. Test R+W>N under delayed/stale replicas.
3. Introduce partition and compare CP/AP behavior.
4. Add read repair and anti-entropy convergence.

## Лабораторная работа

Создать `work/quorums-cap/`.

### Requirements

- quorum equations and topology assumptions are stated;
- reads/writes expose contacted and acknowledged replicas;
- partition tests cover majority/minority clients;
- stale/failed responses are distinguished from operation success;
- sloppy quorum/hinted handoff is modeled separately from strict overlap;
- read repair does not silently overwrite concurrent version;
- normal-operation latency is compared across quorum choices;
- CAP/PACELC conclusions reference exact operation and failure model.

### Failure scenarios

1. R+W>N is assumed sufficient despite sloppy/non-overlapping replicas.
2. Two failure domains contain all quorum members.
3. Minority accepts writes then conflicts after heal.
4. Read repair destroys concurrent update.
5. Timeout response is counted as unavailability without checking committed effect.
6. PACELC is used as a product ranking slogan.

## Результат для базы знаний

- **Read and write quorums**.
- **Strict and sloppy quorums**.
- **CAP theorem under network partitions**.
- **PACELC latency-consistency trade-offs**.
- **Read repair, hinted handoff and anti-entropy**.

## Когда переходить дальше

Можно переходить, когда each quorum configuration has measured partition, latency and convergence behavior under explicit replica/failure-domain assumptions.