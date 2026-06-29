# Спринт 10. Проверка памяти и хранения

Ориентировочный объём: 8–12 часов.

No new theory is introduced. First attempt is performed without rereading sprints 07–09.

## Проверяемые области

- Linux memory accounting, reclaim, swap and OOM;
- inode, links, permissions and ACL;
- filesystems, mounts, LVM and capacity diagnostics.

## Лабораторная система

Create isolated project `work/stateful-cache/`.

### Application

Go daemon `stateful-cache`:

- reads immutable source file;
- builds in-memory index;
- serves localhost HTTP lookup;
- appends request audit records;
- periodically writes snapshot with atomic rename;
- exposes optional pprof;
- handles SIGTERM and flushes state;
- runs under dedicated user.

### Storage

Use `vg_lab` from sprint 09:

- `lv_data` mounted `/srv/stateful-cache/data`;
- `lv_logs` mounted `/srv/stateful-cache/logs`;
- explicit ownership/ACL;
- fstab entries and systemd mount dependencies;
- optional swap LV.

### Service

systemd unit with:

- `RequiresMountsFor=` data/log paths;
- memory limit high enough for baseline;
- dedicated user/group;
- WorkingDirectory;
- journal plus file audit log;
- clean stop timeout.

## Часть 1. Baseline

Generate deterministic source data and checksum manifest. Start service and collect:

- mappings and smaps_rollup;
- `memory.current/stat/events`;
- filesystem block/inode usage;
- mounts and storage stack;
- open descriptors;
- file ownership/ACL;
- service journal;
- request correctness and restart persistence.

## Часть 2. Диагностические сценарии

### A. Cgroup memory OOM

Set service `MemoryMax` below index requirement. Determine whether failure is allocation error or cgroup OOM using journal and memory.events. Restore justified limit.

### B. Retained memory leak

Enable bug mode retaining every response. Detect rising anonymous memory, identify pprof retaining path and fix bounded lifecycle.

### C. Page cache confusion

Read large source repeatedly and compare RSS/PSS/page cache fields. Prove which growth is reclaimable and which belongs to process.

### D. Deleted-open log

Unlink active audit log. Show why space remains, locate descriptor, preserve needed data, restart/reopen correctly and release space.

### E. Inode exhaustion

On a small separate test LV/filesystem create tiny files until inode exhaustion. Demonstrate difference between `df -h` and `df -i`, then clean up.

### F. Hidden data by mount

Write file into mountpoint directory while filesystem is unmounted, then mount LV over it. Diagnose apparent missing file and hidden disk usage without deleting wrong layer.

### G. ACL regression

Remove one ACL mask/execute permission so service gets `EACCES`. Diagnose with effective credentials, `namei`, ACL and mount options. Do not solve with `chmod -R 777`.

### H. LVM snapshot fills

Create small snapshot, generate writes and observe Data% approaching full. Explain invalidation risk and remove/resize before failure.

### I. Bad fstab entry

Add wrong UUID for noncritical mount with/without `nofail` in separate attempts. Observe boot dependency and recover from emergency/rescue mode.

## Часть 3. Recovery proof

1. Create consistent application dataset checksum.
2. Create LVM snapshot.
3. Apply destructive logical changes.
4. Recover selected data from snapshot read-only.
5. Verify checksums and service behavior.
6. Explain why snapshot consistency may require application quiesce or filesystem freeze.

## Часть 4. Capacity runbook

Given alert «disk full», write executable decision tree using commands:

- identify filesystem/mount;
- check blocks and inodes;
- find largest reachable data;
- find deleted-open files;
- inspect logs/journal;
- inspect snapshot/thin metadata;
- avoid deleting active database/package files blindly;
- free space safely;
- verify service and persistence.

Runbook should be concise and tested against scenarios D–F.

## Теоретическая защита

1. Why can RSS, PSS and cgroup memory.current differ?
2. How to prove cgroup OOM?
3. Why may full page cache be healthy?
4. How does unlink interact with open descriptor and disk usage?
5. Why can ACL deny despite permissive group bits?
6. What does a mount hide?
7. Why do `df` and `du` disagree?
8. What does LVM snapshot preserve and what can make it invalid?
9. How can fstab break boot?
10. Which storage operations require offline filesystem?

## Критерии прохождения

- service correctness survives normal restart;
- all nine scenarios are reproduced on disposable resources;
- each cause is proven with specific evidence;
- no host/root filesystem is modified;
- OOM classification uses memory.events/journal;
- full-disk runbook works for blocks, inodes and deleted-open file;
- snapshot recovery verifies checksums;
- cleanup removes service, users, mounts, LVs and temporary files intentionally.

If blocked:

- memory/accounting/OOM → sprint 07;
- path/access/inodes → sprint 08;
- mounts/LVM/filesystem → sprint 09.

## Результат для базы знаний

No checkpoint-specific notes are required. Update previous notes only where observed behavior contradicted the model.