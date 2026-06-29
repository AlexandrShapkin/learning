# Спринт 16. Namespaces, cgroups и изоляция

Ориентировочный объём: 14–20 часов.

## Центральный вопрос

How can Linux give a process isolated views and bounded resources without starting another kernel?

## Результат спринта

После завершения необходимо уметь:

- list and explain mount, PID, network, UTS, IPC, user, cgroup and time namespaces;
- inspect namespace identities via `/proc/<pid>/ns` and `lsns`;
- create namespaces with `unshare` and enter them with `nsenter`;
- explain namespace nesting and lifetime;
- distinguish chroot, mount namespace and pivot_root;
- explain user namespace ID mappings and namespaced capabilities;
- understand cgroup v2 hierarchy, controllers and delegation;
- use `cpu.max`, `memory.max`, `pids.max`, `io.max` where available;
- interpret `cpu.stat`, `memory.events`, `memory.pressure` and `cgroup.events`;
- map systemd unit to cgroup;
- build a minimal container-like environment without Docker;
- explain missing isolation layers: capabilities, seccomp, LSM, filesystem and image lifecycle;
- diagnose namespace/cgroup failures from host and inside views.

## Место в интенсиве

Previous sprints covered processes, mounts, users, network and resource limits separately. Namespaces and cgroups compose these mechanisms into container foundations.

## Основной маршрут

### Шаг 1. Namespace API and types

Read:

- `namespaces(7)`;
- `unshare(1/2)`;
- `setns(2)`;
- `nsenter(1)`;
- type-specific pages: pid, mount, network, user, uts, ipc, cgroup, time namespaces.

Understand namespace lifetime through processes and bind-mounted namespace handles.

### Шаг 2. User and mount isolation

Read:

- `user_namespaces(7)`;
- `mount_namespaces(7)`;
- `pivot_root(2)`;
- `chroot(2)`.

Do not present chroot alone as security boundary.

### Шаг 3. cgroup v2

Read authoritative documentation:

- https://docs.kernel.org/admin-guide/cgroup-v2.html
- `cgroups(7)`;
- `systemd.resource-control(5)`.

Focus on no-internal-process rule, subtree control, delegation and controller files.

### Шаг 4. Container composition

Study OCI concepts overview and one runtime architecture description only after direct mechanisms. Identify layers:

```text
process + namespaces + cgroups + credentials/capabilities + seccomp/LSM + rootfs + lifecycle tooling
```

## Ресурсы

### Обязательный маршрут

- namespace man pages.
- kernel cgroup v2 documentation.
- systemd resource-control documentation.

### Альтернативные объяснения

- TLPI namespace chapters and example programs.
- LWN namespace series.
- Docker/container runtime docs for mapping mechanisms, not as primary API.

### Углубление

- cgroup delegation and rootless containers;
- OCI runtime spec;
- overlayfs;
- seccomp and capabilities;
- CRIU;
- cgroup-aware OOM and pressure;
- container escapes and kernel attack surface.

### Справочные материалы

- `capabilities(7)`, `seccomp(2)`, `landlock(7)` if available.
- `clone(2/3)`.
- `systemd-run(1)`, `systemd-cgls(1)`, `systemd-cgtop(1)`.

## Практические задания

### 1. Namespace inventory

For shell, system service and container/namespace process compare:

```bash
readlink /proc/PID/ns/*
lsns -p PID
cat /proc/PID/uid_map
cat /proc/PID/gid_map
```

Identify shared and isolated namespace types.

### 2. Isolated views

Use `unshare` to independently demonstrate:

- UTS hostname;
- PID numbering and proc mount;
- private tmpfs mount;
- network interface set;
- user namespace mapped root;
- IPC objects.

For each verify host unchanged.

### 3. cgroup controls

Run same workload under systemd scopes with:

- CPU quota 50%;
- memory high/max;
- pids max;
- I/O weight/limit if supported.

Observe controller files and application failure/throttling. Distinguish limit, accounting and pressure.

### 4. Namespace lifetime

Create namespace, bind-mount its `/proc/PID/ns/mnt` handle, exit original process, enter retained namespace, then unmount handle and verify disappearance.

## Лабораторная работа

Create `work/minibox/` — minimal container-like launcher.

### Root filesystem

Build disposable rootfs via one method:

- `debootstrap --variant=minbase` Debian stable;
- BusyBox static rootfs;
- extracted trusted OCI rootfs with verified source.

Rootfs and downloaded packages/images are not committed.

### Launcher requirements

`minibox run ROOTFS COMMAND...` must create:

- user namespace with explicit UID/GID mapping when available;
- UTS namespace with hostname;
- PID namespace with correct PID 1/reaping behavior;
- mount namespace with private propagation;
- proc mount matching PID namespace;
- tmpfs for `/tmp` and limited `/dev` setup;
- network namespace with veth and explicit connectivity option;
- cgroup v2 limits for CPU, memory and pids;
- dropped capabilities/bounding set;
- `no_new_privs`;
- cleanup of veth, mounts, cgroup and namespace handles.

Implementation may combine shell with small Go/C helper. Every privileged operation is explicit.

### Tests

Inside versus host verify:

- hostname;
- PID tree;
- mount table;
- network interfaces/routes;
- UID mapping and capabilities;
- kernel release is same;
- CPU throttling;
- memory OOM event;
- pids limit;
- inability to access host-only path;
- cleanup after abnormal termination.

### Failure scenarios

1. `/proc` mounted before PID namespace and shows host PIDs.
2. Mount propagation leaks mount to host namespace.
3. PID 1 does not reap children.
4. User mapping/setgroups order fails.
5. veth exists but route/forwarding missing.
6. Process is namespaced but no cgroup limit.
7. Cgroup controller not delegated/enabled.
8. Rootfs escape through unintended bind mount.
9. Capability remains in bounding/ambient set.
10. Cleanup misses mount or network interface.

## Дополнительный эксперимент

Add seccomp filter allowing only syscalls needed by one tiny command, then observe failure when command changes. Explain maintenance and compatibility trade-offs.

Alternative: compare `minibox` state with Docker/Podman container through namespace IDs, cgroup files, capabilities, mounts and seccomp status.

## Самопроверка

1. What does each namespace isolate?
2. Why is kernel shared across containers?
3. Why must proc be mounted inside PID namespace?
4. How does user namespace root differ from host root?
5. What is cgroup hierarchy and controller delegation?
6. How do `memory.high` and `memory.max` differ?
7. How does CPU quota appear in `cpu.stat`?
8. Why is chroot not sufficient isolation?
9. What responsibilities does container runtime add?
10. Why can container compromise still affect host kernel?

Practical check: inspect unknown process and determine namespace boundaries, cgroup limits, effective capabilities and reachable host resources.

## Результат для базы знаний

Recommended notes:

- **Linux namespaces** — isolated resource views and lifecycle.
- **PID namespace** — numbering, init and proc.
- **Mount namespace** — mount table and propagation.
- **User namespace** — ID mapping and namespaced capabilities.
- **Network namespace** — interfaces, routes and sockets.
- **cgroup v2** — hierarchy, controllers, delegation and accounting.
- **Container mechanisms** — composition and missing security layers.
- **chroot and pivot_root** — root view versus isolation boundary.

## Когда переходить дальше

Proceed when minibox isolates expected views, limits are proven through cgroup counters/events, PID 1 reaps, and cleanup leaves no namespace mount, cgroup or veth behind.