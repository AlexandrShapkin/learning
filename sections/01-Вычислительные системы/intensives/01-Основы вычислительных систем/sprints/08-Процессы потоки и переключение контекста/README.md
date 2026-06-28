# Спринт 08. Процессы, потоки и переключение контекста

Ориентировочный объём: 10–14 часов.

## Центральный вопрос

Какие ресурсы принадлежат процессу, какие разделяются потоками и как система переключает выполнение между ними?

## Результат спринта

После завершения необходимо уметь:

- объяснять process как address space и набор ресурсов;
- объяснять thread как execution context внутри процесса;
- различать PID, TID, thread group и goroutine;
- объяснять `fork`, `exec`, `wait` и `clone` на концептуальном уровне;
- находить shared и isolated state процессов/потоков;
- объяснять user/kernel context и context switch;
- различать concurrency, parallelism и scheduling;
- интерпретировать process states и context-switch counters;
- объяснять влияние CPU affinity и `GOMAXPROCS`;
- сравнивать OS threads и goroutines без сведения различий только к размеру stack.

## Место в интенсиве

ELF и loader объяснили появление process image. Теперь изучается lifecycle выполнения и multiplexing CPU. Следующий checkpoint соединит machine code, memory, linking и process model.

## Основной маршрут

### Шаг 1. Process abstraction

Прочитать OSTEP:

- глава 4 «The Abstraction: The Process»;
- глава 5 «Interlude: Process API»;
- глава 6 «Mechanism: Limited Direct Execution»;
- глава 7 «Scheduling: Introduction» обзорно.

### Шаг 2. Exceptional control flow

Прочитать CS:APP:

- 8.1 Exceptions;
- 8.2 Processes;
- 8.3 System Call Error Handling;
- 8.4 Process Control;
- 8.5 Signals обзорно.

### Шаг 3. Threads

Прочитать OSTEP:

- глава 26 «Concurrency: An Introduction»;
- глава 27 «Interlude: Thread API».

Подробная синхронизация будет в спринте 10.

### Шаг 4. Linux и Go

Изучить:

- `fork(2)`, `execve(2)`, `waitpid(2)`, `clone(2)`;
- `/proc/<pid>/task/`;
- Go runtime docs: https://pkg.go.dev/runtime
- `GOMAXPROCS`: https://pkg.go.dev/runtime#GOMAXPROCS

## Ресурсы

### Обязательный маршрут

- OSTEP chapters 4–7 и 26–27.
- CS:APP 8.1–8.5.
- Linux man pages для process API.

### Альтернативные объяснения

- The Linux Programming Interface, chapters Processes and Threads.
- CS61C/OS course materials по context switching.
- Go scheduler design docs и runtime traces.

### Углубление

- scheduler classes CFS/EEVDF, realtime scheduling;
- clone flags и namespaces;
- user-level threading;
- M:N schedulers;
- Go scheduler internals.

### Справочные материалы

- `proc(5)`, `proc_pid_status(5)`, `proc_pid_stat(5)`.
- `sched_setaffinity(2)`, `taskset(1)`.
- `pthread_create(3)`, `gettid(2)`.

## Практические задания

### 1. Resource sharing table

До программирования заполнить таблицу для process, POSIX thread и goroutine:

- virtual address space;
- file descriptor table;
- current working directory;
- signal disposition;
- stack;
- registers/program counter;
- scheduler visibility;
- failure isolation.

Каждое утверждение затем подтвердить experiment или documentation.

### 2. Process lifecycle

Написать `work/execution/process.c`, который:

1. открывает файл;
2. выделяет heap object;
3. вызывает `fork`;
4. parent и child выводят PID, PPID, TID, address и value object, file descriptor offset;
5. child изменяет object и пишет в inherited descriptor;
6. child выполняет `execve` небольшого helper;
7. parent вызывает `waitpid` и выводит exit status.

До запуска предсказать, что будет shared, copied-on-write и сохранено через `execve`.

### 3. POSIX threads

Создать variant с четырьмя pthreads. Каждый выводит PID, TID, address общей переменной, address local variable и stack information. Проверить `/proc/$PID/task`.

### 4. Goroutines

Создать Go-программу с 1000 goroutines, которые блокируются на channel. Снять:

- количество OS threads через `/proc/$PID/task`;
- goroutine profile;
- execution trace;
- поведение при `GOMAXPROCS=1` и `GOMAXPROCS=4`.

## Лабораторная работа

Создать `work/execution-lab/` с командами:

```text
make process
make threads
make goroutines
make trace-process
make measure
```

### Эксперимент 1. fork/exec

Запустить:

```bash
strace -f -o process.strace ./process
```

В trace найти `clone`/`fork`, writes, `execve`, file descriptor inheritance и wait. Сопоставить process output с syscalls.

### Эксперимент 2. Context switches

Для CPU-bound workload сравнить:

- один process/one thread;
- N processes;
- N pthreads;
- N goroutines;

где `N` равен количеству logical CPUs и `2N`.

Измерить:

```bash
perf stat -e task-clock,context-switches,cpu-migrations,page-faults ...
```

Workload и объём работы должны быть одинаковыми. Сохранить raw results, median минимум пяти runs и system information.

### Эксперимент 3. Affinity

Повторить один case с pinning на один CPU и без pinning. Объяснить изменения context switches, migrations и wall time.

### Ожидаемые ограничения

- goroutine не обязана соответствовать одному OS thread;
- больше workers не обязаны ускорять workload;
- VM/container может искажать CPU topology;
- context-switch count без workload context не является самодостаточной оценкой.

## Дополнительный эксперимент

Создать blocking syscall в одной goroutine и через Go trace показать, что runtime может продолжить выполнение других goroutines на других threads. Затем повторить с `GOMAXPROCS=1` и объяснить различие между P, M и G только на уровне, подтверждённом trace.

## Самопроверка

1. Что остаётся тем же после `fork`, а что становится отдельным?
2. Что сохраняется и что заменяется при `execve`?
3. Почему два одинаковых virtual address в разных processes не означают одну physical memory?
4. Какие данные thread обязан иметь отдельно?
5. Чем context switch отличается от function call?
6. Почему concurrency возможна на одном CPU?
7. Почему 1000 goroutines не означают 1000 parallel computations?
8. Как scheduler visibility влияет на blocking?

Практическая проверка: по `/proc`, `strace` и output определить process/thread structure неизвестной программы и подтвердить, какие resources разделяются.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Процесс** — address space, resources, identity и lifecycle.
- **Поток** — execution context и shared process state.
- **Создание и запуск процессов** — fork/exec/wait model.
- **Переключение контекста** — сохраняемое state и причины переключения.
- **Планирование выполнения** — runnable, running, blocked и CPU allocation.
- **Goroutines и M:N scheduling** — отличие language runtime tasks от OS threads.
- **CPU affinity** — назначение, migrations и ограничения.

## Когда переходить дальше

Можно переходить, когда process/thread/goroutine resource table подтверждена экспериментами, fork/exec trace объясним, а measurements не смешивают workers, threads и actual parallelism.