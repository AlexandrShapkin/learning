# Спринт 14. Службы, журналы и планирование задач

Ориентировочный объём: 14–19 часов.

## Центральный вопрос

How does Linux reliably start, supervise, restrict, observe and periodically invoke long-running or scheduled workloads?

## Результат спринта

После завершения необходимо уметь:

- choose appropriate systemd service type and lifecycle;
- configure dependencies, restart policy, timeouts and environment;
- use socket/path/timer activation where justified;
- apply systemd identities, directories, capabilities and sandboxing;
- use cgroup-backed CPU/memory/task limits through unit properties;
- query structured journal fields and multiple boots;
- distinguish application log, journal, kernel log and audit log;
- configure persistent/volatile journal storage and retention consciously;
- create safe logrotate policy for file logs;
- diagnose service crash with exit status, signal and coredump;
- compare cron, at and systemd timers;
- explain monotonic versus calendar timers and missed-run behavior;
- package and uninstall service resources cleanly;
- avoid restart loops and log storms.

## Место в интенсиве

Boot sprint introduced units, and package sprint delivered files. This sprint builds production-like service lifecycle and observability on a single host.

## Основной маршрут

### Шаг 1. Service lifecycle

Read official man pages:

- `systemd.service(5)`;
- `systemd.exec(5)`;
- `systemd.kill(5)`;
- `systemd.resource-control(5)`;
- `systemd.unit(5)`;
- `systemctl(1)`.

Focus on Type, ExecStart, readiness, stop, restart and process tracking.

### Шаг 2. Activation and timers

Read:

- `systemd.socket(5)` overview;
- `systemd.path(5)`;
- `systemd.timer(5)`;
- `systemd.time(7)`;
- `systemd-run(1)`.

Compare persistent timer with cron after machine downtime.

### Шаг 3. Journal and logs

Read:

- `journalctl(1)`;
- `systemd-journald.service(8)`;
- `journald.conf(5)`;
- `systemd.journal-fields(7)`;
- `logrotate(8)`.

Understand structured metadata, boot IDs, rate limiting, storage and vacuuming.

### Шаг 4. Crashes and core dumps

Study:

- `coredumpctl(1)`;
- `systemd-coredump(8)`;
- `core(5)`;
- service exit status mapping.

Core dumps may contain secrets and should not be committed.

## Ресурсы

### Обязательный маршрут

- official systemd service/exec/resource/timer/journal man pages.
- Debian Handbook systemd and cron/at sections.
- logrotate and core man pages.

### Альтернативные объяснения

- systemd upstream documentation and examples.
- ArchWiki systemd and journal pages, verified against local man pages.
- Debian Policy chapter on system services.

### Углубление

- `sd_notify` and watchdog;
- socket activation;
- credentials API;
- portable services;
- journal remote/upload;
- systemd-homed/sysusers/tmpfiles;
- service sandboxing analysis.

### Справочные материалы

- `systemd-analyze security`.
- `systemd.sysusers(5)`, `tmpfiles.d(5)`.
- `cron(8)`, `crontab(5)`, `at(1)`.

## Практические задания

### 1. Unit semantics comparison

Create minimal units for Type=simple, oneshot and notify if application supports it. Observe active state, main PID and readiness. Explain why forking mode should not be chosen for modern foreground process without need.

### 2. Restart policy

For exit code, signal crash, clean stop and timeout, test `Restart=no`, `on-failure`, `always`; observe start rate limits. Choose policy per failure class.

### 3. Journal queries

Find entries by:

- unit;
- executable;
- PID;
- priority;
- current/previous boot;
- time interval;
- kernel transport;
- custom structured field.

Export selected entries as JSON and verify field meaning.

### 4. Timer semantics

Create timers:

- monotonic after boot;
- every 5 minutes;
- calendar daily;
- persistent calendar timer;
- randomized delay.

Use `systemd-analyze calendar` and simulate missed execution by stopping VM/time adjustment only in isolated lab.

