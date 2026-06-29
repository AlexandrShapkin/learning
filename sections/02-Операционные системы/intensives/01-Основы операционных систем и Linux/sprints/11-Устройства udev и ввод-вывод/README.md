# Спринт 11. Устройства, udev и ввод-вывод

Ориентировочный объём: 10–14 часов.

## Центральный вопрос

Как Linux представляет hardware and virtual devices, связывает их с drivers and exposes stable interfaces to user space?

## Результат спринта

После завершения необходимо уметь:

- distinguish physical device, kernel device, driver, module and device node;
- explain major/minor numbers and block/character device types;
- navigate `/sys/class`, `/sys/bus`, `/sys/devices` and `/dev`;
- correlate `lsblk`, `lspci`, `lsusb`, `udevadm` and sysfs paths;
- explain uevents and udev rule processing;
- create a narrowly scoped udev rule and stable symlink for a disposable device;
- inspect device permissions and seat/group access;
- explain polling, interrupts, DMA and ioctl at operational level;
- observe device arrival/removal and driver binding;
- distinguish kernel buffer/cache behavior from device completion;
- safely use loop devices and virtual network/block devices;
- diagnose missing device node, wrong driver, wrong permission and unstable naming.

## Место в интенсиве

Storage layers depend on kernel devices, but the device model applies equally to terminals, network interfaces, random generators and virtual devices. This sprint exposes the kernel-to-userspace device lifecycle.

## Основной маршрут

### Шаг 1. Linux device model

Read:

- kernel driver model overview: https://docs.kernel.org/driver-api/driver-model/overview.html
- `sysfs(5)`;
- `proc_devices(5)` if available;
- `mknod(2)` and `mknod(1)` overview.

Understand that sysfs represents kernel objects and relationships, while `/dev` contains special files used to access device interfaces.

### Шаг 2. udev

Study:

- `udev(7)`;
- `udevadm(8)`;
- `systemd-udevd.service(8)`;
- `udev.conf(5)`;
- `systemd.device(5)`.

Focus on match keys, assignment operators, rule ordering, stable properties and why kernel names alone may not be stable.

### Шаг 3. Device I/O

Read OSTEP chapter 36 again and kernel docs for block layer. Review:

- interrupt-driven I/O;
- polling;
- DMA;
- memory-mapped I/O;
- device driver boundary;
- ioctl as device-specific control interface.

### Шаг 4. Virtual devices

Study:

- `losetup(8)`;
- `loop(4)`;
- `tun(4)`/`tap` overview;
- pseudo-terminals `pty(7)`;
- `/dev/null`, `/dev/zero`, `/dev/full`, `/dev/random`, `/dev/urandom`.

## Ресурсы

### Обязательный маршрут

- Linux driver model and sysfs docs.
- `udev(7)` and `udevadm(8)`.
- OSTEP I/O devices chapter.
- util-linux loop device man pages.

### Альтернативные объяснения

- *How Linux Works*, Devices chapter.
- Linux Device Drivers, introductory concepts; old API details are not authoritative for current kernels.
- ArchWiki udev page, verified against installed systemd version.

### Углубление

- writing a simple character driver;
- device tree and ACPI enumeration;
- virtio devices;
- IOMMU and passthrough;
- ioctls and userspace ABI design;
- eBPF tracing of block/device events.

### Справочные материалы

- `lspci(8)`, `lsusb(8)`, `lsblk(8)`.
- `/sys` ABI docs: https://docs.kernel.org/admin-guide/abi.html
- `ioctl(2)`.

## Практические задания

### 1. Device relationship map

Choose one block device and one network interface. For each determine:

- sysfs canonical path;
- subsystem/bus;
- driver symlink;
- module if loadable;
- major/minor or interface index;
- udev properties;
- device node if applicable;
- parent devices;
- systemd device unit.

Build graph from actual symlinks and properties.

### 2. Character devices

Compare behavior of:

```bash
/dev/null
/dev/zero
/dev/full
/dev/random
/dev/urandom
/dev/tty
/dev/pts/*
```

