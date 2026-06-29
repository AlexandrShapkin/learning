# Спринт 03. Гипервизоры и виртуальные машины

Ориентировочный объём: 17–24 часа.

## Центральный вопрос

Как hypervisor multiplexes CPU, memory and devices between VMs, и какие isolation, performance and lifecycle guarantees реально получает guest?

## Результат спринта

После завершения необходимо уметь:

- различать type-1/type-2 terminology and practical host architecture;
- понимать hardware-assisted CPU virtualization;
- объяснять guest physical versus host virtual memory;
- понимать vCPU scheduling, overcommit and steal time;
- различать full virtualization and paravirtualized devices;
- использовать KVM/QEMU/libvirt;
- создавать VM from image through cloud-init;
- проектировать CPU, memory and disk allocation;
- понимать ballooning, huge pages and NUMA at overview level;
- использовать snapshots carefully;
- различать VM image, instance disk, snapshot and backup;
- выполнять clone, migration concept and graceful shutdown;
- диагностировать boot, console, resource and device problems;
- оценивать VM versus container trade-offs.

## Основной маршрут

1. Verify virtualization support and inspect KVM modules.
2. Create one QEMU VM manually, then through libvirt.
3. Provision two guests from a cloud image with cloud-init.
4. Compare virtio devices with emulated alternatives where possible.
5. Saturate vCPU/memory and observe host/guest metrics.

## Ресурсы

- KVM, QEMU and libvirt official docs.
- cloud-init docs.
- virtualization chapters from systems references.

## Лабораторная работа

Создать `work/virtual-machines/`.

### Requirements

- reproducible libvirt network and VM definitions;
- base image pinned by checksum;
- cloud-init user/network/SSH configuration without committed private key;
- at least two VMs with different resource shapes;
- vCPU overcommit/steal-time experiment;
- memory pressure/ballooning observation;
- virtio disk/network evidence;
- snapshot, independent backup copy and restore comparison;
- host/guest shutdown and cleanup scripts;
- report comparing VM and container isolation/overhead for one workload.

### Failure scenarios

1. VM has vCPUs but host scheduler is saturated.
2. Guest memory appears available while host swaps/thrashes.
3. Snapshot is treated as independent backup.
4. Clone reuses machine identity/SSH host keys unexpectedly.
5. Guest cannot boot after disk/controller change.
6. cloud-init reruns or does not run because instance identity is misunderstood.
7. Hard power-off corrupts guest filesystem/application state.
8. Host failure removes all colocated VMs.

## Самопроверка

1. What does KVM do versus QEMU/libvirt?
2. vCPU scheduling and steal time?
3. Guest physical versus host memory?
4. Virtio purpose?
5. Ballooning and overcommit risks?
6. Image, disk, snapshot and backup?
7. cloud-init lifecycle?
8. VM clone identity issues?
9. VM isolation shares what?
10. VM versus container selection?

## Результат для базы знаний

- **Hardware-assisted virtualization and KVM/QEMU**.
- **vCPU, memory overcommit and steal time**.
- **Virtio and paravirtualized devices**.
- **VM images, disks, snapshots and backups**.
- **cloud-init instance provisioning**.
- **Virtual machine lifecycle and failure boundaries**.

## Когда переходить дальше

Можно переходить, когда VMs are rebuilt from pinned image/configuration, resource contention is observable from host and guest, and snapshots are no longer confused with independent recovery copies.