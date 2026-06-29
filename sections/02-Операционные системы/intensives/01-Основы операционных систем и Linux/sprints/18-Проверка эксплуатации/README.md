# Спринт 18. Проверка эксплуатации

Ориентировочный объём: 10–15 часов.

Новая теория не вводится. Первая попытка выполняется без повторного чтения спринтов 11–17.

## Проверяемые области

- devices and udev;
- identities, sudo, PAM and capabilities;
- packages and upgrades;
- systemd services, journal and timers;
- Linux networking and nftables;
- namespaces and cgroup v2;
- host hardening and remote administration.

## Исходная система

Create `work/ops-check/` using `lab-agent` from previous sprints.

### Required deployment

- installed from local signed APT repository;
- runs under dedicated service identity;
- uses systemd service and maintenance timer;
- listens on an address inside a dedicated network namespace or on host localhost through a documented proxy/forwarding path;
- stores data on lab filesystem/LV;
- has CPU, memory and pids limits;
- has minimal capabilities and systemd sandboxing;
- is reachable only from test client network through nftables;
- writes structured journal records and a rotated audit file;
- operator can inspect/restart through narrow sudo rule;
- auditor can read reports but not configuration or mutable data;
- package, unit and firewall changes have rollback commands.

## Часть 1. Baseline and dependency map

Before faults, create one diagram:

```text
APT repository → package files → identities/permissions → systemd unit/cgroup
→ namespace/network interface → socket → nftables → client
→ journal/audit file → timer/maintenance → data filesystem
```

For each arrow record one verification command. Do not duplicate raw outputs.

Baseline must include:

- installed/candidate package version and package checksum;
- effective unit definition and runtime properties;
- service credentials/capabilities;
- namespace IDs and cgroup path;
- listeners/routes/firewall counters;
- health response and data checksum;
- timer next/last run;
- journal query and audit log rotation state;
- SSH/sudo fallback access.

## Часть 2. Диагностические сценарии

Apply one fault at a time, restore baseline and verify before next.

### A. Package/config incompatibility

Install application v2 with old schema. Service exits with explicit migration error. Determine package transition, conffile state and safe rollback/migration.

### B. Stale running binary

Replace package binary while service stays running. Compare `/proc/$PID/exe`, inode/deleted state, package version and process start time. Restart intentionally and verify new version.

### C. Identity or ACL regression

Remove required execute/search or ACL mask on one path. Diagnose through effective service identity, `namei`, ACL and journal. Restore narrow permission.

### D. Capability/sandbox denial

Remove required capability or enable restrictive systemd option. Prove `EPERM/EACCES` through journal/strace/audit and add only the necessary permission.

### E. Wrong namespace placement

Service starts in host network namespace while configuration assumes isolated address, or interface remains in wrong namespace. Diagnose namespace IDs, links, routes and socket binding.

### F. Wrong bind address

Service listens on loopback or wildcard contrary to policy. Detect with `ss`, namespace context and client tests.

### G. Firewall drop

A syntactically valid nftables rule blocks new connections. Use counters, trace/logging and tcpdump; restore atomically without affecting SSH.

### H. DNS/NSS mismatch

`dig` succeeds but application `getaddrinfo` fails because NSS/resolver configuration differs. Diagnose with `getent`, resolver state and packet capture.

### I. CPU throttling

Set CPUQuota too low. Service remains correct but latency increases. Prove with `cpu.stat`, request timing and CPU utilization; do not call it network slowness.

### J. Memory high/OOM

Set MemoryHigh/MemoryMax below workload. Distinguish reclaim/throttling from cgroup OOM via memory.pressure/events and journal.

### K. Timer failure

Timer is active but service command is non-idempotent, points to wrong unit or lacks permissions. Use timer state, service journal and last result.

### L. Log retention failure

Audit file rotates but process keeps old descriptor, or journal reaches configured limit. Prove file descriptor/storage behavior and fix reopen strategy/retention.

### M. Udev identity regression

Stable device symlink disappears because rule matched kernel name or wrong parent attribute. Reconstruct event/rule processing and restore storage dependency.

### N. Privilege delegation flaw

Operator sudo wrapper accepts uncontrolled path/arguments enabling unintended action. Write exploit test, narrow input validation and prove denied path.

### O. SSH rollout error

New AllowGroups/key policy would lock operator out. Detect through effective `sshd -T -C`, second-session test and rollback timer before closing existing session.

## Часть 3. Controlled incident sequence

Randomly select five scenarios and apply without telling the diagnostic order. For each produce concise incident card:

```text
Symptom
Scope
Evidence
Hypotheses
Root cause
Change
Verification
Rollback
```

Each card should fit roughly one screen and reference raw artifact paths.

## Часть 4. Cleanup and rebuild

Destroy application deployment, namespace, cgroup, firewall table, users/groups, sudo/PAM lab rules and local repository configuration.

Then rebuild from repository scripts on clean VM snapshot. Verify baseline checksum and access policy.

## Теоретическая защита

1. How does package version become a running process?
2. What layers can deny an operation after Unix mode bits allow it?
3. How are unit, namespace and cgroup boundaries different?
4. What evidence separates bind failure, route failure and firewall drop?
5. How does CPU throttling differ from CPU saturation?
6. How does cgroup OOM differ from application error?
7. Why can installed binary and running executable differ?
8. Why can timer be active while task result is stale?
9. How should remote security change be rolled out safely?
10. What proves udev stable identity?
11. Why is successful health check not full correctness proof?
12. How do logs and audit differ in purpose?

## Критерии прохождения

- deployment is reproducible from signed repository;
- baseline dependency map is accurate;
- all fifteen faults are reproduced and reverted on disposable VM;
- five blind scenarios are solved from evidence;
- SSH access is never irreversibly lost;
- no broad permission/firewall/sandbox disabling is used as final fix;
- cleanup and clean rebuild succeed;
- at least 10 of 12 defense questions are answered with concrete evidence.

При затруднении:

- devices/udev → sprint 11;
- identities/privileges → sprint 12;
- packages → sprint 13;
- services/logs/timers → sprint 14;
- network/firewall → sprint 15;
- namespaces/cgroups → sprint 16;
- security/SSH/audit → sprint 17.

## Результат для базы знаний

No checkpoint-specific notes are required. Update only notes where incident evidence revealed an incomplete or incorrect model.