## Лабораторная работа

Extend `lab-agent` from sprint 13 into `work/service-lab/`.

### Application

`lab-agent`:

- listens only on localhost;
- has `/health` and `/work` endpoints;
- writes structured logs to stdout/journal;
- optionally writes audit file under StateDirectory/LogsDirectory;
- handles SIGTERM and drains work;
- exposes version and config checksum;
- includes explicit crash and hang test modes available only via local CLI flag.

### Units

Create/package:

- `lab-agent.service`;
- `lab-agent-maintenance.service`;
- `lab-agent-maintenance.timer`;
- optional `lab-agent.socket` or `.path` with justified activation;
- tmpfiles/sysusers config if not using static package user.

### Service requirements

- dedicated unprivileged user or DynamicUser;
- `StateDirectory`, `RuntimeDirectory`, `LogsDirectory` where appropriate;
- no broad writable filesystem;
- `NoNewPrivileges=yes`;
- capability bounding set empty unless needed;
- `PrivateTmp=yes`;
- protect system/home settings justified and tested;
- memory/CPU/tasks limits that permit baseline;
- explicit restart and timeout policy;
- environment loaded without secrets in world-readable files;
- health check is not used as a substitute for process readiness without explanation.

### Observability

- custom journal fields such as `LAB_REQUEST_ID` or JSON logs;
- journal queries saved as commands, not full archive;
- one file log with logrotate policy demonstrating rename/copytruncate trade-off;
- coredump test in VM and deletion after analysis;
- timer result visible in journal and state file.

### Diagnostic scenarios

1. Wrong EnvironmentFile path.
2. Read-only filesystem sandbox blocks legitimate write.
3. Service binds address already in use.
4. MemoryMax triggers cgroup OOM.
5. Restart loop hits start limit.
6. Timer points to wrong service or command is not idempotent.
7. File log is rotated but process keeps old descriptor.
8. Journal rate limiting hides repeated messages.
9. Service crashes and core is disabled/limited by policy.
10. Package upgrade changes binary while old process still runs.

For each, establish earliest causal evidence and minimal fix.

### Verification

Provide `verify.sh` checking:

- service identity and capabilities;
- expected cgroup limits;
- only intended listen socket;
- writable paths;
- timer next/last trigger;
- journal query returns startup/work/shutdown events;
- no process/files/unit remain after uninstall.

## Дополнительный эксперимент

Implement `sd_notify` readiness/watchdog in Go and compare Type=notify with Type=simple. Reproduce startup hang and watchdog restart.

Alternative: socket activation with file descriptor passing, explaining why service can start after connection arrives.

## Самопроверка

1. What does systemd consider main process?
2. Why is daemonization often unnecessary under systemd?
3. How do restart policy and start limit interact?
4. What is difference between ordering and activation dependency?
5. Where does systemd store service processes?
6. How are journal entries associated with unit after process forks?
7. Why can logrotate fail to free space immediately?
8. How does persistent timer behave after downtime?
9. Why can core dump be sensitive?
10. What does `systemd-analyze security` score mean and not mean?

Practical check: given service failure, journal, unit properties and cgroup state, find root cause before changing restart policy or permissions.

## Результат для базы знаний

Recommended notes:

- **systemd service lifecycle** — types, readiness, stop and restart.
- **systemd execution environment** — users, directories, capabilities and sandboxing.
- **systemd resource control** — unit cgroups and limits.
- **systemd timers** — monotonic/calendar schedules and persistence.
- **systemd journal** — structured fields, boots, storage and retention.
- **Log rotation** — rename/reopen, copytruncate and deleted-open files.
- **Core dumps** — generation, storage, analysis and security.
- **Service diagnostics** — status, journal, process and resource evidence.

## Когда переходить дальше

Proceed when service package installs cleanly, units pass verification, timer and logs survive intended lifecycle, and all diagnostic scenarios are explained without disabling sandboxing broadly.