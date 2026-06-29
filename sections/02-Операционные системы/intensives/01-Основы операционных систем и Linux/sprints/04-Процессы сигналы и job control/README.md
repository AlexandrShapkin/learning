# Спринт 04. Процессы, сигналы и job control

Ориентировочный объём: 12–16 часов.

## Центральный вопрос

Как Linux представляет выполняемую программу, связывает процессы в дерево и управляет их жизненным циклом, terminal ownership и завершением?

## Результат спринта

После завершения необходимо уметь:

- различать program, process, thread и task;
- объяснять PID, PPID, TID и process tree;
- объяснять fork/clone, exec и wait;
- читать process state через `/proc` и `ps`;
- различать running, runnable, sleeping, stopped, zombie и dead states;
- объяснять session, process group, controlling terminal и foreground group;
- использовать shell job control;
- объяснять signal disposition, mask, pending signals и default actions;
- корректно завершать process tree и избегать orphaned children;
- воспроизводить zombie и orphan process;
- использовать `pstree`, `ps`, `pgrep`, `pidwait`, `strace` и `/proc/<pid>`;
- объяснять PID 1 responsibilities и subreaper behavior на обзорном уровне.

## Место в интенсиве

Boot заканчивается запуском services и user sessions. Теперь изучается базовая единица выполнения, на которой основаны scheduling, memory accounting, services, containers и diagnostics.

## Основной маршрут

### Шаг 1. Process abstraction и API

Прочитать OSTEP:

- chapter 4 «The Abstraction: The Process»;
- chapter 5 «Interlude: Process API»;
- chapter 6 «Mechanism: Limited Direct Execution».

Из TLPI прочитать chapters о processes, process creation/termination и child monitoring либо соответствующие man pages:

- `fork(2)`;
- `clone(2)` обзорно;
- `execve(2)`;
- `wait(2)`;
- `_exit(2)`.

### Шаг 2. `/proc` и process state

Изучить:

- `proc_pid_stat(5)`;
- `proc_pid_status(5)`;
- `proc_pid_cmdline(5)`;
- `proc_pid_environ(5)`;
- `proc_pid_fd(5)`;
- `ps(1)`.

Сравнить command line, executable, cwd, open descriptors, environment и kernel state. Учитывать permissions и races при чтении `/proc`.

### Шаг 3. Signals

Прочитать:

- `signal(7)`;
- `sigaction(2)`;
- `kill(2)`;
- `sigprocmask(2)`;
- `signalfd(2)` обзорно.

Понять, какие signals catchable, blockable и queueable, а также почему signal handler ограничен async-signal-safe operations.

### Шаг 4. Sessions и job control

Прочитать TLPI chapters о process groups, sessions и job control либо:

- `credentials(7)`;
- `setsid(2)`;
- `setpgid(2)`;
- `termios(3)` обзорно;
- Bash manual, Job Control.

## Ресурсы

### Обязательный маршрут

- OSTEP chapters 4–6.
- Linux man pages process lifecycle and signals.
- Bash Job Control documentation.

### Альтернативные объяснения

- *The Linux Programming Interface*, process and signal chapters.
- *Advanced Programming in the UNIX Environment*, process control and signals.
- Debian Reference sections on process management.

### Углубление

- `pidfd_open` and race-free process management;
- subreapers and supervisors;
- `clone3`;
- ptrace;
- signal delivery to multithreaded processes;
- terminal line discipline.

### Справочные материалы

- `pstree(1)`, `pgrep(1)`, `pidwait(1)`, `prctl(2)`.
- `proc(5)`.

## Практические задания

### 1. Process identity

Для interactive shell и child process определить:

- PID/PPID;
- session ID;
- process group ID;
- controlling TTY;
- foreground process group;
- threads;
- open descriptors;
- cwd/root/exe symlinks;
- inherited environment subset.

Проверить через `ps -o`, `/proc`, `readlink` и `ls -l /proc/$PID/fd`.

