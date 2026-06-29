# Спринт 05. Планирование, приоритеты и limits

Ориентировочный объём: 10–14 часов.

## Центральный вопрос

Как Linux распределяет CPU между runnable tasks и какими механизмами можно изменить приоритет, placement и допустимое потребление ресурсов?

## Результат спринта

После завершения необходимо уметь:

- различать CPU utilization, runnable queue, latency and throughput;
- объяснять preemption, time sharing and context switch;
- читать scheduling class, policy, priority and nice value;
- объяснять, почему nice — относительный вес, а не CPU percentage;
- использовать `nice`, `renice`, `chrt`, `taskset`, `ionice` безопасно;
- различать process affinity and scheduler policy;
- измерять context switches, migrations and run-queue pressure;
- использовать soft/hard rlimits через shell and `prlimit`;
- объяснять inherited limits;
- различать rlimits, cgroups and systemd limits;
- диагностировать CPU starvation, excessive workers and descriptor exhaustion;
- не применять realtime policies без bounded experiment.

## Место в интенсиве

После process lifecycle рассматривается выбор того, кто выполняется на CPU и в каких пределах. Memory-specific limits и cgroups будут углублены позже.

## Основной маршрут

### Шаг 1. Scheduling concepts

Прочитать OSTEP:

- chapter 7 «Scheduling: Introduction»;
- chapter 8 «The Multi-Level Feedback Queue»;
- chapter 9 «Scheduling: Proportional Share»;
- chapter 10 «Multiprocessor Scheduling».

Алгоритмы OSTEP используются как модели. Не отождествлять их напрямую с current Linux scheduler implementation.

### Шаг 2. Linux scheduling API

Прочитать:

- `sched(7)`;
- `nice(2)` and `nice(1)`;
- `getpriority(2)`;
- `sched_setaffinity(2)`;
- `chrt(1)`;
- `taskset(1)`.

Для current kernel scheduler details использовать docs installed distribution/kernel, поскольку implementation changes.

### Шаг 3. Resource limits

Прочитать:

- `getrlimit(2)`;
- `prlimit(2)`;
- `ulimit` in Bash manual;
- `limits.conf(5)`;
- `systemd.exec(5)` Limit* options overview.

### Шаг 4. Measurement

Изучить:

```bash
ps -eo pid,tid,cls,rtprio,pri,ni,psr,stat,pcpu,comm
pidstat -u -w -t
vmstat 1
mpstat -P ALL 1
perf stat -e task-clock,context-switches,cpu-migrations
```

Учитывать virtualization and host contention.

## Ресурсы

### Обязательный маршрут

- OSTEP chapters 7–10.
- `sched(7)`, `nice(1/2)`, `taskset(1)`, `prlimit(1/2)`.
- procps/sysstat man pages.

### Альтернативные объяснения

- Linux kernel scheduler docs: https://docs.kernel.org/scheduler/
- Brendan Gregg, CPU analysis chapters in *Systems Performance*.
- Red Hat performance tuning scheduling chapters as secondary distro documentation.

### Углубление

- EEVDF/CFS internals for current kernel;
- realtime scheduling and deadline scheduler;
- CPU isolation, cpusets and NUMA;
- PSI CPU pressure;
- scheduler tracepoints.

### Справочные материалы

- `proc_loadavg(5)`, `proc_stat(5)`, `proc_pid_sched(5)` if available.
- `ionice(1)` and block I/O scheduling docs.

## Практические задания

### 1. Load average model

Создать CPU-bound, sleeping and uninterruptible-I/O workloads where safe. Observe load average, runnable count, CPU utilization and task states.

Explain why load average is not simply CPU percentage and why a blocked task can contribute depending on state.

### 2. Nice under contention

Run two identical CPU workloads pinned to one CPU:

```bash
taskset -c 0 nice -n 0 ./worker
taskset -c 0 nice -n 10 ./worker
```

Measure completed work over same wall interval at least seven times. Verify relative share, not exact fixed ratio.

### 3. Affinity

Compare one workload:

- unpinned;
- pinned to one CPU;
- N workers pinned to one CPU;
- N workers spread across CPUs.

Collect migrations, context switches and throughput. Explain topology/VM limitations.

### 4. rlimits

Create tiny helper programs to trigger:

- `RLIMIT_NOFILE`;
- `RLIMIT_CPU`;
- `RLIMIT_FSIZE`;
- `RLIMIT_NPROC` where safe and meaningful;
- `RLIMIT_AS` with a bounded allocation.

For each, identify failure mode: syscall error, signal or process creation failure.

## Лабораторная работа

Создать `work/schedlab/` with Go command:

```text
schedlab cpu --workers N --duration 10s
schedlab mixed --cpu-workers N --sleep-workers M
schedlab descriptors --count N
schedlab report --pid PID
```

### CPU workload

- deterministic checksum;
- fixed duration and fixed-work modes;
- per-worker completed iterations;
- optional CPU affinity through launch script;
- no allocations in hot loop unless explicitly measured.

### Experiment matrix

1. workers: 1, logical CPU count, 2× logical CPU count;
2. `GOMAXPROCS`: 1 and all CPUs;
3. nice: 0 and 10 under direct contention;
4. pinned/unpinned;
5. normal vs `SCHED_BATCH` if available;
6. `RLIMIT_CPU` and `RLIMIT_NOFILE` controlled failures.

### Evidence

Collect:

- wall and CPU time;
- work completed;
- context switches;
- CPU migrations;
- per-CPU utilization;
- run queue/load average;
- process scheduler fields;
- exact kernel/VM CPU topology.

### Safety

- do not use `SCHED_FIFO` or `SCHED_RR` as root in mandatory experiments;
- duration bounded by timeout;
- no fork bomb or uncontrolled descriptor allocation;
- workers stop on context cancellation/signals.

## Дополнительный эксперимент

Use Pressure Stall Information:

```bash
cat /proc/pressure/cpu
```

Create bounded CPU contention and compare `some`/`full` pressure with load average and utilization. Explain what pressure measures that CPU percentage does not.

Alternative: trace scheduler events with `perf sched` or tracepoints and visualize wakeup-to-run latency.

## Самопроверка

1. Why can 100% CPU be healthy?
2. What is a runnable task?
3. Why doesn't nice specify a percentage?
4. What changes when affinity is set?
5. What is saved during context switch?
6. Why can too many workers reduce throughput?
7. How are soft and hard rlimits different?
8. Why are rlimits not a replacement for cgroups?
9. How does `RLIMIT_NOFILE` surface to application?
10. Why are realtime policies dangerous?

Практическая проверка: given `pidstat`, `vmstat`, scheduler fields and throughput data, determine whether a workload is CPU-saturated, oversubscribed, blocked or artificially limited.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Планирование процессов** — runnable tasks, preemption, classes and fairness.
- **Nice и priorities** — relative weighting and limitations.
- **CPU affinity** — placement, migrations and topology.
- **Context switch** — triggers, state and cost.
- **Load average** — runnable/uninterruptible tasks and interpretation.
- **Resource limits** — soft/hard rlimits, inheritance and failure modes.
- **Pressure Stall Information** — resource contention time.

## Когда переходить дальше

Можно переходить, когда schedlab experiments are reproducible, nice/affinity effects are measured under controlled contention, and rlimit failures are explained by exact API behavior.