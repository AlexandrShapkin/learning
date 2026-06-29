# Спринт 06. Проверка основания Linux

Ориентировочный объём: 7–11 часов.

Новая теория не вводится. Первая попытка выполняется без повторного чтения спринтов 01–05.

## Проверяемые области

- shell and system inspection;
- kernel/user boundary;
- boot and systemd dependencies;
- processes, signals, sessions and job control;
- scheduling, affinity and rlimits.

## Исходный проект

Создать `work/checkpoint-runner/`:

```text
cmd/runnerd/
cmd/worker/
config/
systemd/
scripts/
Makefile
go.mod
```

`runnerd` запускает configurable number of workers, собирает их exit statuses, обрабатывает signals and writes concise structured logs.

## Часть 1. Реализация

### Worker

`worker` supports modes:

- `cpu` — bounded deterministic CPU work;
- `sleep` — waits and handles SIGTERM;
- `spawn` — creates one child worker;
- `leak-fd` — opens files until failure, only under explicit test flag;
- `fail` — exits with requested code.

### Runner

`runnerd` must:

- parse a small config file;
- launch workers in one process group or explicit groups;
- forward SIGTERM/SIGINT;
- apply configurable nice and rlimits before exec through wrapper/helper;
- wait and report statuses;
- enforce shutdown timeout;
- expose `--report` with PID/PGID/SID, open descriptors and scheduler fields;
- never leave workers after normal stop.

### systemd unit

Create `runnerd.service`:

- uses absolute paths;
- runs as dedicated laboratory user;
- has explicit WorkingDirectory;
- restarts only on defined failures;
- has `LimitNOFILE` and CPU affinity/nice settings;
- logs to journal;
- has install/uninstall scripts;
- does not require network.

## Часть 2. Предварительный прогноз

До первого run ответить:

1. Какие syscalls будут dominant during startup?
2. Какие resources inherit workers?
3. Как service stop reaches process group?
4. Что произойдёт при worker exit 17?
5. Как LimitNOFILE проявится в leak-fd mode?
6. Как nice and affinity видны через `/proc`/`ps`?
7. Which unit dependencies are ordering and which requirement?
8. What remains if runner exits without waiting?

Сохранить кратко в `PREDICTION.md`.

## Часть 3. Наблюдение

Collect:

```bash
systemctl status runnerd.service
systemctl show runnerd.service
journalctl -u runnerd.service
ps -eo pid,ppid,pgid,sid,cls,pri,ni,psr,stat,cmd --forest
strace -ff -e trace=%process,%signal,%desc ./runnerd ...
pidstat -u -w -t -p PID 1
```

Map every worker to process tree, process group, scheduling fields and unit cgroup.

## Часть 4. Диагностические сценарии

### A. Wrong environment assumption

Runner expects relative config path and works interactively but fails in systemd. Diagnose cwd/environment difference and fix with explicit path/WorkingDirectory.

### B. Wrong signal target

Stop sends SIGTERM only to direct child while grandchild survives. Prove with process tree and fix using process groups or appropriate systemd KillMode/design.

### C. Zombie

One code path forgets `Wait`. Observe zombie state and fix lifecycle.

### D. Restart loop

Service exits quickly and `Restart=always` hits start-limit. Diagnose earliest failure and correct restart policy.

### E. Descriptor limit

`LimitNOFILE=32` causes controlled failure. Find exact `EMFILE`, compare shell `ulimit` and service limits, then choose justified limit.

### F. CPU contention

Two workers pinned to one CPU with different nice values. Demonstrate relative share using completed work and scheduling evidence.

## Часть 5. Boot integration

Enable service, reboot VM and establish:

- when service started;
- whether it was on critical chain;
- which target pulled it in;
- previous boot logs;
- clean shutdown signal sequence.

Then disable it and verify no residual symlinks/processes.

## Теоретическая защита

Ответить без материалов:

1. How does shell pipeline become processes and descriptors?
2. Where is kernel/user boundary visible in runner?
3. What happens from systemd transaction to `execve`?
4. How are session, process group and unit cgroup different?
5. Why is a zombie different from a surviving orphan?
6. How do nice, affinity and rlimits change distinct aspects?
7. Why can service work manually but fail under systemd?
8. What evidence distinguishes dependency failure from executable failure?
9. What data in `/proc` is dynamic or race-prone?
10. What rollback removes checkpoint changes completely?

## Критерии прохождения

- runner and workers have tests;
- service starts, stops and survives reboot as designed;
- no process remains after stop;
- all six failures are reproduced and diagnosed;
- rlimit/nice/affinity effects are visible in evidence;
- boot and shutdown sequence is found in journal;
- install/uninstall leave no laboratory user, unit or file unexpectedly;
- at least 8 of 10 theoretical questions are answered correctly.

При затруднении:

- shell/path/streams → sprint 01;
- syscall/kernel interfaces → sprint 02;
- units/boot → sprint 03;
- process groups/signals/wait → sprint 04;
- scheduling/limits → sprint 05.

## Результат для базы знаний

Новые заметки специально для checkpoint не требуются. Исправить только заметки предыдущих спринтов, где practical evidence contradicted current model.