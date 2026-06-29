# Спринт 04. Виртуальные сети, диски, snapshots и образы

Ориентировочный объём: 17–24 часа.

## Центральный вопрос

Как connect virtual machines to networks and persistent storage так, чтобы addressing, routing, attachment, durability and recovery boundaries оставались явными?

## Результат спринта

После завершения необходимо уметь:

- различать bridge, NAT, routed and isolated VM networks;
- понимать tap devices, Linux bridge and virtual NIC path;
- проектировать addressing, DHCP and DNS for VM lab;
- диагностировать L2/L3/MTU/firewall failures;
- различать raw, qcow2 and block-device backing;
- понимать thin provisioning, copy-on-write and discard;
- выбирать ephemeral and persistent disks;
- выполнять attach/detach, resize and filesystem growth;
- понимать crash-consistent versus application-consistent snapshot;
- создавать golden/base images safely;
- отделять image build from instance configuration;
- тестировать backup/restore and image replacement;
- учитывать storage latency/IOPS and queueing;
- избегать identity/secret leakage in images.

## Основной маршрут

1. Build isolated, NAT and bridged networks through libvirt/Linux bridge.
2. Trace packet from guest to host and external target.
3. Attach multiple virtual disk formats and compare allocation/performance.
4. Create snapshot under stopped and active application state.
5. Build a clean reusable image and instantiate two guests.

## Ресурсы

- libvirt networking/storage docs;
- Linux bridge, tap, nftables and routing docs;
- QEMU image format docs;
- filesystem/application backup references.

## Лабораторная работа

Создать `work/virtual-network-storage/`.

### Requirements

- three virtual network modes with diagrams and verification commands;
- predictable DHCP/DNS or static lease mapping;
- packet capture proves NAT/bridge path;
- firewall rules are isolated and cleanup restores host baseline;
- raw/qcow2 thin allocation comparison;
- disk resize includes partition/filesystem steps and rollback evidence;
- online snapshot demonstrates consistency limitation;
- independent backup restore to a different VM succeeds;
- golden image contains no host keys, machine ID or credentials;
- image replacement preserves separately owned persistent data;
- fault scripts include MTU mismatch, detached disk and full backing storage.

### Failure scenarios

1. Guest route/DNS works internally but NAT forwarding is disabled.
2. MTU mismatch causes selective large-packet failure.
3. Thin-provisioned host storage fills despite apparent guest free space.
4. Snapshot captures filesystem but not application consistency.
5. Backing image is modified and dependent overlays break.
6. Disk UUID/mount path changes after attachment order changes.
7. Golden image leaks SSH host keys or machine identity.
8. VM rebuild deletes data stored on root/ephemeral disk.

## Самопроверка

1. Bridge, NAT and routed virtual networks?
2. Tap device role?
3. raw versus qcow2?
4. Thin provisioning risk?
5. Crash-consistent versus application-consistent snapshot?
6. Snapshot versus backup?
7. Image versus instance configuration?
8. How persistent disk survives replacement?
9. MTU symptom?
10. What must image cleanup remove?

## Результат для базы знаний

- **Virtual machine network modes**.
- **Tap devices and Linux bridge path**.
- **Virtual disk formats and thin provisioning**.
- **Disk attachment, resizing and filesystem growth**.
- **Crash-consistent and application-consistent snapshots**.
- **Golden images and instance identity cleanup**.

## Когда переходить дальше

Можно переходить, когда network/storage paths are traceable, VM replacement preserves intended persistent state, and restore evidence distinguishes snapshots, images and independent backups.