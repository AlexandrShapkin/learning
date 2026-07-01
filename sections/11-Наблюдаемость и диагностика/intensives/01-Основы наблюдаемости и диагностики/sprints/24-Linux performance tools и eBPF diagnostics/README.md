# Спринт 24. Linux performance tools и eBPF diagnostics

Ориентировочный объём: 20–30 часов.

## Центральный вопрос

Как локализовать resource and syscall-level problems outside application instrumentation using bounded Linux and eBPF observations?

## Результат спринта

После завершения необходимо уметь:

- use `ps`, `top`, `pidstat`, `vmstat`, `iostat`, `sar` and pressure signals;
- inspect files, sockets and processes with `lsof`, `ss` and procfs;
- trace syscalls with `strace` selectively;
- capture packets with filters and interpret timing/retransmission clues;
- use `perf stat`, `perf record` and scheduler/off-CPU evidence;
- understand CPU run queue, context switches and PSI;
- inspect disk latency/queue and network drops/retransmits;
- use bpftrace/BCC tools for bounded questions;
- understand privileges, kernel support and overhead;
- correlate host, container and Kubernetes identities;
- preserve evidence without flooding output;
- avoid tool-first diagnosis.

## Основной маршрут

1. Diagnose CPU saturation, memory pressure, disk latency and network retransmission separately.
2. Use syscall tracing for one file/network wait.
3. Use `perf` for on-CPU and scheduler evidence.
4. Run one bpftrace/BCC tool against a labeled laboratory process.
5. Correlate host PID/cgroup/container/Pod and application trace.

## Ресурсы

- Linux procfs, perf, strace, sysstat and PSI documentation.
- Brendan Gregg Linux performance material.
- bpftrace/BCC docs.

## Лабораторная работа

Создать `work/linux-diagnostics/`.

### Requirements

- each tool invocation begins with a specific hypothesis/question;
- CPU case includes per-core/run-queue/context-switch evidence;
- memory case includes reclaim, faults, swap/OOM/PSI evidence where applicable;
- disk case includes device latency, queue and application syscall wait;
- network case includes socket state, retransmits/drops and filtered capture;
- syscall traces are filtered by process/call and bounded duration;
- eBPF programs target exact PID/cgroup and have cleanup;
- container/Pod is mapped to host process/cgroup/network identity;
- command overhead and privilege requirements are documented;
- raw captures/traces are not committed; findings and commands are.

### Failure scenarios

1. `top` CPU percentage is interpreted without cgroup/core context.
2. Free memory is treated as memory health.
3. Disk utilization is high but latency/queue semantics are ignored.
4. Packet capture without filter fills disk.
5. `strace` all processes creates severe overhead.
6. eBPF script attaches system-wide accidentally.
7. Container PID is confused with host PID.
8. Retransmissions are blamed on application without path evidence.
9. `perf` permissions/sampling limitations are ignored.

## Самопроверка

1. Run queue/context switches/PSI?
2. Memory pressure versus usage?
3. Disk latency, queue and utilization?
4. Socket/retransmit/drop evidence?
5. `strace` appropriate use?
6. `perf stat` versus record?
7. eBPF value and risks?
8. PID/cgroup/container mapping?
9. How bound captures/traces?
10. Why question-first tool use?

## Результат для базы знаний

- **Linux CPU, memory, disk and network diagnostics**.
- **Linux pressure-stall information and saturation**.
- **Syscall diagnosis with strace**.
- **Linux perf and scheduler profiling**.
- **Bounded eBPF diagnostics and container identity mapping**.

## Когда переходить дальше

Можно переходить, когда CPU, memory, disk and network faults are localized through bounded host evidence and correlated back to the exact workload instance.