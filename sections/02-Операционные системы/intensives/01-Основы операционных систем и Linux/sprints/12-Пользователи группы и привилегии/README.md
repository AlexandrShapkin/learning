# Спринт 12. Пользователи, группы и привилегии

Ориентировочный объём: 12–16 часов.

## Центральный вопрос

Как Linux establishes process identity and grants only the privileges required for authentication, administration and service operation?

## Результат спринта

После завершения необходимо уметь:

- explain UID/GID, real/effective/saved IDs and supplementary groups;
- use `/etc/passwd`, `/etc/shadow`, `/etc/group`, `/etc/gshadow` safely;
- query identity through NSS and `getent`;
- create human and system accounts with correct lifecycle;
- manage password lock, expiry and shells;
- explain authentication, account, password and session phases of PAM;
- validate sudoers with `visudo` and implement command-specific delegation;
- distinguish su, sudo, setuid, ACL and capabilities;
- inspect and assign file capabilities to a controlled binary;
- explain privilege dropping and service accounts;
- audit effective identity and privilege boundaries;
- diagnose permission failures caused by identity, NSS, PAM, sudo or capabilities;
- avoid broad NOPASSWD shell-equivalent rules.

## Место в интенсиве

Filesystem permissions established object access rules. This sprint focuses on process credentials, authentication and controlled privilege elevation used by services and administrators.

## Основной маршрут

### Шаг 1. Identity and NSS

Read:

- `credentials(7)`;
- `passwd(5)`, `shadow(5)`, `group(5)`, `gshadow(5)`;
- `nsswitch.conf(5)`;
- `getent(1)`;
- `id(1)`.

Understand that local files are one NSS source; applications should not assume all identities exist in `/etc/passwd`.

### Шаг 2. Account lifecycle

Study:

- `useradd(8)`, `usermod(8)`, `userdel(8)`;
- `groupadd(8)`, `gpasswd(1)`;
- `passwd(1)`, `chage(1)`;
- `login.defs(5)`.

Differentiate locked password, expired account, nologin shell and disabled service.

### Шаг 3. sudo and PAM

Read:

- `sudo(8)`, `sudoers(5)`, `visudo(8)`;
- Linux-PAM System Administrators' Guide;
- `pam.d(5)`, `pam.conf(5)`;
- modules used by current login/sudo stack via local man pages.

Do not modify production PAM stack. Mandatory experiment uses a separate PAM service file.

### Шаг 4. Capabilities and setuid

Read:

- `capabilities(7)`;
- `getcap(8)`, `setcap(8)`, `capsh(1)`;
- `setuid(2)`, `setgid(2)` overview;
- `no_new_privs` in `prctl(2)`.

Understand permitted, effective, inheritable, bounding and ambient sets at overview level.

## Ресурсы

### Обязательный маршрут

- Linux credentials and account file man pages.
- sudo upstream/local man pages.
- Linux-PAM administrator guide.
- `capabilities(7)`.

### Альтернативные объяснения

- Debian Administrator's Handbook chapters on users and sharing admin rights.
- *The Linux Programming Interface*, credentials chapters.
- systemd `User=`, `DynamicUser=` and credentials docs as practical examples.

### Углубление

- LDAP/SSSD identity sources;
- Kerberos;
- user namespaces and ID mapping;
- PAM module development;
- Linux Security Modules;
- polkit and desktop authorization.

### Справочные материалы

- `su(1)`, `runuser(1)`, `setpriv(1)`.
- `systemd.exec(5)` user/privilege options.

## Практические задания

### 1. Credential inspection

Write small C or Go helper that prints:

- real/effective/saved UID/GID where available;
- supplementary groups;
- capabilities from `/proc/self/status`;
- `NoNewPrivs` and seccomp state;
- login name versus effective identity.

Run as normal user, through `sudo`, `su`, `runuser` and service account. Explain differences.

### 2. Account states

Create disposable users representing:

- interactive operator;
- locked former user;
- service account with nologin shell;
- temporary user with expiry;
- user whose password is locked but SSH key scenario is conceptually considered.

Use `getent`, `passwd -S`, `chage -l` and login attempts in VM console. Clean up afterward.

