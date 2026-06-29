# Спринт 17. Безопасность и удалённое администрирование

Ориентировочный объём: 14–20 часов.

## Центральный вопрос

How can a Linux host minimize attack surface and privilege while remaining observable, maintainable and recoverable?

## Результат спринта

После завершения необходимо уметь:

- create basic host threat model and asset/trust boundaries;
- inventory exposed services, users, packages and privileged files;
- secure SSH key authentication and validate config before reload;
- preserve fallback access during remote changes;
- use least privilege through service users, sudo and capabilities;
- apply nftables host firewall with tested rollback;
- manage security updates and verify repository trust;
- use auditd for targeted evidence without uncontrolled log volume;
- inspect setuid files, file capabilities and listening sockets;
- apply systemd sandboxing based on service needs;
- understand roles of seccomp, AppArmor/SELinux/Landlock at overview level;
- protect secrets and file permissions;
- identify insecure sysctl/config patterns without cargo-cult hardening;
- recover from SSH/firewall/sudo/PAM mistakes in VM console;
- distinguish prevention, detection and recovery controls.

## Место в интенсиве

All mechanisms studied so far become security boundaries or attack surface. This sprint integrates identity, packages, services, network, namespaces and logging.

## Основной маршрут

### Шаг 1. Threat model and inventory

Read Securing Debian Manual introduction and relevant host sections:

- https://www.debian.org/doc/manuals/securing-debian-manual/

Create inventory categories: remote entry, local users, privileged processes, mutable config, secrets, package sources, data and recovery channel.

### Шаг 2. OpenSSH

Read official manuals:

- https://www.openssh.com/manual.html
- `sshd(8)`;
- `sshd_config(5)`;
- `ssh(1)`, `ssh_config(5)`;
- `authorized_keys(5)`.

Use `sshd -t` and `sshd -T` before reload. Do not close existing session until new session succeeds.

### Шаг 3. Host controls

Review:

- nftables from sprint 15;
- sudo/capabilities from sprint 12;
- package trust from sprint 13;
- systemd sandboxing from sprint 14;
- `sysctl` security-related docs;
- `findmnt` options such as nosuid/nodev/noexec with limitations.

### Шаг 4. Audit and mandatory controls

Read:

- `auditd(8)`, `auditctl(8)`, `audit.rules(7)`, `ausearch(8)`, `aureport(8)`;
- current LSM state in `/sys/kernel/security/lsm`;
- AppArmor or SELinux distribution docs if active;
- seccomp and Landlock overviews.

Mandatory practice uses targeted audit rules, not broad `-w /` monitoring.

## Ресурсы

### Обязательный маршрут

- Securing Debian Manual.
- OpenSSH official manuals.
- nftables, sudo, capabilities, systemd sandboxing and audit man pages.
- Debian security and update documentation.

### Альтернативные объяснения

- Debian Administrator's Handbook security chapters.
- CIS Benchmark only as a checklist source if legally available; every control requires threat/context validation.
- ANSSI Linux configuration recommendations as additional checklist.

### Углубление

- AppArmor/SELinux policy authoring;
- measured boot and TPM;
- disk encryption and key management;
- FIDO2 SSH keys;
- file integrity monitoring;
- incident forensics;
- supply-chain provenance and reproducible builds.

### Справочные материалы

- `systemd-analyze security`.
- `find(1)` queries for setuid/setgid.
- `ss`, `getcap`, `last`, `lastlog`, `faillog` where applicable.

## Практические задания

### 1. Attack surface inventory

Collect and classify:

- listening sockets and owning units;
- enabled services/timers;
- human/system accounts;
- sudo rules;
- setuid/setgid executables;
- file capabilities;
- world-writable directories/files with filesystem boundaries respected;
- package sources and pending security updates;
- firewall rules;
- SSH effective configuration;
- active LSM and audit status.

For each item decide keep, restrict, remove or monitor, with evidence.

### 2. SSH key policy

Create laboratory operator key and account. Configure:

