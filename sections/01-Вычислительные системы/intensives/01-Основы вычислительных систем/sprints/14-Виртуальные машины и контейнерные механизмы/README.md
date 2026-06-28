# Спринт 14. Виртуальные машины и контейнерные механизмы

Ориентировочный объём: 10–15 часов.

## Центральный вопрос

Как несколько изолированных сред разделяют один физический компьютер и чем аппаратная виртуализация отличается от контейнерной изоляции?

## Результат спринта

После завершения необходимо уметь:

- различать emulation, full virtualization, hardware-assisted virtualization и containers;
- объяснять host, guest, hypervisor, vCPU и virtual device;
- объяснять trap-and-emulate и роль VM exits на обзорном уровне;
- различать type 1 и type 2 hypervisor без чрезмерного упрощения современных stacks;
- объяснять роль QEMU и KVM в Linux;
- объяснять namespaces как views/isolation и cgroups как accounting/control;
- перечислять основные Linux namespaces и наблюдать их через `/proc`;
- ограничивать CPU и memory через cgroup v2 или systemd-run;
- доказать, что container разделяет host kernel;
- сравнивать isolation boundary VM и container;
- объяснять, почему namespace/cgroup не исчерпывают container security.

## Место в интенсиве

Последние спринты показали процессы, memory, I/O и resource measurement. Виртуализация переиспользует и расширяет эти механизмы, создавая виртуальные CPUs/devices или изолированные process trees.

## Основной маршрут

### Шаг 1. Виды виртуализации

Прочитать QEMU overview:

- https://www.qemu.org/docs/master/about/
- https://www.qemu.org/docs/master/system/introduction.html

Составить comparison table для native execution, user-mode emulation, full-system emulation, KVM-accelerated VM и container.

### Шаг 2. Hardware assistance

Изучить обзор KVM:

- https://docs.kernel.org/virt/kvm/index.html

В Intel SDM Volume 3 прочитать overview VMX operation только для понимания guest/host transitions. Не требуется изучать VMCS fields.

### Шаг 3. Namespaces

Прочитать:

- overview: https://man7.org/linux/man-pages/man7/namespaces.7.html
- PID: https://man7.org/linux/man-pages/man7/pid_namespaces.7.html
- mount: https://man7.org/linux/man-pages/man7/mount_namespaces.7.html
- network: https://man7.org/linux/man-pages/man7/network_namespaces.7.html
- user: https://man7.org/linux/man-pages/man7/user_namespaces.7.html

### Шаг 4. cgroup v2

Прочитать introduction, terminology и controllers overview:

- https://docs.kernel.org/admin-guide/cgroup-v2.html

Сосредоточиться на `cgroup.procs`, `cpu.max`, `memory.max`, `memory.current`, `pids.max`.

## Ресурсы

### Обязательный маршрут

- QEMU system emulation introduction.
- KVM official documentation overview.
- Linux namespaces manual pages.
- cgroup v2 documentation.

### Альтернативные объяснения

- OSTEP chapters/notes on virtualization concepts.
- Red Hat virtualization documentation for KVM architecture.
- Docker documentation on namespaces and cgroups, только после первичных Linux sources.

### Углубление

- virtio and paravirtualized devices;
- nested virtualization;
- IOMMU and device passthrough;
- seccomp, capabilities, LSM and container security;
- rootless containers;
- microVMs.

### Справочные материалы

- `unshare(1)`, `nsenter(1)`, `lsns(8)`.
- `systemd-run(1)` resource-control properties.
- Docker resource constraints: https://docs.docker.com/engine/containers/resource_constraints/

## Практические задания

### 1. Classification

Для случаев QEMU TCG, QEMU+KVM, Docker container, Java VM, WebAssembly runtime и Rosetta-like translation указать:

- что virtualized/emulated;
- какая ISA выполняется;
- какой kernel используется;
- где isolation boundary;
- какие resources контролируются.

JVM не называть machine virtualization без пояснения уровня abstraction.

### 2. Namespace identity

Для текущего shell вывести namespace links:

```bash
readlink /proc/self/ns/{user,pid,mnt,uts,ipc,net,cgroup,time}
lsns
```

Повторить внутри container или `unshare` и сравнить inode numbers.

