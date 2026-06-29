# Спринт 07. Память, swap, pressure и OOM

Ориентировочный объём: 12–16 часов.

## Центральный вопрос

Как Linux учитывает и освобождает память, когда начинает использовать swap и что именно происходит при нехватке памяти?

## Результат спринта

После завершения необходимо уметь:

- различать virtual address space, RSS, PSS, anonymous memory, file-backed memory and page cache;
- интерпретировать `/proc/meminfo`, `smaps`, `smaps_rollup`, `vmstat` and `free`;
- объяснять reclaim, dirty pages, writeback and slab memory;
- различать memory allocation, commitment and residency;
- объяснять overcommit policy and commit limit;
- создавать, включать and safely remove swap file or test swap LV;
- объяснять swappiness without treating it as a direct percentage;
- использовать PSI memory pressure;
- различать global OOM and cgroup OOM;
- находить OOM-kill evidence and victim selection factors;
- diagnose leak, cache growth, fragmentation symptoms and memory pressure;
- safely reproduce OOM inside a strict limit.

## Место в интенсиве

Virtual memory was introduced in computer systems. Here the focus is operational: how Linux accounts, reclaims and limits memory and how to distinguish normal cache use from actual pressure.

## Основной маршрут

### Шаг 1. Linux memory accounting

Repeat OSTEP virtual memory overview, then study:

- `proc_meminfo(5)`;
- `proc_pid_smaps(5)`;
- `proc_pid_status(5)`;
- `free(1)`;
- `vmstat(8)`.

Build relations between MemAvailable, Cached, Buffers, SReclaimable, Anonymous, SwapCached, Dirty and Committed_AS. Do not derive one universal formula from fields that change across kernel versions.

### Шаг 2. Reclaim and swap

Read kernel documentation:

- https://docs.kernel.org/admin-guide/mm/
- https://docs.kernel.org/admin-guide/sysctl/vm.html
- https://docs.kernel.org/admin-guide/mm/concepts.html

Study `swapon(8)`, `swapoff(8)`, `mkswap(8)` and `fstab(5)`.

### Шаг 3. OOM behavior

Read:

- kernel OOM documentation under Memory Management;
- `proc_pid_oom_score(5)` and `proc_pid_oom_adj(5)`/`oom_score_adj`;
- systemd resource-control memory options overview.

Understand that the kernel may fail allocation, reclaim, invoke OOM killer or trigger cgroup-local OOM depending on context.

### Шаг 4. Pressure and observation

Study:

```bash
cat /proc/pressure/memory
vmstat 1
sar -r ALL 1
pidstat -r -p PID 1
journalctl -k -g 'oom|Out of memory|Killed process'
```

PSI measures stalled time, not bytes consumed.

## Ресурсы

### Обязательный маршрут

- Linux kernel Memory Management admin guide.
- `/proc` memory field man pages.
- `swapon`, `mkswap`, `free`, `vmstat`, `pidstat` man pages.
- cgroup v2 memory controller overview for OOM experiment.

### Альтернативные объяснения

- OSTEP virtual memory chapters 13–23.
- *Systems Performance*, memory chapters.
- Brendan Gregg memory analysis checklist.

### Углубление

- NUMA placement and balancing;
- transparent huge pages;
- slab allocators and fragmentation;
- `vm.overcommit_memory` algorithms;
- zswap/zram;
- memory reclaim tracepoints and eBPF.

### Справочные материалы

- `mmap(2)`, `madvise(2)`, `mlock(2)`.
- `systemd.resource-control(5)`.
- cgroup v2 memory controller docs.

## Практические задания

### 1. Memory field map

On an idle VM record:

```bash
free -b
cat /proc/meminfo
cat /proc/pressure/memory
vmstat 1 10
```

For at least ten fields explain source and operational meaning. Then create:

- anonymous allocation;
- large file read;
- file write without immediate fsync;
- many small files.

Identify which fields change and which assumptions are invalid.

