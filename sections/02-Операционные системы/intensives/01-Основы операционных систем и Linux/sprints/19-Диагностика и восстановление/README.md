# Спринт 19. Диагностика и восстановление

Ориентировочный объём: 16–24 часа.

## Центральный вопрос

How can an administrator restore a Linux system safely when symptoms span boot, services, memory, storage, packages, network and access controls?

## Результат спринта

После завершения необходимо уметь:

- define symptom, scope, timeline and impact before changing system;
- collect volatile evidence with minimal disturbance;
- build and rank falsifiable hypotheses;
- distinguish root cause, trigger and secondary failures;
- compare current state with known-good configuration/package/unit;
- choose reversible change and explicit verification;
- use rescue/emergency mode and live/rescue ISO;
- mount and chroot into installed system safely;
- recover from broken fstab, systemd unit, initramfs or bootloader config;
- repair interrupted package state;
- perform offline filesystem checks on disposable/correct device;
- recover access after sudo/PAM/SSH/firewall mistakes;
- diagnose high load, memory pressure, full disk and network outage;
- create tested backup/restore and rollback procedure;
- produce concise incident record without replacing evidence with narrative.

## Место в интенсиве

All previous mechanisms are now used as a troubleshooting system. This sprint deliberately focuses on uncertainty, risk management and restoration rather than adding another subsystem.

## Основной маршрут

### Шаг 1. Diagnostic method

Use the loop:

```text
stabilize → define symptom/scope → collect evidence → timeline
→ hypotheses → discriminating test → minimal change
→ verification → rollback/cleanup → prevention
```

For each incident identify what evidence may disappear after restart or cleanup.

### Шаг 2. Rescue environments

Study:

- systemd rescue/emergency targets;
- Debian installer rescue mode;
- `mount`, `chroot`, `systemd-nspawn` optional;
- bind mounts for `/dev`, `/proc`, `/sys`, `/run` when needed;
- bootloader and initramfs tools.

Never run repair command before identifying correct root/boot/filesystem.

### Шаг 3. Recovery by subsystem

Review operational commands:

- boot: journal previous boot, systemd-analyze, GRUB config, initramfs inspection;
- process/service: systemctl, journalctl, ps, strace, coredumpctl;
- memory: meminfo, vmstat, PSI, cgroup events;
- storage: lsblk, findmnt, df/du/inodes, lsof +L1, LVM, fsck offline;
- packages: dpkg audit/configure, apt simulation/policy/logs;
- network: ip/ss/getent/nft/tcpdump;
- access: id/getent/namei/ACL/sudo/sshd/PAM/audit.

### Шаг 4. Backups and rollback

Define:

- what is backed up;
- consistency point;
- retention and off-host boundary;
- integrity/authenticity;
- restore procedure;
- RPO/RTO expectations;
- restore test.

A snapshot without independent restore test is not sufficient.

## Ресурсы

### Обязательный маршрут

- Debian installation rescue documentation.
- systemd boot/recovery man pages.
- local filesystem, LVM, package and bootloader man pages.
- previous sprint documentation as subsystem reference.

### Альтернативные объяснения

- Debian Handbook maintenance and recovery chapters.
- *Systems Performance* methodology chapters.
- distribution recovery guides for actual VM.

### Углубление

- kdump and kernel crash analysis;
- eBPF tracing;
- forensic acquisition;
- disaster recovery automation;
- immutable/reprovisioned hosts;
- configuration drift detection.

### Справочные материалы

- `journalctl --list-boots`, `coredumpctl`, `systemd-analyze`.
- `debugfs`, `xfs_repair`, `btrfs check` only according to exact filesystem docs.

## Практические задания

### 1. Triage collector

Create `work/recovery-lab/triage.sh` producing sanitized timestamped bundle:

- OS/kernel/boot ID;
- uptime/load/CPU/memory/PSI;
- process tree and failed units;
- recent high-priority journal entries;
- mounts/block/LVM/capacity/inodes/deleted-open files;
- interfaces/routes/sockets/resolver/firewall summary;
- package audit and recent package transactions;
- users/sudo/SSH effective summary without hashes/keys;
- cgroup limits/events for selected service.

Requirements:

- read-only by default;
- bounded output and timeouts;
- no secrets/private keys/full environments;
- indicates unavailable commands and permissions;
- JSON/text manifest with hashes;
- tests against fixture directory where feasible.

### 2. Known-good comparison

For a unit, package, firewall ruleset and fstab create canonical copies/hash or Git-controlled configuration. Produce diff current vs known-good and classify generated/runtime fields that should not be compared literally.

### 3. Backup and restore

Back up lab service config and data to separate virtual disk or host-shared archive with checksums. Stop/quiesce service or use application-consistent snapshot. Delete/corrupt selected data, restore to alternate path, verify checksums and service behavior before replacing production path.

## Лабораторная работа

Create VM snapshot `before-recovery-incidents`, then prepare incidents. Apply one at a time or ask another person/tool to choose hidden subset.

### Incident 1. Broken unit dependency

