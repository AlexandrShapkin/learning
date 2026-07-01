# Спринт 11. RED, USE, golden signals и saturation

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Как выбрать небольшой набор service and resource signals, который показывает user impact, load, errors, latency and saturation without reducing diagnosis to one universal dashboard?

## Результат спринта

После завершения необходимо уметь:

- применять RED to request-driven services;
- применять USE to bounded resources;
- понимать golden signals and queueing relationships;
- отличать utilization from saturation;
- измерять demand, capacity, queue depth and wait;
- определять service boundary and user journey;
- избегать averages that hide tails and segments;
- связывать retries with observed load;
- distinguish symptom metrics from cause candidates;
- select drill-down dimensions;
- model dependencies and fan-out amplification;
- recognize when method does not fit batch/event workloads.

## Основной маршрут

1. Build RED view for API and worker/job view for asynchronous path.
2. Build USE view for CPU, memory, disk, network, DB pool and queue.
3. Saturate each resource while keeping some utilization averages deceptively low.
4. Trace retry amplification from dependency latency to request volume.

## Ресурсы

- Google SRE golden signals.
- Brendan Gregg USE method.
- RED method references and queueing basics.

## Лабораторная работа

Создать `work/red-use/`.

### Requirements

- user-facing request success/latency/load is measured by route class;
- async work measures arrivals, completion, errors, age and backlog;
- each bounded resource has utilization, saturation and errors where meaningful;
- CPU per-core, memory pressure, disk queue/latency, network drops and DB pool wait are included;
- retries are separated from logical operations;
- averages include tail or distribution views;
- dependency fan-out and amplification are visible;
- one symptom dashboard links to resource/dependency drill-down;
- method limitations for low-volume and batch work are documented;
- known saturation fault is localized from signals.

### Failure scenarios

1. CPU average is low while one core is saturated.
2. Memory utilization is high but no pressure; or low before sudden OOM.
3. Disk capacity is free while latency/queue is saturated.
4. Request rate rises because retries, not users.
5. Average latency hides tail or one route/tenant.
6. Queue depth is stable while item age grows.
7. Error count rises only because traffic rises.
8. Batch job is forced into request-only RED model.

## Самопроверка

1. RED components?
2. USE components?
3. Golden signals?
4. Utilization versus saturation?
5. Queue depth versus age?
6. Logical request versus retry attempt?
7. Tail versus average?
8. Per-resource signal selection?
9. Fan-out amplification?
10. When these methods do not fit?

## Результат для базы знаний

- **RED method for service monitoring**.
- **USE method for resource diagnosis**.
- **Golden signals and user impact**.
- **Utilization, saturation, queues and pressure**.
- **Retry and fan-out load amplification**.

## Когда переходить дальше

Можно переходить, когда one induced saturation can be localized from user symptom through service/dependency signals to the bounded resource without relying on a single average.