### 3. Sudo rule analysis

For each proposed rule identify escalation risk:

```text
ALL=(ALL) NOPASSWD: /bin/bash
systemctl restart *
vim /etc/app.conf
cp * /etc/app.conf
journalctl -u app.service
```

Design least-privilege alternatives with exact commands, arguments or controlled wrapper that validates input.

### 4. Capability versus setuid

Build helper binding TCP port below 1024 or performing another controlled privileged action. Compare:

- normal binary;
- root execution;
- setuid-root test binary inside VM;
- file capability such as `cap_net_bind_service=ep`;
- systemd AmbientCapabilities/CapabilityBoundingSet.

Remove setuid/capabilities at end. Explain mount `nosuid` and `NoNewPrivileges` effects.

## Лабораторная работа

Create `work/identity-lab/`.

### Roles

- `labapp` — noninteractive service account;
- `laboperator` — can inspect and restart only lab service;
- `labauditor` — can read selected logs/reports but not config/data;
- `labadmin` — temporary broader lab-only administrator;
- groups `labops`, `labaudit`.

### Service resources

Under `/srv/identity-lab` create config, data, runtime and reports with ownership, modes and ACLs matching roles. Automated tests run commands as each identity and assert allowed/denied cases.

### Sudo delegation

Create `/etc/sudoers.d/identity-lab` using exact lab commands or a root-owned wrapper. Requirements:

- validated by `visudo -cf` before install;
- operator cannot edit unit/config or invoke arbitrary pager/editor shell;
- environment is reset;
- command logging enabled where supported;
- no wildcard that expands to arbitrary service or path;
- uninstall removes rule.

### PAM sandbox

If `pamtester` is available, create `/etc/pam.d/identity-lab` referencing safe standard modules without changing `login`, `sshd`, `sudo` or `su` stacks.

Test authentication/account phases for active, locked and expired lab users. If `pamtester` unavailable, trace an isolated `su`/application stack without editing global configuration.

### Privilege-dropping service

Run a small service initially via systemd as root only if required to bind/open resource, then drop to `labapp`, or preferably let systemd provide capability and start directly as `labapp`.

Verify effective IDs/capabilities after startup and prove it cannot read root-only test file.

### Diagnostic scenarios

1. User exists in NSS but not local `/etc/passwd` assumption.
2. Group membership changed but old session has stale supplementary groups.
3. Sudo rule syntactically valid but allows shell escape through pager/editor.
4. PAM account phase denies expired user despite correct password.
5. Capability missing from bounding set.
6. File capability ignored because filesystem/mount policy.
7. Service account has accidental interactive shell/home ownership.

## Дополнительный эксперимент

Use `systemd-run -p DynamicUser=yes` for a transient service. Inspect allocated identity, private directories and cleanup. Compare static service account and DynamicUser trade-offs.

Alternative: create user namespace with mapped root and demonstrate that UID 0 inside does not equal full host root capabilities.

## Самопроверка

1. Why are UID and username different concepts?
2. What does NSS provide?
3. How do real and effective IDs differ?
4. What happens to supplementary groups after membership change?
5. What are PAM management groups?
6. Why can a narrow-looking sudo command allow shell escape?
7. How is setuid different from file capabilities?
8. What does capability bounding set do?
9. Why is a locked password not always equivalent to disabled account?
10. Why should services use separate identities?

Practical check: given an authorization failure, locate layer among NSS, credentials, pathname permissions/ACL, PAM, sudo, capability set, mount and LSM without broad privilege changes.

## Результат для базы знаний

Recommended notes:

- **Linux users and groups** — UID/GID, NSS and account databases.
- **Process credentials** — real/effective/saved IDs and supplementary groups.
- **PAM** — stack phases, modules and service files.
- **sudo** — policy, environment, command delegation and escape risks.
- **Service accounts** — lifecycle and least privilege.
- **setuid and setgid** — credential transition and risks.
- **Linux capabilities** — capability sets, file capabilities and bounding.
- **Privilege dropping** — startup patterns and verification.

## Когда переходить дальше

Proceed when role tests pass, sudoers is validated and non-escalating, PAM experiment is isolated, and effective service privileges are proven from runtime state.