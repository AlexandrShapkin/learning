# Спринт 07. Container runtime, Docker, сети и volumes

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как image превращается в running container через runtime, и как процессы, сети, DNS, ports, writable layers and volumes связаны с host lifecycle?

## Результат спринта

После завершения необходимо уметь:

- различать Docker Engine, containerd, CRI and OCI runtime roles;
- понимать create/start/exec/stop/kill/remove lifecycle;
- наблюдать container process from host namespaces/cgroups;
- объяснять writable layer and copy-on-write behavior;
- различать bind mount, named volume, tmpfs and image data;
- проектировать container bridge networks and embedded DNS;
- понимать port publishing, NAT and host binding;
- использовать health checks without confusing readiness/liveness semantics;
- задавать restart policy and understand its limits;
- управлять logs and container stdout/stderr contract;
- использовать Compose for dependency topology and local reproducibility;
- понимать rootless/runtime socket risks;
- диагностировать network, DNS, mount, permission and signal failures;
- выполнять safe cleanup by labels/projects.

## Основной маршрут

1. Trace `docker run` through image pull, create, runtime process and host cgroup/namespace.
2. Build two custom networks and inspect bridge/veth/NAT/DNS.
3. Compare bind, volume and tmpfs ownership/lifecycle.
4. Compose API, PostgreSQL, object storage and worker.
5. Stop with SIGTERM/grace period and reproduce PID 1/signal issue.

## Ресурсы

- Docker Engine, networking, storage and Compose docs.
- containerd/runc/CRI/OCI runtime docs.
- Linux namespaces/cgroups/networking docs from previous sprint.

## Лабораторная работа

Создать `work/container-platform/`.

### Requirements

- local registry image is run by digest;
- host and container PID/cgroup/namespace mapping is recorded;
- at least isolated backend and edge networks;
- only intended service port is published;
- DNS/service-name behavior and network aliases tested;
- persistent database/object data uses explicit volumes;
- permissions work with non-root UID/GID;
- root filesystem is read-only where feasible;
- tmpfs used for ephemeral writable state;
- startup dependency uses health/application retry, not fixed sleeps;
- graceful stop and forced-kill behavior measured;
- log rotation/size policy is explicit;
- Compose project can rebuild and clean without deleting unrelated resources.

### Failure scenarios

1. Port published on all interfaces unintentionally.
2. `depends_on` is treated as application readiness guarantee.
3. Database state is stored only in writable container layer.
4. Bind-mount ownership differs across host/runtime user.
5. PID 1 does not forward/reap signals/children.
6. Restart loop hides permanent configuration failure.
7. Docker socket mounted into application grants host-level control.
8. Container DNS fails after wrong network attachment.
9. Volume removal destroys data without backup/confirmation.

## Самопроверка

1. Docker Engine, containerd and runc roles?
2. Image versus writable layer?
3. Bind mount, volume and tmpfs?
4. Bridge network and port publishing path?
5. Container DNS scope?
6. PID 1 and signals?
7. Restart policy limitations?
8. Health check versus readiness?
9. Docker socket risk?
10. Compose provides what and not what?

## Результат для базы знаний

- **Container runtime stack and lifecycle**.
- **Container writable layers and volumes**.
- **Docker bridge networks, DNS and port publishing**.
- **Container PID 1 and signal handling**.
- **Compose topology and dependency readiness**.
- **Container runtime socket and host-control risk**.

## Когда переходить дальше

Можно переходить, когда a multi-service environment survives container replacement, network/storage paths are explicit, and shutdown/permission/DNS failures are diagnosable from host and runtime evidence.