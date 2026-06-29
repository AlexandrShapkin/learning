# Спринт 13. Пакеты и жизненный цикл программ

Ориентировочный объём: 12–17 часов.

## Центральный вопрос

Как distribution transforms software into verifiable packages, resolves dependencies and performs controlled installation, upgrade and removal?

## Результат спринта

После завершения необходимо уметь:

- distinguish upstream source, package, repository and installed files;
- explain roles of dpkg and APT;
- inspect package metadata, ownership, dependencies and conffiles;
- use `apt update`, simulated upgrade and policy inspection safely;
- understand repository suites, components and priorities;
- explain repository signature verification and trust boundary;
- distinguish install, remove, purge, autoremove and hold;
- diagnose broken dependencies and interrupted configuration;
- locate package providing a file and verify installed content;
- build a simple deterministic `.deb` for a lab application;
- create and consume a local signed APT repository;
- test package upgrade, conffile behavior, service integration and rollback;
- avoid mixing incompatible distribution suites.

## Место в интенсиве

Services and system tools are delivered as packages. Before managing long-running units, this sprint establishes how files, dependencies and upgrades enter the system.

## Основной маршрут

### Шаг 1. dpkg package model

Read:

- `deb(5)`;
- `deb-control(5)`;
- `dpkg(1)`;
- `dpkg-query(1)`;
- `dpkg-deb(1)`;
- Debian Policy chapters on package structure, scripts and conffiles.

### Шаг 2. APT and repositories

Read Debian Handbook chapter 6 and:

- `apt(8)`;
- `apt-get(8)`;
- `apt-cache(8)`;
- `sources.list(5)`;
- `apt_preferences(5)`;
- `apt-secure(8)`.

Understand metadata refresh separately from package upgrade.

### Шаг 3. Lifecycle and recovery

Study:

```bash
apt-get -s upgrade
apt-cache policy PACKAGE
apt-mark showhold
apt-mark showauto
sudo dpkg --audit
sudo dpkg --configure -a
sudo apt-get -f install
```

Recovery commands are used only after identifying package state and on VM snapshot.

### Шаг 4. Package verification

Use:

- `dpkg -S PATH`;
- `dpkg -L PACKAGE`;
- `apt-file search`;
- package checksums under `/var/lib/dpkg/info`;
- `debsums` if installed;
- `apt changelog` and package source metadata.

## Ресурсы

### Обязательный маршрут

- Debian Administrator's Handbook APT chapter.
- APT User's Guide.
- dpkg and package format man pages.
- Debian Policy package lifecycle sections.

### Альтернативные объяснения

- Debian Reference package management chapters.
- Debian New Maintainers' Guide for package build context.
- Fedora RPM/DNF documentation as comparison, not mandatory practice.

### Углубление

- full Debian source package with debhelper;
- reproducible builds;
- pinning and backports;
- unattended upgrades;
- package triggers and alternatives;
- local repository management with reprepro/aptly;
- SBOM and provenance.

### Справочные материалы

- https://www.debian.org/doc/debian-policy/
- https://www.debian.org/doc/manuals/apt-guide/
- `update-alternatives(1)`, `dpkg-divert(1)`.

## Практические задания

### 1. Package ownership

Choose five system files and determine:

- owning package;
- package version and source package;
- checksum/conffile status;
- dependencies/reverse dependencies;
- repository candidate and installed priority;
- whether file is generated or packaged.

### 2. Simulation before change

Run update and simulated upgrade. Explain held, kept-back, newly installed and removed packages. Do not execute major upgrade until simulation is understood and snapshot exists.

### 3. Removal semantics

Install a small disposable package, change its config, then compare remove, reinstall and purge. Observe dpkg status and conffile persistence.

### 4. Broken dependency sandbox

Build two lab packages where app depends on exact library package version. Attempt incompatible upgrade using local files, observe dpkg state, then repair through correct repository/version. Do not break essential distribution packages.

## Лабораторная работа

Create `work/package-lab/` with application `lab-agent`.

### Package contents

```text
/usr/bin/lab-agent
/usr/lib/systemd/system/lab-agent.service
/usr/lib/systemd/system/lab-agent.timer
/etc/lab-agent/config.yaml
/usr/share/doc/lab-agent/README.Debian
/usr/share/man/man1/lab-agent.1.gz
/var/lib/lab-agent/  # created by package/service mechanism, not embedded mutable content
```

Prefer tmpfiles/sysusers or maintainer scripts only when justified. Package must not start unsafe network service automatically.

### Versions

Build:

- `lab-agent_1.0.0-1`;
- `lab-agent_1.1.0-1` with compatible config;
- `lab-agent_2.0.0-1` requiring migration or rejecting old schema.

### Requirements

- deterministic build script records source commit and compiler version;
- `dpkg-deb --info` and `--contents` pass inspection;
- permissions/ownership are correct;
- conffile behavior is intentional;
- install, upgrade, downgrade and purge are tested on VM snapshot;
- service user/data survive or are removed according to documented policy;
- package scripts use `set -e` carefully and are idempotent;
- no secret generated into repository.

### Local signed repository

Create repository under `work/package-lab/repo/` using `dpkg-scanpackages` or repository tool. Generate ephemeral signing key for lab only, sign Release metadata and configure source with `signed-by=` keyring.

Verify:

```bash
apt update
apt-cache policy lab-agent
apt install lab-agent
apt upgrade
```

Then tamper with package/index and prove APT rejects unsigned or checksum-mismatched content.

### Failure scenarios

1. Repository metadata stale.
2. Candidate version comes from unintended priority.
3. Package postinst fails halfway.
4. Conffile modified locally during upgrade.
5. Dependency package unavailable.
6. Service fails after package upgrade.
7. User attempts to trust repository with deprecated global `apt-key` approach.

Diagnose using apt/dpkg logs, status database, policy and package scripts.

## Дополнительный эксперимент

Build a proper Debian source package with `debuild`/`dpkg-buildpackage` and debhelper, then inspect build dependencies and reproducibility. Compare binary-only handcrafted package with policy-compliant packaging.

Alternative: compare RPM metadata/lifecycle in a Fedora VM without converting packages between formats.

## Самопроверка

1. How do dpkg and APT responsibilities differ?
2. What does `apt update` change?
3. What is candidate version?
4. Why does repository signature not make every package bug-free?
5. What is a conffile?
6. How do remove and purge differ?
7. What does auto-installed mean?
8. Why is mixing stable/testing/unstable dangerous?
9. How do package maintainer scripts affect rollback?
10. How can package ownership help incident diagnosis?

Practical check: given failed package upgrade, determine current dpkg state, candidate source, failing script/dependency and safest recovery without blindly deleting package database locks.

## Результат для базы знаний

Recommended notes:

- **Linux package** — metadata, payload, scripts and conffiles.
- **dpkg** — local package database and lifecycle.
- **APT** — repositories, dependency resolution and candidates.
- **Repository trust** — signed metadata, key scope and checksums.
- **Package upgrade and rollback** — compatibility, scripts and data migration.
- **Package ownership and verification** — file provenance and integrity checks.
- **Debian package states** — unpacked, configured, triggers and broken states.

## Когда переходить дальше

Proceed when local signed repository works, tampering is rejected, three package versions exercise upgrade behavior, and broken package state is repaired through evidence rather than manual deletion of dpkg metadata.