# Спринт 05. Namespaces, cgroups и изоляция контейнеров

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Какие Linux kernel mechanisms создают container-like isolation and resource control, and which host/kernel/security dependencies remain shared?

## Результат спринта

После завершения необходимо уметь:

- объяснять process, mount, PID, network, IPC, UTS, user and cgroup namespaces;
- создавать isolated process with `unshare`/`nsenter`;
- понимать root filesystem, bind mounts, pivot_root/chroot differences;
- использовать cgroups v2 for CPU, memory, PIDs and I/O limits;
- понимать capabilities and capability bounding sets;
- понимать seccomp and syscall filtering;
- различать namespace isolation, permission isolation and resource isolation;
- объяснять user namespaces and rootless containers;
- понимать shared kernel attack/failure boundary;
- диагностировать OOM kill, throttling and PID exhaustion;
- учитывать page cache/kernel memory and host overhead;
- сравнивать VM and container isolation;
- избегать privileged container and broad host mounts.

## Основной маршрут

1. Build a minimal container-like environment using namespaces and a root filesystem.
2. Create virtual network namespace and veth pair.
3. Apply cgroup v2 CPU, memory and PID limits.
4. Drop capabilities and inspect effective/permitted/bounding sets.
5. Apply a simple seccomp profile through a runtime or test helper.

## Ресурсы

- Linux namespace and cgroups v2 docs/man pages.
- capabilities and seccomp documentation.
- OCI Runtime Specification.
- container mechanism chapters from relevant books.

## Лабораторная работа

Создать `work/container-mechanisms/`.

### Requirements

- script creates mount/PID/UTS/network isolation without Docker;
- rootfs is read-only except explicit writable paths where possible;
- veth/bridge/routing path is documented and captured;
- cgroup CPU quota, memory max/high and PID limit are measured;
- OOM and throttling evidence collected;
- capabilities are reduced to minimum for one task;
- rootless/user-namespace experiment maps IDs correctly;
- host kernel/process visibility limitations are documented;
- privileged mode/host PID/network/mount risks are reproduced safely;
- cleanup removes namespaces, cgroups, mounts, veth devices and processes.

### Failure scenarios

1. Filesystem chroot is called a complete container boundary.
2. PID namespace exists but process still has host capabilities/mounts.
3. Memory limit causes OOM and is mistaken for application bug without cgroup evidence.
4. CPU quota throttling appears as random latency.
5. PID limit blocks process/thread creation.
6. Root in container is treated as harmless despite host capabilities/mounts.
7. User namespace mapping creates unexpected file ownership.
8. Shared kernel resource/bug affects all containers.

## Самопроверка

1. Namespace types and responsibilities?
2. cgroups versus namespaces?
3. chroot versus mount namespace/pivot root?
4. CPU quota and throttling?
5. Memory high/max and OOM?
6. Linux capabilities?
7. Seccomp purpose?
8. Rootless container mechanism?
9. What remains shared with host?
10. Why privileged containers are dangerous?

## Результат для базы знаний

- **Linux namespaces for containers**.
- **cgroups v2 resource control**.
- **Container capabilities and seccomp**.
- **Rootless containers and user namespaces**.
- **Container shared-kernel boundary**.
- **Container OOM, throttling and PID exhaustion**.

## Когда переходить дальше

Можно переходить, когда a container-like process can be constructed and diagnosed without Docker, and every isolation claim is mapped to a specific kernel mechanism and remaining shared dependency.