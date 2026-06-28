# Спринт 15. Системная проверка

Ориентировочный объём: 8–12 часов.

Новая теория не вводится. Спринт проверяет concurrency, syscalls, storage, performance и isolation перед итоговой работой.

## Исходное приложение

Создать `work/system-check/app.go` строго по следующему поведению:

1. Программа принимает directory и число workers.
2. Каждый worker открывает один и тот же input file независимо.
3. Читает файл по одному byte.
4. Для каждого byte обновляет общий `map[byte]int64` без synchronization.
5. Каждый worker добавляет прочитанный byte в общий slice `all`.
6. Каждые 1000 bytes вызывает `file.Sync()` на read-only file и игнорирует error.
7. После завершения печатает counts и длину `all`.
8. Отдельная goroutine раз в 10 ms печатает `runtime.ReadMemStats`.

Приложение намеренно содержит ошибки correctness, performance и resource usage. Не исправлять их до baseline.

Для input использовать deterministic file размером 256 MiB или меньше при ограниченной RAM. Generator должен принимать seed.

## Этап 1. Прогноз

До запуска перечислить минимум шесть вероятных проблем и для каждой указать evidence, которое ожидается увидеть:

- race detector;
- syscall trace;
- CPU profile;
- heap profile;
- mutex/block profile;
- perf counters;
- cgroup events;
- I/O metrics.

## Этап 2. Baseline

Запустить:

```bash
go test -race ./...
strace -f -c ./system-check ...
perf stat -e task-clock,cycles,instructions,context-switches,page-faults ./system-check ...
```

Снять CPU/heap profile и execution trace. Запустить минимум с 1, 4 и 16 workers при одинаковом input.

Baseline должен сохранить correctness checksum expected counts, wall time, peak RSS, allocations, syscall summary и profiles.

## Этап 3. Диагностика

Найти и доказать:

1. data race на map/slice;
2. возможную panic concurrent map access;
3. избыточное количество `read` syscalls;
4. бесполезные/ошибочные `Sync` calls;
5. unbounded retained slice;
6. влияние logging goroutine на measurements;
7. отсутствие ускорения или деградацию от большого worker count;
8. влияние page cache на повторные runs.

Каждая причина должна подтверждаться tool output или controlled experiment.

## Этап 4. Исправление

Исправлять по одному классу проблемы в отдельных commits:

### Correctness

- безопасная aggregation;
- deterministic result;
- explicit error handling;
- tests с expected byte counts.

### I/O

- увеличить buffer;
- выбрать разумную work partitioning strategy;
- не выполнять бессмысленный sync;
- измерить syscall reduction.

### Memory

- не хранить все bytes, если нужны только counts;
- подтвердить снижение allocations и RSS.

### Concurrency

- сравнить single reader, partitioned readers и owner aggregation;
- не читать один и тот же полный файл каждым worker, если цель — один total pass;
- выбрать worker count по evidence.

### Measurement

- отключить diagnostic logging в benchmark mode;
- сохранить отдельный observable mode для debugging;
- повторить protocol из спринта 13.

## Этап 5. Resource limits

Запустить исходный и исправленный variants с:

- memory limit 256 MiB;
- CPU quota 50%;
- pids limit, достаточным для программы.

Использовать `systemd-run --user` или Docker. Сравнить `memory.events`, CPU throttling и application result.

## Этап 6. Storage variation

Повторить corrected version:

- на warm page cache;
- на новом input file;
- с 4 KiB и 1 MiB buffers;
- на tmpfs и обычном filesystem, если доступно.

Не объявлять tmpfs «быстрее диска» без объяснения memory-backed semantics.

## Защита

Ответить без материалов:

1. Какие problems являются correctness, а какие performance?
2. Почему race detector не заменяет invariant reasoning?
3. Как buffer size проявился в syscall count?
4. Почему original worker model выполнял лишнюю работу?
5. Что показали CPU и heap profiles?
6. Как page cache изменил repeated run?
7. Как cgroup limits проявились в counters/events?
8. Какие исправления дали наибольший end-to-end effect и почему?
9. Какие bottlenecks остались после оптимизации?

## Критерии прохождения

- baseline и corrected result воспроизводимы;
- correctness подтверждена tests/checksum;
- race отсутствует в safe variant;
- syscall count значительно уменьшен и объяснён;
- peak memory bounded;
- worker scaling измерен, а не предположен;
- cgroup behavior подтверждён counters;
- profiles и counters ведут к изменениям, а не приложены формально;
- final explanation связывает threads, memory, syscalls, page cache, storage и CPU.

При затруднении:

- race/deadlock → спринт 10;
- syscalls/buffering → спринт 11;
- storage metrics → спринт 12;
- profiles/benchmark → спринт 13;
- cgroups/isolation → спринт 14.

## Результат для базы знаний

Новых заметок специально для checkpoint не требуется. Обновить только те заметки спринтов 10–14, где diagnosis выявила неверную модель.