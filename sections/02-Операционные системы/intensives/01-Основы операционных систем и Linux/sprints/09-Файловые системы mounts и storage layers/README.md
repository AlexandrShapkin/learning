# Спринт 09. Файловые системы, mounts и storage layers

Ориентировочный объём: 14–20 часов.

## Центральный вопрос

Как block devices, partitions, device mapper, filesystems and mount namespaces combine into the storage tree visible to a process?

## Результат спринта

После завершения необходимо уметь:

- explain storage stack from virtual disk to mounted directory;
- distinguish disk, partition, block device, filesystem, volume and mount;
- read `lsblk`, `blkid`, `findmnt`, `/proc/self/mountinfo` and `/etc/fstab`;
- create GPT partitions on disposable disk;
- create and inspect ext4 filesystem;
- mount by UUID and choose basic mount options;
- explain bind mount, tmpfs and mount propagation at overview level;
- create LVM PV, VG and LV;
- extend logical volume and filesystem safely;
- create and restore test snapshot with limitations;
- create swap LV/file and cleanly remove it;
- diagnose full blocks, inode exhaustion, hidden-by-mount files and stale fstab entry;
- perform offline filesystem check only on unmounted test filesystem;
- distinguish journaling, backup and snapshot.

## Место в интенсиве

The previous sprint explained file objects and permissions. This sprint places them on concrete filesystems and storage layers, preparing for devices, packages, services and recovery.

## Основной маршрут

### Шаг 1. Mount model

Read:

- `mount(8)` and `mount(2)`;
- `findmnt(8)`;
- `fstab(5)`;
- `proc_pid_mountinfo(5)`;
- `mount_namespaces(7)` overview.

Understand that one filesystem can be mounted multiple times and each process observes a mount namespace.

### Шаг 2. Partitions and filesystems

Study:

- `lsblk(8)`, `blkid(8)`, `fdisk(8)` or `parted(8)`;
- `mkfs.ext4(8)`, `tune2fs(8)`, `dumpe2fs(8)`, `e2fsck(8)`;
- kernel ext4 documentation: https://docs.kernel.org/filesystems/ext4/

Do not run fsck on mounted read-write filesystem.

### Шаг 3. LVM and device mapper

Read local man pages:

- `lvm(8)`;
- `pvcreate(8)`, `vgcreate(8)`, `lvcreate(8)`;
- `pvs`, `vgs`, `lvs`;
- `lvextend(8)`, `lvreduce(8)`;
- `dmsetup(8)`.

Model: physical volume → volume group extents → logical volume → filesystem → mount.

### Шаг 4. Capacity and recovery

Study:

- `df(1)` vs `du(1)`;
- `statvfs(3)` overview;
- inode count and reserved blocks;
- ext4 journal and recovery goals;
- `fstrim(8)` overview.

## Ресурсы

### Обязательный маршрут

- util-linux mount/block tools man pages.
- ext4 kernel docs and e2fsprogs man pages.
- LVM2 command man pages.
- Debian Handbook storage chapters.

### Альтернативные объяснения

- ArchWiki LVM, fstab and filesystems pages, verified against Debian.
- *How Linux Works*, storage and filesystem chapters.
- Red Hat LVM documentation as secondary guide.

### Углубление

- XFS allocation groups and repair;
- Btrfs subvolumes, checksums and snapshots;
- md RAID and failure modes;
- encryption with dm-crypt/LUKS;
- thin provisioning;
- idmapped and overlay mounts.

### Справочные материалы

- https://docs.kernel.org/admin-guide/device-mapper/
- XFS and Btrfs upstream docs.
- `wipefs(8)`, `losetup(8)`, `blockdev(8)`.

## Правило безопасности

Mandatory practice uses only two disposable virtual disks or explicitly created loop images. Before every destructive command record:

```bash
lsblk -o NAME,PATH,SIZE,TYPE,FSTYPE,MOUNTPOINTS,MODEL,SERIAL
findmnt
blkid
```

The selected devices must not contain root, boot, swap or valuable data.

## Практические задания

### 1. Storage stack map

For root filesystem determine:

- underlying block device path;
- partition table and partition;
- device-mapper/LVM layer if any;
- filesystem type, UUID and features;
- mount point/options/propagation;
- capacity, used blocks and inodes.

