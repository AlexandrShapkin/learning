# Спринт 99. Итоговая работа

Ориентировочный объём: 28–45 часов.

## Задача

Build `linux-host-lab` — a reproducible single-host Linux service environment that can be installed, operated, broken, diagnosed and restored from documented evidence.

The goal is not to create a production platform. The project must demonstrate a coherent model of Linux from boot and identity to storage, service supervision, network, isolation, security and recovery.

## Итоговая архитектура

```text
Debian VM
├── bootloader + kernel + initramfs + systemd
├── users/groups/sudo/PAM policy
├── local signed APT repository
│   └── host-lab-agent package
├── LVM
│   ├── data LV and filesystem
│   ├── logs LV and filesystem
│   └── optional swap LV
├── systemd
│   ├── host-lab-agent.service
│   ├── maintenance.service/.timer
│   └── mount/device dependencies
├── network
│   ├── management SSH path
│   ├── application namespace/interface
│   └── nftables policy
├── cgroup/resource limits and sandboxing
├── journal + bounded audit/file logs
├── backup target on separate virtual disk
└── triage, verify, backup, restore and cleanup scripts
```

## Repository structure

Create inside sprint:

```text
work/linux-host-lab/
├── app/
├── packaging/
├── repository/
├── systemd/
├── storage/
├── network/
├── security/
├── backup/
├── incidents/
├── scripts/
│   ├── provision.sh
│   ├── verify.sh
│   ├── triage.sh
│   ├── backup.sh
│   ├── restore.sh
│   ├── inject-fault.sh
│   └── cleanup.sh
├── docs/
│   ├── architecture.md
│   ├── recovery.md
│   └── evidence-map.md
├── Makefile
└── README.md
```

README contains only prerequisites, safe execution order, verification and known limitations. Detailed theory belongs in `knowledge`.

## Application

Create Go service `host-lab-agent`:

- localhost/application-namespace HTTP endpoint;
- `/health`, `/ready`, `/version`, `/data/<key>`;
- persistent key/value or append-only test data on data LV;
- structured stdout logs and optional audit file;
- graceful SIGTERM;
- deterministic data generator and checksum;
- maintenance command compacting/verifying data;
- explicit test modes: CPU load, memory pressure, descriptor leak, deadlock/crash, disabled by default;
- pprof bound to localhost only in lab mode;
- no root requirement.

Correctness tests and race detector are mandatory.

## Stage 1. Reproducible base and inventory

Provision a fresh Debian VM from documented prerequisites. Record:

- OS and kernel;
- boot mode and storage topology;
- package sources;
- network interfaces;
- cgroup mode;
- active LSM;
- snapshot/backup boundaries.

Run environment checker and baseline triage. No secrets or machine IDs are stored.

## Stage 2. Package and repository

Build versioned Debian packages:

- application binary;
- systemd units;
- config template;
- sysusers/tmpfiles or service-account integration;
- man page and documentation;
- migration command for schema change.

Publish in local signed APT repository using scoped `signed-by` key. Test clean install, upgrade, downgrade where supported, conffile handling and purge.

## Stage 3. Identity and privilege

Create roles:

- service identity with no interactive login;
- operator with narrow inspect/restart permissions;
- auditor with read-only reports/log access;
- administrator via normal sudo policy;
- recovery through VM console/rescue.

Verify credentials, supplementary groups, ACL, capabilities and sudo rules automatically. Service must not run as root.

## Stage 4. Storage

Using disposable disks:

- create GPT/PV/VG/LVs;
- format and mount data/logs by stable identifiers;
- define fstab and systemd dependencies;
- set ownership/ACL/mount options;
- create optional swap;
- implement capacity/inode checks;
- create snapshot or application-consistent backup;
- verify restore to alternate location.

All destructive scripts verify device identity and require explicit confirmation.

## Stage 5. Service lifecycle

Create hardened `host-lab-agent.service`:

- correct Type/readiness model;
- dedicated user;
- runtime/state/log directories;
- graceful stop timeout;
- justified restart policy and rate limits;
- CPU/memory/pids controls;
- minimal writable paths;
- `NoNewPrivileges` and capability bounding;
- sandboxing compatible with application;
- mount/network dependencies without unnecessary `network-online`;
- journal metadata and health verification.

Create maintenance timer and prove missed-run behavior.

## Stage 6. Network

Place application in host or dedicated network namespace according to documented design. Configure:

- stable addresses/routes;
- resolver behavior;
- loopback and bind policy;
- management SSH separate from app path;
- nftables default-deny inbound policy;
- allow required management/application traffic only;
- atomic validation/apply and rollback timer;
- packet-capture verification.

Protocol-level load balancing/TLS PKI is outside scope unless added as optional extension.

## Stage 7. Security

Provide one-page threat model. Apply:

- package/repository verification;
- key-based SSH with safe rollout;
- least privilege and narrow sudo;
- file ownership/ACL and secret handling;
- systemd sandboxing;
- resource limits;
- targeted audit rules;
- bounded log retention;
- active security updates policy;
- inventory of listeners, setuid files and capabilities;
- console/rescue recovery path.

Every control has functional test and rollback.

## Stage 8. Observability and triage

Implement:

- `verify.sh` — intended state and end-to-end behavior;
- `triage.sh` — bounded read-only evidence bundle;
- journal queries for startup/work/shutdown/errors;
- timer/service/package/storage/network/security checks;
- process/cgroup/memory/PSI/socket/mount data;
- evidence map linking symptom to commands/artifacts.