Service waits for nonexistent mount/device. Find earliest dependency failure and correct unit/fstab relationship.

### Incident 2. Invalid fstab

Wrong UUID or option prevents normal boot. Recover through emergency/rescue mode, validate with `mount -a` and reboot.

### Incident 3. Broken initramfs

Current initramfs missing required module/file only on disposable kernel entry or copied boot setup. Boot previous kernel/rescue, rebuild initramfs and verify. Do not remove only working kernel.

### Incident 4. GRUB/kernel command line error

One-time/persistent parameter points to wrong root or target. Edit boot entry temporarily, boot, repair persistent config and regenerate config.

### Incident 5. Filesystem dirty/corrupt test image

Use copied loop image or disposable LV. Identify filesystem, unmount, run read-only check, repair with documented tool, remount and verify data hashes.

### Incident 6. Full blocks

Service fails because data filesystem full. Identify largest data, deleted-open files and safe cleanup. Verify free space and service recovery.

### Incident 7. Inode exhaustion

Writes fail despite free bytes. Diagnose `df -i`, remove generated tiny files safely, verify root cause.

### Incident 8. LVM exhaustion/snapshot risk

VG lacks extents or snapshot nearing invalidation. Inspect pvs/vgs/lvs, choose extend/cleanup and verify filesystem layer separately.

### Incident 9. Memory pressure/OOM

Service killed or throttled. Use PSI, memory.events, journal, smaps and cgroup config. Fix leak/limit/workload rather than only raising limit.

### Incident 10. CPU load

High load caused by CPU workers, uninterruptible I/O or oversubscription. Distinguish with task states, pidstat, vmstat and I/O evidence.

### Incident 11. Package transaction interrupted

Lab package unpacked but unconfigured or dependency missing. Use dpkg audit/logs and apt simulation; repair without deleting lock/database files blindly.

### Incident 12. Service crash/hang

Use journal, coredump, process state, strace and watchdog evidence. Separate crash from deadlock/blocking dependency.

### Incident 13. Network route/DNS/firewall

Client cannot reach service. Localize to bind/interface/route/resolver/firewall with layered tests and packet capture.

### Incident 14. Permission/identity failure

Service cannot access data due to UID change, stale group, ACL mask, mount option or capability. Identify exact authorization layer.

### Incident 15. SSH/sudo/PAM lockout

Recover through VM console/rescue. Validate config, restore narrow access and prove old insecure/broken path removed.

### Incident 16. Udev/device naming change

Storage mount references unstable kernel name. Recover using UUID/stable symlink and verify future reattach/reboot.

### Incident 17. Journal/log storage pressure

Journal or file logs fill filesystem; deleted-open rotation complicates cleanup. Apply bounded retention and correct reopen behavior.

### Incident 18. Namespace/cgroup residue

Failed launcher leaves mount, veth or cgroup. Find ownership/dependencies, terminate safely and clean without impacting unrelated resources.

## Recovery procedure requirements

For every incident record:

```text
Symptom and impact
Evidence preserved before changes
Scope and timeline
Hypotheses and discriminating tests
Root cause and trigger
Minimal change
Verification
Rollback
Prevention or detection improvement
```

Do not write long narrative if commands/artifacts already prove the conclusion.

## Additional experiment

Perform full bare-style restore into a new VM:

1. install minimal compatible OS or boot rescue;
2. recreate storage/mounts/users/packages;
3. restore config/data from backup;
4. enable service/network/firewall;
5. verify behavior and security;
6. measure recovery time and identify undocumented dependency.

Alternative: build automated reprovisioning script and compare with in-place repair.

## Самопроверка

1. What evidence is volatile and should be collected first?
2. How do symptom, trigger and root cause differ?
3. Why change one variable at a time?
4. How to identify correct root filesystem from rescue environment?
5. When is chroot needed?
6. Why run fsck only on appropriate offline filesystem?
7. How to distinguish full blocks, inodes and deleted-open files?
8. How to prove OOM versus crash?
9. Why can reboot hide evidence and temporarily mask issue?
10. What makes backup restorable?
11. How to recover remote access safely?
12. When is reprovisioning safer than in-place repair?

Practical check: receive one unknown broken VM, produce triage bundle, identify causal chain, restore service and verify cleanup without using snapshot unless recovery path fails.

## Результат для базы знаний

Recommended notes:

- **Linux diagnostic method** — scope, evidence, hypotheses, minimal change and verification.
- **Rescue environment and chroot** — mounting installed system and repair boundaries.
- **Boot recovery** — fstab, initramfs, bootloader and kernel entries.
- **Filesystem recovery** — identification, offline checks and data verification.
- **Package recovery** — dpkg states, logs and dependency repair.
- **Access recovery** — SSH, sudo, PAM and console fallback.
- **Backup and restore testing** — consistency, integrity, RPO/RTO and alternate restore.
- **Incident evidence** — volatile data, timeline and known-good comparison.

## Когда переходить дальше

Proceed to final project when at least twelve incidents, including boot, storage, memory, package, network and access recovery, are solved without snapshot rollback and recovery documentation is executable by another person.