### 2. Reserve vs touch

Write `memshape` helper that can reserve N MiB via `mmap`, touch one page at a time and optionally retain/release mappings. Compare VSZ, RSS, PSS, page faults and cgroup memory.current before/after touch.

### 3. Page cache

Create a file larger than a small test cgroup limit but safe for the VM. Read it twice and compare elapsed time, major faults and cache-related fields. Use `vmtouch` only as optional tool; do not globally drop caches as mandatory action.

### 4. Swap lifecycle

Inside VM create a 512 MiB swap file:

```bash
sudo fallocate -l 512M /swap-lab
sudo chmod 600 /swap-lab
sudo mkswap /swap-lab
sudo swapon /swap-lab
```

Verify via `swapon --show`, `/proc/swaps`, `free` and `vmstat`. Generate bounded pressure, then `swapoff` and remove file. If filesystem does not support safe swapfile semantics, use a disposable LV.

## Лабораторная работа

Create `work/memlab/` with Go program:

```text
memlab anon --size 256MiB --touch sequential
memlab file-cache --file data.bin --passes 2
memlab leak --rate 4MiB/s --limit 256MiB
memlab churn --objects N --seconds 30
memlab report --pid PID
```

### Requirements

- safe default maximum 256 MiB;
- deterministic seed;
- JSON and text reports;
- graceful signal handling;
- no unbounded host allocation;
- `/proc` parser tests from fixtures;
- report RSS/PSS/anonymous/file/swap, faults and PSI snapshot;
- generated files stay inside `work/memlab/data` and are ignored if large.

### Controlled OOM

Run leak mode under a 192 MiB memory cgroup:

```bash
systemd-run --user --scope -p MemoryMax=192M -p MemorySwapMax=0 ./memlab leak ...
```

If user delegation is unavailable, use root systemd scope or a container with explicit memory limit in the disposable VM.

Collect:

- `memory.current`;
- `memory.events`;
- `memory.stat`;
- process RSS/PSS;
- journal/kernel messages;
- exit status.

Prove whether this was cgroup OOM, global OOM or application allocation error.

### Leak diagnosis

Add optional pprof endpoint/profile. Identify retaining path, fix leak through bounded buffer/reuse and repeat identical workload. Compare peak memory and end-to-end result.

## Дополнительный эксперимент

Compare the same pressure with swap disabled and enabled. Observe latency, `si/so`, PSI and completion. Do not conclude that swap is always good or bad; state workload and memory-limit context.

Alternative: set `MemoryHigh` below `MemoryMax` and observe throttling/reclaim before OOM.

## Самопроверка

1. Why is free memory often small on a healthy Linux system?
2. How do RSS and PSS differ?
3. What is page cache and when can it be reclaimed?
4. What makes a page dirty?
5. Why can VSZ be huge while RSS is small?
6. What does swappiness control and what does it not control?
7. How is swap activity visible?
8. What is overcommit?
9. How does cgroup OOM differ from global OOM?
10. What does memory PSI measure?

Practical check: given `meminfo`, `vmstat`, PSI, smaps and memory.events, classify the situation as idle cache use, active reclaim, swapping, leak, cgroup limit or global pressure.

## Результат для базы знаний

Recommended notes:

- **Memory accounting in Linux** — RSS, PSS, anonymous, file-backed and shared memory.
- **Page cache and writeback** — clean/dirty pages, reclaim and persistence boundary.
- **Swap** — purpose, activation, policies and operational effects.
- **Memory pressure and reclaim** — watermarks, scanning and observable symptoms.
- **Overcommit** — commitment policy and allocation guarantees.
- **OOM killer** — global/cgroup OOM, victim selection and evidence.
- **PSI** — stalled time and resource pressure interpretation.

## Когда переходить дальше

Proceed when memory experiments are bounded, swap lifecycle is cleanly reversed, cgroup OOM is proven through memory.events, and cache growth is not mistaken for a leak.