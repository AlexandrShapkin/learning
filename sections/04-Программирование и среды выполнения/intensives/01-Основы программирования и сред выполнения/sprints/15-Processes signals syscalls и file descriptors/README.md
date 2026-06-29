# Спринт 15. Processes, signals, syscalls и file descriptors

Ориентировочный объём: 14–20 часов.

## Центральный вопрос

Как user-space program creates processes, accesses kernel resources and reacts to lifecycle events through system calls and file descriptors?

## Результат спринта

После завершения необходимо уметь:

- explain syscall boundary and errno/error conversion;
- distinguish process, OS thread, goroutine and child process;
- use `os`, `os/exec`, `syscall`/`x/sys` only where justified;
- understand file descriptors as process-local references to open resources;
- redirect stdin/stdout/stderr and build pipelines safely;
- explain fork/exec model conceptually and Go child creation behavior;
- manage child lifecycle, exit status, signals and wait;
- use contexts/timeouts to terminate subprocess tree carefully;
- handle SIGINT/SIGTERM and graceful shutdown;
- distinguish signal delivery from application cancellation;
- inspect `/proc`, `strace`, `lsof` and descriptor tables;
- understand descriptor inheritance and close-on-exec;
- diagnose zombie, orphan, leaked descriptor, blocked pipe and subprocess deadlock;
- avoid shell injection and unsafe command construction;
- understand privilege/environment/current-directory boundaries.

## Основной маршрут

### Шаг 1. Syscalls and descriptors

Review OS intensive and read:

- `syscalls(2)` overview;
- `open(2)`, `read(2)`, `write(2)`, `close(2)`;
- `dup(2)`, `pipe(2)`, `fcntl(2)`;
- Go `os`/`io` mapping.

### Шаг 2. Process creation

Study `fork(2)`, `execve(2)`, `wait(2)` conceptually and Go `os/exec`. Understand why Go runtime makes direct raw fork handling special.

### Шаг 3. Signals

Study `signal(7)`, Go `os/signal`, `signal.NotifyContext`, process groups and termination escalation.

### Шаг 4. Safe subprocess design

Use argument arrays, explicit environment, working directory, bounded stdout/stderr, stdin closure and context. Do not invoke shell unless shell syntax is explicitly required and input is trusted/escaped.

## Ресурсы

### Обязательный маршрут

- TLPI process/file descriptor/signal chapters.
- Linux man-pages for relevant syscalls.
- Go `os`, `os/exec`, `os/signal`, `syscall` docs.
- `strace` and `/proc` documentation.

### Альтернативные объяснения

- CS:APP exceptional control flow/process sections.
- Bash pipeline/process semantics for comparison.

### Углубление

- pidfd;
- signalfd/eventfd/epoll;
- seccomp;
- namespaces/cgroups child isolation;
- process supervisors;
- PTYs;
- Unix domain sockets and descriptor passing.

## Практические задания

### 1. Syscall trace

Trace file copy, process execution and network-free command with `strace -f`. Map selected Go operations to syscalls; note buffering/runtime differences.

### 2. Descriptor inheritance

Open files/pipes, spawn child and inspect `/proc/PID/fd`. Demonstrate unintended inheritance where possible and close-on-exec protection.

### 3. Pipeline

Build `producer | transformer | consumer` with `os/exec` pipes. Handle startup failure, early consumer exit, broken pipe and stderr without deadlock.

### 4. Signals/process groups

Start child spawning grandchild. Cancel context and prove whether whole tree exits. Implement process-group termination on Linux with safe isolation.

## Лабораторная работа

Создать `work/procrunner/` — bounded command execution library/CLI.

```text
procrunner run --timeout 5s --stdout-limit 1MiB -- COMMAND ARGS...
procrunner pipeline spec.json
procrunner inspect PID
```

### Requirements

- no shell by default;
- explicit argv/env/cwd;
- separate bounded stdout/stderr capture or streaming;
- timeout/cancellation;
- process group cleanup on Linux;
- exit code/signal/start failure classification;
- child resources and descriptors closed;
- optional stdin file/pipe;
- safe redaction of environment/arguments in logs;
- tests use helper subprocess built from test binary;
- no external command assumptions for core tests;
- race-safe lifecycle;
- context cancellation does not leak goroutines/pipes.

### Failure scenarios

1. Executable missing/permission denied.
2. Child exits non-zero.
3. Child killed by signal.
4. Timeout while child ignores SIGTERM.
5. Grandchild remains alive.
6. Child fills stderr while parent reads only stdout.
7. Parent forgets stdin close and child waits forever.
8. Output exceeds limit.
9. Descriptor leaked/inherited.
10. Working directory/environment invalid.
11. Shell injection attempt treated as literal argument.
12. Parent receives SIGTERM during active children.

## Дополнительный эксперимент

Use PTY to run interactive child and compare with ordinary pipes: buffering, terminal detection and signal behavior.

Alternative: pass open file descriptor over Unix domain socket between processes.

## Самопроверка

1. What is syscall boundary?
2. What is file descriptor?
3. How do open file description and descriptor differ conceptually?
4. What do fork/exec/wait do?
5. Why must child be waited?
6. What is zombie?
7. Why can subprocess pipeline deadlock?
8. How do signal and context cancellation differ?
9. Why kill process group?
10. What is close-on-exec?
11. Why avoid shell command concatenation?
12. How to classify exit by code versus signal?

Практическая проверка: given hanging process tree and fd state, identify blocked pipe, missing wait, leaked descriptor or incomplete termination.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **System call boundary**.
- **File descriptor and open resource**.
- **Process creation and exec**.
- **Child process lifecycle and wait**.
- **Signals and graceful termination**.
- **Subprocess pipes and deadlocks**.
- **Descriptor inheritance and close-on-exec**.
- **Safe command execution**.
- **Process groups and child-tree cleanup**.

## Когда переходить дальше

Можно переходить, когда procrunner handles every lifecycle failure, no child/fd/goroutine remains after timeout, and shell injection is structurally avoided.