### 2. Fork/exec/wait

Написать C helper `lifecycle.c`, который:

1. печатает PID/PPID/PGID/SID;
2. создаёт two children;
3. один child завершается с code 42;
4. второй выполняет `execve` helper;
5. parent ждёт обоих через `waitpid`;
6. декодирует exit/signal status.

Снять `strace -f -e trace=%process,%signal` и связать output с API.

### 3. Zombie и orphan

Создать controlled programs:

- zombie: child exits, parent не вызывает wait в течение 30 seconds;
- orphan: parent exits first, child продолжает и наблюдает new PPID.

Найти state через `ps` и `/proc`. Не оставлять процессы после задания.

### 4. Job control

В interactive Bash:

- запустить pipeline в foreground;
- остановить `Ctrl-Z`;
- продолжить `bg`;
- вернуть `fg`;
- отправить signal всей process group;
- запустить command через `setsid`;
- сравнить SIGHUP behavior при закрытии terminal и `nohup`/systemd-run.

## Лабораторная работа

Создать `work/supervisor/` с программой `minisupervisor` на Go или C.

### Функциональность

```text
minisupervisor run --grace 5s -- command args...
```

Supervisor должен:

- запускать child в отдельной process group;
- перенаправлять или наследовать stdout/stderr по explicit option;
- обрабатывать SIGINT, SIGTERM и SIGHUP;
- пересылать signals process group;
- ждать child и всех известных descendants, насколько позволяет выбранная design;
- после grace period отправлять SIGKILL;
- возвращать meaningful exit status;
- не оставлять zombie;
- логировать lifecycle with timestamps;
- корректно обрабатывать failure before exec.

### Tests

Создать helper workloads:

- immediate success;
- exit code 17;
- ignore SIGTERM;
- spawn child that sleeps;
- child handles SIGTERM gracefully;
- child crashes by signal;
- command not found;
- rapid child exit before signal setup.

Tests должны проверять отсутствие surviving process group через `kill(-pgid, 0)`/`ps` и timeout.

### Наблюдение

Снять:

```bash
strace -ff -e trace=%process,%signal ./minisupervisor ...
ps -eo pid,ppid,pgid,sid,stat,tty,cmd --forest
```

Объяснить exact sequence spawn → signal → wait → exit.

## Дополнительный эксперимент

Использовать `prctl(PR_SET_CHILD_SUBREAPER)` в C version или отдельном helper. Создать grandchild, parent которого exits, и сравнить reparenting с обычным mode.

Альтернатива: использовать pidfd API для ожидания и signal delivery, объяснив, какую PID-reuse race он устраняет.

## Самопроверка

1. Чем program отличается от process?
2. Что наследуется при `fork`, а что заменяется при `exec`?
3. Почему zombie не потребляет обычный address space, но остаётся проблемой?
4. Кто обязан вызвать `wait`?
5. Чем process group отличается от session?
6. Как terminal выбирает foreground process group?
7. Почему `kill` может адресовать process group?
8. Почему SIGKILL нельзя поймать?
9. Чем signal mask отличается от disposition?
10. Почему shell background job и daemon не одно и то же?

Практическая проверка: по process tree and states восстановить lifecycle unknown command and identify unreaped child or wrong signal target.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Процесс Linux** — identity, resources, state and lifecycle.
- **Создание и запуск процесса** — fork/clone, exec and wait.
- **Состояния процесса** — runnable, sleeping, stopped, zombie.
- **Сигналы** — delivery, masks, dispositions and default actions.
- **Process groups и sessions** — job control and terminal ownership.
- **Zombie и orphan processes** — causes, reaping and supervision.
- **PID 1 и subreaper** — child adoption and service supervision.

## Когда переходить дальше

Можно переходить, когда supervisor passes tests, process groups and sessions are visible in evidence, and zombie/orphan/signal behaviors are explained without relying on shell folklore.