- key-only authentication for lab account after successful test;
- root login disabled or restricted according to lab policy;
- AllowUsers/AllowGroups only if rollback path exists;
- idle/session forwarding settings justified;
- authorized key restrictions for a forced-command key.

Test `sshd -t`, start second session, then reload. Never use real private key in repo.

### 3. Firewall policy

Implement default-deny inbound policy allowing established traffic, loopback and SSH from lab subnet plus application port if required. Validate ruleset and schedule automatic rollback before applying during remote session.

### 4. Audit evidence

Add temporary rules for:

- changes to lab sudoers/unit/config;
- execution of one privileged lab command;
- writes to protected data directory.

Generate events, find them via `ausearch` and remove rules. Measure log volume.

## Лабораторная работа

Create `work/hardening-lab/` for service from sprint 14.

### Threat model

Document in one page:

- assets;
- entry points;
- trust boundaries;
- attacker assumptions;
- unacceptable outcomes;
- recovery channel.

### Baseline

Record:

- service user/capabilities;
- writable paths;
- syscalls/operations actually needed;
- network listeners;
- package source/version;
- firewall path;
- logs/audit evidence;
- backup/restore path.

### Controls

Apply and test:

- dedicated identity;
- least file/ACL access;
- empty capability bounding set or only required capability;
- `NoNewPrivileges`;
- systemd filesystem/private-device/kernel tunable restrictions compatible with service;
- CPU/memory/pids limits;
- localhost or specific-address bind;
- nftables allowlist;
- SSH admin path separated from app service;
- package update policy;
- targeted audit rules;
- secret file mode and non-logging guarantee.

### Failure and rollback scenarios

1. SSH config invalid — caught by `sshd -t`.
2. Firewall would lock out session — rollback timer restores previous rules.
3. Sudoers syntax error — caught by `visudo`.
4. PAM lab rule denies account — console/rescue path remains.
5. systemd sandbox blocks required operation — use audit/journal evidence and narrow exception.
6. Capability removed unexpectedly — prove EPERM and restore only required capability.
7. Package update changes config/conffile.
8. Audit rule produces too much noise.
9. Secret accidentally appears in environment/log — redesign injection and rotate lab secret.
10. Service compromised simulation attempts access to host files/network and is constrained.

### Verification script

`verify-hardening.sh` asserts intended identity, capabilities, writable paths, listeners, firewall, unit properties, SSH effective config and audit rule state. It must not claim absolute security.

## Дополнительный эксперимент

Create minimal seccomp profile for service or use `SystemCallFilter=` in systemd. Start from observed syscall set, add failure tests and document why allowlisting based on one trace can be incomplete.

Alternative: confine service with active AppArmor/SELinux and inspect denial audit records.

## Самопроверка

1. What is threat model used for?
2. Why is disabling all features not automatically secure operation?
3. How do prevention, detection and recovery differ?
4. Why validate SSH and sudo config before activation?
5. How can remote firewall change be made recoverable?
6. What does least privilege mean for service?
7. Why are setuid and capabilities attack surface?
8. What does systemd sandboxing not protect from?
9. How does repository trust relate to host security?
10. Why can audit rules become denial-of-service/noise source?
11. What does LSM add beyond Unix permissions?

Practical check: given a hardening change that broke service, identify required operation, prove denial layer and add narrow exception rather than disabling the whole control.

## Результат для базы знаний

Recommended notes:

- **Linux host threat model** — assets, entry points, trust and recovery.
- **OpenSSH hardening** — authentication, effective config and safe rollout.
- **Least privilege for services** — identity, capabilities and writable paths.
- **Host firewall** — default policy, state and rollback.
- **Linux audit** — targeted rules, events and limitations.
- **systemd sandboxing** — isolation options, evidence and compatibility.
- **Linux Security Modules** — mandatory policy layer overview.
- **Security updates and repository trust** — package provenance and maintenance.
- **Secure configuration change** — validation, second session and rollback.

## Когда переходить дальше

Proceed when hardening is verified by tests, SSH/firewall changes have proven rollback, audit rules produce useful evidence, and service remains functional with narrowly justified privileges.