Do not implement full monitoring platform.

## Stage 9. Backup and restore

`backup.sh` creates application-consistent backup to separate disk/archive with:

- config and package/version manifest;
- data and checksum manifest;
- unit/firewall/storage metadata needed for rebuild;
- no private SSH keys or unnecessary secrets;
- retention limited to lab.

`restore.sh` restores to alternate path/clean VM first. Verify data checksum, service behavior, ownership and security policy.

Measure RPO/RTO assumptions and actual recovery time.

## Stage 10. Fault injection catalogue

`inject-fault.sh` supports named, reversible faults. Each fault has precondition, effect, expected evidence, rollback and safety guard.

Mandatory faults:

1. `boot-fstab` — wrong noncritical/critical mount entry.
2. `boot-unit` — dependency/order failure.
3. `package-broken` — unconfigured/incompatible lab package.
4. `stale-binary` — package updated while old process runs.
5. `permission-acl` — service loses exact path access.
6. `capability` — required capability removed/bounded.
7. `memory-leak` — bounded retained memory.
8. `memory-oom` — cgroup limit below workload.
9. `cpu-throttle` — excessive CPU quota restriction.
10. `disk-blocks` — data filesystem fills.
11. `disk-inodes` — inode exhaustion on small lab FS.
12. `deleted-log` — unlinked open file retains space.
13. `lvm-snapshot` — snapshot approaches full.
14. `device-name` — unstable device reference breaks mount.
15. `service-crash` — process exits by signal/core.
16. `service-hang` — request or shutdown deadlock.
17. `timer` — maintenance timer misconfigured/non-idempotent.
18. `bind` — service listens on wrong address.
19. `route` — missing/wrong route.
20. `dns-nss` — resolver/NSS mismatch.
21. `firewall` — nftables drops new connection.
22. `namespace` — process/interface/mount in wrong namespace.
23. `ssh` — invalid/restrictive config caught before lockout.
24. `sudo` — broken/overbroad lab rule.
25. `logs` — journal/file retention pressure.

Fault injector must refuse non-lab host/device and must not silently repair fault.

## Stage 11. Blind incident exercise

Select at least ten faults, including:

- one boot;
- one memory;
- two storage;
- one package/service;
- one network;
- one access/security;
- one namespace/cgroup;
- two arbitrary combined failures.

First attempt uses only symptom statement. For each:

```text
Symptom and impact
Initial safety action
Evidence and timeline
Hypotheses
Discriminating test
Root cause/trigger
Minimal repair
Verification
Rollback
Prevention/detection improvement
```

At least two exercises must combine faults, for example full logs LV plus service restart loop, or wrong route plus firewall counter noise.

## Stage 12. Rescue restore

From rescue ISO or emergency environment:

1. identify installed root/boot/data devices;
2. mount correctly;
3. bind required pseudo-filesystems and chroot if needed;
4. repair one broken fstab/boot/initramfs/package/access scenario;
5. reboot normal system;
6. verify package, service, data, network and security;
7. restore from backup into fresh alternate VM or clean snapshot.

Snapshot rollback is allowed only after documenting why manual recovery failed.

## Required artifacts

Commit:

- application source and tests;
- package build metadata and scripts;
- sanitized systemd/network/security/storage configs;
- setup/verify/triage/backup/restore/fault/cleanup scripts;
- small fixtures;
- architecture and evidence map;
- concise incident cards;
- commands to regenerate large logs/traces;
- links to created/updated knowledge notes.

Do not commit:

- VM disks/snapshots/ISO;
- package caches and large `.deb` repository artifacts unless intentionally tiny;
- private keys/password hashes/tokens;
- full journals, pcap with unrelated traffic or core dumps;
- real host identifiers and secrets.

## Final defense

Answer with project evidence:

1. How does OS manage hardware resources?
2. Where is kernel/user boundary?
3. What happens during boot?
4. How are processes created, scheduled and terminated?
5. How are CPU and memory allocated/limited?
6. How are files, inodes, mounts and storage layers organized?
7. How do identities, permissions and privileges work?
8. How are packages, services, logs and timers managed?
9. How does application reach files, network and devices?
10. How are high load, memory pressure and full disk diagnosed?
11. Which Linux mechanisms create container isolation?
12. How is a host recovered after configuration or component failure?

Each answer must reference at least one command/output or incident from project.

## Completion criteria

The intensive is complete when:

- clean VM can be provisioned and verified from repository;
- package/repository/service/storage/network/security lifecycle works;
- application runs without root and passes tests/race detector;
- backup restores to alternate clean environment;
- all mandatory faults are safe and reversible;
- at least ten blind incidents are diagnosed from evidence;
- rescue repair and reboot succeed;
- cleanup leaves no unintended resources;
- main section questions are answered through mechanisms and evidence;
- generalized knowledge is transferred to `knowledge` without raw machine-specific duplication.

## Delayed assessment

After 7–14 days without rereading:

1. draw full boot-to-service-to-storage/network path;
2. explain twelve section questions;
3. deploy or inspect clean host from scripts;
4. diagnose three randomly selected incidents;
5. restore backup to alternate path or VM;
6. identify one design assumption that should be automated or documented better.

Only after delayed assessment should level 3–4 be considered retained.