Use bounded reads/writes and `strace`. Explain syscalls, blocking behavior and errors. Never read unbounded `/dev/zero` to terminal or file.

### 3. Uevent observation

Run:

```bash
udevadm monitor --kernel --udev --property
```

Attach/detach a disposable virtual disk or create/remove loop device. Correlate kernel event, udev event, sysfs object and `/dev` node.

### 4. Driver binding

For a safe virtual device inspect `driver`, `modalias`, `uevent` and module metadata. If manually unbinding/rebinding, do it only for a disposable dummy/virtual device and from local console, never the root disk or active network interface.

## Лабораторная работа

Create `work/devlab/`.

### Part A. Loop device lifecycle

1. Create sparse image and filesystem.
2. Attach with `losetup --find --show --partscan`.
3. Observe udev events and sysfs path.
4. Mount, read/write, unmount and detach.
5. Prove cleanup through `losetup -a`, `/sys/block` and `/dev`.

### Part B. Stable udev identity

Use disposable virtual disk with a unique serial or another stable property visible through `udevadm info`.

Create rule under `/etc/udev/rules.d/99-devlab.rules` that:

- matches only the laboratory device;
- creates symlink `/dev/devlab-data`;
- assigns a dedicated group and restrictive mode;
- tags device for systemd if justified;
- never matches the root disk by generic `sd*` name.

Validate with:

```bash
udevadm verify /etc/udev/rules.d/99-devlab.rules
udevadm test /sys/path/to/device
udevadm control --reload
udevadm trigger --sysname-match=...
```

Commands vary by systemd version; use installed man page.

### Part C. Access test

Create group `devlab`, add test user, verify read/write allowed only where policy requires. Confirm access denial for unrelated user. Remove membership/rule and verify cleanup.

### Part D. Device watcher

Write Go program `devwatch` that monitors uevents through netlink or invokes/consumes `udevadm monitor --property` robustly. It records add/remove/change events as JSON and resolves selected sysfs attributes.

Tests use captured sanitized fixtures; no hardware dependency in unit tests.

### Diagnostic scenarios

1. Rule matches wrong attribute level and never applies.
2. Symlink points to stale kernel name after reattach.
3. Permissions differ because later rule overrides assignment.
4. Device node exists but filesystem is not mounted.
5. Driver/module unavailable or built into kernel.

Diagnose with event sequence, `udevadm info/test`, rule order and sysfs relationships.

## Дополнительный эксперимент

Create a dummy network interface and observe its sysfs, udev/systemd representation and namespace movement. Move it to a network namespace and explain why host sysfs/network views change differently.

Alternative: create paired pseudo-terminals and inspect `/dev/ptmx`, `/dev/pts`, controlling terminal and permissions.

## Самопроверка

1. What does a device node store?
2. What are major/minor numbers used for?
3. Why can driver work without appearing in `lsmod`?
4. How do sysfs and `/dev` differ?
5. What creates most device nodes on modern Linux?
6. Why are kernel names like `/dev/sdb` not always stable?
7. How is udev rule ordering resolved?
8. What is DMA and how does completion reach CPU?
9. What does ioctl provide beyond read/write?
10. Why can device node exist while device is unusable?

Practical check: given an unavailable storage device, determine whether failure is enumeration, driver, node creation, permissions, filesystem or mount layer.

## Результат для базы знаний

Recommended notes:

- **Linux device model** — devices, buses, drivers and kernel objects.
- **Block and character devices** — interfaces and device numbers.
- **sysfs and device nodes** — representation versus access endpoint.
- **udev** — uevents, rules, properties and stable naming.
- **Device drivers** — binding, modules and userspace ABI.
- **Interrupts, polling and DMA** — I/O coordination mechanisms.
- **Virtual devices** — loop, pty, tun/tap and their uses.

## Когда переходить дальше

Proceed when disposable device lifecycle is observable end-to-end, udev rule is narrowly matched and tested, and each diagnostic scenario is assigned to the correct layer.