Draw exact stack from `lsblk`, `findmnt`, `dmsetup`, `blkid` and filesystem tools.

### 2. Loop filesystem

Create 1 GiB sparse image, attach loop device, create ext4, mount and inspect. Compare sparse file apparent size and allocated blocks. Detach cleanly.

### 3. Mount semantics

Demonstrate:

- bind mount;
- read-only remount;
- tmpfs;
- mounting filesystem over nonempty directory and revealing hidden files after unmount;
- private mount namespace with `unshare --mount`.

### 4. Capacity failures

On small test filesystem reproduce separately:

- block exhaustion with large files;
- inode exhaustion with many tiny files;
- deleted-open file consuming space;
- reserved space/metadata overhead.

Compare `df`, `df -i`, `du` and `lsof +L1`.

## Лабораторная работа

Create `work/storage-admin/` and use disposable disks A and B.

### Stage A. Partition and filesystem

1. Create GPT and one partition on disk A.
2. Create ext4 with label `LABDATA`.
3. Mount under `/srv/labdata` by UUID.
4. Add safe `/etc/fstab` entry with `nofail,x-systemd.device-timeout=...` only after manual test.
5. Verify generated mount unit and boot behavior.
6. Remove entry and cleanly unmount at stage end unless needed later.

### Stage B. LVM

1. Create PV on disk B and optional second partition/device.
2. Create VG `vg_lab`.
3. Create LVs `lv_data`, `lv_logs`, `lv_swap`.
4. Create ext4 on data/logs and swap on swap LV.
5. Mount by UUID or stable mapper path.
6. Extend `lv_data` and filesystem online.
7. Record extent/free-space changes.

### Stage C. Snapshot

1. Write deterministic test dataset and checksum manifest.
2. Create LVM snapshot.
3. Modify/delete part of dataset.
4. Mount snapshot read-only and verify original checksums.
5. Restore selected files or merge snapshot only if safely supported and VM snapshot exists.
6. Demonstrate snapshot COW usage growth.

### Stage D. Offline check

1. Unmount a test LV.
2. Run non-destructive `e2fsck -n`.
3. On a copied image or disposable LV create controlled metadata issue only with documented test method.
4. Repair offline, remount and verify checksums.

Never corrupt the main VM root filesystem.

### Automation

Provide scripts:

```text
inventory.sh
create-lab.sh
verify-lab.sh
cleanup-lab.sh
```

Scripts validate device identity, abort if mounted/in-use and require explicit confirmation token containing device path and size.

## Дополнительный эксперимент

Choose one:

- create XFS on another LV and compare grow/repair semantics with ext4;
- create Btrfs filesystem with subvolume and snapshot, compare with LVM snapshot boundaries;
- create dm-crypt/LUKS volume on disposable LV and document key handling without committing secrets.

## Самопроверка

1. What is mounted: a disk, partition, filesystem or directory?
2. Why use UUID in fstab?
3. How does a bind mount differ from symlink?
4. What does a mount namespace isolate?
5. Why can `df` show full space while `du` does not?
6. How can inode exhaustion happen with free bytes?
7. What does filesystem journal guarantee and not guarantee?
8. What are PV, VG, LV and extent?
9. Why is LVM snapshot not a backup?
10. Why must fsck usually run offline?
11. What happens when a mount hides existing directory contents?

Practical check: from `lsblk`, `findmnt`, LVM and fstab outputs reconstruct storage stack and identify one unsafe change before executing it.

## Результат для базы знаний

Recommended notes:

- **VFS and filesystem** — common interface versus concrete on-disk format.
- **Mount and mount table** — attachment to namespace, options and propagation.
- **Partitions and block devices** — disk layout and stable identifiers.
- **ext4** — superblock, allocation, journal and maintenance overview.
- **LVM** — PV/VG/LV, extents, resizing and snapshots.
- **Filesystem capacity** — blocks, inodes, deleted-open files and diagnostics.
- **fstab** — persistent mounts, dependencies and boot risks.
- **Filesystem check and recovery** — offline validation and repair limits.

## Когда переходить дальше

Proceed when lab storage stack is reproducible and removable, fstab reboot succeeds, LV/filesystem extension is explained layer by layer, and capacity failures are diagnosed with correct evidence.