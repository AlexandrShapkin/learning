# Спринт 08. Проверка виртуализации и контейнеров

Ориентировочный объём: 14–21 час.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 01–07.

## Исходная задача

Создать `work/compute-isolation-checkpoint/` — один synthetic application stack in three forms:

1. processes on one Linux host;
2. multi-service Compose environment;
3. two or more VMs provisioned from image/cloud-init with containers inside.

## Required workload

- HTTP API;
- PostgreSQL;
- background worker;
- object storage or file service;
- local OCI registry;
- synthetic load generator.

## Required evidence

For each form record:

- CPU, memory, disk and network allocation;
- process/namespace/cgroup/VM mapping;
- data persistence boundary;
- image/build provenance;
- startup and shutdown sequence;
- shared failure domains;
- replacement and recovery time;
- cleanup verification.

## Mandatory fault cases

1. CPU quota throttling.
2. Container/guest memory pressure and OOM.
3. Host disk or thin pool full.
4. Broken DNS or route.
5. MTU mismatch.
6. Volume or virtual disk detached/read-only.
7. PID 1 ignores graceful stop.
8. Mutable image tag changes deployment contents.
9. Snapshot restores inconsistent application state.
10. VM/container shares hidden host dependency with replica.
11. Rootless/UID mapping creates file-permission failure.
12. Host or VM hard failure during write.

## Defense

1. Which resources are reserved, limited and shared?
2. What isolation is provided by VM versus container?
3. How does the network path differ across forms?
4. Which data survives process/container/VM replacement?
5. What does image digest identify?
6. How are builds and instance configuration separated?
7. Which evidence distinguishes throttling from low application efficiency?
8. Why snapshot is not sufficient backup?
9. Which failure domains remain shared?
10. When is VM/container/host process the appropriate choice?
11. How is graceful shutdown verified?
12. How does cleanup prove no residual resources remain?

## Критерии прохождения

- all three forms are reproducible from repository definitions;
- application behavior is equivalent at contract level;
- persistent state survives intended replacement and restores independently;
- images are pinned/inspectable and contain no secrets;
- all twelve faults are reproduced and diagnosed;
- resource and failure-domain comparison is explicit;
- cleanup removes only labeled lab VMs, networks, images, volumes and containers;
- at least 10 of 12 defense answers are supported by commands/measurements.

## Результат для базы знаний

Checkpoint-specific note не требуется. Update existing notes where measured behavior changed assumptions about isolation, persistence or resource accounting.