### 3. Resource limits

Запустить memory workload из спринта 13 через:

```bash
systemd-run --user --scope -p MemoryMax=256M -p CPUQuota=50% <command>
```

Если user systemd/cgroup delegation недоступны, использовать Docker:

```bash
docker run --rm --memory=256m --cpus=0.5 ...
```

Наблюдать `memory.current`, `memory.events`, `cpu.stat` и application behavior.

## Лабораторная работа

Лаборатория состоит из двух независимых частей. KVM acceleration может быть недоступна; в этом случае QEMU TCG остаётся обязательным, а limitation фиксируется.

### Часть A. VM через QEMU

1. Скачать актуальный Alpine Linux Virtual ISO только с https://alpinelinux.org/downloads/.
2. Проверить published SHA-256.
3. Создать qcow2 image в `work/virtualization/images/`; image не коммитить.
4. Запустить installation/boot через QEMU TCG.
5. При наличии `/dev/kvm` повторить с `-accel kvm`.
6. В guest собрать:
   - `uname -a`;
   - `/proc/cpuinfo`;
   - `lspci`;
   - block/network devices;
   - timing CPU workload.
7. На host наблюдать QEMU process, threads, mappings, file descriptors и CPU use.

Сохранить command lines и versions, но не VM image.

### Часть B. Контейнер без container runtime

Использовать `unshare`:

```bash
unshare --user --map-root-user --pid --fork --mount-proc --uts --mount /bin/bash
```

Внутри:

- изменить hostname;
- сравнить PID view;
- смонтировать private tmpfs;
- сравнить namespace inode numbers;
- проверить, что kernel version совпадает с host;
- показать, какие host resources всё ещё видимы без дополнительных restrictions.

Затем запустить process в cgroup limit и подтвердить accounting/control.

### Обязательное сравнение

Заполнить готовую таблицу фактами experiment:

| Свойство | QEMU TCG | QEMU+KVM | namespace process/container |
|---|---|---|---|
| Guest ISA | | | |
| Kernel | | | |
| Virtual devices | | | |
| Isolation boundary | | | |
| Startup cost | | | |
| CPU overhead | | | |
| Resource control | | | |

Это содержательный результат experiment, а не progress tracking.

## Дополнительный эксперимент

### Вариант 1. Cross-architecture emulation

Собрать простой ARM64 static binary cross-compiler и выполнить через `qemu-aarch64`. Сравнить `file`, ELF machine type и host ISA. Объяснить translation boundary.

### Вариант 2. Container inspection

Запустить минимальный Docker container и сопоставить:

- container PID и host PID;
- namespace inode numbers;
- cgroup path;
- mounted filesystem layers;
- capabilities и seccomp status.

Не считать Docker отдельным kernel или VM только из-за filesystem image.

## Самопроверка

1. Чем emulation отличается от virtualization?
2. Как KVM использует hardware virtualization?
3. Какую роль выполняет QEMU при KVM acceleration?
4. Почему VM может запускать другой kernel, а обычный container — нет?
5. Что изолирует PID namespace?
6. Чем namespace отличается от cgroup?
7. Почему root в user namespace не обязательно host root?
8. Что происходит при превышении `memory.max`?
9. Почему container isolation требует capabilities/seccomp/LSM помимо namespaces?
10. Какие costs возникают при virtual I/O?

Практическая проверка: по host process tree, namespace IDs, cgroup path и guest output определить, является среда VM или container, и указать evidence.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Эмуляция и виртуализация** — различия execution и resource model.
- **Гипервизор** — host/guest, vCPU, VM exits и virtual devices.
- **KVM и QEMU** — kernel acceleration и device/system emulation.
- **Linux namespaces** — виды isolation views.
- **Control groups** — accounting, limits и controllers.
- **Контейнерные механизмы** — namespaces, cgroups, filesystem и security layers.
- **VM и контейнеры** — разные isolation boundaries, costs и use cases.

## Когда переходить дальше

Можно переходить, когда QEMU boot воспроизводим, KVM availability проверена честно, namespace/cgroup effects подтверждены через `/proc`/cgroupfs, а comparison VM/container основано на observed kernel/ISA/isolation boundary.